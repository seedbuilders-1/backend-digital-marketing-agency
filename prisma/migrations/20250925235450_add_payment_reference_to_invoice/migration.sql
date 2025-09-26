/*
  Warnings:

  - A unique constraint covering the columns `[payment_reference]` on the table `Invoice` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE `invoice` ADD COLUMN `payment_method` VARCHAR(191) NULL,
    ADD COLUMN `payment_reference` VARCHAR(191) NULL;

-- CreateIndex
CREATE UNIQUE INDEX `Invoice_payment_reference_key` ON `Invoice`(`payment_reference`);
