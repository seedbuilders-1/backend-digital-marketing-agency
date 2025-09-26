const invoiceService = require("../services/invoiceService");
const { sendSuccess, sendError } = require("../utils/response");
const { getUserIdFromHeader } = require("../utils/getUserId");

/**
 * Controller to get a single invoice by its ID.
 * Performs a critical security check to ensure users can only see their own invoices.
 */
exports.getInvoiceById = async (req, res) => {
  try {
    const userId = await getUserIdFromHeader(req);
    const userRole = req.user.role; // Assuming 'auth' middleware provides the user role
    const { id } = req.params;

    const invoice = await invoiceService.getInvoiceById(id);

    if (!invoice) {
      return sendError(res, 404, "Invoice not found.");
    }

    // --- CRITICAL SECURITY CHECK ---
    // A user can only view an invoice if they are an admin OR if the invoice belongs to them.
    if (userRole !== "admin" && invoice.user_id !== userId) {
      return sendError(
        res,
        403,
        "Forbidden. You are not authorized to view this invoice."
      );
    }

    return sendSuccess(res, 200, invoice, "Invoice retrieved successfully.");
  } catch (err) {
    console.error("Failed to get invoice:", err);
    return sendError(
      res,
      500,
      "Failed to retrieve invoice details",
      err.message
    );
  }
};

exports.getUserInvoices = async (req, res) => {
  try {
    const { id: userId } = req.user; // Get user ID from the authenticated request

    const invoices = await invoiceService.getInvoicesByUserId(userId);

    return sendSuccess(res, 200, invoices, "Invoices retrieved successfully.");
  } catch (err) {
    console.error("Failed to retrieve user invoices:", err);
    return sendError(res, 500, "Failed to retrieve invoices", err.message);
  }
};
