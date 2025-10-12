const { prisma } = require("../config/db");

/**
 * Creates a ServiceRequest and a corresponding Invoice in a single database transaction.
 * If a referralId is provided, it links the new invoice to the referral record.
 *
 * @param {object} data The core request data.
 * @param {number} finalPrice The amount for the invoice.
 * @param {string} [referralId] The optional ID of the referral record to link.
 * @returns {Promise<{request: object, invoice: object}>}
 */
const initializeRequestWithInvoice = async (
  data,
  finalPrice,
  referralId = null
) => {
  const { userId, serviceId, selectedPlan, formData, startDate, endDate } =
    data;

  return await prisma.$transaction(async (tx) => {
    // Step 1: Create the ServiceRequest
    const newRequest = await tx.serviceRequest.create({
      data: {
        user_id: userId,
        service_id: serviceId,
        plan_name: selectedPlan.name,
        planId: selectedPlan.id,
        formData: formData,
        status: "PENDING_APPROVAL",
        start_date: new Date(startDate),
        end_date: new Date(endDate),
      },
    });

    // Step 2: Create the Invoice, with a conditional connection to the referral.
    const newInvoice = await tx.invoice.create({
      data: {
        user_id: userId,
        service_request_id: newRequest.id,
        amount: finalPrice,
        status: "Unpaid",
        due_date: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),

        // --- THIS IS THE KEY FIX ---
        // If a referralId is provided, we use the `connect` syntax on the RELATION field.
        // The relation field on your `Invoice` model is likely named `referral`.
        ...(referralId && {
          referral: {
            connect: {
              id: referralId,
            },
          },
        }),
      },
    });

    // Optional but correct: Update the referral record to link back to the invoice.
    // This is good for two-way data lookups.
    if (referralId) {
      await tx.referral.update({
        where: { id: referralId },
        data: {
          invoice_id: newInvoice.id, // Set the scalar field here
          status: "COMPLETED",
        },
      });
    }

    return { request: newRequest, invoice: newInvoice };
  });
};

/**
 * Retrieves all service requests. Primarily for admins.
 * Includes user and service details.
 * @returns {Promise<Array>} A list of all service requests.
 */
const getAllRequests = async () => {
  return await prisma.serviceRequest.findMany({
    orderBy: {
      created_at: "desc",
    },
    include: {
      user: {
        select: { id: true, name: true, email: true },
      },
      service: {
        select: { id: true, title: true },
      },
      invoice: true, // Also include the associated invoice
    },
  });
};

/**
 * Retrieves a single service request by its ID.
 * @param {string} requestId - The ID of the service request.
 * @returns {Promise<object|null>} The service request object or null if not found.
 */
const getRequestById = async (requestId) => {
  return await prisma.serviceRequest.findUnique({
    where: {
      id: requestId,
    },
    include: {
      user: {
        select: { id: true, name: true, email: true },
      },
      service: {
        select: { id: true, title: true },
      },
      invoice: true,
      milestones: true,
    },
  });
};

/**
 * Retrieves all service requests for a specific user.
 * @param {string} userId - The ID of the user.
 * @returns {Promise<Array>} A list of service requests for the given user.
 */
const getRequestsByUserId = async (userId) => {
  console.log("running");
  return await prisma.serviceRequest.findMany({
    where: {
      user_id: userId,
    },
    orderBy: {
      created_at: "desc",
    },
    // We include the service title to display it in the projects table
    include: {
      service: {
        select: {
          title: true,
        },
      },
      // Include the invoice to quickly show payment status
      invoice: {
        select: {
          status: true,
        },
      },
    },
  });
};

/**
 * Updates the status of a ServiceRequest (e.g., to 'COMPLETED').
 */
const updateServiceRequestStatus = async (serviceRequestId, status) => {
  return await prisma.serviceRequest.update({
    where: { id: serviceRequestId },
    data: {
      status,
    },
  });
};

module.exports = {
  initializeRequestWithInvoice,
  getAllRequests,
  getRequestById,
  getRequestsByUserId,
  updateServiceRequestStatus,
};
