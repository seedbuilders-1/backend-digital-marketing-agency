const invoiceModel = require("../models/invoiceModel");

/**
 * Handles the business logic for retrieving a single invoice.
 * @param {string} invoiceId - The ID of the invoice to retrieve.
 * @returns {Promise<object|null>} The invoice object.
 */
const getInvoiceById = async (invoiceId) => {
  // In the future, you could add logic here, e.g., checking if the invoice has expired.
  return await invoiceModel.getInvoiceById(invoiceId);
};

/**
 * Retrieves all invoices belonging to a specific user.
 * @param {string} userId - The ID of the user.
 * @returns {Promise<Array<object>>} A list of the user's invoices.
 */
const getInvoicesByUserId = async (userId) => {
  return await invoiceModel.getInvoicesByUserId(userId);
};

module.exports = {
  getInvoiceById,
  getInvoicesByUserId,
};
