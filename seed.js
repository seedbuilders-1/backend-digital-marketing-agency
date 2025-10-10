// prisma/seed.js

const bcrypt = require("bcrypt");
const { servicesToSeed } = require("./seed-data/services");
const { PrismaClient } = require("./generated/prisma");

const prisma = new PrismaClient();

// Define your default Role IDs here for consistency
const defaultUserRoleId = "your-default-user-role-id"; // IMPORTANT: Replace if different
const defaultAdminRoleId = "your-default-admin-role-id"; // IMPORTANT: Replace if different

async function main() {
  console.log("🚀 Starting the seeding process...");

  // --- 1. Seed Roles ---
  console.log("Checking and seeding roles...");
  const roles = [
    {
      id: defaultUserRoleId,
      title: "user",
      description: "Default user role",
    },
    {
      id: defaultAdminRoleId,
      title: "admin",
      description: "Administrator role with full permissions",
    },
  ];

  for (const role of roles) {
    const existingRole = await prisma.role.findUnique({
      where: { id: role.id },
    });

    if (!existingRole) {
      await prisma.role.create({ data: role });
      console.log(`Role created: ${role.title}`);
    } else {
      console.log(`Role already exists: ${role.title}`);
    }
  }

  // --- Create a default user if it doesn't exist ---
  const defaultAdminEmail = "admin@dma.com";

  const existingUser = await prisma.user.findUnique({
    where: { email: defaultAdminEmail },
  });

  if (!existingUser) {
    const hashedPassword = await bcrypt.hash("password123", 10);

    const newUser = await prisma.user.create({
      data: {
        name: "Admin",
        email: defaultAdminEmail,
        tel: "+1234567890",
        country: "Unknown",
        city: "unknown",
        address: "Default Address",
        category: "Individual",
        password: hashedPassword,
        role_id: defaultAdminRoleId, // assign default user role
      },
    });

    console.log("Default admin created:", newUser);
  } else {
    console.log("Default user already exists:", existingUser.email);
  }

  const adminUser = await prisma.user.findUnique({
    where: { email: defaultAdminEmail },
  });
  if (!adminUser) {
    console.error(
      "Critical error: Default admin user not found. Cannot seed services."
    );
    process.exit(1); // Exit the script if the admin doesn't exist
  }

  // --- 3. Seed Services and All Related Data ---
  console.log("Checking and seeding services...");

  // Clean up old service-related data to ensure a fresh start
  console.log("🧹 Cleaning old service-related data...");
  await prisma.plan.deleteMany({});
  await prisma.faq.deleteMany({});
  await prisma.caseStudy.deleteMany({}); // <-- ADDED
  await prisma.testimonial.deleteMany({}); // <-- ADDED
  await prisma.service.deleteMany({});
  console.log("✅ Old data deleted.");

  for (const serviceData of servicesToSeed) {
    // Destructure all relations from the main service data
    const { plans, faqs, caseStudies, testimonials, ...mainServiceData } =
      serviceData;

    // Use a transaction for each service to ensure all related data is created successfully
    await prisma.$transaction(async (tx) => {
      // Create the main Service record
      const service = await tx.service.create({
        data: {
          ...mainServiceData,
          // Use Prisma's `connect` syntax to link to an existing user
          user: {
            connect: {
              id: adminUser.id,
            },
          },
        },
      });
      console.log(`- Created service: ${service.title}`);

      if (plans && plans.length > 0) {
        for (const plan of plans) {
          await tx.plan.create({
            data: {
              ...plan, // `plan.features` is already a JS array from our data file
              service_id: service.id,
            },
          });
        }
      }

      // Create related FAQs
      if (faqs && faqs.length > 0) {
        await tx.faq.createMany({
          data: faqs.map((faq) => ({
            ...faq,
            service_id: service.id,
          })),
        });
      }

      // --- NEWLY ADDED LOGIC ---
      // Create related Case Studies
      if (caseStudies && caseStudies.length > 0) {
        await tx.caseStudy.createMany({
          data: caseStudies.map((cs) => ({
            ...cs,
            service_id: service.id,
          })),
        });
      }

      // Create related Testimonials
      if (testimonials && testimonials.length > 0) {
        await tx.testimonial.createMany({
          data: testimonials.map((ts) => ({
            ...ts,
            service_id: service.id,
          })),
        });
      }
      // --- END NEW LOGIC ---
    });
  }
  console.log("✅ All services and their relations seeded successfully.");

  console.log("🏁 Seeding finished.");
}

// --- Main Execution Block ---
main()
  .catch((e) => {
    console.error("An error occurred during seeding:", e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
