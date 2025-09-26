const orgService = require("../services/orgServices.js");
const { sendSuccess, sendError } = require("../utils/response");
const {
  uploadMultipleToCloudinary,
  uploadToCloudinary,
} = require("../services/cloudinaryService");
const { getUserIdFromHeader } = require("../utils/getUserId");

// Helper function to upload a single required file and get its URL
const uploadRequiredFile = async (files, fieldName, folder) => {
  if (!files || !files[fieldName] || files[fieldName].length === 0) {
    throw new Error(`Missing required file for field: ${fieldName}`);
  }
  const file = files[fieldName][0];
  const result = await uploadToCloudinary(file.buffer, folder);
  return result.secure_url;
};

exports.getAllorgs = async (req, res) => {
  try {
    const orgs = await orgService.getAllorgs();
    if (orgs.length === 0) return sendError(res, 404, "Oganisations not found");
    return sendSuccess(res, 200, orgs, "Organisation fetched successfully");
  } catch (err) {
    return sendError(res, 500, "Could not fetch organisations", err.message);
  }
};

exports.getorgById = async (req, res) => {
  try {
    const id = req.params.id;
    const org = await orgService.getorgById(id);
    if (!org) return sendError(res, 404, "organisation not found");

    return sendSuccess(res, 200, org, "Organisation fetched successfully");
  } catch (err) {
    return sendError(res, 500, "Server error", err.message);
  }
};

exports.createOrg = async (req, res) => {
  try {
    // 1. Destructure all non-file fields from the body
    const {
      name,
      email,
      address,
      country,
      industry,
      rc_number,
      staff_size,
      type,
    } = req.body;

    // 2. Validate all required text fields
    const requiredFields = {
      name,
      email,
      address,
      country,
      industry,
      rc_number,
      staff_size,
      type,
    };
    for (const [key, value] of Object.entries(requiredFields)) {
      if (!value) {
        return sendError(res, 400, `Field '${key}' is required.`);
      }
    }

    const userId = getUserIdFromHeader(req);
    const { files } = req; // req.files will be an object like { logo: [file], ... }

    // 3. Upload all required files in parallel for efficiency
    const [
      logoUrl,
      certOfIncUrl,
      memOfAssocUrl,
      proofOfAddressUrl,
      statusReportUrl,
    ] = await Promise.all([
      uploadRequiredFile(files, "logo", "orgs/logos"),
      uploadRequiredFile(files, "certificateOfIncorporation", "orgs/documents"),
      uploadRequiredFile(files, "memorandumOfAssociation", "orgs/documents"),
      uploadRequiredFile(files, "proofOfAddress", "orgs/documents"),
      uploadRequiredFile(files, "statusReport", "orgs/documents"),
    ]);

    // 4. Call the service with the complete data, including all new URLs
    const newOrg = await orgService.createOrg({
      name,
      email,
      address,
      country,
      industry,
      rc_number,
      staff_size,
      type,
      logo_url: logoUrl,
      cert_of_inc_url: certOfIncUrl,
      mem_of_assoc_url: memOfAssocUrl,
      proof_of_address_url: proofOfAddressUrl,
      company_status_report_url: statusReportUrl,
      user_id: userId,
    });

    return sendSuccess(
      res,
      201,
      { org: newOrg },
      "Organization created successfully"
    );
  } catch (err) {
    console.error("CREATE ORGANIZATION ERROR:", err);
    if (err.code === "P2002") {
      return sendError(
        res,
        409,
        `An organization with this ${err.meta.target.join(
          ", "
        )} already exists.`
      );
    }
    return sendError(res, 500, "Could not create organization", err.message);
  }
};

exports.updateOrg = async (req, res) => {
  try {
    const {
      name,
      email,
      address,
      country,
      type,
      industry,
      rc_number,
      staff_size,
    } = req.body;
    const { id } = req.params;

    if (
      !name ||
      !email ||
      !address ||
      !country ||
      !type ||
      !industry ||
      !rc_number ||
      !staff_size
    ) {
      return sendError(
        res,
        400,
        "All fields are required - All fields are required - name, email, address, country, type, industry, rc_number, staff_size"
      );
    }

    const org = await orgService.getorgById(id);
    let logo_url = org.logo_url;

    if (req.file) {
      const logo = await uploadToCloudinary(req.file.path, "orgs/logo");
      logo_url = logo.secure_url;
    }

    const updated = await orgService.updateOrg(id, {
      name,
      email,
      address,
      country,
      type,
      industry,
      rc_number,
      staff_size,
      logo_url,
    });

    if (!updated) {
      return sendError(res, 404, "Organisation not found");
    }

    return sendSuccess(
      res,
      200,
      { Organisation: updated },
      "Organisation updated successfully"
    );
  } catch (err) {
    return sendError(res, 500, "Could not update organisation", err.message);
  }
};

