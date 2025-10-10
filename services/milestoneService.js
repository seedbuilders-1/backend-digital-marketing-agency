const milestoneModel = require("../models/milestoneModel");
const serviceRequestModel = require("../models/serviceRequestModel");
const { uploadToCloudinary } = require("./cloudinaryService");

/**
 * Handles the business logic for creating a new milestone.
 * @param {object} milestoneData - The data for the new milestone.
 * @returns {Promise<object>} The newly created milestone object.
 */
const createMilestone = async (milestoneData) => {
  return await milestoneModel.createMilestone(milestoneData);
};

/**
 * Retrieves all milestones for a specific service request.
 * @param {string} serviceRequestId - The ID of the service request.
 * @returns {Promise<Array<object>>} A list of milestones.
 */
const getMilestonesByServiceRequest = async (serviceRequestId) => {
  return await milestoneModel.getMilestonesByServiceRequestId(serviceRequestId);
};

/**
 * Retrieves a single milestone by its ID.
 * @param {string} milestoneId - The ID of the milestone.
 * @returns {Promise<object|null>} The milestone object or null if not found.
 */
const getMilestoneById = async (milestoneId) => {
  return await milestoneModel.getMilestoneById(milestoneId);
};

/**
 * Handles the business logic for updating a milestone.
 * @param {string} milestoneId - The ID of the milestone to update.
 * @param {object} updateData - The data to update for the milestone.
 * @returns {Promise<object>} The updated milestone object.
 */
const updateMilestone = async (milestoneId, updateData) => {
  return await milestoneModel.updateMilestone(milestoneId, updateData);
};

/**
 * Handles the business logic for deleting a milestone.
 * @param {string} milestoneId - The ID of the milestone to delete.
 * @returns {Promise<object>} The deleted milestone object.
 */
const deleteMilestone = async (milestoneId) => {
  return await milestoneModel.deleteMilestone(milestoneId);
};

/**
 * Handles the business logic for uploading a milestone deliverable.
 * @param {string} milestoneId - The ID of the milestone.
 * @param {object} file - The file object from Multer (req.file).
 * @returns {Promise<object>} The updated milestone object.
 */
const uploadDeliverable = async (milestoneId, file) => {
  if (!file) {
    throw new Error("No file provided for upload.");
  }

  const uploadResult = await uploadToCloudinary(
    file.buffer,
    `deliverables/${milestoneId}`
  );

  const deliverableData = {
    url: uploadResult.secure_url,
    name: file.originalname,
  };

  const updatedMilestone = await milestoneModel.updateMilestoneDeliverable(
    milestoneId,
    deliverableData
  );

  return updatedMilestone;
};

/**
 * Handles the business logic for submitting a deliverable (file, link, or both).
 * @param {string} milestoneId The ID of the milestone.
 * @param {object} deliverables An object containing the optional file and link.
 * @param {File} [deliverables.file] The uploaded file object from Multer.
 * @param {string} [deliverables.link] The submitted external URL.
 * @returns {Promise<object>} The updated milestone object.
 */
const submitDeliverable = async (milestoneId, { file, link }) => {
  // Start with the link data if it exists.
  const deliverableData = {
    deliverable_link_url: link || null,
  };

  // If a file was also uploaded, process it and add its data.
  if (file) {
    const uploadResult = await uploadToCloudinary(
      file.buffer,
      `deliverables/${milestoneId}`
    );
    deliverableData.deliverable_file_url = uploadResult.secure_url;
    deliverableData.deliverable_file_name = file.originalname;
  }

  // Call the model with the combined data object.
  return await milestoneModel.updateMilestoneDeliverable(
    milestoneId,
    deliverableData
  );
};

/**
 * Handles the business logic for a client reviewing a milestone deliverable.
 * @param {string} milestoneId - The ID of the milestone being reviewed.
 * @param {string} userId - The ID of the client performing the review.
 * @param {'APPROVED' | 'REJECTED'} status - The review status.
 * @param {string} [rejection_reason] - The reason, if the deliverable is rejected.
 * @returns {Promise<object>} An object containing the updated milestone.
 */
const reviewMilestone = async (
  milestoneId,
  userId,
  status,
  rejection_reason
) => {
  // 1. Authorize: Check if the milestone exists and belongs to the user making the request.
  const milestone = await milestoneModel.getMilestoneWithServiceRequest(
    milestoneId
  );

  if (!milestone) {
    throw new Error("Milestone not found.");
  }
  if (milestone.service_request.user_id !== userId) {
    const error = new Error("You are not authorized to review this milestone.");
    error.name = "AuthorizationError";
    throw error;
  }
  // A client can only review a milestone that is pending their approval.
  if (milestone.status !== "PENDING_CLIENT_APPROVAL") {
    throw new Error("This milestone is not currently awaiting your approval.");
  }

  // 2. Update the milestone with the client's review.
  const updatedMilestone = await milestoneModel.updateMilestoneReview(
    milestoneId,
    status,
    rejection_reason
  );

  // 3. If the deliverable was approved, check if the entire project is now complete.
  if (status === "APPROVED") {
    const allMilestones = await milestoneModel.getMilestonesByServiceRequestId(
      milestone.service_request_id
    );

    // Check if every single milestone for the project is now approved.
    const allMilestonesApproved = allMilestones.every(
      (m) => m.status === "APPROVED"
    );

    if (allMilestonesApproved) {
      // If all are approved, update the parent service request's status to COMPLETED.
      await serviceRequestModel.updateServiceRequestStatus(
        milestone.service_request_id,
        "COMPLETED"
      );
    }
  }

  return { milestone: updatedMilestone };
};

module.exports = {
  createMilestone,
  getMilestonesByServiceRequest,
  getMilestoneById,
  updateMilestone,
  deleteMilestone,
  uploadDeliverable,
  reviewMilestone,
  submitDeliverable,
};
