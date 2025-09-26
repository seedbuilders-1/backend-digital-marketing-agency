const conversationService = require("./services/conversationService");

function initializeSocket(io) {
  console.log("trying to initialize socket");
  io.on("connection", (socket) => {
    console.log(`A user connected: ${socket.id}`);

    // Event for a user to join a project-specific chat room
    socket.on("joinRoom", (serviceRequestId) => {
      socket.join(serviceRequestId);
      console.log(`User ${socket.id} joined room ${serviceRequestId}`);
    });

    // Event for when a new message is sent from the client
    socket.on(
      "sendMessage",
      async ({ serviceRequestId, senderId, text }, callback) => {
        try {
          // Save the message to the database
          const newMessage = await conversationService.createMessage(
            serviceRequestId,
            senderId,
            text
          );

          // Broadcast the new message to everyone in that specific room
          io.to(serviceRequestId).emit("receiveMessage", newMessage);

          // Acknowledge the message was sent successfully
          if (callback) callback({ status: "ok" });
        } catch (error) {
          console.error("Error sending message:", error);
          // Acknowledge there was an error
          if (callback) callback({ status: "error", message: error.message });
        }
      }
    );

    // Handle user disconnection
    socket.on("disconnect", () => {
      console.log(`User disconnected: ${socket.id}`);
    });
  });
}

module.exports = initializeSocket;
