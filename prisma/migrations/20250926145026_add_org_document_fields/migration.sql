/*
  Warnings:

  - Added the required column `cert_of_inc_url` to the `Organisation` table without a default value. This is not possible if the table is not empty.
  - Added the required column `company_status_report_url` to the `Organisation` table without a default value. This is not possible if the table is not empty.
  - Added the required column `mem_of_assoc_url` to the `Organisation` table without a default value. This is not possible if the table is not empty.
  - Added the required column `proof_of_address_url` to the `Organisation` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `organisation` ADD COLUMN `cert_of_inc_url` TEXT NOT NULL,
    ADD COLUMN `company_status_report_url` TEXT NOT NULL,
    ADD COLUMN `mem_of_assoc_url` TEXT NOT NULL,
    ADD COLUMN `proof_of_address_url` TEXT NOT NULL;
