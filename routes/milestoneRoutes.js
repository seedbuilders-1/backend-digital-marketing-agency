const express = require("express");
const router = express.Router();
const auth = require("../middlewares/authmiddleware");
const { authorizeRoles } = require("../middlewares/authenticate");
const upload = require("../middlewares/multer"); // Your configured Multer instance
const milestoneController = require("../controllers/milestoneController");
const handleMulterError = require("../middlewares/multerErrorHandler");

/**
 * @route   POST /api/milestones
 * @desc    Create a new milestone
 * @access  Private (Admin only)
 */
router.post(
  "/",
  auth,
  authorizeRoles("admin"),
  milestoneController.createMilestone
);

/**
 * @route   GET /api/milestones/service-request/:serviceRequestId
 * @desc    Get all milestones for a specific service request
 * @access  Private (User and Admin)
 */
router.get(
  "/service-request/:serviceRequestId",
  auth,
  authorizeRoles("user", "admin"),
  milestoneController.getMilestonesByServiceRequest
);

/**
 * @route   GET /api/milestones/:id
 * @desc    Get a single milestone by ID
 * @access  Private (User and Admin)
 */
router.get(
  "/:id",
  auth,
  authorizeRoles("user", "admin"),
  milestoneController.getMilestoneById
);

/**
 * @route   PUT /api/milestones/:id
 * @desc    Update a milestone
 * @access  Private (Admin only)
 */
router.put(
  "/:id",
  auth,
  authorizeRoles("admin"),
  milestoneController.updateMilestone
);

/**
 * @route   DELETE /api/milestones/:id
 * @desc    Delete a milestone
 * @access  Private (Admin only)
 */
router.delete(
  "/:id",
  auth,
  authorizeRoles("admin"),
  milestoneController.deleteMilestone
);

/**
 * @route   POST /api/milestones/:id/deliverable
 * @desc    Upload a deliverable file for a specific milestone
 * @access  Private (Admin only)
 */
router.post(
  "/:id/deliverable",
  auth,
  authorizeRoles("admin"),
  handleMulterError(upload.single("deliverableFile")),
  milestoneController.submitDeliverable
);

/**
 * @route   PATCH /api/milestones/:id/review
 * @desc    Client reviews (approves/rejects) a milestone deliverable
 * @access  Private (User/Client only)
 */
router.patch(
  "/:id/review",
  auth,
  authorizeRoles("user", "admin"), // Ensures only users (clients) can access this
  milestoneController.reviewMilestone
);

module.exports = router;
