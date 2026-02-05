const { prisma } = require("../config/db");

const getAllUsers = async () => {
  console.log("[MODEL] getAllUsers called");

  // Get total count in database (including soft-deleted)
  const totalCount = await prisma.user.count();
  console.log(`[MODEL] Total users in database: ${totalCount}`);

  // Get all users (no filters - show everything)
  const users = await prisma.user.findMany({
    // Removed deleted_at filter to show ALL users
    // Using `select` is a secure way to explicitly choose the fields you want to return.
    select: {
      id: true,
      name: true,
      email: true,
      tel: true,
      status: true,
      category: true,
      created_at: true,
      deleted_at: true, // Include this so we can see if user was soft-deleted
      role: {
        select: {
          title: true,
        },
      },
    },
    orderBy: {
      created_at: "desc", // Show the most recently created users first
    },
  });

  console.log(`[MODEL] Returning ${users.length} users`);
  console.log(
    `[MODEL] Users with deleted_at set: ${users.filter((u) => u.deleted_at !== null).length}`,
  );

  return users;
};

const getuserById = async (id) => {
  const user = await prisma.user.findUnique({
    where: {
      id: id,
      deleted_at: null,
    },
    omit: {
      password: true,
    },
    include: {
      role: {
        select: {
          title: true,
        },
      },
    },
  });
  return user;
};

/**
 * Retrieves a user by their email, including their role, their organization,
 * and all contacts associated with that organization.
 *
 * @param {string} email The email of the user to find.
 * @returns {Promise<object|null>} A promise that resolves to the user object with
 * nested relations, or null if not found.
 */
const getuserByEmail = async (email) => {
  const user = await prisma.user.findUnique({
    where: {
      email: email,
      deleted_at: null,
    },
    // The `include` clause fetches related data in the same query.
    include: {
      // Keep the existing role inclusion
      role: {
        select: {
          title: true,
        },
      },

      // Include the related Organisation record.
      // If the user has no organization, Prisma will automatically return `null` for this field.
      organisation: {
        // Inside the organization, also include all of its related Contact records.
        include: {
          contacts: true, // `true` fetches all fields for each contact.
        },
      },
    },
  });

  return user;
};

const getupdateUserByEmail = async (id, email) => {
  const rows = await prisma.user.findUnique({
    where: {
      email: email,
      deleted_at: null,
    },
    NOT: {
      id: id,
    },
    include: {
      role: {
        select: {
          title: true,
        },
      },
    },
  });
  return rows;
};

const getuserByTel = async (tel) => {
  const rows = await prisma.user.findUnique({
    where: {
      tel: tel,
      deleted_at: null,
    },
  });
  return rows;
};

const createUser = async ({
  name,
  email,
  tel,
  country,
  city,
  address,
  category,
  password,
}) => {
  const userRole = await prisma.role.findUnique({
    where: {
      title: "user",
    },
  });

  // 2. Add a crucial safety check. If the 'user' role doesn't exist,
  //    the system is in an invalid state. We must throw an error.
  if (!userRole) {
    throw new Error(
      "Default 'user' role not found in the database. Please seed the database.",
    );
  }
  const user = await prisma.user.create({
    data: {
      name: name,
      email: email,
      tel: tel,
      country: country,
      city: city,
      address: address,
      category: category,
      password: password,
      role_id: userRole?.id,
    },
    omit: {
      password: true,
    },
  });

  // These can be run in parallel for better performance
  await Promise.all([
    prisma.notification_settings.create({ data: { user_id: user.id } }),
    prisma.privacy_settings.create({ data: { user_id: user.id } }),
  ]);
  return user;
};

const updateUser = async (
  id,
  { name, email, tel, country, address, category, password },
) => {
  const result = await prisma.user.update({
    where: {
      id: id,
      deleted_at: null,
    },
    data: {
      name: name,
      email: email,
      tel: tel,
      country: country,
      city: city,
      address: address,
      category: category,
      password: password,
    },
    omit: {
      password: true,
    },
  });
  return result;
};

