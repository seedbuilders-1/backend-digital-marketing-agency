const { prisma } = require("../config/db");
const conversationModel = require("../models/conversationModel");

/**
 * Authorizes a user or admin and retrieves all messages for a specific service request's conversation.
 * This is the primary function for fetching a chat's history.
 *
 * @param {string} serviceRequestId - The ID of the service request (the "chat room").
 * @param {string} userId - The ID of the user making the request.
 * @param {string} userRole - The role of the user making the request (e.g., 'admin', 'user').
 * @returns {Promise<Array<object>>} A promise that resolves to a list of message objects.
 */
const getMessagesForRequest = async (serviceRequestId, userId, userRole) => {
  // 1. Fetch the service request to find out who the owner is.
  //    We only select the `user_id` for an efficient, lightweight query.
  const serviceRequest = await prisma.serviceRequest.findUnique({
    where: { id: serviceRequestId },
    select: { user_id: true },
  });

  // 2. Handle the case where the service request doesn't exist.
  if (!serviceRequest) {
    throw new Error("Service request not found.");
  }

  // 3. Perform the authorization check.
  const isOwner = serviceRequest.user_id === userId;
  const isAdmin = userRole === "admin";

  // Access is denied if the requester is NOT the owner AND is NOT an admin.
  if (!isOwner && !isAdmin) {
    const error = new Error("You are not authorized to view these messages.");
    error.name = "AuthorizationError"; // Set a custom name to be caught by the controller
    throw error;
  }

  // 4. If authorization passes, call the model to fetch the messages from the database.
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
 * Retrieves all conversations from the database for the admin view.
 * @returns {Promise<Array<object>>} A list of all conversation objects.
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
