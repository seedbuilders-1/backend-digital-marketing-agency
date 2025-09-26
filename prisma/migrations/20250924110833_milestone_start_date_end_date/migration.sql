/*
  Warnings:

  - You are about to alter the column `status` on the `servicerequest` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Enum(EnumId(0))`.

*/
-- AlterTable
ALTER TABLE `servicerequest` ADD COLUMN `end_date` DATETIME(3) NULL,
    ADD COLUMN `start_date` DATETIME(3) NULL,
    MODIFY `status` ENUM('PENDING_APPROVAL', 'ACTIVE', 'COMPLETED', 'DECLINED', 'CANCELLED') NOT NULL DEFAULT 'PENDING_APPROVAL';

-- CreateTable
CREATE TABLE `Milestone` (
    `id` VARCHAR(191) NOT NULL,
    `service_request_id` VARCHAR(191) NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `deadline` DATETIME(3) NOT NULL,
    `deliverable_url` VARCHAR(191) NULL,
    `deliverable_name` VARCHAR(191) NULL,
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updated_at` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Milestone` ADD CONSTRAINT `Milestone_service_request_id_fkey` FOREIGN KEY (`service_request_id`) REFERENCES `ServiceRequest`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
