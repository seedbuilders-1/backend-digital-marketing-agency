const referralService = require("../services/referralService");
const { sendError, sendSuccess } = require("../utils/response");
exports.validateReferral = async (req, res) => {
  try {
    const { referralEmail } = req.body;
    await referralService.validateReferralEmail(referralEmail);
    // If it doesn't throw an error, it's valid.
    return sendSuccess(res, 200, { valid: true }, "Referral email is valid.");
  } catch (err) {
    // The service will throw an error if the email is invalid
    return sendError(res, 409, err.message); // 409 Conflict is a good status code here
  }
};
