const { prisma } = require("../config/db");

const getAllorgs = async () => {
  const orgs = await prisma.organisation.findMany({
    where: { deleted_at: null },
    include: {
      user: {
        select: {
          name: true,
        },
      },
    },
  });
  return orgs;
};

const getorgById = async (id) => {
  const org = await prisma.organisation.findUnique({
    where: {
      id: id,
      deleted_at: null,
    },
  });
  return org;
};

/**
 * Creates a new organization record in the database.
 * @param {object} orgData The complete data for the new organization.
 * @returns {Promise<object>} The newly created organization object.
 */
const createOrg = async (orgData) => {
  const {
    name,
    email,
    address,
    country,
    industry,
    rc_number,
    staff_size,
    type,
    logo_url,
    cert_of_inc_url,
    mem_of_assoc_url,
    proof_of_address_url,
    company_status_report_url,
    user_id,
  } = orgData;

  const org = await prisma.organisation.create({
    data: {
      name,
      email,
      address,
      country,
      industry,
      rc_number,
      staff_size,
      type,
      logo_url,
      cert_of_inc_url,
      mem_of_assoc_url,
      proof_of_address_url,
      company_status_report_url,
      user_id,
    },
  });
  return org;
};

const updateOrg = async (
  id,
  {
    name,
    email,
    address,
    country,
    type,
    industry,
    rc_number,
    staff_size,
    logo_url,
  }
) => {
  const updated = await prisma.organisation.update({
    where: {
      id: id,
      deleted_at: null,
    },
    data: {
      name: name,
      email: email,
      address: address,
      country: country,
      type: type,
      industry: industry,
      rc_number: rc_number,
      staff_size: staff_size,
      logo_url: logo_url,
    },
  });
  return updated;
};

const deleteOrg = async (id) => {
  const deleted = await prisma.organisation.update({
    where: {
      id: id,
      deleted_at: null,
    },
    data: {
      deleted_at: new Date(),
    },
  });
  return deleted;
};

const getAllContacts = async () => {
  const contacts = await prisma.contact.findMany({
    where: { deleted_at: null },
    include: {
      organisation: {
        select: {
          name: true,
        },
      },
    },
  });
  return contacts;
};

const getContact = async (id) => {
  const contact = await prisma.contact.findUnique({
    where: {
      id: id,
      deleted_at: null,
    },
    include: {
      organisation: {
        select: {
          name: true,
        },
      },
    },
  });
  return contact;
};

/**
 * Creates a new contact record in the database.
 * @param {object} contactData The data for the new contact.
 * @returns {Promise<object>} The newly created contact object.
 */
const createContact = async ({ name, pfp_url, id_url, organisation_id }) => {
  const contact = await prisma.contact.create({
    data: {
      name,
      pfp_url,
      id_url, // Prisma handles the JSON conversion for the array of URLs
      organisation_id,
    },
  });
  return contact;
};

const updateContact = async ({
  id,
  name,
  pfp_url,
  id_url,
  organisation_id,
}) => {
  const contact = await prisma.contact.update({
    where: {
      id: id,
      deleted_at: null,
    },
    data: {
      name: name,
      pfp_url: pfp_url,
      id_url: id_url,
      organisation_id: organisation_id,
    },
  });
  return contact;
};

const deleteContact = async (id) => {
  const contact = await prisma.contact.update({
    where: {
      id: id,
      deleted_at: null,
    },
    data: {
      deleted_at: new Date(),
    },
  });
  return contact;
};

module.exports = {
  getAllorgs,
  getorgById,
  createOrg,
  updateOrg,
  deleteOrg,
  createContact,
  getContact,
  getAllContacts,
  updateContact,
  deleteContact,
};
