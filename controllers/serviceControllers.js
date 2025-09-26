const serviceService = require("../services/serviceServices");
const testimonialService = require("../services/testimonialServices");
const getUserId = require("../utils/getUserId");
const { sendSuccess, sendError } = require("../utils/response");
const { uploadToCloudinary } = require("../services/cloudinaryService");
const upload = require("../middlewares/multer");

exports.getAllServices = async (req, res) => {
  try {
    const services = await serviceService.getAllServices();
    if (services.length === 0)
      return sendError(res, 200, "No services are available");
    return sendSuccess(res, 200, services);
  } catch (err) {
    return sendError(res, 500, "Failed to get our services", err.message);
  }
};

exports.getService = async (req, res) => {
  try {
    const { id } = req.params; // Get the ID from the URL parameters
    const service = await serviceService.getService(id);

    // If no service is found with that ID, return a 404 error
    if (!service) {
      return sendError(res, 404, "Service not found.");
    }

    // If the service is found, send it back successfully
    return sendSuccess(res, 200, service);
  } catch (err) {
    // If any other error occurs, send a 500 server error
    console.error("Failed to get service:", err);
    return sendError(res, 500, "Failed to get service details", err.message);
  }
};

// In your serviceController.js

exports.createService = async (req, res) => {
  try {
    // 1. Manually reconstruct nested objects from the flattened req.body
    const reconstructedBody = {};
    for (const key in req.body) {
      // Use regex to match array syntax like 'plans[0][name]'
      const match = key.match(/(\w+)\[(\d+)\]\[(\w+)\]/);
      if (match) {
        const arrayName = match[1];
        const index = parseInt(match[2], 10);
        const propName = match[3];

        if (!reconstructedBody[arrayName]) {
          reconstructedBody[arrayName] = [];
        }
        if (!reconstructedBody[arrayName][index]) {
          reconstructedBody[arrayName][index] = {};
        }
        reconstructedBody[arrayName][index][propName] = req.body[key];
      } else {
        // Handle simple, non-array fields
        reconstructedBody[key] = req.body[key];
      }
    }

    const {
      title,
      isPublic,
      bannerText,
      heroHeadline,
      heroParagraph,
      blueprintHeadline,
      blueprintParagraph,
      plans = [], // Default to empty arrays if not present
      faqs = [],
      caseStudies = [],
      testimonials = [],
    } = reconstructedBody;

    if (!title) {
      return sendError(res, 400, "Service title is required.");
    }

    // 2. Upload images to Cloudinary and create a map of fieldname -> URL
    const fileUploads = req.files || [];
    const uploadPromises = fileUploads.map((file) =>
      // Pass the file buffer directly to the upload function
      uploadToCloudinary(file.buffer, `services/${title.replace(/\s+/g, "-")}`)
    );
    const uploadResults = await Promise.all(uploadPromises);
    const imageUrlMap = uploadResults.reduce((map, result, index) => {
      map[fileUploads[index].fieldname] = result.secure_url;
      return map;
    }, {});

    // 3. Assemble the final data object for the database service
    const admin_id = await getUserId.getUserIdFromHeader(req);
    const serviceData = {
      title,
      admin_id,
      isPublic: isPublic === "true",
      heroHeadline,
      heroParagraph,
      heroImageUrl: imageUrlMap["heroImage"] || null,
      blueprintHeadline,
      blueprintParagraph,
      blueprintImageUrl: imageUrlMap["blueprintImage"] || null,
      bannerText,
      // Parse the inner JSON string for features
      plans: plans.map((p) => ({
        ...p,
        features: JSON.parse(p.features || "[]"),
      })),
      faqs,
      // Re-associate images with the text data
      caseStudies: caseStudies.map((cs, index) => ({
        ...cs,
        bannerImageUrl: imageUrlMap[`caseStudy_${index}_bannerImage`] || null,
        challengeImageUrl:
          imageUrlMap[`caseStudy_${index}_challengeImage`] || null,
        solutionImageUrl:
          imageUrlMap[`caseStudy_${index}_solutionImage`] || null,
        resultImageUrl: imageUrlMap[`caseStudy_${index}_resultImage`] || null,
      })),
      testimonials: testimonials.map((ts, index) => ({
        ...ts,
        // Convert stars back to a number
        stars: Number(ts.stars),
        authorImageUrl: imageUrlMap[`testimonial_${index}_authorImage`] || null,
        user_id: admin_id,
      })),
    };

    // 4. Call the service to create the data in a transaction
    const newService = await serviceService.createService(serviceData);

    return sendSuccess(
      res,
      201,
      { service: newService },
      "Service created successfully!"
    );
  } catch (err) {
    console.error("Service creation failed:", err);
    return sendError(res, 500, "Failed to create Service", err.message);
  }
};
exports.updateService = async (req, res) => {
  try {
    const id = req.params.id;
    const { title, subtitle, description } = req.body;
    if (!title || !subtitle || !description) {
      return sendError(
        res,
        400,
        "title, subtitle, and description fields are required"
      );
    }

    const service = await serviceService.getService(id);
    if (!service) return sendError(res, 404, "service not found");

    let banner_url = service.banner_url;

    if (req.file) {
      const banner = await uploadToCloudinary(req.file.path, "services/banner");
      banner_url = banner.secure_url;
    }

    const updated = await serviceService.updateService(id, {
      title,
      subtitle,
      description,
      banner_url,
    });
    return sendSuccess(
      res,
      200,
      { service: updated },
      "service was updated successfully!"
    );
  } catch (err) {
    return sendError(res, 500, "Could not update service", err.message);
  }
};

exports.deleteService = async (req, res) => {
  try {
    const id = req.params.id;
    const service = await serviceService.deleteService(id);
    if (!service) return sendError(res, 404, "service not found");

    return sendSuccess(
      res,
      200,
      { Service: service },
      "Service has been deleted"
    );
  } catch (err) {
    return sendError(res, 500, "Could not delete this service", err.message);
  }
};

exports.updateServiceForm = async (req, res) => {
  try {
    const { id } = req.params;
    const { formFields } = req.body; // Expecting a JSON array

    if (!formFields) {
      return sendError(res, 400, "formFields are required.");
    }

    const updatedForm = await serviceService.updateServiceForm(id, formFields);
    return sendSuccess(
      res,
      200,
      updatedForm,
      "Service form updated successfully."
    );
  } catch (err) {
    console.error("Failed to update service form:", err);
    return sendError(res, 500, "Failed to update service form", err.message);
  }
};
