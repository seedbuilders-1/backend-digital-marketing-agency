const express = require("express");
const router = express.Router();
const auth = require("../middlewares/authmiddleware");
const paymentController = require("../controllers/paymentController");

/**
 * @route   POST /api/payments/paystack/initialize
 * @desc    Initialize a payment transaction with Paystack
 * @access  Private (Authenticated users only)
 */
router.post(
  "/paystack/initialize",
  auth,
  paymentController.initializePaystackPayment
);

/**
 * @route   GET /api/payments/paystack/verify/:reference
 * @desc    Verify a payment transaction with Paystack
 * @access  Private (Authenticated users only)
 */
router.get(
  "/paystack/verify/:reference",
  auth,
  paymentController.verifyPaystackPayment
);

module.exports = router;
