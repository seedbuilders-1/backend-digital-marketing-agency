const express = require("express");
const router = express.Router();
const auth = require("../middlewares/authmiddleware");
const serviceController = require("../controllers/serviceControllers");
const { authorizeRoles } = require("../middlewares/authenticate");
const upload = require("../middlewares/multer");
const handleMulterError = require("../middlewares/multerErrorHandler");

router.get("/", auth, serviceController.getAllServices);
router.post(
  "/",
  handleMulterError(upload.any()), // <-- MULTER RUNS FIRST
  auth, // <-- Auth runs second, can now safely access req.body
  authorizeRoles("admin"), // <-- Roles runs third
  serviceController.createService
);
router.get("/:id", auth, serviceController.getService);
router.put(
  "/:id",
  auth,
  authorizeRoles("admin"),
  handleMulterError(upload.any()),
  serviceController.updateService
);
router.delete(
  "/:id",
  auth,
  authorizeRoles("admin"),
  serviceController.deleteService
);

router.put(
  "/:id/form",
  auth,
  authorizeRoles("admin"),
  serviceController.updateServiceForm
);

module.exports = router;
