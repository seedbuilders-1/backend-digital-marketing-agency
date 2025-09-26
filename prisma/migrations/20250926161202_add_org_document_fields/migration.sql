/*
  Warnings:

  - A unique constraint covering the columns `[user_id]` on the table `Organisation` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE `organisation` DROP FOREIGN KEY `Organisation_user_id_fkey`;

-- DropIndex
DROP INDEX `Organisation_user_id_fkey` ON `organisation`;

-- CreateIndex
CREATE UNIQUE INDEX `Organisation_user_id_key` ON `Organisation`(`user_id`);

-- AddForeignKey
ALTER TABLE `Organisation` ADD CONSTRAINT `Organisation_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
