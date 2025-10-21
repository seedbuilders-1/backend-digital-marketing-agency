const multer = require("multer");

// Use memoryStorage so files are stored in memory as Buffer objects
const storage = multer.memoryStorage();

// No filtering — accept any file type
const fileFilter = (req, file, cb) => {
  cb(null, true);
};

// No limits — accept any file size or count
const upload = multer({
  storage,
  fileFilter,
  limits: { fileSize: 1024 * 1024 * 100 }, // 100MB
});

module.exports = upload;