const deleteUser = async (id) => {
  console.log("=== DELETE USER STARTED ===");
  console.log("User ID to delete:", id);

  try {
    // First, get the user to retrieve file URLs for cleanup
    console.log("Step 1: Fetching user data...");
    const user = await prisma.user.findUnique({
      where: { id: id },
      select: {
        id: true,
        name: true,
        email: true,
        pfp_url: true,
        id_url: true,
      },
    });

    if (!user) {
      console.error("ERROR: User not found with ID:", id);
      throw new Error("User not found");
    }

    console.log("User found:", {
      id: user.id,
      name: user.name,
      email: user.email,
    });

    // Delete all related records in the correct order (respecting foreign key constraints)
    // This is a transaction to ensure all-or-nothing deletion
    console.log(
      "Step 2: Starting transaction to delete all related records...",
    );

    await prisma.$transaction(async (tx) => {
      console.log("Transaction started");

      // 1. Delete milestone-related records first
      console.log("Step 2.1: Finding service requests...");
      const serviceRequests = await tx.service_request.findMany({
        where: { user_id: id },
        select: { id: true },
      });
      console.log(`Found ${serviceRequests.length} service requests`);

      for (const request of serviceRequests) {
        console.log(`Processing service request: ${request.id}`);

        // Delete milestone deliverables
        console.log("  - Deleting milestone deliverables...");
        const deliverables = await tx.milestone_deliverable.deleteMany({
          where: {
            milestone: {
              service_request_id: request.id,
            },
          },
        });
        console.log(`  - Deleted ${deliverables.count} milestone deliverables`);

        // Delete milestones
        console.log("  - Deleting milestones...");
        const milestones = await tx.milestone.deleteMany({
          where: { service_request_id: request.id },
        });
        console.log(`  - Deleted ${milestones.count} milestones`);
      }

      // 2. Delete messages and conversations
      console.log("Step 2.2: Deleting messages...");
      const messages = await tx.message.deleteMany({
        where: {
          conversation: {
            service_request: {
              user_id: id,
            },
          },
        },
      });
      console.log(`Deleted ${messages.count} messages`);

      console.log("Step 2.3: Deleting conversations...");
      const conversations = await tx.conversation.deleteMany({
        where: {
          service_request: {
            user_id: id,
          },
        },
      });
      console.log(`Deleted ${conversations.count} conversations`);

      // 3. Delete service requests
      console.log("Step 2.4: Deleting service requests...");
      const requests = await tx.service_request.deleteMany({
        where: { user_id: id },
      });
      console.log(`Deleted ${requests.count} service requests`);

      // 4. Delete invoices and payments
      console.log("Step 2.5: Deleting payments...");
      const payments = await tx.payment.deleteMany({
        where: {
          invoice: {
            user_id: id,
          },
        },
      });
      console.log(`Deleted ${payments.count} payments`);

      console.log("Step 2.6: Deleting invoices...");
      const invoices = await tx.invoice.deleteMany({
        where: { user_id: id },
      });
      console.log(`Deleted ${invoices.count} invoices`);

      // 5. Delete referrals (both as referrer and referee)
      console.log("Step 2.7: Deleting referrals...");
      const referrals = await tx.referral.deleteMany({
        where: {
          OR: [{ referrer_id: id }, { referee_id: id }],
        },
      });
      console.log(`Deleted ${referrals.count} referrals`);

      // 6. Delete authentication and settings records
      console.log("Step 2.8: Deleting OTPs...");
      const otps = await tx.otp.deleteMany({ where: { user_id: id } });
      console.log(`Deleted ${otps.count} OTPs`);

      console.log("Step 2.9: Deleting password tokens...");
      const tokens = await tx.password_token.deleteMany({
        where: { user_id: id },
      });
      console.log(`Deleted ${tokens.count} password tokens`);

      console.log("Step 2.10: Deleting privacy settings...");
      const privacy = await tx.privacy_settings.deleteMany({
        where: { user_id: id },
      });
      console.log(`Deleted ${privacy.count} privacy settings`);

      console.log("Step 2.11: Deleting notification settings...");
      const notifications = await tx.notification_settings.deleteMany({
        where: { user_id: id },
      });
      console.log(`Deleted ${notifications.count} notification settings`);

      // 7. Delete organization if user owns one
      console.log("Step 2.12: Deleting organizations...");
      const orgs = await tx.organisation.deleteMany({
        where: { user_id: id },
      });
      console.log(`Deleted ${orgs.count} organizations`);

      // 8. Finally, delete the user
      console.log("Step 2.13: Deleting user record...");
      await tx.user.delete({
        where: { id: id },
      });
      console.log("User record deleted successfully");

      console.log("Transaction completed successfully");
    });

    console.log("Step 3: All deletions completed successfully");
    console.log("=== DELETE USER COMPLETED ===");

    // Note: Cloudinary file deletion would happen here if needed
    // You would need to import cloudinary service and delete files:
    // - user.pfp_url (profile picture)
    // - user.id_url (ID documents - array)
    // Example: await cloudinary.deleteFiles([user.pfp_url, ...user.id_url]);

    return user;
  } catch (error) {
    console.error("=== DELETE USER FAILED ===");
    console.error("Error type:", error.name);
    console.error("Error message:", error.message);
    console.error("Error stack:", error.stack);
    console.error("Full error object:", error);
    throw error;
  }
};

const profile = async (
  id,
  { pfp_url, id_url, business_status, registered_with_a_business },
) => {
  const profile = await prisma.user.update({
    where: {
      id: id,
      deleted_at: null,
    },
    data: {
      pfp_url: pfp_url,
      id_url: id_url,
      business_status: business_status,
      registered_with_a_business: registered_with_a_business,
    },
    omit: {
      password: true,
    },
  });
  return profile;
};

module.exports = {
  getAllUsers,
  getuserById,
  getuserByEmail,
  getupdateUserByEmail,
  getuserByTel,
  createUser,
  updateUser,
  deleteUser,
  profile,
};
