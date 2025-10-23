const analyticsModel = require("../models/analyticsModel");

const getDashboardAnalytics = async () => {
  return await analyticsModel.getDashboardMetrics();
};

module.exports = { getDashboardAnalytics };
