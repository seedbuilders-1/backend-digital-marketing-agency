-- CreateTable
CREATE TABLE `User` (
    `id` CHAR(36) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `tel` VARCHAR(20) NOT NULL,
    `country` VARCHAR(64) NOT NULL,
    `address` TEXT NOT NULL,
    `category` VARCHAR(15) NOT NULL,
    `pfp_url` TEXT NULL,
    `id_url` JSON NULL,
    `business_status` BOOLEAN NULL,
    `registered_with_a_business` BOOLEAN NULL,
    `password` TEXT NOT NULL,
    `status` VARCHAR(10) NOT NULL DEFAULT 'unverified',
    `role_id` CHAR(36) NOT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `deleted_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `email`(`email`),
    UNIQUE INDEX `tel`(`tel`),
    INDEX `user_role_id_fkey`(`role_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Organisation` (
    `id` CHAR(36) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `address` TEXT NOT NULL,
    `country` VARCHAR(64) NOT NULL,
    `industry` TEXT NOT NULL,
    `logo_url` TEXT NOT NULL,
    `rc_number` VARCHAR(20) NOT NULL,
    `staff_size` VARCHAR(15) NOT NULL,
    `type` VARCHAR(50) NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `user_id` CHAR(36) NOT NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    UNIQUE INDEX `email`(`email`),
    UNIQUE INDEX `rc_number`(`rc_number`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Service` (
    `id` CHAR(36) NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `isPublic` BOOLEAN NOT NULL DEFAULT true,
    `heroHeadline` TEXT NULL,
    `heroParagraph` TEXT NULL,
    `heroImageUrl` TEXT NULL,
    `blueprintHeadline` TEXT NULL,
    `blueprintParagraph` TEXT NULL,
    `blueprintImageUrl` TEXT NULL,
    `bannerText` TEXT NULL,
    `admin_id` CHAR(36) NOT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `deleted_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Plan` (
    `id` CHAR(36) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `price` VARCHAR(191) NOT NULL,
    `priceUnit` VARCHAR(20) NOT NULL,
    `audience` VARCHAR(100) NOT NULL,
    `features` JSON NOT NULL,
    `service_id` CHAR(36) NOT NULL,
    `plan_typeId` CHAR(36) NULL,
    `billing_cycleId` CHAR(36) NULL,

    INDEX `Plan_service_id_idx`(`service_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `CaseStudy` (
    `id` CHAR(36) NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `subtitle` VARCHAR(255) NOT NULL,
    `bannerImageUrl` TEXT NULL,
    `challenge` TEXT NULL,
    `challengeImageUrl` TEXT NULL,
    `solution` TEXT NULL,
    `solutionImageUrl` TEXT NULL,
    `result` TEXT NULL,
    `resultImageUrl` TEXT NULL,
    `service_id` CHAR(36) NOT NULL,
    `organisationId` CHAR(36) NULL,

    INDEX `CaseStudy_service_id_idx`(`service_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Testimonial` (
    `id` CHAR(36) NOT NULL,
    `quote` TEXT NOT NULL,
    `authorName` VARCHAR(100) NOT NULL,
    `authorTitle` VARCHAR(100) NOT NULL,
    `stars` INTEGER NOT NULL DEFAULT 5,
    `authorImageUrl` TEXT NULL,
    `service_id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Faq` (
    `id` CHAR(36) NOT NULL,
    `question` TEXT NOT NULL,
    `answer` TEXT NOT NULL,
    `service_id` CHAR(36) NOT NULL,

    INDEX `Faq_service_id_idx`(`service_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Service_request` (
    `id` CHAR(36) NOT NULL,
    `message` TEXT NOT NULL,
    `service_id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `requested_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `status` VARCHAR(15) NOT NULL,
    `plan_id` CHAR(36) NOT NULL,

    INDEX `Service_request_service_id_idx`(`service_id`),
    INDEX `Service_request_plan_id_idx`(`plan_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Contact` (
    `id` CHAR(36) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `pfp_url` TEXT NOT NULL,
    `organisation_id` CHAR(36) NOT NULL,
    `id_url` JSON NOT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `deleted_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Otp` (
    `id` CHAR(36) NOT NULL,
    `otp` TEXT NOT NULL,
    `expires_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `user_id` CHAR(36) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Password_token` (
    `id` CHAR(36) NOT NULL,
    `token` TEXT NOT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `expires_at` TIMESTAMP(0) NULL,
    `user_id` CHAR(36) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Notification` (
    `id` CHAR(36) NOT NULL,
    `activity` TEXT NOT NULL,
    `completed_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `user_id` CHAR(36) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Privacy_settings` (
    `id` CHAR(36) NOT NULL,
    `ads` BOOLEAN NOT NULL DEFAULT true,
    `data_sharing` BOOLEAN NOT NULL DEFAULT true,
    `marketing_status` BOOLEAN NOT NULL DEFAULT true,
    `activity_status` BOOLEAN NOT NULL DEFAULT true,
    `user_id` CHAR(36) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Notification_settings` (
    `id` CHAR(36) NOT NULL,
    `alerts` BOOLEAN NOT NULL DEFAULT true,
    `messages` BOOLEAN NOT NULL DEFAULT true,
    `updates` BOOLEAN NOT NULL DEFAULT true,
    `billing_alerts` BOOLEAN NOT NULL DEFAULT true,
    `email` BOOLEAN NOT NULL DEFAULT true,
    `in_app` BOOLEAN NOT NULL DEFAULT true,
    `user_id` CHAR(36) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Plan_type` (
    `id` CHAR(36) NOT NULL,
    `name` VARCHAR(20) NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `created_by` CHAR(36) NOT NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `Plan_type_created_by_idx`(`created_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Billing_cycle` (
    `id` CHAR(36) NOT NULL,
    `name` VARCHAR(20) NOT NULL,
    `duration_in_days` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `deleted_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Subscription` (
    `id` CHAR(36) NOT NULL,
    `start_date` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `end_date` TIMESTAMP(0) NULL,
    `status` VARCHAR(20) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `plan_id` CHAR(36) NOT NULL,

    INDEX `Subscription_plan_id_idx`(`plan_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Role` (
    `id` CHAR(36) NOT NULL,
    `title` VARCHAR(25) NOT NULL,
    `description` TEXT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `created_by` CHAR(36) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `Role_created_by_idx`(`created_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `User` ADD CONSTRAINT `User_role_id_fkey` FOREIGN KEY (`role_id`) REFERENCES `Role`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Organisation` ADD CONSTRAINT `Organisation_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Service` ADD CONSTRAINT `Service_admin_id_fkey` FOREIGN KEY (`admin_id`) REFERENCES `User`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Plan` ADD CONSTRAINT `Plan_service_id_fkey` FOREIGN KEY (`service_id`) REFERENCES `Service`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Plan` ADD CONSTRAINT `Plan_plan_typeId_fkey` FOREIGN KEY (`plan_typeId`) REFERENCES `Plan_type`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Plan` ADD CONSTRAINT `Plan_billing_cycleId_fkey` FOREIGN KEY (`billing_cycleId`) REFERENCES `Billing_cycle`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CaseStudy` ADD CONSTRAINT `CaseStudy_service_id_fkey` FOREIGN KEY (`service_id`) REFERENCES `Service`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CaseStudy` ADD CONSTRAINT `CaseStudy_organisationId_fkey` FOREIGN KEY (`organisationId`) REFERENCES `Organisation`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Testimonial` ADD CONSTRAINT `Testimonial_service_id_fkey` FOREIGN KEY (`service_id`) REFERENCES `Service`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Testimonial` ADD CONSTRAINT `Testimonial_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Faq` ADD CONSTRAINT `Faq_service_id_fkey` FOREIGN KEY (`service_id`) REFERENCES `Service`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Service_request` ADD CONSTRAINT `Service_request_plan_id_fkey` FOREIGN KEY (`plan_id`) REFERENCES `Plan`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Service_request` ADD CONSTRAINT `Service_request_service_id_fkey` FOREIGN KEY (`service_id`) REFERENCES `Service`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Service_request` ADD CONSTRAINT `Service_request_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Contact` ADD CONSTRAINT `Contact_organisation_id_fkey` FOREIGN KEY (`organisation_id`) REFERENCES `Organisation`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Otp` ADD CONSTRAINT `Otp_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Password_token` ADD CONSTRAINT `Password_token_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Notification` ADD CONSTRAINT `Notification_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Privacy_settings` ADD CONSTRAINT `Privacy_settings_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Notification_settings` ADD CONSTRAINT `Notification_settings_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Plan_type` ADD CONSTRAINT `Plan_type_created_by_fkey` FOREIGN KEY (`created_by`) REFERENCES `User`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Subscription` ADD CONSTRAINT `Subscription_plan_id_fkey` FOREIGN KEY (`plan_id`) REFERENCES `Plan`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Subscription` ADD CONSTRAINT `Subscription_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `Role` ADD CONSTRAINT `Role_created_by_fkey` FOREIGN KEY (`created_by`) REFERENCES `User`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
