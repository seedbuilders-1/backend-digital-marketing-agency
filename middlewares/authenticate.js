const logger = require("../utils/logger");

const authorizeRoles = (...roles) => {
  return (req, res, next) => {
    const userRole = req.user?.role;
    console.log(userRole);
    logger.info(`User role is ${userRole}`);
    if (!req.user) {
      logger.error("Unauthorized");
      return res.status(401).json({ message: "Unauthenticated" });
    }

    if (!roles.includes(req.user.role)) {
      return res.status(403).json({ message: "Forbidden" });
    }

    next();
  };
};

module.exports = { authorizeRoles };
