// utils/emailService.js

const nodemailer = require("nodemailer");

const transporter = nodemailer.createTransport({
  host: process.env.ZOHO_HOST,
  port: parseInt(process.env.ZOHO_PORT, 10),
  secure: process.env.ZOHO_PORT === "465", // true for 465, false for other ports
  auth: {
    user: process.env.ZOHO_USER,
    pass: process.env.ZOHO_APP_PASSWORD, // Use the App-Specific Password here
  },
  // Add timeout configurations to prevent hanging
  connectionTimeout: 10000, // 10 seconds to establish connection
  greetingTimeout: 10000, // 10 seconds to wait for greeting
  socketTimeout: 15000, // 15 seconds of inactivity
  // Add pool configuration for better performance
  pool: true,
  maxConnections: 5,
  maxMessages: 100,
});

/**
 * Sends an email using the configured Zoho transporter.
 *
 * @param {string} to The recipient's email address.
 * @param {string} subject The subject line of the email.
 * @param {string} text The plain-text version of the email body.
 * @param {string} html The HTML version of the email body.
 * @returns {Promise<void>}
 */
const sendEmail = async (to, subject, text, html) => {
  try {
    // Define the email options
    const mailOptions = {
      from: process.env.EMAIL_FROM,
      to: to,
      subject: subject,
      text: text,
      html: html,
    };

    // Send the email
    const info = await transporter.sendMail(mailOptions);
    console.log(
      "Email sent successfully via Zoho. Message ID:",
      info.messageId,
    );
  } catch (error) {
    console.error("Error sending email via Zoho:", error);
    // Throw the error so the calling service can handle it
    throw new Error("Failed to send email.");
  }
};

module.exports = {
  sendEmail,
};
