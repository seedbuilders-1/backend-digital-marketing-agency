const { prisma } = require("../config/db");

const getDashboardMetrics = async () => {
  // --- THE FIX: Assign a variable for EACH promise ---
  const [
    totalRevenueData,
    serviceRequestCounts,
    pendingTaskCount,
    unpaidInvoicesCount,
    totalUsersCount,
    invoicesForChart,
    requestsForChart,
  ] = await Promise.all([
    // 1. Calculate Total Revenue
    prisma.invoice.aggregate({
      _sum: { amount: true },
      where: { status: "Paid" },
    }),
    // 2. Count Service Requests by status
    prisma.serviceRequest.groupBy({
      by: ["status"],
      _count: { id: true },
    }),
    // 3. Count Pending Milestones
    prisma.milestone.count({
      where: { status: "PENDING_ADMIN_UPLOAD" },
    }),
    // 4. Count Unpaid Invoices
    prisma.invoice.count({
      where: { status: "Unpaid" },
    }),
    // 5. Count Total Users (clients)
    prisma.user.count({
      where: { role: { title: "user" } },
    }),
    // 6. Get paid invoices for the revenue chart
    prisma.invoice.findMany({
      where: { status: "Paid" },
      select: { amount: true, created_at: true },
    }),
    // 7. Get all service requests for the project stats chart
    prisma.serviceRequest.findMany({
      select: { status: true, created_at: true },
    }),
  ]);

  // --- Process the raw data (this part of the logic remains the same) ---

  const totalRevenue = totalRevenueData._sum.amount || 0;

  // A safer way to get counts, handling cases where a status might not exist
  const requestCounts = serviceRequestCounts.reduce(
    (acc, item) => {
      acc[item.status] = item._count.id;
      return acc;
    },
    { ACTIVE: 0, COMPLETED: 0, PENDING_APPROVAL: 0 }
  ); // Initialize with defaults

  const stats = {
    totalRevenue,
    totalServiceRequests:
      (requestCounts.ACTIVE || 0) +
      (requestCounts.COMPLETED || 0) +
      (requestCounts.PENDING_APPROVAL || 0),
    pendingTasks: pendingTaskCount || 0,
    completedProjects: requestCounts.COMPLETED || 0,
    averageRevenue: totalUsersCount > 0 ? totalRevenue / totalUsersCount : 0,
    unpaidInvoices: unpaidInvoicesCount || 0,
    totalClients: totalUsersCount || 0,
    activeProjects: requestCounts.ACTIVE || 0,
  };

  // Process CHARTS
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

  // Initialize charts with all months set to 0
  const revenueChart = monthNames.map((month) => ({ month, value: 0 }));
  const projectStatsChart = monthNames.map((month) => ({
    month,
    pending: 0,
    active: 0,
    completed: 0,
  }));

  // Now `invoicesForChart` is a proper array, so .forEach will work.
  invoicesForChart.forEach((inv) => {
    const month = monthNames[new Date(inv.created_at).getMonth()];
    const index = revenueChart.findIndex((m) => m.month === month);
    if (index > -1) revenueChart[index].value += parseFloat(inv.amount);
  });

  // Now `requestsForChart` is a proper array, so .forEach will work.
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
    recentActivities: [], // This can be built out later
  };
};

module.exports = { getDashboardMetrics };
