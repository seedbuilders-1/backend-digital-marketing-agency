/*
  Warnings:

  - You are about to drop the column `deliverable_name` on the `milestone` table. All the data in the column will be lost.
  - You are about to drop the column `deliverable_url` on the `milestone` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE `milestone` DROP COLUMN `deliverable_name`,
    DROP COLUMN `deliverable_url`,
    ADD COLUMN `deliverable_file_name` VARCHAR(191) NULL,
    ADD COLUMN `deliverable_file_url` VARCHAR(191) NULL,
    ADD COLUMN `deliverable_link_url` VARCHAR(191) NULL;
