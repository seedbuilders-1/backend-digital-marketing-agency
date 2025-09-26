const orgModel = require("../models/orgModels");

const getAllorgs = async () => {
  return await orgModel.getAllorgs();
};

const getorgById = async (id) => {
  return await orgModel.getorgById(id);
};

const createOrg = async (OrgData) => {
  return await orgModel.createOrg(OrgData);
};

const updateOrg = async (id, updateData) => {
  return await orgModel.updateOrg(id, updateData);
};

const deleteOrg = async (id) => {
  return await orgModel.deleteOrg(id);
};

const getAllContacts = async () => {
  return await orgModel.getAllContacts();
};

const getContact = async (id) => {
  return await orgModel.getContact(id);
};

/**
 * Handles the business logic for creating a new contact.
 * @param {object} contactData The complete data for the new contact.
 * @returns {Promise<object>} The newly created contact object.
 */
const createContact = async (contactData) => {
  // Pass the data directly to the model for database creation.
  // Future logic, like sending a notification, would go here.
  return await orgModel.createContact(contactData);
};

const updateContact = async (OrgData) => {
  return await orgModel.updateContact(OrgData);
};

const deleteContact = async (id) => {
  return await orgModel.deleteContact(id);
};

module.exports = {
  getAllorgs,
  getorgById,
  createOrg,
  updateOrg,
  deleteOrg,
  createContact,
  getContact,
  getAllContacts,
  updateContact,
  deleteContact,
};
