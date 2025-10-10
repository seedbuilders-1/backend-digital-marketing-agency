// prisma/seed.js

const bcrypt = require("bcrypt");
const { servicesToSeed } = require("./seed-data/services");
const { PrismaClient } = require("./generated/prisma");

const prisma = new PrismaClient();

const defaultUserRoleTitle = "user";
const defaultAdminRoleTitle = "admin";

async function main() {
  console.log("🚀 Starting the seeding process...");

  // --- 1. Seed Roles ---
  console.log("Checking and seeding roles...");

  await prisma.role.upsert({
    where: { title: defaultUserRoleTitle },
    update: {},
    create: {
      title: defaultUserRoleTitle,
      description: "Default user role with client permissions.",
    },
  });

  await prisma.role.upsert({
    where: { title: defaultAdminRoleTitle },
    update: {},
    create: {
      title: defaultAdminRoleTitle,
      description: "Administrator role with full permissions.",
    },
  });

  console.log("✅ Roles are in sync.");

  // --- 2. Seed Default Admin User ---
  console.log("Checking and seeding default admin user...");
  const defaultAdminEmail = "admin@dma.com";
  const existingAdmin = await prisma.user.findUnique({
    where: { email: defaultAdminEmail },
  });

  if (!existingAdmin) {
    const adminRole = await prisma.role.findUnique({
      where: { title: defaultAdminRoleTitle },
    });

    if (!adminRole) {
      throw new Error(
        "Could not find 'admin' role to create default admin user. Seeding cannot continue."
      );
    }

    const hashedPassword = await bcrypt.hash("password123", 10);

    await prisma.user.create({
      data: {
        name: "Admin User",
        email: defaultAdminEmail,
        tel: "00000000000",
        country: "Nigeria",
        address: "Admin Address",
        category: "organisation",
        password: hashedPassword,
        status: "verified",
        role_id: adminRole.id,
      },
    });
    console.log("✅ Default admin user created.");
  } else {
    console.log("Default admin user already exists.");
  }
  const adminUser = await prisma.user.findUnique({
    where: { email: defaultAdminEmail },
  });
  if (!adminUser) {
    console.error(
      "Critical error: Default admin user not found. Cannot seed services."
    );
    process.exit(1);
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
