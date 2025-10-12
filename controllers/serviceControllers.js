const serviceService = require("../services/serviceServices");
const testimonialService = require("../services/testimonialServices");
const getUserId = require("../utils/getUserId");
const { sendSuccess, sendError } = require("../utils/response");
const { uploadToCloudinary } = require("../services/cloudinaryService");
const upload = require("../middlewares/multer");
const { slugify } = require("../utils/helpers");
const logger = require("../utils/logger");

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

exports.getAllPublicServices = async (req, res) => {
  try {
    const services = await serviceService.getAllPublicServices();
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

const parseJson = (jsonString, defaultValue = []) => {
  try {
    return jsonString ? JSON.parse(jsonString) : defaultValue;
  } catch (e) {
    logger.error("Failed to parse JSON string:", jsonString, e);
    return defaultValue;
  }
};

// Reusable helper to build the service data object for create and update
const buildServiceData = async (body, files, existingService = {}, adminId) => {
  const {
    title,
    isPublic,
    bannerText,
    heroHeadline,
    heroParagraph,
    blueprintHeadline,
    blueprintParagraph,
  } = body;

  // 1. Upload all new files in parallel and create a map of their URLs.
  const fileUploads = files || [];
  const serviceSlug = slugify(title);

  const uploadPromises = fileUploads.map((file) =>
    uploadToCloudinary(file.buffer, `services/${serviceSlug}`).then(
      (result) => ({
        fieldname: file.fieldname,
        url: result.secure_url,
      })
    )
  );
  const uploadResults = await Promise.all(uploadPromises);

  // Creates a simple map like { heroImage: 'url1', caseStudy_0_bannerImage: 'url2' }
  const imageUrlMap = uploadResults.reduce((map, result) => {
    map[result.fieldname] = result.url;
    return map;
  }, {});

  // 2. Parse all array data from their JSON string format.
  const plans = parseJson(body.plans);
  const faqs = parseJson(body.faqs);
  const caseStudiesText = parseJson(body.caseStudies);
  const testimonialsText = parseJson(body.testimonials);

  // 3. Construct the final object, merging new data with existing data.
  return {
    title,
    admin_id: adminId,
    isPublic: isPublic === "true",
    heroHeadline,
    heroParagraph,
    // Use the new image URL if it exists in the map, otherwise keep the existing one.
    heroImageUrl:
      imageUrlMap["heroImage"] || existingService.heroImageUrl || null,
    blueprintHeadline,
    blueprintParagraph,
    blueprintImageUrl:
      imageUrlMap["blueprintImage"] ||
      existingService.blueprintImageUrl ||
      null,
    bannerText,

    // The `plans` variable is now a proper JS array, so .map() works.
    // We add the `position` index here for database sorting.
    plans: plans.map((p, index) => ({
      ...p,
      position: index,
      // The `features` property inside `p` is already a correct array.
    })),

    faqs, // faqs is a simple array of objects.

    // For nested items, merge the text data with new or existing image URLs.
    caseStudies: caseStudiesText.map((cs, index) => {
      const existingCS = existingService.caseStudies?.[index] || {};
      return {
        ...cs,
        bannerImageUrl:
          imageUrlMap[`caseStudy_${index}_bannerImage`] ||
          existingCS.bannerImageUrl,
        challengeImageUrl:
          imageUrlMap[`caseStudy_${index}_challengeImage`] ||
          existingCS.challengeImageUrl,
        solutionImageUrl:
          imageUrlMap[`caseStudy_${index}_solutionImage`] ||
          existingCS.solutionImageUrl,
        resultImageUrl:
          imageUrlMap[`caseStudy_${index}_resultImage`] ||
          existingCS.resultImageUrl,
      };
    }),

    testimonials: testimonialsText.map((ts, index) => {
      const existingTs = existingService.testimonials?.[index] || {};
      return {
        ...ts,
        stars: Number(ts.stars),
        authorImageUrl:
          imageUrlMap[`testimonial_${index}_authorImage`] ||
          existingTs.authorImageUrl,
        user_id: adminId,
      };
    }),
  };
};

// --- CONTROLLERS ---
// Your controllers are now extremely clean because all the heavy lifting
// is done by the buildServiceData helper.

exports.createService = async (req, res) => {
  try {
    const { title } = req.body;
    if (!title) return sendError(res, 400, "Service title is required.");

    const adminId = getUserId.getUserIdFromHeader(req);
    // Call the builder with an empty object for existingService
    const serviceData = await buildServiceData(
      req.body,
      req.files,
      {},
      adminId
    );

    const newService = await serviceService.createService(serviceData);
    return sendSuccess(
      res,
      201,
      { service: newService },
      "Service created successfully!"
    );
  } catch (err) {
    logger.error("Service creation failed:", err);
    return sendError(res, 500, "Failed to create Service", err.message);
  }
};

exports.updateService = async (req, res) => {
  try {
    const { id } = req.params;
    const existingService = await serviceService.getService(id);
    if (!existingService) return sendError(res, 404, "Service not found.");

    const { title } = req.body;
    if (!title) return sendError(res, 400, "Service title is required.");

    const adminId = "a20b1f85-d726-4ff1-9259-872f2d2b0b1f";
    // Call the builder and pass the existingService object
    const serviceData = await buildServiceData(
      req.body,
      req.files,
      existingService,
      adminId
    );

    const updatedService = await serviceService.updateService(id, serviceData);
    return sendSuccess(
      res,
      200,
      { service: updatedService },
      "Service updated successfully!"
    );
  } catch (err) {
    logger.error("Service update failed:", err);
    return sendError(res, 500, "Failed to update Service", err.message);
  }
};

exports.deleteService = async (req, res) => {
  try {
    const { id } = req.params;

    // The service layer now handles everything (Cloudinary + DB)
    const deletedService = await serviceService.deleteService(id);

    if (!deletedService) {
      return sendError(res, 404, "Service not found or already deleted.");
    }

    return sendSuccess(
      res,
      200,
      { service: deletedService },
      "Service has been successfully soft-deleted and assets removed."
    );
  } catch (err) {
    // This will catch errors from both Cloudinary and Prisma
    console.error("Service deletion failed:", err);
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
