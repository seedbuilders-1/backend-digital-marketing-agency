const { prisma } = require("../config/db");
const serviceRequestModel = require("../models/serviceRequestModel");

/**
 * Handles the business logic for initializing a service request.
 * @param {object} data - The data for the new request.
 * @returns {Promise<object>} The newly created request and invoice.
 */
const initializeRequest = async (data) => {
  // Future logic could go here (e.g., sending notification emails)
  return await serviceRequestModel.initializeRequestWithInvoice(data);
};

/**
 * Handles the business logic for retrieving all service requests.
 * @returns {Promise<Array>} A list of all service requests.
 */
const getAllRequests = async () => {
  return await serviceRequestModel.getAllRequests();
};

/**
 * Handles the business logic for retrieving a single service request.
 * @param {string} requestId - The ID of the service request.
 * @returns {Promise<object|null>} The service request object.
 */
const getRequestById = async (requestId) => {
  return await serviceRequestModel.getRequestById(requestId);
};

const updateRequestStatus = async (requestId, status, milestones = []) => {
  // Use a transaction to ensure both updates happen or neither do
  return await prisma.$transaction(async (tx) => {
    // 1. Update the request's status
    const updatedRequest = await tx.serviceRequest.update({
      where: { id: requestId },
      data: { status: status },
    });

    // 2. If activating the project, create all the milestones
    if (status === "ACTIVE" && milestones.length > 0) {
      const milestoneData = milestones.map((m) => ({
        title: m.title,
        deadline: new Date(m.deadline),
        service_request_id: requestId,
        status: "PENDING_ADMIN_UPLOAD",
      }));

      await tx.milestone.createMany({
        data: milestoneData,
      });
    }

    return updatedRequest;
  });
};

const getRequestsByUserId = async (userId) => {
  console.log("Getting requests by user ID:", userId);
  return await serviceRequestModel.getRequestsByUserId(userId);
};

module.exports = {
  initializeRequest,
  getAllRequests,
  getRequestById,
  updateRequestStatus,
  getRequestsByUserId,
};
