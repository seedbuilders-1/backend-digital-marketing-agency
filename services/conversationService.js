const { prisma } = require("../config/db");
const conversationModel = require("../models/conversationModel");

/**
 * Authorizes user and retrieves all messages for a service request.
 * @param {string} serviceRequestId - The ID of the service request.
 * @param {string} userId - The ID of the user requesting the messages.
 * @returns {Promise<Array<object>>} A list of messages.
 */
const getMessagesForRequest = async (serviceRequestId, userId) => {
  // 1. Authorize: Ensure the user is part of this service request (or is an admin).
  const serviceRequest = await prisma.serviceRequest.findUnique({
    where: { id: serviceRequestId },
    select: { user_id: true },
  });

  if (!serviceRequest) {
    throw new Error("Service request not found.");
  }

  // This is a simplified auth check. In a real app, you'd check req.user.role === 'admin'
  if (serviceRequest.user_id !== userId) {
    const error = new Error("You are not authorized to view these messages.");
    error.name = "AuthorizationError";
    throw error;
  }

  // 2. Fetch the messages from the model.
  return await conversationModel.getMessagesByServiceRequestId(
    serviceRequestId
  );
};

/**
 * Creates a new message and saves it to the database.
 * This will be called by our WebSocket logic.
 * @param {string} serviceRequestId - The ID of the service request.
 * @param {string} senderId - The ID of the user sending the message.
 * @param {string} text - The message content.
 * @returns {Promise<object>} The newly created message object.
 */
const createMessage = async (serviceRequestId, senderId, text) => {
  if (!text || text.trim() === "") {
    throw new Error("Message text cannot be empty.");
  }
  return await conversationModel.createMessageAndConversation(
    serviceRequestId,
    senderId,
    text
  );
};

// ADD THIS NEW SERVICE
const getConversationsForUser = async (userId) => {
  return await conversationModel.getConversationsByUserId(userId);
};

module.exports = {
  getMessagesForRequest,
  createMessage,
  getConversationsForUser,
};
