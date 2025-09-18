-- CreateTable
CREATE TABLE `user` (
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
CREATE TABLE `organisation` (
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
    INDEX `organisation_user_id_idx`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `service` (
    `id` CHAR(36) NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `description` TEXT NOT NULL,
    `subtitle` VARCHAR(100) NOT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `admin_id` CHAR(36) NOT NULL,
    `banner_url` TEXT NOT NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `service_admin_id_idx`(`admin_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `service_request` (
    `id` CHAR(36) NOT NULL,
    `message` TEXT NOT NULL,
    `service_id` CHAR(36) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `requested_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `status` VARCHAR(15) NOT NULL,
    `plan_id` CHAR(36) NOT NULL,

    INDEX `service_request_user_id_idx`(`user_id`),
    INDEX `service_request_service_id_idx`(`service_id`),
    INDEX `service_request_plan_id_idx`(`plan_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `case_studies` (
    `id` CHAR(36) NOT NULL,
    `banner` TEXT NOT NULL,
    `challenge` TEXT NOT NULL,
    `challenge_img` TEXT NOT NULL,
    `solution` TEXT NOT NULL,
    `solution_img` TEXT NOT NULL,
    `result` TEXT NOT NULL,
    `result_img` TEXT NOT NULL,
    `service_id` CHAR(36) NOT NULL,
    `organisation_id` CHAR(36) NOT NULL,

    INDEX `case_studies_organisation_id_idx`(`organisation_id`),
    INDEX `case_studies_service_id_idx`(`service_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `testimonial` (
    `id` CHAR(36) NOT NULL,
    `message` TEXT NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `service_id` CHAR(36) NOT NULL,
    `stars` DECIMAL(2, 1) NOT NULL,
    `user_title` TEXT NOT NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `testimonial_user_id_idx`(`user_id`),
    INDEX `testimonial_service_id_idx`(`service_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contact` (
    `id` CHAR(36) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `pfp_url` TEXT NOT NULL,
    `organisation_id` CHAR(36) NOT NULL,
    `id_url` JSON NOT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `contact_organisation_id_idx`(`organisation_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `otp` (
    `id` CHAR(36) NOT NULL,
    `otp` TEXT NOT NULL,
    `expires_at` TIMESTAMP(0) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `user_id` CHAR(36) NOT NULL,

    INDEX `otp_user_id_idx`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `password_token` (
    `id` CHAR(36) NOT NULL,
    `token` TEXT NOT NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `expires_at` TIMESTAMP(0) NULL,
    `user_id` CHAR(36) NOT NULL,

    INDEX `password_token_user_id_idx`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `notification` (
    `id` CHAR(36) NOT NULL,
    `activity` TEXT NOT NULL,
    `completed_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `user_id` CHAR(36) NOT NULL,

    INDEX `notification_user_id_idx`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `privacy_settings` (
    `id` CHAR(36) NOT NULL,
    `ads` BOOLEAN NOT NULL DEFAULT true,
    `data_sharing` BOOLEAN NOT NULL DEFAULT true,
    `marketing_status` BOOLEAN NOT NULL DEFAULT true,
    `activity_status` BOOLEAN NOT NULL DEFAULT true,
    `user_id` CHAR(36) NOT NULL,

    INDEX `privacy_settings_user_id_idx`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `notification_settings` (
    `id` CHAR(36) NOT NULL,
    `alerts` BOOLEAN NOT NULL DEFAULT true,
    `messages` BOOLEAN NOT NULL DEFAULT true,
    `updates` BOOLEAN NOT NULL DEFAULT true,
    `billing_alerts` BOOLEAN NOT NULL DEFAULT true,
    `email` BOOLEAN NOT NULL DEFAULT true,
    `in_app` BOOLEAN NOT NULL DEFAULT true,
    `user_id` CHAR(36) NOT NULL,

    INDEX `notification_settings_user_id_idx`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plan_type` (
    `id` CHAR(36) NOT NULL,
    `name` VARCHAR(20) NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `created_by` CHAR(36) NOT NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `billing_cycle` (
    `id` CHAR(36) NOT NULL,
    `name` VARCHAR(20) NOT NULL,
    `duration_in_days` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `deleted_at` TIMESTAMP(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `plan` (
    `id` CHAR(36) NOT NULL,
    `service_id` CHAR(36) NOT NULL,
    `plan_type_id` CHAR(36) NOT NULL,
    `billing_cycle_id` CHAR(36) NOT NULL,
    `price` INTEGER NOT NULL,
    `description` TEXT NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `subscription` (
    `id` CHAR(36) NOT NULL,
    `start_date` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `end_date` TIMESTAMP(0) NULL,
    `status` VARCHAR(20) NOT NULL,
    `user_id` CHAR(36) NOT NULL,
    `plan_id` CHAR(36) NOT NULL,

    INDEX `subscription_user_id_idx`(`user_id`),
    INDEX `subscription_plan_id_idx`(`plan_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `role` (
    `id` CHAR(36) NOT NULL,
    `title` VARCHAR(25) NOT NULL,
    `description` TEXT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `created_by` CHAR(36) NULL,
    `deleted_at` TIMESTAMP(0) NULL,

    INDEX `role_created_by_idx`(`created_by`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `user` ADD CONSTRAINT `user_role_id_fkey` FOREIGN KEY (`role_id`) REFERENCES `role`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `organisation` ADD CONSTRAINT `organisation_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `service` ADD CONSTRAINT `service_admin_id_fkey` FOREIGN KEY (`admin_id`) REFERENCES `user`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `service_request` ADD CONSTRAINT `service_request_plan_id_fkey` FOREIGN KEY (`plan_id`) REFERENCES `plan`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `service_request` ADD CONSTRAINT `service_request_service_id_fkey` FOREIGN KEY (`service_id`) REFERENCES `service`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `service_request` ADD CONSTRAINT `service_request_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `case_studies` ADD CONSTRAINT `case_studies_organisation_id_fkey` FOREIGN KEY (`organisation_id`) REFERENCES `organisation`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `case_studies` ADD CONSTRAINT `case_studies_service_id_fkey` FOREIGN KEY (`service_id`) REFERENCES `service`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `testimonial` ADD CONSTRAINT `testimonial_service_id_fkey` FOREIGN KEY (`service_id`) REFERENCES `service`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `testimonial` ADD CONSTRAINT `testimonial_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `contact` ADD CONSTRAINT `contact_organisation_id_fkey` FOREIGN KEY (`organisation_id`) REFERENCES `organisation`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `otp` ADD CONSTRAINT `otp_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `password_token` ADD CONSTRAINT `password_token_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `notification` ADD CONSTRAINT `notification_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `privacy_settings` ADD CONSTRAINT `privacy_settings_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `notification_settings` ADD CONSTRAINT `notification_settings_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `plan_type` ADD CONSTRAINT `plan_type_created_by_fkey` FOREIGN KEY (`created_by`) REFERENCES `user`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `plan` ADD CONSTRAINT `plan_service_id_fkey` FOREIGN KEY (`service_id`) REFERENCES `service`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `plan` ADD CONSTRAINT `plan_plan_type_id_fkey` FOREIGN KEY (`plan_type_id`) REFERENCES `plan_type`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `plan` ADD CONSTRAINT `plan_billing_cycle_id_fkey` FOREIGN KEY (`billing_cycle_id`) REFERENCES `billing_cycle`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `subscription` ADD CONSTRAINT `subscription_plan_id_fkey` FOREIGN KEY (`plan_id`) REFERENCES `plan`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `subscription` ADD CONSTRAINT `subscription_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `user`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `role` ADD CONSTRAINT `role_created_by_fkey` FOREIGN KEY (`created_by`) REFERENCES `user`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
