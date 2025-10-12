const { prisma } = require("../config/db");
const serviceRequestModel = require("../models/serviceRequestModel");

/**
 * Handles the business logic for initializing a service request.
 * @param {object} data - The data for the new request.
 * @returns {Promise<object>} The newly created request and invoice.
 */
const initializeRequest = async (data) => {
  // The price is taken directly from the selected plan
  const price = Number(data.selectedPlan.price);
  return await serviceRequestModel.initializeRequestWithInvoice(data, price);
};

/**
 * Initializes a service request with a referral, applying a 50% discount.
 */
const createRequestWithReferral = async (
  referrerId,
  requestData,
  referredEmail
) => {
  // 1. Validate the referral
  if (!referredEmail || !referredEmail.includes("@")) {
    throw new Error("A valid referral email address is required.");
  }

  // Check if this email has already been successfully referred and used a discount
  const existingReferral = await prisma.referral.findFirst({
    where: {
      referred_email: referredEmail,
      status: "COMPLETED",
    },
  });
  if (existingReferral) {
    throw new Error(
      "This email has already been referred and claimed a discount."
    );
  }

  // 2. Fetch the original plan price
  const plan = await prisma.plan.findUnique({
    where: { id: requestData.selectedPlan.id },
  });
  if (!plan) throw new Error("Selected plan not found.");

  // 3. Apply 50% Discount
  const discountedPrice = parseFloat(plan.price) * 0.5;
  console.log("getting the discounted price:", discountedPrice, plan.price);

  // 4. Create the Referral record
  const newReferral = await prisma.referral.create({
    data: {
      referrer_id: referrerId,
      referred_email: referredEmail,
      // We don't know the referred_user_id yet, that comes after they sign up
      status: "PENDING", // It's pending until the invoice is paid
    },
  });

  const finalRequestData = {
    ...requestData,
    userId: referrerId, // Add the user's ID to the object
  };

  // 5. Call the model function, now passing the new referral's ID
  return await serviceRequestModel.initializeRequestWithInvoice(
    finalRequestData,
    discountedPrice,
    newReferral.id // Pass the referral ID
  );
};

/**
 * Handles the business logic for retrieving all service requests.
 * @returns {Promise<Array>} A list of all service requests.
 */
const getAllRequests = async () => {
  return await serviceRequestModel.getAllRequests();
};

/**
 * Handles the business logic for retrieving a single service request.
 * @param {string} requestId - The ID of the service request.
 * @returns {Promise<object|null>} The service request object.
 */
const getRequestById = async (requestId) => {
  return await serviceRequestModel.getRequestById(requestId);
};

const updateRequestStatus = async (requestId, status, milestones = []) => {
  // Use a transaction to ensure both updates happen or neither do
  return await prisma.$transaction(async (tx) => {
    // 1. Update the request's status
    const updatedRequest = await tx.serviceRequest.update({
      where: { id: requestId },
      data: { status: status },
    });

    // 2. If activating the project, create all the milestones
    if (status === "ACTIVE" && milestones.length > 0) {
      const milestoneData = milestones.map((m) => ({
        title: m.title,
        deadline: new Date(m.deadline),
        service_request_id: requestId,
        status: "PENDING_ADMIN_UPLOAD",
      }));

      await tx.milestone.createMany({
        data: milestoneData,
      });
    }

    return updatedRequest;
  });
};

const getRequestsByUserId = async (userId) => {
  console.log("Getting requests by user ID:", userId);
  return await serviceRequestModel.getRequestsByUserId(userId);
};

module.exports = {
  initializeRequest,
  getAllRequests,
  createRequestWithReferral,
  getRequestById,
  updateRequestStatus,
  getRequestsByUserId,
};
