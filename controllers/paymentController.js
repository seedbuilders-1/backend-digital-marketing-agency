const paymentService = require("../services/paymentService");
const { sendSuccess, sendError } = require("../utils/response");

/**
 * Controller to initialize a Paystack payment.
 */
exports.initializePaystackPayment = async (req, res) => {
  try {
    const { invoiceId } = req.body;
    const { id: userId, email } = req.user; // Assuming auth middleware attaches user info

    if (!invoiceId) {
      return sendError(res, 400, "Invoice ID is required.");
    }

    const authorizationUrl = await paymentService.initializePaystackTransaction(
      invoiceId,
      userId,
      email
    );

    return sendSuccess(
      res,
      200,
      { authorization_url: authorizationUrl },
      "Payment initialized successfully. Redirect user to the URL."
    );
  } catch (err) {
    console.error("Failed to initialize payment:", err);
    return sendError(res, 500, "Payment initialization failed", err.message);
  }
};

/**
 * Controller to verify a Paystack payment.
 */
exports.verifyPaystackPayment = async (req, res) => {
  try {
    const { reference } = req.params;

    const result = await paymentService.verifyPaystackTransaction(reference);

    return sendSuccess(res, 200, result, "Payment verified successfully.");
  } catch (err) {
    console.error("Failed to verify payment:", err);
    return sendError(res, 500, "Payment verification failed", err.message);
  }
};
