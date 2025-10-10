const milestoneService = require("../services/milestoneService");
const { sendSuccess, sendError } = require("../utils/response");

/**
 * Controller to handle the creation of a new milestone.
 */
exports.createMilestone = async (req, res) => {
  try {
    const newMilestone = await milestoneService.createMilestone(req.body);
    return sendSuccess(
      res,
      201,
      newMilestone,
      "Milestone created successfully."
    );
  } catch (err) {
    console.error("Failed to create milestone:", err);
    return sendError(res, 500, "Failed to create milestone", err.message);
  }
};

/**
 * Controller to get all milestones for a service request.
 */
exports.getMilestonesByServiceRequest = async (req, res) => {
  try {
    const { serviceRequestId } = req.params;
    const milestones = await milestoneService.getMilestonesByServiceRequest(
      serviceRequestId
    );
    return sendSuccess(
      res,
      200,
      milestones,
      "Milestones retrieved successfully."
    );
  } catch (err) {
    console.error("Failed to get milestones:", err);
    return sendError(res, 500, "Failed to get milestones", err.message);
  }
};

/**
 * Controller to get a single milestone by ID.
 */
exports.getMilestoneById = async (req, res) => {
  try {
    const { id } = req.params;
    const milestone = await milestoneService.getMilestoneById(id);
    if (!milestone) {
      return sendError(res, 404, "Milestone not found.");
    }
    return sendSuccess(
      res,
      200,
      milestone,
      "Milestone retrieved successfully."
    );
  } catch (err) {
    console.error("Failed to get milestone:", err);
    return sendError(res, 500, "Failed to get milestone", err.message);
  }
};

/**
 * Controller to update a milestone.
 */
exports.updateMilestone = async (req, res) => {
  try {
    const { id } = req.params;
    const updatedMilestone = await milestoneService.updateMilestone(
      id,
      req.body
    );
    return sendSuccess(
      res,
      200,
      updatedMilestone,
      "Milestone updated successfully."
    );
  } catch (err) {
    console.error("Failed to update milestone:", err);
    return sendError(res, 500, "Failed to update milestone", err.message);
  }
};

/**
 * Controller to delete a milestone.
 */
exports.deleteMilestone = async (req, res) => {
  try {
    const { id } = req.params;
    await milestoneService.deleteMilestone(id);
    return sendSuccess(res, 204, null, "Milestone deleted successfully.");
  } catch (err) {
    console.error("Failed to delete milestone:", err);
    return sendError(res, 500, "Failed to delete milestone", err.message);
  }
};

/**
 * Controller to handle the upload of a deliverable for a milestone.
 */
exports.uploadDeliverable = async (req, res) => {
  try {
    const { id } = req.params;
    const file = req.file;

    if (!file) {
      return sendError(res, 400, "No deliverable file was uploaded.");
    }

    const updatedMilestone = await milestoneService.uploadDeliverable(id, file);

    return sendSuccess(
      res,
      200,
      updatedMilestone,
      "Deliverable uploaded successfully."
    );
  } catch (err) {
    console.error("Failed to upload deliverable:", err);
    return sendError(res, 500, "Failed to upload deliverable", err.message);
  }
};

/**
 * Controller to handle the submission of a deliverable, which can include
 * a file, a URL, or both.
 */
exports.submitDeliverable = async (req, res) => {
  try {
    const { id: milestoneId } = req.params;
    const { deliverableLink } = req.body; // The external link is now a text field in the form
    const file = req.file; // The file is optional

    // --- Validation ---
    // A submission must contain AT LEAST one of them.
    if (!file && !deliverableLink) {
      return sendError(
        res,
        400,
        "You must provide either a file or a link to submit."
      );
    }

    // Optional: If a link is provided, validate its format.
    if (
      deliverableLink &&
      !/^(ftp|http|https|):\/\/[^ "]+$/.test(deliverableLink)
    ) {
      return sendError(res, 400, "The provided link is not a valid URL.");
    }

    // Pass everything to the service layer to handle the logic.
    const updatedMilestone = await milestoneService.submitDeliverable(
      milestoneId,
      {
        file,
        link: deliverableLink,
      }
    );

    return sendSuccess(
      res,
      200,
      updatedMilestone,
      "Deliverable submitted successfully."
    );
  } catch (err) {
    console.error("Failed to submit deliverable:", err);
    return sendError(res, 500, "Failed to submit deliverable", err.message);
  }
};

/**
 * Controller for a client to review a milestone deliverable (approve or reject).
 */
exports.reviewMilestone = async (req, res) => {
  try {
    const { id: milestoneId } = req.params;
    const { status, rejection_reason } = req.body;
    const { id: userId } = req.user; // Auth middleware must attach user object to req

    // Validate the incoming status
    if (!status || !["APPROVED", "REJECTED"].includes(status)) {
      return sendError(
        res,
        400,
        "Invalid status provided. Must be 'APPROVED' or 'REJECTED'."
      );
    }

    // A reason is mandatory if the deliverable is rejected
    if (
      status === "REJECTED" &&
      (!rejection_reason || rejection_reason.trim() === "")
    ) {
      return sendError(
        res,
        400,
        "A reason is required when rejecting a deliverable."
      );
    }

    const result = await milestoneService.reviewMilestone(
      milestoneId,
      userId,
      status,
      rejection_reason
    );

    return sendSuccess(
      res,
      200,
      result,
      "Milestone review submitted successfully."
    );
  } catch (err) {
    console.error("Failed to review milestone:", err);
    // Send a specific error for authorization failures
    if (err.name === "AuthorizationError") {
      return sendError(res, 403, "Forbidden", err.message);
    }
    return sendError(
      res,
      500,
      "Failed to process milestone review",
      err.message
    );
  }
};
