const { prisma } = require("../config/db");

/**
 * Creates a new ServiceRequest and a linked Invoice within a single transaction.
 * @param {object} data - The data for the new request and invoice.
 * @returns {Promise<object>} An object containing the new request and invoice.
 */
const initializeRequestWithInvoice = async (data) => {
  const { userId, serviceId, selectedPlan, formData, startDate, endDate } =
    data;

  return await prisma.$transaction(async (tx) => {
    // Step 1: Create the ServiceRequest with a "Pending Payment" status
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

    // Step 2: Create the Invoice, linking it to the new request
    const newInvoice = await tx.invoice.create({
      data: {
        user_id: userId,
        service_request_id: newRequest.id, // Link to the request
        amount: Number(selectedPlan.price), // Ensure price is a number
        status: "Unpaid",
        // Set a due date, e.g., 7 days from now
        due_date: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000),
      },
    });

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
