const serviceRequestService = require("../services/serviceRequestService");
const { sendSuccess, sendError } = require("../utils/response");
const { getUserIdFromHeader } = require("../utils/getUserId");
const { uploadToCloudinary } = require("../services/cloudinaryService");

/**
 * Initializes a service request and generates an invoice.
 */
exports.initializeServiceRequest = async (req, res) => {
  try {
    const userId = await getUserIdFromHeader(req);
    const { serviceId, selectedPlan, formData, startDate, endDate } =
      JSON.parse(req.body.jsonData);

    // The files are now in req.files
    const files = req.files || [];

    // Validate incoming data
    if (
      !serviceId ||
      !selectedPlan ||
      !formData ||
      typeof formData !== "object" ||
      !selectedPlan.price ||
      !startDate ||
      !endDate
    ) {
      return sendError(
        res,
        400,
        "Missing required data. 'serviceId', 'selectedPlan' (with price), and 'formData' are required."
      );
    }

    const uploadPromises = files.map((file) =>
      uploadToCloudinary(file.buffer, `service-requests/${serviceId}`)
    );
    const uploadResults = await Promise.all(uploadPromises);
    const fileUrlMap = uploadResults.reduce((map, result, index) => {
      map[files[index].fieldname] = result.secure_url;
      return map;
    }, {});

    // 2. Inject the file URLs back into the formData object
    const finalFormData = { ...formData };
    for (const fieldname in fileUrlMap) {
      finalFormData[fieldname] = fileUrlMap[fieldname];
    }

    // 3. Now proceed with the original logic using the complete formData
    const result = await serviceRequestService.initializeRequest({
      userId,
      serviceId,
      selectedPlan,
      formData: finalFormData, // Use the data with Cloudinary URLs
      startDate,
      endDate,
    });

    return sendSuccess(
      res,
      201,
      result,
      "Request initialized successfully. Please proceed to payment."
    );
  } catch (err) {
    console.error("Failed to initialize service request:", err);
    if (err.code === "P2003") {
      return sendError(res, 404, "Invalid service or user ID provided.");
    }
    return sendError(
      res,
      500,
      "Failed to initialize service request",
      err.message
    );
  }
};

const prepareRequestData = async (req) => {
  const { serviceId, selectedPlan, formData, startDate, endDate } = JSON.parse(
    req.body.jsonData
  );
  const files = req.files || [];

  // Validate incoming data
  if (!serviceId || !selectedPlan || !formData || !startDate || !endDate) {
    throw new Error(
      "Missing required data. 'serviceId', 'selectedPlan', 'formData', 'startDate', and 'endDate' are required."
    );
  }

  // Upload any files to Cloudinary and get their URLs
  const uploadPromises = files.map((file) =>
    uploadToCloudinary(file.buffer, `service-requests/${serviceId}`)
  );
  const uploadResults = await Promise.all(uploadPromises);
  const fileUrlMap = uploadResults.reduce((map, result, index) => {
    map[files[index].fieldname] = result.secure_url;
    return map;
  }, {});

  // Inject the file URLs back into the formData object
  const finalFormData = { ...formData };
  for (const fieldname in fileUrlMap) {
    finalFormData[fieldname] = fileUrlMap[fieldname];
  }

  return {
    serviceId,
    selectedPlan,
    formData: finalFormData,
    startDate,
    endDate,
  };
};

exports.initializeWithReferral = async (req, res) => {
  try {
    const userId = getUserIdFromHeader(req);
    const { referralEmail } = req.body;
    if (!referralEmail) {
      return sendError(res, 400, "Referral email is required.");
    }

    const requestData = await prepareRequestData(req); // Your existing helper

    // --- LOGIC CHANGE ---
    // Pass both the current userId (the referrer) and the referredEmail to the service
    const result = await serviceRequestService.createRequestWithReferral(
      userId,
      requestData,
      referralEmail
    );

    return sendSuccess(
      res,
      201,
      result,
      "Referral request submitted successfully."
    );
  } catch (err) {
    console.error("Failed to initialize referral request:", err);
    // Handle specific error for duplicate referrals
    if (err.message.includes("already been referred")) {
      return sendError(res, 409, err.message); // 409 Conflict
    }
    return sendError(
      res,
      500,
      "Failed to initialize referral request",
      err.message
    );
  }
};

/**
 * Gets all service requests (Admin only).
 */
exports.getAllServiceRequests = async (req, res) => {
  try {
    const requests = await serviceRequestService.getAllRequests();
    return sendSuccess(
      res,
      200,
      requests,
      "Service requests retrieved successfully."
    );
  } catch (err) {
    console.error("Failed to get service requests:", err);
    return sendError(res, 500, "Failed to get service requests", err.message);
  }
};

/**
 * Gets a single service request by ID.
 * Ensures a regular user can only see their own requests, while an admin can see any.
 */
exports.getServiceRequestById = async (req, res) => {
  try {
    const userId = await getUserIdFromHeader(req);
    const userRole = req.user.role; // Assuming your 'auth' middleware adds user info to req
    const { id } = req.params;

    const request = await serviceRequestService.getRequestById(id);

    if (!request) {
      return sendError(res, 404, "Service request not found.");
    }

    // Security check: Is the user an admin OR the owner of the request?
    if (userRole !== "admin" && request.user_id !== userId) {
      return sendError(
        res,
        403,
        "You are not authorized to view this request."
      );
    }

    return sendSuccess(
      res,
      200,
      request,
      "Service request retrieved successfully."
    );
  } catch (err) {
    console.error("Failed to get service request:", err);
    return sendError(res, 500, "Failed to get service request", err.message);
  }
};

exports.updateRequestStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status, milestones } = req.body; // 'status' will be 'ACTIVE' or 'DECLINED'

    // Validate the status
    if (!["ACTIVE", "DECLINED"].includes(status)) {
      return sendError(res, 400, "Invalid status provided.");
    }

    // If accepting, milestones are required
    if (status === "ACTIVE" && (!milestones || milestones.length === 0)) {
      return sendError(
        res,
        400,
        "Milestones are required to activate a project."
      );
    }

    const updatedRequest = await serviceRequestService.updateRequestStatus(
      id,
      status,
      milestones
    );
    return sendSuccess(
      res,
      200,
      updatedRequest,
      `Request has been ${status.toLowerCase()}.`
    );
  } catch (err) {
    console.error(`Failed to update request status:`, err);
    return sendError(res, 500, "Failed to update request status", err.message);
  }
};

exports.getUserServiceRequests = async (req, res) => {
  try {
    // Get the logged-in user's ID from the authentication middleware
    const userId = await getUserIdFromHeader(req);
    if (!userId) {
      return sendError(res, 401, "User not authenticated.");
    }

    const requests = await serviceRequestService.getRequestsByUserId(userId);
    return sendSuccess(
      res,
      200,
      requests,
      "User service requests retrieved successfully."
    );
  } catch (err) {
    console.error("Failed to get user service requests:", err);
    return sendError(
      res,
      500,
      "Failed to get user service requests",
      err.message
    );
  }
};
