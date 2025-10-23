const analyticsService = require("../services/analyticsService");
const logger = require("../utils/logger");
const { sendError, sendSuccess } = require("../utils/response");

exports.getDashboardAnalytics = async (req, res) => {
  try {
    const analytics = await analyticsService.getDashboardAnalytics();
    return sendSuccess(
      res,
      200,
      analytics,
      "Dashboard analytics retrieved successfully."
    );
  } catch (err) {
    console.error("Failed to get dashboard analytics:", err);
    logger.info(`analytics error, ${err}`);
    return sendError(res, 500, "Failed to retrieve analytics", err.message);
  }
};
