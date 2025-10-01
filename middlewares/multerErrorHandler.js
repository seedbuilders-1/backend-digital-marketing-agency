// middlewares/multerErrorHandler.js

const multer = require("multer");
const { sendError } = require("../utils/response"); // Import your error handler

/**
 * A custom middleware that wraps a Multer upload instance to handle its specific errors.
 *
 * @param {Function} multerUpload - The configured Multer middleware (e.g., upload.single('logo')).
 * @returns {Function} An Express middleware function.
 */
const handleMulterError = (multerUpload) => {
  return (req, res, next) => {
    // Execute the Multer middleware
    multerUpload(req, res, (err) => {
      // Check if the error is a known Multer error
      if (err instanceof multer.MulterError) {
        let message = "An unknown file upload error occurred.";
        switch (err.code) {
          case "LIMIT_FILE_SIZE":
            message = `File is too large. Maximum size is ${
              err.limit / 1024 / 1024
            }MB.`;
            break;
          case "LIMIT_FILE_COUNT":
            message = "Too many files uploaded.";
            break;
          case "LIMIT_UNEXPECTED_FILE":
            message =
              "Invalid file type. Please upload only allowed file types.";
            break;
          // You can add more cases here for other Multer error codes
        }
        // Use your custom sendError function to send a clean 400 response
        return sendError(res, 400, message, err.code);
      } else if (err) {
        // Handle other, non-Multer errors that might have occurred
        return sendError(
          res,
          500,
          "An internal error occurred during file upload.",
          err.message
        );
      }

      // If there are no errors, proceed to the next middleware (your controller)
      next();
    });
  };
};

module.exports = handleMulterError;
