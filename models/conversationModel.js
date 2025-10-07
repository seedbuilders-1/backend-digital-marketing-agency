const { prisma } = require("../config/db");

/**
 * Fetches all messages for a conversation linked to a service request.
 */
const getMessagesByServiceRequestId = async (serviceRequestId) => {
  return await prisma.message.findMany({
    where: {
      conversation: {
        service_request_id: serviceRequestId,
      },
    },
    include: {
      sender: {
        select: { id: true, name: true }, // Include sender info
      },
    },
    orderBy: {
      created_at: "asc", // Show oldest messages first
    },
  });
};

/**
 * Atomically finds or creates a conversation, then creates a message within it.
 * Using a transaction ensures data integrity.
 */
const createMessageAndConversation = async (
  serviceRequestId,
  senderId,
  text
) => {
  return prisma.$transaction(async (tx) => {
    // 1. Find or create the conversation for the service request.
    let conversation = await tx.conversation.findUnique({
      where: { service_request_id: serviceRequestId },
    });

    if (!conversation) {
      conversation = await tx.conversation.create({
        data: { service_request_id: serviceRequestId },
      });
    }

    // 2. Create the new message within that conversation.
    const newMessage = await tx.message.create({
      data: {
        conversation_id: conversation.id,
        sender_id: senderId,
        text,
      },
      include: {
        sender: {
          select: { id: true, name: true },
        },
      },
    });

    return newMessage;
  });
};

const getConversationsByUserId = async (userId) => {
  return await prisma.conversation.findMany({
    where: {
      service_request: {
        user_id: userId,
      },
    },
    include: {
      service_request: {
        // We need the project title and status
        select: {
          status: true,
          service: {
            select: { title: true },
          },
        },
      },
      messages: {
        // We need the last message for the preview
        orderBy: { created_at: "desc" },
        take: 1, // Crucial optimization: only take the most recent message
        include: {
          sender: { select: { name: true } },
        },
      },
    },
    orderBy: {
      updated_at: "desc", // Show the most recently active conversations first
    },
  });
};

/**
 * Fetches all conversations from the database, including the associated
 * project title, project status, and the client's name.
 * @returns {Promise<Array<object>>} A promise resolving to an array of all conversations.
 */
const getAllConversations = async () => {
  return await prisma.conversation.findMany({
    // No 'where' clause, so it fetches everything
    include: {
      service_request: {
        select: {
          id: true,
          status: true,
          service: {
            select: { title: true },
          },
          // CRITICAL: Include the user to get their name
          user: {
            select: { name: true },
          },
        },
      },
      messages: {
        orderBy: { created_at: "desc" },
        take: 1, // Get the last message for a preview
        include: {
          sender: { select: { name: true } },
        },
      },
    },
    orderBy: {
      updated_at: "desc", // Show the most recently active chats first
    },
  });
};

module.exports = {
  getMessagesByServiceRequestId,
  createMessageAndConversation,
  getConversationsByUserId,
  getAllConversations,
};
