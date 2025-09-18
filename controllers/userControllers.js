const bcrypt = require("bcrypt");
const userService = require("../services/userServices");
const authService = require("../services/authServices");
const generateOTP = require("../utils/generateOTP");
const { sendSuccess, sendError } = require("../utils/response");
const {
  uploadToCloudinary,
  uploadMultipleToCloudinary,
} = require("../services/cloudinaryService");

exports.getAllusers = async (req, res) => {
  try {
    const users = await userService.getAllusers();
    if (!users) return sendError(res, 404, users, "Users not found");
    return sendSuccess(res, 200, users, "Users fetched!");
  } catch (err) {
    return sendError(res, 500, "Could not get users", err.message);
  }
};

exports.getuserById = async (req, res) => {
  try {
    const user = await userService.getuserById(req.params.id);
    if (!user) return sendError(res, 404, "User not found");
    return sendSuccess(res, 200, user, "User profile fetched!");
  } catch (err) {
    return sendError(res, 500, "Could not get user", err.message);
  }
};

exports.createUser = async (req, res) => {
  try {
    const { name, email, tel, country, address, category, password } = req.body;

    // 1. Basic validation remains
    if (
      !name ||
      !email ||
      !tel ||
      !country ||
      !address ||
      !category ||
      !password
    ) {
      return sendError(res, 400, "All required fields must be provided.");
    }

    // 2. Call the service (passing the raw password)
    // The service now returns the user and tokens
    const { user, accessToken, refreshToken } = await userService.createUser({
      name,
      email,
      tel,
      country,
      address,
      category,
      password, // Pass the plain password to the service
    });

    // 3. OTP generation remains the same
    const { otp, expiresAt } = await generateOTP();
    const hashedOTP = await bcrypt.hash(otp, 10);
    const save = await authService.saveOTP({
      hashedOTP,
      expiresAt,
      id: user.id,
    });

    // 4. Construct and send the final, complete success response
    const responsePayload = {
      user: user,
      tokens: {
        accessToken: accessToken,
        refreshToken: refreshToken,
      },
      otp: otp, // Sending the plain OTP for verification is common
    };

    return sendSuccess(res, 201, responsePayload, "User created successfully!");
  } catch (err) {
    const statusCode = err.statusCode || 500;
    return sendError(res, statusCode, "Could not create user", err.message);
  }
};

exports.updateUser = async (req, res) => {
  try {
    const { name, email, tel, country, address, category, password } = req.body;
    const { id } = req.params;

    if (
      !name ||
      !email ||
      !tel ||
      !country ||
      !address ||
      !category ||
      !password
    ) {
      return sendError(
        res,
        400,
        "All fields are required - name, email, tel, country, address, category, password"
      );
    }

    const hashed_password = await bcrypt.hash(password, 10);

    const updated = await userService.updateUser(id, {
      name,
      email,
      tel,
      country,
      address,
      category,
      password: hashed_password,
    });

    if (!updated) {
      return sendError(res, 404, "User not found");
    }

    return sendSuccess(
      res,
      200,
      { user: updated },
      "User updated successfully!"
    );
  } catch (err) {
    const statusCode = err.statusCode || 500;
    return sendError(res, statusCode, "Could not update User", err.message);
  }
};

exports.deleteUser = async (req, res) => {
  try {
    const { id } = req.params;
    const deleted = await userService.deleteUser(id);

    if (!deleted) {
      return sendError(res, 404, "User not found");
    }

    return sendSuccess(
      res,
      200,
      { user: deleted },
      "User deleted successfully"
    );
  } catch (err) {
    return sendError(res, 500, "Could not delete user", err.message);
  }
};

exports.profile = async (req, res) => {
  try {
    const id = req.params.id;
    let { business_status, registered_with_a_business } = req.body;

    if (!req.files["profile-pic"] || !req.files["IDs"] || !business_status) {
      return sendError(
        res,
        400,
        "Profile picture, ID, and business_status fields are required"
      );
    }

    if (business_status.toLowerCase() === "yes") {
      business_status = true;
    } else {
      business_status = false;
    }

    const uploadResult = await uploadToCloudinary(
      req.files["profile-pic"][0].path,
      "users/profile-pic"
    );

    const idFiles = req.files["IDs"] || [];
    const idResults = await uploadMultipleToCloudinary(idFiles, "users/docs");

    const profile = await userService.profile(id, {
      pfp_url: uploadResult.secure_url,
      id_url: idResults.map((img) => img.secure_url),
      business_status,
      registered_with_a_business,
    });
    if (!profile) return sendError(res, 404, "User not found");

    return sendSuccess(
      res,
      200,
      { user: profile, image: { pfp: profile.pfp_url, ID: profile.id_url } },
      "user profile has been successfully completed!"
    );
  } catch (err) {
    return sendError(res, 500, "Could not complete user profile", err.message);
  }
};
