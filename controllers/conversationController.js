const conversationService = require("../services/conversationService");
const { sendSuccess, sendError } = require("../utils/response");

/**
 * Controller to fetch all messages for a service request.
 */
exports.getMessages = async (req, res) => {
  try {
    const { serviceRequestId } = req.params;
    const { id: userId, role: userRole } = req.user;

    const messages = await conversationService.getMessagesForRequest(
      serviceRequestId,
      userId,
      userRole
    );

    return sendSuccess(res, 200, messages, "Messages retrieved successfully.");
  } catch (err) {
    console.error("Failed to retrieve messages:", err);
    if (err.name === "AuthorizationError") {
      return sendError(res, 403, "Forbidden", err.message);
    }
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
    const conversations = await conversationService.getAllConversations();
    return sendSuccess(res, 200, conversations, "All conversations retrieved.");
  } catch (err) {
    console.error("Failed to retrieve admin conversations:", err);
    return sendError(res, 500, "Failed to retrieve conversations", err.message);
  }
};
