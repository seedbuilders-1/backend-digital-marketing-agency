// routes/analyticsRoutes.js

const express = require("express");
const router = express.Router();
const auth = require("../middlewares/authmiddleware");
const { authorizeRoles } = require("../middlewares/authenticate");
const analyticsController = require("../controllers/analyticsController");

/**
 * @route   GET /api/analytics/dashboard
 * @desc    Get all key metrics and analytics for the admin dashboard
 * @access  Private (Admin only)
 */
router.get(
  "/dashboard",
  auth,
  authorizeRoles("admin"),
  analyticsController.getDashboardAnalytics
);

module.exports = router;
