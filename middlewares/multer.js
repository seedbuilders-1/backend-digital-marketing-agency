const multer = require("multer");

// Use memoryStorage, which is correct for your use case.
const storage = multer.memoryStorage();

// Define a file filter to only accept image files. Your existing filter is fine.
const fileFilter = (req, file, cb) => {
  if (file.mimetype.startsWith("image/")) {
    cb(null, true);
  } else {
    // Rejects the file and provides a specific error message for Multer to catch.
    cb(
      new multer.MulterError(
        "LIMIT_UNEXPECTED_FILE",
        "Not an image! Please upload only images."
      ),
      false
    );
  }
};

// --- THIS IS THE CRITICAL FIX ---
// Define explicit limits for the upload.
const limits = {
  // Maximum file size of 5MB. Your 1MB file will be well within this.
  fileSize: 1024 * 1024 * 5,

  // Maximum number of files in a single request. Your form can have many.
  files: 20,

  // Maximum number of non-file fields.
  fields: 100,
};

// Create and export the fully configured multer instance.
const upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  limits: limits, // <-- Add the limits object here
});

module.exports = upload;
