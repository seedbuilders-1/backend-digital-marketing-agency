const express = require("express");
const router = express.Router();
const auth = require("../middlewares/authmiddleware");
const { validateReferral } = require("../controllers/referralControllers");

/**
 * @route   POST /api/referrals/validate
 * @desc    Validate if an email can be used for a referral discount
 * @access  Private
 */
router.post("/validate", auth, validateReferral);

module.exports = router;
