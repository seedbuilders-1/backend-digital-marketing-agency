const serviceModel = require("../models/serviceModels");

const getAllServices = async () => {
  return await serviceModel.getAllServices();
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

const deleteService = async (id) => {
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
  getService,
  createService,
  updateService,
  deleteService,
  getCaseStudiesByServiceId,
  updateServiceForm,
};
