const conversationService = require("../services/conversationService");
const logger = require("../utils/logger");
const { sendSuccess, sendError } = require("../utils/response");

/**
 * Controller to fetch all messages for a service request.
 */
exports.getMessages = async (req, res) => {
  try {
    const { serviceRequestId } = req.params;

    // Destructure the user's ID and role object from the request.
    // This data is reliably added by your `auth` middleware.
    const { id: userId, role } = req.user;
    logger.info(`userId: ${userId}`);
    logger.info(`role: ${role}`);
    console.log(req.user);
    const userRole = role?.title; // Get the role title (e.g., 'admin')

    // Pass all three necessary arguments to the service function.
    const messages = await conversationService.getMessagesForRequest(
      serviceRequestId,
      userId,
      userRole
    );

    return sendSuccess(res, 200, messages, "Messages retrieved successfully.");
  } catch (err) {
    console.error("Failed to retrieve messages:", err);
    // This custom error check allows us to send a specific "Forbidden" status code.
    if (err.name === "AuthorizationError") {
      return sendError(res, 403, "Forbidden", err.message);
    }
    // Handle other errors (e.g., database connection issues) with a generic 500 status.
    return sendError(res, 500, "Failed to retrieve messages", err.message);
  }
};
// ADD THIS NEW CONTROLLER
exports.getConversations = async (req, res) => {
  try {
    const { id: userId } = req.user;
    const conversations = await conversationService.getConversationsForUser(
      userId
    );
    return sendSuccess(res, 200, conversations, "Conversations retrieved.");
  } catch (err) {
    if (err.name === "AuthorizationError") {
      return sendError(res, 403, "Forbidden", err.message);
    }
    return sendError(res, 500, "Failed to retrieve conversations", err.message);
  }
};

exports.getAdminConversations = async (req, res) => {
  try {
    // It calls a dedicated service function that has no user-specific filtering.
    const conversations = await conversationService.getAllConversations();
    return sendSuccess(
      res,
      200,
      conversations,
      "All conversations retrieved successfully."
    );
  } catch (err) {
    console.error("Failed to retrieve admin conversations:", err);
    return sendError(res, 500, "Failed to retrieve conversations", err.message);
  }
};
