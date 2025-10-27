// routes/mediaRoutes.js
const express = require("express");
const router = express.Router();
const auth = require("../middlewares/authmiddleware");

const mediaController = require("../controllers/mediaControllers");

// This is the new endpoint your frontend will call
router.get("/generate-signature", auth, mediaController.generateSignature);

module.exports = router;
