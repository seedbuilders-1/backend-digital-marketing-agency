const serviceModel = require("../models/serviceModels");
const {
  deleteFromCloudinary,
  extractPublicIdFromUrl,
} = require("./cloudinaryService");

const getAllServices = async () => {
  return await serviceModel.getAllServices();
};

const getAllPublicServices = async () => {
  return await serviceModel.getAllPublicServices();
};

const getService = async (id) => {
  return await serviceModel.getService(id);
};

const createService = async (serviceData) => {
  // This service now calls the powerful transaction-based model function
  return await serviceModel.createServiceWithDetails(serviceData);
};
const updateService = async (id, serviceData) => {
  return await serviceModel.updateService(id, serviceData);
};

const deleteServiceAndAssets = async (id) => {
  // 1. Fetch the full service record, including all related items with images
  const service = await serviceModel.getService(id);
  if (!service) {
    return null; // The controller will handle the 404
  }

  // 2. Gather all public_ids from the service and its relations
  const publicIds = [];
  if (service.heroImageUrl)
    publicIds.push(extractPublicIdFromUrl(service.heroImageUrl));
  if (service.blueprintImageUrl)
    publicIds.push(extractPublicIdFromUrl(service.blueprintImageUrl));

  service.caseStudies.forEach((cs) => {
    if (cs.bannerImageUrl)
      publicIds.push(extractPublicIdFromUrl(cs.bannerImageUrl));
    if (cs.challengeImageUrl)
      publicIds.push(extractPublicIdFromUrl(cs.challengeImageUrl));
    if (cs.solutionImageUrl)
      publicIds.push(extractPublicIdFromUrl(cs.solutionImageUrl));
    if (cs.resultImageUrl)
      publicIds.push(extractPublicIdFromUrl(cs.resultImageUrl));
  });

  service.testimonials.forEach((ts) => {
    if (ts.authorImageUrl)
      publicIds.push(extractPublicIdFromUrl(ts.authorImageUrl));
  });

  // Filter out any null values that may have resulted from empty URLs
  const validPublicIds = publicIds.filter(Boolean);

  // 3. Delete the assets from Cloudinary
  if (validPublicIds.length > 0) {
    await deleteFromCloudinary(validPublicIds);
  }

  // 4. Soft delete the service from the database
  return await serviceModel.deleteService(id);
};

const getCaseStudiesByServiceId = async (id) => {
  return await serviceModel.getCaseStudiesByServiceId(id);
};

const updateServiceForm = async (serviceId, formFields) => {
  return await serviceModel.updateServiceForm(serviceId, formFields);
};

module.exports = {
  getAllServices,
  getAllPublicServices,
  getService,
  createService,
  updateService,
  deleteService: deleteServiceAndAssets,
  getCaseStudiesByServiceId,
  updateServiceForm,
};
