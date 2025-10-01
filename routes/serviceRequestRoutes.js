const express = require("express");
const router = express.Router();
const auth = require("../middlewares/authmiddleware");
const { authorizeRoles } = require("../middlewares/authenticate");
const requestController = require("../controllers/serviceRequestController");
const upload = require("../middlewares/multer");
const handleMulterError = require("../middlewares/multerErrorHandler");

/**
 * @route   POST /api/service-requests/initialize
 * @desc    Initialize a new service request and create an invoice
 * @access  Private (User must be logged in)
 */
router.post(
  "/initialize",
  auth,
  handleMulterError(upload.any()),
  requestController.initializeServiceRequest
);

/**
 * @route   GET /api/service-requests
 * @desc    Get all service requests
 * @access  Private (Admin only)
 */
router.get(
  "/",
  auth,
  authorizeRoles("admin"),
  requestController.getAllServiceRequests
);

/**
 * @route   GET /api/service-requests/my-requests
 * @desc    Get all service requests for the currently logged-in user
 * @access  Private (User must be logged in)
 */
router.get("/my-requests", auth, requestController.getUserServiceRequests);

/**
 * @route   GET /api/service-requests/:id
 * @desc    Get a single service request by ID
 * @access  Private (User can see their own, Admin can see any)
 */
router.get("/:id", auth, requestController.getServiceRequestById);

/**
 * @route   PATCH /api/service-requests/:id/status
 * @desc    Update a request's status (Accept/Decline) and add milestones
 * @access  Private (Admin only)
 */
router.patch(
  "/:id/status",
  auth,
  authorizeRoles("admin"),
  requestController.updateRequestStatus
);

module.exports = router;
