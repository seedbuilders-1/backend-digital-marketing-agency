const { prisma } = require("../config/db");
const conversationModel = require("../models/conversationModel");

/**
 * Authorizes a user or admin and retrieves all messages for a service request.
 *
 * @param {string} serviceRequestId - The ID of the service request.
 * @param {string} userId - The ID of the user making the request.
 * @param {string} userRole - The role of the user making the request (e.g., 'admin', 'user').
 * @returns {Promise<Array<object>>} A list of messages.
 */
const getMessagesForRequest = async (serviceRequestId, userId, userRole) => {
  // 1. Fetch the service request to find out who the owner is.
  const serviceRequest = await prisma.serviceRequest.findUnique({
    where: { id: serviceRequestId },
    select: { user_id: true }, // We only need the owner's ID for the check.
  });

  if (!serviceRequest) {
    // If the project doesn't exist, throw an error.
    throw new Error("Service request not found.");
  }

  const isOwner = serviceRequest.user_id === userId;
  const isAdmin = userRole === "admin";

  if (!isOwner && !isAdmin) {
    // If the user is neither the owner nor an admin, deny access.
    const error = new Error("You are not authorized to view these messages.");
    error.name = "AuthorizationError";
    throw error;
  }

  // 3. If authorization passes, fetch and return the messages from the model.
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

/**
 * Retrieves all conversations from the database.
 * @returns {Promise<Array<object>>} A list of all conversations.
 */
const getAllConversations = async () => {
  return await conversationModel.getAllConversations();
};

module.exports = {
  getMessagesForRequest,
  createMessage,
  getConversationsForUser,
  getAllConversations,
};
