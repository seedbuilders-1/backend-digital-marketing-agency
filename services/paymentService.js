const axios = require("axios");
const { v4: uuidv4 } = require("uuid");
const { prisma } = require("../config/db");

const PAYSTACK_API_BASE = "https://api.paystack.co";

/**
 * Initializes a payment transaction with Paystack.
 * @param {string} invoiceId - The ID of the invoice to be paid.
 * @param {string} userId - The ID of the user making the payment.
 * @param {string} email - The email of the user.
 * @returns {Promise<string>} The authorization URL from Paystack.
 */
const initializePaystackTransaction = async (invoiceId, userId, email) => {
  // 1. Fetch the invoice to get the amount and validate it
  const invoice = await prisma.invoice.findUnique({
    where: { id: invoiceId },
  });

  if (!invoice) {
    throw new Error("Invoice not found.");
  }
  if (invoice.user_id !== userId) {
    throw new Error("You are not authorized to pay for this invoice.");
  }
  if (invoice.status === "Paid") {
    throw new Error("This invoice has already been paid.");
  }

  // 2. Prepare data for Paystack API
  const amountInKobo = Math.round(invoice.amount * 100);
  const reference = uuidv4(); // Generate a unique reference for this transaction

  // Store the reference with the invoice for later verification
  await prisma.invoice.update({
    where: { id: invoiceId },
    data: { payment_reference: reference },
  });

  const payload = {
    email,
    amount: amountInKobo,
    reference,
    callback_url: `${process.env.FRONTEND_URL}/payment/verify`, // The page user returns to
  };

  // 3. Make the API call to Paystack
  const response = await axios.post(
    `${PAYSTACK_API_BASE}/transaction/initialize`,
    payload,
    {
      headers: {
        Authorization: `Bearer ${process.env.PAYSTACK_SECRET_KEY}`,
      },
    }
  );

  if (!response.data.status) {
    throw new Error("Failed to initialize Paystack transaction.");
  }

  // 4. Return the authorization URL
  return response.data.data.authorization_url;
};

/**
 * Verifies a payment transaction with Paystack.
 * @param {string} reference - The transaction reference from Paystack.
 * @returns {Promise<object>} The updated invoice object.
 */
const verifyPaystackTransaction = async (reference) => {
  // 1. Make API call to Paystack to verify
  const response = await axios.get(
    `${PAYSTACK_API_BASE}/transaction/verify/${reference}`,
    {
      headers: {
        Authorization: `Bearer ${process.env.PAYSTACK_SECRET_KEY}`,
      },
    }
  );

  const { status, data } = response.data;

  if (!status || data.status !== "success") {
    throw new Error("Payment verification failed with Paystack.");
  }

  // 2. Find the invoice in our DB using the reference
  const invoice = await prisma.invoice.findFirst({
    where: { payment_reference: reference },
  });

  if (!invoice) {
    throw new Error("No invoice found for this payment reference.");
  }

  // 3. Update the invoice status to "Paid"
  const updatedInvoice = await prisma.invoice.update({
    where: { id: invoice.id },
    data: {
      status: "Paid",
      payment_method: "Paystack", // Optional: store payment method
    },
  });

  // Optional: You could also update the related ServiceRequest status here if needed

  return { invoice: updatedInvoice, message: "Payment was successful." };
};

module.exports = {
  initializePaystackTransaction,
  verifyPaystackTransaction,
};
