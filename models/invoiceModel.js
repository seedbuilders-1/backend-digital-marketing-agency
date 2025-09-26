const { prisma } = require("../config/db");

/**
 * Retrieves a single invoice by its ID from the database.
 * Includes related user and service request details needed for the invoice preview.
 * @param {string} invoiceId - The unique ID of the invoice.
 * @returns {Promise<object|null>} The invoice object with related data, or null if not found.
 */
const getInvoiceById = async (invoiceId) => {
  return await prisma.invoice.findUnique({
    where: {
      id: invoiceId,
    },
    // Include the data needed to populate the invoice UI
    include: {
      // Get the user's name to display "Billed to"
      user: {
        select: {
          id: true,
          name: true,
          email: true,
          // You could also select address fields here if they are on the user model
        },
      },
      // Get the service request to know which service this invoice is for
      service_request: {
        include: {
          service: {
            select: {
              id: true,
              title: true,
            },
          },
        },
      },
    },
  });
};

/**
 * Fetches all invoices for a specific user from the database.
 * The data shape for each invoice mirrors `getInvoiceById`, including
 * user details and the specific service title for easy display in a list.
 * @param {string} userId - The ID of the user whose invoices are to be fetched.
 * @returns {Promise<Array<object>>} A promise that resolves to an array of detailed invoice objects.
 */
const getInvoicesByUserId = async (userId) => {
  return await prisma.invoice.findMany({
    // Filter the results to only include invoices belonging to the specified user.
    where: {
      user_id: userId,
    },
    include: {
      // Get the service request and the service title to show what each invoice is for.
      service_request: {
        include: {
          service: {
            select: {
              id: true,
              title: true,
            },
          },
        },
      },
    },
    // Order the invoices with the most recent one appearing first.
    orderBy: {
      created_at: "desc",
    },
  });
};

module.exports = {
  getInvoiceById,
  getInvoicesByUserId,
};
