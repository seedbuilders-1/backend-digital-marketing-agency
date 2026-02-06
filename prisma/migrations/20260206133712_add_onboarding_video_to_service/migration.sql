-- AlterTable
ALTER TABLE `Plan` ADD COLUMN `discountPercentage` INTEGER NOT NULL DEFAULT 50;

-- AlterTable
ALTER TABLE `Service` ADD COLUMN `onboardingVideoUrl` TEXT NULL;

-- AlterTable
ALTER TABLE `Testimonial` ADD COLUMN `link` TEXT NULL;
