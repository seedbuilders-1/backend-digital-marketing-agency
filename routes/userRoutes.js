const express = require("express");
const router = express.Router();
const auth = require("../middlewares/authmiddleware");
const userController = require("../controllers/userControllers");
const { authorizeRoles } = require("../middlewares/authenticate");
const upload = require("../middlewares/multer");
const handleMulterError = require("../middlewares/multerErrorHandler");

router.get("/", auth, authorizeRoles("admin"), userController.getAllusers);
/**
 * @route   GET /api/users/me
 * @desc    Get the profile of the currently logged-in user
 * @access  Private
 */
router.get(
  "/me",
  auth, // The auth middleware validates the token and attaches the user to `req.user`
  userController.getMe
);
router.post(
  "/profile/:id",
  auth,
  handleMulterError(
    upload.fields([
      { name: "profile-pic", maxCount: 1 },
      { name: "IDs", maxCount: 5 },
    ])
  ),
  userController.profile
);
router.get("/:id", auth, userController.getuserById);
router.put("/:id", auth, userController.updateUser);
router.delete("/:id", auth, authorizeRoles("admin"), userController.deleteUser);

module.exports = router;
