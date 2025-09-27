const bcrypt = require("bcrypt");
const userService = require("../services/userServices");
const authService = require("../services/authServices");
const generateOTP = require("../utils/generateOTP");
const { sendSuccess, sendError } = require("../utils/response");
const {
  uploadToCloudinary,
  uploadMultipleToCloudinary,
} = require("../services/cloudinaryService");
const { sendEmail } = require("../utils/emailService");

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

    const emailSubject = `Your Verification Code for DMA`;
    const emailText = `Welcome! Your verification code is ${otp}. It will expire in 10 minutes.`;
    const emailHtml = `
    <div style="font-family: sans-serif; padding: 20px; color: #333;">
      <h2 style="color: #7642FE;">Welcome to the Digital Marketing Agency!</h2>
      <p>Thank you for registering. Please use the code below to verify your account.</p>
      <p style="background-color: #f4f4f4; border-radius: 5px; padding: 15px; font-size: 24px; text-align: center; letter-spacing: 3px; font-weight: bold;">
        ${otp}
      </p>
      <p>This code is valid for 10 minutes.</p>
      <hr style="border: none; border-top: 1px solid #eee; margin: 20px 0;" />
      <p style="font-size: 12px; color: #999;">If you did not request this, please ignore this email.</p>
    </div>
  `;

    // 3. Call our reusable email service to send the email via Zoho
    try {
      console.log("Sending email to", user.email);
      await sendEmail(user.email, emailSubject, emailText, emailHtml);
    } catch (emailError) {
      // If the email fails, we might want to still let the user be created but log the error.
      // Or, you could reverse the user creation in a more complex transaction.
      // For now, we'll log it and proceed.
      console.error(
        `Failed to send OTP email to ${user.email}, but user was created.`,
        emailError
      );
    }

    // --- END ZOHO EMAIL INTEGRATION ---

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
    // Get the string values from the multipart form body
    let { business_status, registered_with_a_business } = req.body;

    // --- Validation ---
    if (!req.files || !req.files["profile-pic"] || !req.files["IDs"]) {
      return sendError(res, 400, "Profile picture and ID files are required.");
    }
    if (!business_status || !registered_with_a_business) {
      return sendError(
        res,
        400,
        "Both business status questions are required."
      );
    }

    // --- Robust Boolean Conversion for BOTH fields ---
    const ownsBusiness = ["yes", "true", "1"].includes(
      business_status.toLowerCase()
    );
    // THIS IS THE FIX: Convert the second field to a boolean as well.
    const isRegisteredWithBusiness = ["yes", "true", "1"].includes(
      registered_with_a_business.toLowerCase()
    );

    // --- File Uploads (using .buffer) ---
    const profilePicBuffer = req.files["profile-pic"][0].buffer;
    const uploadResult = await uploadToCloudinary(
      profilePicBuffer,
      "users/profile-pic"
    );

    const idFiles = req.files["IDs"] || [];
    const idResults = await uploadMultipleToCloudinary(idFiles, "users/docs");

    // --- Service Call ---
    // Pass the corrected boolean values to the service.
    const profile = await userService.profile(id, {
      pfp_url: uploadResult.secure_url,
      id_url: idResults.map((img) => img.secure_url),
      business_status: ownsBusiness,
      registered_with_a_business: isRegisteredWithBusiness,
    });

    if (!profile) return sendError(res, 404, "User not found");

    return sendSuccess(
      res,
      200,
      { user: profile, image: { pfp: profile.pfp_url, ID: profile.id_url } },
      "User profile has been successfully completed!"
    );
  } catch (err) {
    console.error("PROFILE UPDATE ERROR:", err);
    return sendError(res, 500, "Could not complete user profile", err.message);
  }
};
