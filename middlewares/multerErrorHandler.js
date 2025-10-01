// middlewares/multerErrorHandler.js

const multer = require("multer");
const { sendError } = require("../utils/responseHandler");

/**
 * A custom middleware that wraps a Multer upload instance to handle its specific errors,
 * providing detailed feedback to the user.
 *
 * @param {Function} multerUpload - The configured Multer middleware (e.g., upload.single('logo')).
 * @returns {Function} An Express middleware function.
 */
const handleMulterError = (multerUpload) => {
  return (req, res, next) => {
    multerUpload(req, res, (err) => {
      if (err instanceof multer.MulterError) {
        let message = "An unknown file upload error occurred.";

        // --- THIS IS THE KEY ENHANCEMENT ---
        // The `err.field` property contains the name of the form field that caused the error.
        const fieldName = err.field;

        switch (err.code) {
          case "LIMIT_FILE_SIZE":
            // Create a more descriptive and user-friendly field name
            // e.g., 'certificateOfIncorporation' becomes 'Certificate Of Incorporation'
            const friendlyFieldName = fieldName
              .replace(/([A-Z])/g, " $1")
              .replace(/^./, (str) => str.toUpperCase());

            // Construct a specific error message
            message = `The file for "${friendlyFieldName}" is too large. Maximum size is ${
              process.env.MAX_FILE_SIZE_MB || 5
            }MB.`;
            break;

          case "LIMIT_FILE_COUNT":
            message =
              "Too many files were uploaded. Please check the limits for each field.";
            break;

          case "LIMIT_UNEXPECTED_FILE":
            // If a field name is available, include it. This is common with `upload.fields`.
            if (fieldName) {
              const friendlyName = fieldName
                .replace(/([A-Z])/g, " $1")
                .replace(/^./, (str) => str.toUpperCase());
              message = `The file for "${friendlyName}" is an invalid type. Please upload only allowed file types (Images or PDF).`;
            } else {
              message =
                "An invalid file type was uploaded. Please upload only allowed file types (Images or PDF).";
            }
            break;

          // You can add more specific cases here if needed
        }

        // Send the specific, user-friendly error message
        return sendError(res, 400, message, err.code);
      } else if (err) {
        // Handle other, non-Multer errors
        return sendError(
          res,
          500,
          "An internal server error occurred during file upload.",
          err.message
        );
      }

      // If no errors, proceed to the controller
      next();
    });
  };
};

module.exports = handleMulterError;
