const cloudinary = require("../config/cloudinary");

/**
 * Uploads a single file buffer directly to Cloudinary using a stream.
 * @param {Buffer} fileBuffer The file buffer from req.file.buffer
 * @param {string} [folder='uploads'] The Cloudinary folder to upload into
 * @returns {Promise<object>} A promise that resolves with the Cloudinary upload result object
 */
const uploadToCloudinary = (fileBuffer, folder = "uploads") => {
  return new Promise((resolve, reject) => {
    const uploadStream = cloudinary.uploader.upload_stream(
      { folder: folder, resource_type: "auto" },
      (error, result) => {
        if (error) {
          console.error("Cloudinary upload stream error:", error);
          return reject(
            new Error("Failed to upload file to Cloudinary.", error)
          );
        }
        resolve(result);
      }
    );
    uploadStream.end(fileBuffer);
  });
};

/**
 * Uploads an array of files to Cloudinary in parallel.
 * This function takes an array of file objects (from req.files) and
 * uses the uploadToCloudinary function for each one.
 *
 * @param {Array<object>} filesArray The array of file objects from Multer (e.g., req.files['IDs'])
 * @param {string} [folder='uploads'] The Cloudinary folder to upload into
 * @returns {Promise<Array<object>>} A promise that resolves with an array of Cloudinary upload result objects
 */
const uploadMultipleToCloudinary = async (
  filesArray = [],
  folder = "uploads"
) => {
  // 1. Create an array of promises. Each promise represents one file being uploaded.
  // We use .map() to transform the array of files into an array of upload promises.
  const uploadPromises = filesArray.map((file) => {
    // For each file, we call our single uploader with its buffer.
    return uploadToCloudinary(file.buffer, folder);
  });

  // 2. Wait for ALL promises in the array to resolve.
  // Promise.all is incredibly efficient. It runs all the uploads in parallel
  // and only resolves when the last one has finished. If any upload fails,
  // it will reject immediately.
  try {
    const results = await Promise.all(uploadPromises);
    return results;
  } catch (error) {
    // If any of the uploads fail, we'll catch the error here.
    console.error("Error during multiple file upload to Cloudinary:", error);
    // Re-throw the error to be caught by the controller's main try...catch block.
    throw new Error("Failed to upload one or more ID files.");
  }
};

// Make sure to export both functions
module.exports = {
  uploadToCloudinary,
  uploadMultipleToCloudinary, // <-- Export the new function
};
