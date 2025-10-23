// models/analyticsModel.js

const { prisma } = require("../config/db");

const getDashboardMetrics = async () => {
  // We'll use Promise.all to run multiple independent queries in parallel for maximum efficiency.
  const [
    totalRevenueData,
    serviceRequestCounts,
    pendingTaskCount,
    unpaidInvoicesCount,
    totalUsersCount,
    monthlyData,
  ] = await Promise.all([
    // 1. Calculate Total Revenue from all 'Paid' invoices
    prisma.invoice.aggregate({
      _sum: { amount: true },
      where: { status: "Paid" },
    }),
    // 2. Count Service Requests by status
    prisma.serviceRequest.groupBy({
      by: ["status"],
      _count: { id: true },
    }),
    // 3. Count Pending Milestones (deliverable not yet submitted)
    prisma.milestone.count({
      where: { status: "PENDING_ADMIN_UPLOAD" },
    }),
    // 4. Count Unpaid Invoices
    prisma.invoice.count({
      where: { status: "Unpaid" },
    }),
    // 5. Count Total Users
    prisma.user.count({
      where: { role: { title: "user" } }, // Only count clients, not admins
    }),
    // 6. Get data for charts (can be expanded with date filters)
    prisma.invoice.findMany({
      where: { status: "Paid" },
      select: { amount: true, created_at: true },
    }),
    prisma.serviceRequest.findMany({
      select: { status: true, created_at: true },
    }),
  ]);

  // --- Process the raw data into a clean, frontend-friendly object ---

  // Process STATS
  const totalRevenue = totalRevenueData._sum.amount || 0;
  const requestCounts = serviceRequestCounts.reduce((acc, item) => {
    acc[item.status] = item._count.id;
    return acc;
  }, {});

  const stats = {
    totalRevenue,
    totalServiceRequests:
      requestCounts.ACTIVE +
        requestCounts.COMPLETED +
        requestCounts.PENDING_APPROVAL || 0,
    pendingTasks: pendingTaskCount || 0,
    completedProjects: requestCounts.COMPLETED || 0,
    averageRevenue: totalUsersCount > 0 ? totalRevenue / totalUsersCount : 0,
    unpaidInvoices: unpaidInvoicesCount || 0,
    totalClients: totalUsersCount || 0,
    activeProjects: requestCounts.ACTIVE || 0,
  };

  // Process CHARTS (simplified monthly aggregation)
  const monthNames = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  const revenueChart = monthNames.map((month) => ({ month, value: 0 }));
  const [invoicesForChart, requestsForChart] = monthlyData;

  invoicesForChart.forEach((inv) => {
    const month = monthNames[new Date(inv.created_at).getMonth()];
    const index = revenueChart.findIndex((m) => m.month === month);
    if (index > -1) revenueChart[index].value += parseFloat(inv.amount);
  });

  const projectStatsChart = monthNames.map((month) => ({
    month,
    pending: 0,
    active: 0,
    completed: 0,
  }));
  requestsForChart.forEach((req) => {
    const month = monthNames[new Date(req.created_at).getMonth()];
    const index = projectStatsChart.findIndex((m) => m.month === month);
    if (index > -1) {
      if (req.status === "PENDING_APPROVAL") projectStatsChart[index].pending++;
      if (req.status === "ACTIVE") projectStatsChart[index].active++;
      if (req.status === "COMPLETED") projectStatsChart[index].completed++;
    }
  });

  return {
    stats,
    charts: {
      revenue: revenueChart,
      projectStats: projectStatsChart,
    },
    // You could add a list of recent activities here too
    recentActivities: [],
  };
};

module.exports = { getDashboardMetrics };
