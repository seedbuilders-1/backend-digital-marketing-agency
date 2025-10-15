const { prisma } = require("../config/db");

/**
 * Checks if an email has already been used in a completed referral.
 * Throws an error if the email is invalid or already used.
 * @param {string} referredEmail The email to validate.
 */
const validateReferralEmail = async (referredEmail) => {
  if (!referredEmail || !referredEmail.includes("@")) {
    throw new Error("Please provide a valid email address.");
  }

  const existingReferral = await prisma.referral.findFirst({
    where: {
      referred_email: referredEmail,
      status: "COMPLETED",
    },
  });

  if (existingReferral) {
    throw new Error(
      "This email has already been referred and used a discount."
    );
  }

  // If we reach here, the email is valid for a referral.
  return true;
};

module.exports = { validateReferralEmail };
