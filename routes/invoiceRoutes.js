const express = require("express");
const router = express.Router();
const auth = require("../middlewares/authmiddleware");
const invoiceController = require("../controllers/invoiceController");
const { authorizeRoles } = require("../middlewares/authenticate");

/**
 * @route   GET /api/invoices/:id
 * @desc    Get a single invoice by its ID
 * @access  Private (User can see their own, Admin can see any)
 */
router.get("/:id", auth, invoiceController.getInvoiceById);

/**
 * @route   GET /api/invoices
 * @desc    Get all invoices for the authenticated user
 * @access  Private (User only)
 */
router.get(
  "/",
  auth,
  authorizeRoles("user", "admin"), // Ensures only logged-in clients can get their invoices
  invoiceController.getUserInvoices
);

module.exports = router;
