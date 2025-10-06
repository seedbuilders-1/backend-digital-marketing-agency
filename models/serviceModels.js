const { prisma } = require("../config/db");

const getAllServices = async () => {
  const services = await prisma.service.findMany({
    where: { deleted_at: null },

    include: {
      user: {
        select: {
          name: true,
        },
      },
      plans: true,
      caseStudies: true,
      testimonials: true,
      faqs: true,
    },
  });
  return services;
};

const getAllPublicServices = async () => {
  const services = await prisma.service.findMany({
    where: { deleted_at: null },
    select: {
      id: true,
      title: true,
      heroParagraph: true,
      heroImageUrl: true,
    },
  });
  return services;
};

const getService = async (id) => {
  const service = await prisma.service.findUnique({
    where: {
      id: id,
      deleted_at: null, // Ensure we don't fetch soft-deleted services
    },
    // Include all the nested data you need for the detail page
    include: {
      user: {
        select: {
          name: true,
        },
      },
      plans: true,
      caseStudies: true,
      testimonials: true,
      faqs: true,
      form: true,
    },
  });
  return service;
};

const createService = async ({
  title,
  subtitle,
  description,
  banner_url,
  user_id,
}) => {
  const service = await prisma.service.create({
    data: {
      title: title,
      subtitle: subtitle,
      description: description,
      banner_url: banner_url,
      admin_id: user_id,
    },
    include: {
      user: {
        select: {
          name: true,
        },
      },
    },
  });
  return service;
};

const createServiceWithDetails = async (serviceData) => {
  const { plans, caseStudies, testimonials, faqs, ...mainServiceData } =
    serviceData;

  return await prisma.$transaction(async (tx) => {
    // 1. Create the main service record
    const newService = await tx.service.create({
      data: mainServiceData,
    });

    // 2. Create all related records, linking them with the new service's ID
    if (plans && plans.length > 0) {
      await tx.plan.createMany({
        data: plans.map((plan) => ({ ...plan, service_id: newService.id })),
      });
    }
    if (caseStudies && caseStudies.length > 0) {
      await tx.caseStudy.createMany({
        data: caseStudies.map((cs) => ({ ...cs, service_id: newService.id })),
      });
    }
    if (testimonials && testimonials.length > 0) {
      await tx.testimonial.createMany({
        data: testimonials.map((ts) => ({ ...ts, service_id: newService.id })),
      });
    }
    if (faqs && faqs.length > 0) {
      await tx.faq.createMany({
        data: faqs.map((faq) => ({ ...faq, service_id: newService.id })),
      });
    }

    // 3. Return the fully created service with all its relations
    return await tx.service.findUnique({
      where: { id: newService.id },
      include: {
        plans: true,
        caseStudies: true,
        testimonials: true,
        faqs: true,
      },
    });
  });
};

const updateService = async (id, serviceData) => {
  const { plans, caseStudies, testimonials, faqs, ...mainServiceData } =
    serviceData;

  return await prisma.$transaction(async (tx) => {
    // 1. Update the main service record
    const updatedService = await tx.service.update({
      where: { id: id },
      data: mainServiceData,
    });

    // 2. Delete existing related records
    await Promise.all([
      tx.plan.deleteMany({ where: { service_id: id } }),
      tx.caseStudy.deleteMany({ where: { service_id: id } }),
      tx.testimonial.deleteMany({ where: { service_id: id } }),
      tx.faq.deleteMany({ where: { service_id: id } }),
    ]);

    // 3. Create new related records with the updated data
    if (plans && plans.length > 0) {
      await tx.plan.createMany({
        data: plans.map((plan) => ({ ...plan, service_id: id })),
      });
    }
    if (caseStudies && caseStudies.length > 0) {
      await tx.caseStudy.createMany({
        data: caseStudies.map((cs) => ({ ...cs, service_id: id })),
      });
    }
    if (testimonials && testimonials.length > 0) {
      await tx.testimonial.createMany({
        data: testimonials.map((ts) => ({ ...ts, service_id: id })),
      });
    }
    if (faqs && faqs.length > 0) {
      await tx.faq.createMany({
        data: faqs.map((faq) => ({ ...faq, service_id: id })),
      });
    }

    // 4. Return the fully updated service with all its new relations
    return await tx.service.findUnique({
      where: { id: id },
      include: {
        plans: true,
        caseStudies: true,
        testimonials: true,
        faqs: true,
      },
    });
  });
};

const deleteService = async (id) => {
  const service = await prisma.service.update({
    where: { id: id, deleted_at: null },
    data: {
      deleted_at: new Date(),
    },
  });
  return service;
};

const getCaseStudiesByServiceId = async (id) => {
  const caseStudies = await prisma.case_studies.findMany({
    where: { service_id: id },
    include: {
      organisation: {
        select: {
          name: true,
        },
      },
    },
  });
  return caseStudies;
};

const updateServiceForm = async (serviceId, formFields) => {
  return await prisma.serviceForm.upsert({
    where: { service_id: serviceId },
    update: { formFields: formFields },
    create: {
      service_id: serviceId,
      formFields: formFields,
    },
  });
};

module.exports = {
  getAllServices,
  getAllPublicServices,
  getService,
  createService,
  createServiceWithDetails,
  updateService,
  deleteService,
  getCaseStudiesByServiceId,
  updateServiceForm,
};