exports.deleteOrg = async (req, res) => {
  try {
    const { id } = req.params;
    const deleted = await orgService.deleteOrg(id);

    if (!deleted) {
      return sendError(res, 404, "Organisation not found");
    }

    return sendSuccess(
      res,
      200,
      { Organisation: deleted },
      "Organisation deleted successfully"
    );
  } catch (err) {
    return sendError(res, 500, "Could not delete Organisation", err.message);
  }
};

exports.getAllContacts = async (req, res) => {
  try {
    const contacts = await orgService.getAllContacts();
    if (contacts.length === 0) return sendError(res, 404, "No contacts found");

    return sendSuccess(res, 200, contacts, "Contacts found");
  } catch (err) {
    return sendError(res, 500, "Failed to get contacts", err.message);
  }
};

exports.getContact = async (req, res) => {
  try {
    const id = req.params.id;
    const contact = await orgService.getContact(id);
    if (!contact) return sendError(res, 404, "Contact not found");

    return sendSuccess(res, 200, contact, "Contact fetched successfully!");
  } catch (err) {
    return sendError(res, 500, "Failed to get the contact", err.message);
  }
};

exports.createContact = async (req, res) => {
  try {
    // 1. Destructure non-file fields from the request body
    const { name, organisation_id } = req.body;

    // 2. Validate all required fields
    if (!name || !organisation_id) {
      return sendError(
        res,
        400,
        "The name and organisation_id fields are required."
      );
    }
    if (!req.files || !req.files["profile-pic"] || !req.files["IDs"]) {
      return sendError(
        res,
        400,
        "A profile picture and at least one ID file are required."
      );
    }

    const { files } = req;

    // 3. Upload files to Cloudinary in parallel for efficiency
    // The Promise.all will run both uploads at the same time.
    const [pfpUploadResult, idUploadResults] = await Promise.all([
      uploadToCloudinary(files["profile-pic"][0].buffer, "contacts/pfp"),
      uploadMultipleToCloudinary(files["IDs"], "contacts/docs"),
    ]);

    // 4. Prepare the data payload for the service layer
    const contactData = {
      name,
      pfp_url: pfpUploadResult.secure_url,
      // The `id_url` field is JSON, so we send an array of URLs,
      // which Prisma will automatically stringify and store.
      id_url: idUploadResults.map((result) => result.secure_url),
      organisation_id,
    };

    // 5. Call the service to create the contact in the database
    const newContact = await orgService.createContact(contactData);

    // 6. Send the success response
    return sendSuccess(
      res,
      201,
      { contact: newContact },
      "Contact created successfully"
    );
  } catch (err) {
    console.error("CREATE CONTACT ERROR:", err);
    // Handle specific Prisma error for non-existent organization
    if (err.code === "P2003") {
      return sendError(res, 404, "The specified organization does not exist.");
    }
    return sendError(res, 500, "Could not create contact", err.message);
  }
};

exports.updateContact = async (req, res) => {
  try {
    const { name, organisation_id } = req.body;
    const id = req.params.id;

    const contact = await orgService.getContact(id);
    if (!contact) return sendError(res, 404, "Contact was not found");

    if (
      !name ||
      !req.files["profile-pic"] ||
      !req.files["IDs"] ||
      !organisation_id
    ) {
      return sendError(
        res,
        400,
        "All fields are required - name, profile picture, ID, organisation_id"
      );
    }

    const uploadResult = await uploadToCloudinary(
      req.files["profile-pic"][0].path,
      "users/profile-pic"
    );

    const idFiles = req.files["IDs"] || [];
    const idResults = await uploadMultipleToCloudinary(idFiles, "users/docs");

    const updated = await orgService.updateContact({
      id,
      name,
      pfp_url: uploadResult.secure_url,
      id_url: idResults.map((img) => img.secure_url),
      organisation_id,
    });

    return sendSuccess(
      res,
      201,
      { Contact: updated, image: { pfp: updated.pfp_url, ID: updated.id_url } },
      "Organisation contact updated successfully"
    );
  } catch (err) {
    return sendError(res, 500, "Could not update contact", err.message);
  }
};

exports.deleteContact = async (req, res) => {
  try {
    const id = req.params.id;

    const contact = await orgService.getContact(id);
    if (!contact) return sendError(res, 404, "Organisation was not found");

    const deleted = await orgService.deleteContact(id);
    return sendSuccess(
      res,
      200,
      { contact: deleted },
      "Contact has been deleted successfully!"
    );
  } catch (err) {
    return sendError(res, 500, "Could not delete contact", err.message);
  }
};
