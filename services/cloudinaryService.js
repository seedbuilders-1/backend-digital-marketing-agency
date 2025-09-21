// In your cloudinary service file (e.g., utils/cloudinary.js)

const cloudinary = require("../config/cloudinary"); // Make sure this path is correct

/**
 * Uploads a file buffer directly to Cloudinary using a stream.
 * This is the correct method for use with multer's memoryStorage.
 *
 * @param {Buffer} fileBuffer The file buffer from req.files[...].buffer
 * @param {string} [folder='uploads'] The Cloudinary folder to upload into
 * @returns {Promise<object>} A promise that resolves with the Cloudinary upload result object
 */
const uploadToCloudinary = (fileBuffer, folder = "uploads") => {
  return new Promise((resolve, reject) => {
    // Create an upload stream that will send the buffer to Cloudinary
    const uploadStream = cloudinary.uploader.upload_stream(
      {
        folder: folder,
        resource_type: "auto", // Let Cloudinary auto-detect the file type
      },
      (error, result) => {
        if (error) {
          // If Cloudinary returns an error, reject the promise
          console.error("Cloudinary upload stream error:", error);
          return reject(new Error("Failed to upload file to Cloudinary."));
        }
        // If the upload is successful, resolve the promise with the result
        resolve(result);
      }
    );

    // Write the buffer to the stream and signal that the write is complete
    uploadStream.end(fileBuffer);
  });
};

module.exports = { uploadToCloudinary };
