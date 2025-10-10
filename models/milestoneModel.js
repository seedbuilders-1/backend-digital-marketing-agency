const { prisma } = require("../config/db");

/**
 * Creates a new milestone for a service request.
 * @param {object} milestoneData - The data for the new milestone.
 * @param {string} milestoneData.service_request_id - The ID of the service request.
 * @param {string} milestoneData.title - The title of the milestone.
 * @param {Date} milestoneData.deadline - The deadline for the milestone.
 * @returns {Promise<object>} The newly created milestone object.
 */
const createMilestone = async (milestoneData) => {
  return await prisma.milestone.create({
    data: milestoneData,
  });
};

/**
 * Retrieves a single milestone by its ID.
 * @param {string} milestoneId - The ID of the milestone.
 * @returns {Promise<object|null>} The milestone object or null if not found.
 */
const getMilestoneById = async (milestoneId) => {
  return await prisma.milestone.findUnique({
    where: {
      id: milestoneId,
    },
  });
};

/**
 * Updates a milestone's details.
 * @param {string} milestoneId - The ID of the milestone to update.
 * @param {object} updateData - The data to update for the milestone.
 * @returns {Promise<object>} The updated milestone object.
 */
const updateMilestone = async (milestoneId, updateData) => {
  return await prisma.milestone.update({
    where: {
      id: milestoneId,
    },
    data: updateData,
  });
};

/**
 * Updates a milestone with any provided deliverable URLs (file and/or link)
 * and sets its status to PENDING_CLIENT_APPROVAL.
 */
const updateMilestoneDeliverable = async (milestoneId, deliverableData) => {
  // `deliverableData` will be an object like:
  // { deliverable_link_url: '...', deliverable_file_url: '...', deliverable_file_name: '...' }
  // Prisma's `update` will only update the fields that are present in the object.

  return await prisma.milestone.update({
    where: { id: milestoneId },
    data: {
      ...deliverableData,
      status: "PENDING_CLIENT_APPROVAL",
      rejection_reason: null,
    },
  });
};

/**
 * Updates a milestone's status based on a client's review.
 * This is called when the client approves or rejects a deliverable.
 */
const updateMilestoneReview = async (milestoneId, status, rejection_reason) => {
  return await prisma.milestone.update({
    where: { id: milestoneId },
    data: {
      status,
      // Set the rejection reason if rejected, otherwise clear it.
      rejection_reason: status === "REJECTED" ? rejection_reason : null,
    },
  });
};

/**
 * Deletes a milestone by its ID.
 * @param {string} milestoneId - The ID of the milestone to delete.
 * @returns {Promise<object>} The deleted milestone object.
 */
const deleteMilestone = async (milestoneId) => {
  return await prisma.milestone.delete({
    where: {
      id: milestoneId,
    },
  });
};

/**
 * Retrieves all milestones for a given service request.
 * The results are ordered by the milestone deadline in ascending order.
 * @param {string} serviceRequestId - The ID of the service request.
 * @returns {Promise<Array<object>>} A promise that resolves to an array of milestone objects.
 */
const getMilestonesByServiceRequestId = async (serviceRequestId) => {
  return await prisma.milestone.findMany({
    where: {
      // Filters the milestones to only include those matching the provided serviceRequestId.
      service_request_id: serviceRequestId,
    },
    orderBy: {
      // Sorts the returned milestones. This ensures that 'Milestone 1'
      // always appears before 'Milestone 2' in the user interface.
      deadline: "asc",
    },
  });
};

/**
 * Retrieves a single milestone by its ID and includes specific data
 * from its associated ServiceRequest.
 * This is primarily used for authorization to check if the milestone
 * belongs to the requesting user before performing an action.
 * @param {string} milestoneId - The unique ID of the milestone to retrieve.
 * @returns {Promise<object|null>} A promise that resolves to the milestone object
 * with nested service request data, or null if the milestone is not found.
 */
const getMilestoneWithServiceRequest = async (milestoneId) => {
  return await prisma.milestone.findUnique({
    // 1. Find the specific milestone by its unique ID.
    where: {
      id: milestoneId,
    },
    // 2. 'include' is Prisma's way of performing a join to fetch related records.
    include: {
      // We want to include data from the related 'service_request'.
      service_request: {
        // 3. Instead of fetching the entire ServiceRequest object, we use 'select'
        //    for efficiency. We only need the user_id for our authorization check.
        select: {
          user_id: true,
        },
      },
    },
  });
};

module.exports = {
  createMilestone,
  getMilestonesByServiceRequestId,
  getMilestoneById,
  updateMilestone,
  updateMilestoneDeliverable,
  deleteMilestone,
  updateMilestoneReview,
  getMilestoneWithServiceRequest,
};
