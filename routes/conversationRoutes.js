const express = require("express");
const router = express.Router();
const auth = require("../middlewares/authmiddleware");
const { authorizeRoles } = require("../middlewares/authenticate");
const conversationController = require("../controllers/conversationController");

/**
 * @route   GET /api/conversations
 * @desc    Get all conversations for the authenticated user
 * @access  Private (User and Admin)
 */
router.get(
  "/",
  auth,
  authorizeRoles("user", "admin"),
  conversationController.getConversations
);

/**
 * @route   GET /api/conversations/:serviceRequestId/messages
 * @desc    Get all messages for a specific service request's conversation
 * @access  Private (User and Admin)
 */
router.get(
  "/:serviceRequestId/messages",
  auth,
  authorizeRoles("user", "admin"),
  conversationController.getMessages
);

module.exports = router;
