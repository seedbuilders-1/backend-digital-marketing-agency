// utils/emailService.js

const { Resend } = require("resend");

// Initialize Resend with API key from environment
const resend = new Resend(process.env.RESEND_API_KEY);

/**
 * Sends an email using Resend.
 *
 * @param {string} to The recipient's email address.
 * @param {string} subject The subject line of the email.
 * @param {string} text The plain-text version of the email body (optional, used as fallback).
 * @param {string} html The HTML version of the email body.
 * @returns {Promise<void>}
 */
const sendEmail = async (to, subject, text, html) => {
  try {
    // Validate required fields
    if (!to || !subject || !html) {
      throw new Error("Missing required email fields: to, subject, or html");
    }

    // Validate API key is configured
    if (!process.env.RESEND_API_KEY) {
      throw new Error(
        "RESEND_API_KEY is not configured in environment variables",
      );
    }

    // Validate sender email is configured
    if (!process.env.EMAIL_FROM) {
      throw new Error("EMAIL_FROM is not configured in environment variables");
    }

    // Send the email using Resend
    const data = await resend.emails.send({
      from: process.env.EMAIL_FROM,
      to: [to],
      subject: subject,
      html: html,
      text: text || undefined, // Include text version if provided
    });

    console.log("Email sent successfully via Resend. Message ID:", data.id);

    return data;
  } catch (error) {
    console.error("Error sending email via Resend:", error);

    // Provide more specific error messages
    if (error.message?.includes("API key")) {
      throw new Error("Invalid Resend API key configuration");
    }

    if (error.message?.includes("from")) {
      throw new Error("Invalid sender email address");
    }

    // Throw the error so the calling service can handle it
    throw new Error(`Failed to send email: ${error.message}`);
  }
};

module.exports = {
  sendEmail,
};
