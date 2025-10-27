// routes/mediaRoutes.js
const express = require("express");
const router = express.Router();
const auth = require("../middleware/auth"); // Protect the route
const mediaController = require("../controllers/mediaController");

// This is the new endpoint your frontend will call
router.get("/generate-signature", auth, mediaController.generateSignature);

module.exports = router;
