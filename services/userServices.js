const userModel = require("../models/userModels");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

const getAllusers = async () => {
  return await userModel.getAllusers();
};

const getuserById = async (id) => {
  return await userModel.getuserById(id);
};

const getuserByEmail = async (email) => {
  return await userModel.getuserByEmail(email);
};

const getuserByTel = async (tel) => {
  return await userModel.getuserByTel(tel);
};

const createUser = async (userData) => {
  const { email, tel, password } = userData;

  // 1. Check for existing user (this part was correct)
  const existingUserByEmail = await userModel.getuserByEmail(email);
  if (existingUserByEmail) {
    const error = new Error("An account with this email already exists.");
    error.statusCode = 409; // 409 Conflict is more appropriate
    throw error;
  }

  const existingUserByTel = await userModel.getuserByTel(tel);
  if (existingUserByTel) {
    const error = new Error(
      "An account with this phone number already exists."
    );
    error.statusCode = 409;
    throw error;
  }

  // 2. Hash the password (moved from controller to service)
  const hashedPassword = await bcrypt.hash(password, 10);

  // 3. Create the user in the database
  const newUser = await userModel.createUser({
    ...userData,
    password: hashedPassword,
  });

  const newUserWithDetails = await userModel.getuserByEmail(email);
  if (!newUserWithDetails) {
    // This should ideally never happen, but it's a good safeguard
    throw new Error("Failed to retrieve user details after creation.");
  }

  // 4. Generate tokens USING THE NEWLY CREATED USER'S DATA
  const accessToken = jwt.sign(
    {
      id: newUser.id,
      email: newUser.email,
      role: newUserWithDetails.role.title,
    },
    process.env.JWT_ACCESS_SECRET,
    { expiresIn: "1h" }
  );

  const refreshToken = jwt.sign(
    { id: newUser.id },
    process.env.JWT_REFRESH_SECRET,
    { expiresIn: "7d" }
  );

  // 5. Remove the password from the user object before returning
  delete newUser.password;

  // 6. Return the complete payload
  return { user: newUser, accessToken, refreshToken };
};

const updateUser = async (id, updateData) => {
  const { email } = updateData;
  const existingUser = await userModel.getupdateUserByEmail(id, email);
  if (existingUser) {
    const error = new Error("Email already exists");
    error.statusCode = 400;
    throw error;
  }
  return await userModel.updateUser(id, updateData);
};

const deleteUser = async (id) => {
  return await userModel.deleteUser(id);
};

const profile = async (id, profileData) => {
  return await userModel.profile(id, profileData);
};

module.exports = {
  getAllusers,
  getuserById,
  getuserByEmail,
  getuserByTel,
  createUser,
  updateUser,
  deleteUser,
  profile,
};
