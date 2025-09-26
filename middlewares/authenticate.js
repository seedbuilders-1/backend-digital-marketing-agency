const authorizeRoles = (...roles) => {
  return (req, res, next) => {
    const userRole = req.user?.role;
    console.log(userRole);
    if (!roles.includes(userRole)) {
      return res.status(403).json({ message: "Forbidden: Access denied" });
    }
    next();
  };
};

module.exports = { authorizeRoles };
