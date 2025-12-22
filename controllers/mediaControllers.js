const logger = require("../utils/logger");

// controllers/mediaController.js
const cloudinary = require("cloudinary").v2;

exports.generateSignature = (req, res) => {
  try {
    // Get the timestamp in seconds
    const timestamp = Math.round(new Date().getTime() / 1000);

    // Use the Cloudinary SDK to create a signature
    // We can also sign parameters, like the folder, for added security
    const signature = cloudinary.utils.api_sign_request(
      {
        timestamp: timestamp,
        folder: "organization_documents", // Optional: Lock the upload to a specific folder
      },
      process.env.CLOUDINARY_API_SECRET
    );

    // Send the signature and timestamp back to the client
    res.status(200).json({ timestamp, signature });
  } catch (error) {
    logger.info(`Error generating Cloudinary signature:, ${error}`);
    console.error("Error generating Cloudinary signature:", error);
    res.status(500).json({ message: "Could not generate upload signature." });
  }
};
