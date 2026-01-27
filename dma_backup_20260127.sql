/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.4.9-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: secukgjn_dma_prod
-- ------------------------------------------------------
-- Server version	11.4.9-MariaDB-cll-lve-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `Billing_cycle`
--

DROP TABLE IF EXISTS `Billing_cycle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Billing_cycle` (
  `id` char(36) NOT NULL,
  `name` varchar(20) NOT NULL,
  `duration_in_days` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Billing_cycle`
--

LOCK TABLES `Billing_cycle` WRITE;
/*!40000 ALTER TABLE `Billing_cycle` DISABLE KEYS */;
/*!40000 ALTER TABLE `Billing_cycle` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CaseStudy`
--

DROP TABLE IF EXISTS `CaseStudy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `CaseStudy` (
  `id` char(36) NOT NULL,
  `title` varchar(255) NOT NULL,
  `subtitle` varchar(255) NOT NULL,
  `bannerImageUrl` text DEFAULT NULL,
  `challenge` text DEFAULT NULL,
  `challengeImageUrl` text DEFAULT NULL,
  `solution` text DEFAULT NULL,
  `solutionImageUrl` text DEFAULT NULL,
  `result` text DEFAULT NULL,
  `resultImageUrl` text DEFAULT NULL,
  `service_id` char(36) NOT NULL,
  `organisationId` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `CaseStudy_service_id_idx` (`service_id`),
  KEY `CaseStudy_organisationId_fkey` (`organisationId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CaseStudy`
--

LOCK TABLES `CaseStudy` WRITE;
/*!40000 ALTER TABLE `CaseStudy` DISABLE KEYS */;
/*!40000 ALTER TABLE `CaseStudy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Contact`
--

DROP TABLE IF EXISTS `Contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Contact` (
  `id` char(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `pfp_url` text NOT NULL,
  `organisation_id` char(36) NOT NULL,
  `id_url` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`id_url`)),
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Contact_organisation_id_fkey` (`organisation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Contact`
--

LOCK TABLES `Contact` WRITE;
/*!40000 ALTER TABLE `Contact` DISABLE KEYS */;
INSERT INTO `Contact` VALUES
('023493f4-291b-43f0-863c-4cb5a64b636d','TYYYU','https://res.cloudinary.com/ddrutuohj/image/upload/v1760596168/contacts/pfp/lqswfde6dfytyfafe94m.jpg','39166324-4416-4164-9bef-a38e6af5a0f6','[\"https://res.cloudinary.com/ddrutuohj/image/upload/v1760596168/contacts/docs/u1oxrgq03vzgsfuxour0.jpg\"]','2025-10-16 10:29:28',NULL),
('aa61a7a2-2f3e-4b9b-9f9c-5f03ddc8c86f','sssssss','https://res.cloudinary.com/ddrutuohj/image/upload/v1761123507/contacts/pfp/w4cbmtsuwss4nozqb27z.jpg','0d51db93-c8f1-4f61-8448-496fae3b4127','[\"https://res.cloudinary.com/ddrutuohj/image/upload/v1761123507/contacts/docs/ozrjvl1p2oefggghu3da.pdf\"]','2025-10-22 12:58:27',NULL);
/*!40000 ALTER TABLE `Contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Conversation`
--

DROP TABLE IF EXISTS `Conversation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Conversation` (
  `id` varchar(191) NOT NULL,
  `service_request_id` varchar(191) NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Conversation_service_request_id_key` (`service_request_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Conversation`
--

LOCK TABLES `Conversation` WRITE;
/*!40000 ALTER TABLE `Conversation` DISABLE KEYS */;
INSERT INTO `Conversation` VALUES
('31e85da7-7a08-4eb8-9a02-1a0765088dea','0ff9d1f8-2498-4db2-a36f-b17d8309fa09','2025-10-22 08:47:33.638','2025-10-22 08:47:33.638'),
('36466cbc-5b27-48ac-b87d-532f5d01c773','cae2cf96-fb45-4181-80fd-805c8a53b4df','2025-12-01 12:36:25.524','2025-12-01 12:36:25.524');
/*!40000 ALTER TABLE `Conversation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Faq`
--

DROP TABLE IF EXISTS `Faq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Faq` (
  `id` char(36) NOT NULL,
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `service_id` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Faq_service_id_idx` (`service_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Faq`
--

LOCK TABLES `Faq` WRITE;
/*!40000 ALTER TABLE `Faq` DISABLE KEYS */;
/*!40000 ALTER TABLE `Faq` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Invoice`
--

DROP TABLE IF EXISTS `Invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Invoice` (
  `id` varchar(191) NOT NULL,
  `user_id` varchar(191) NOT NULL,
  `service_request_id` varchar(191) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` varchar(191) NOT NULL,
  `due_date` datetime(3) NOT NULL,
  `paid_at` datetime(3) DEFAULT NULL,
  `payment_method` varchar(191) DEFAULT NULL,
  `payment_reference` varchar(191) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Invoice_service_request_id_key` (`service_request_id`),
  UNIQUE KEY `Invoice_payment_reference_key` (`payment_reference`),
  KEY `Invoice_user_id_fkey` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Invoice`
--

LOCK TABLES `Invoice` WRITE;
/*!40000 ALTER TABLE `Invoice` DISABLE KEYS */;
INSERT INTO `Invoice` VALUES
('f700374e-b83a-41e1-af30-0b223790c03a','1d0ee97c-c72c-40ff-bd10-3ff86a2cb7c8','9453b4d8-b700-4411-b56a-9fe0dfa563de',0.00,'Paid','2026-01-23 00:00:00.000',NULL,'Free Plan',NULL,'2026-01-26 22:17:28.752','2026-01-26 22:17:28.752'),
('f3b578aa-84e3-4ee6-8a76-317a498bb6ae','1d0ee97c-c72c-40ff-bd10-3ff86a2cb7c8','d1518a44-8b3d-4035-ba4e-4f7b2b1a0415',0.00,'Unpaid','2026-01-30 00:00:00.000',NULL,NULL,'2fc1273a-c0be-45ad-af0d-e6a46ba0eaba','2026-01-26 22:14:08.492','2026-01-26 22:14:26.001'),
('bd820a9d-915d-4874-9cc5-89c3934ae53e','1d0ee97c-c72c-40ff-bd10-3ff86a2cb7c8','b44f4e12-0723-43ed-8962-e725ffb67676',100000.00,'Unpaid','2026-01-29 00:00:00.000',NULL,NULL,'29d5e652-fb2f-496f-986b-d023e351951b','2026-01-26 22:08:42.210','2026-01-26 22:08:58.104'),
('0aace5b4-3eb5-433c-85ad-d71d4a3fb78f','b5f87ce0-e3b5-4a00-992c-c3666bdef154','c46777d5-766d-4d2c-a302-769a0ea7a3a4',100000.00,'Unpaid','2026-01-30 00:00:00.000',NULL,NULL,NULL,'2026-01-26 16:23:29.799','2026-01-26 16:23:29.799'),
('2dd54192-96c5-4de0-82fc-8a6a1d1ded2b','fcba6ceb-f506-458d-b5f1-4cca8af09608','0ff9d1f8-2498-4db2-a36f-b17d8309fa09',2500.00,'Paid','2025-10-25 00:00:00.000',NULL,'Paystack','800196d6-869f-4370-9484-f07d7f3a24d8','2025-10-21 13:54:03.133','2025-10-21 13:56:02.905'),
('dd20ef4a-6e04-4ffb-bbb0-d15e8c89ac1a','28d31f78-3fe9-43ac-a20f-8a2730879296','1c16d90a-05a8-4b69-9cf3-44ad7c4997a6',5000.00,'Unpaid','2026-01-30 00:00:00.000',NULL,NULL,NULL,'2026-01-15 14:45:03.174','2026-01-15 14:45:03.174'),
('c80035d3-b9c3-4d01-9ca4-4bce90543b63','95e1a648-2785-4d51-9d42-90bb0f644d8a','cae2cf96-fb45-4181-80fd-805c8a53b4df',50000.00,'Unpaid','2025-12-01 00:00:00.000',NULL,NULL,NULL,'2025-12-01 12:30:29.744','2025-12-01 12:30:29.744');
/*!40000 ALTER TABLE `Invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Message`
--

DROP TABLE IF EXISTS `Message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Message` (
  `id` varchar(191) NOT NULL,
  `conversation_id` varchar(191) NOT NULL,
  `sender_id` varchar(191) NOT NULL,
  `text` text NOT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  PRIMARY KEY (`id`),
  KEY `Message_conversation_id_fkey` (`conversation_id`),
  KEY `Message_sender_id_fkey` (`sender_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Message`
--

LOCK TABLES `Message` WRITE;
/*!40000 ALTER TABLE `Message` DISABLE KEYS */;
INSERT INTO `Message` VALUES
('927779f7-546b-461f-be47-c38733fece67','31e85da7-7a08-4eb8-9a02-1a0765088dea','a20b1f85-d726-4ff1-9259-872f2d2b0b1f','Dear RepairWolf,\n\nThank you for your request for a single flyer. We appreciate your interest and are ready to assist with the design. However, we currently do not have sufficient information regarding the specific content or details you would like to include on the flyer.\n\nKindly provide the necessary details so we can proceed accordingly. You may either share a link to a resource containing all the required information or type the details directly here.\n\nWe look forward to your response.\n\nWarm regards,\nAbubakar Usman\nThe Digital Marketing Agency','2025-10-22 08:47:33.644'),
('abb19672-7e8a-48c3-9bc9-4f640bc2ac6c','98a377c8-b362-4fb4-89c6-43e8b57020e7','a20b1f85-d726-4ff1-9259-872f2d2b0b1f','how far relax o','2025-10-22 09:39:55.964'),
('61302d34-ab9a-4064-ba20-c77e6e4fe2ea','98a377c8-b362-4fb4-89c6-43e8b57020e7','1d0ee97c-c72c-40ff-bd10-3ff86a2cb7c8','no vex\n\ni dey emergency abeg','2025-10-22 09:40:21.800'),
('dd01658f-cdad-4a11-ac5a-7d9f7de4ef0b','31e85da7-7a08-4eb8-9a02-1a0765088dea','fcba6ceb-f506-458d-b5f1-4cca8af09608','🎯 RepairWolf Social Media Flyer Ad Brief\n\nTarget Audience: Property Managers & Facilities Managers\nCampaign Goal: Awareness & Lead Generation\nAd Format: Instagram + Facebook Flyer (1080x1080)\nVisual Style: Clean, professional, trustworthy, with multi-trade imagery (plumbing, electrical, cleaning, etc.)\nCTA: “Message us on WhatsApp” + website link + phone icon\n\n\n---\n\n🧱 Core Content for the Flyer\n\n📣 Headline (Bold, Big Font):\n\"Property Repairs Made Simple.\"\n\n📌 Subheadline / Tagline:\nOne trusted platform for all your maintenance needs.\n\n🧰 Problem (small icons or bullets):\n\nChasing multiple contractors\n\nPoor reporting & documentation\n\nInconsistent repair quality\n\n\n✅ Solution (visually highlighted):\n✔ Multi-trade service under one roof\n✔ Live updates & professional reports\n✔ Emergency response & scheduled works\n\n💬 Messaging Angle (caption or quote-style):\n“Simplify your operations with one trusted repair partner.”\n\n\n---\n\n📲 Call to Action\n\nWhatsApp CTA: “Message us today – Get started in minutes!”\n\nContact Info:\n📱 +44 7572 360043\n🌐 www.repairwolf.co.uk\n🔗 Link in bio\n\n\n\n---\n\n🔧 Suggested Image Elements\n\nA photo of a property manager reviewing a checklist with tradespeople\n\nIcon grid showing plumbing, electrical, painting, cleaning\n\nWhatsApp logo + RepairWolf logo','2025-10-22 09:56:04.918'),
('a863b92a-6407-4b78-90ac-b6078eac1b9a','36466cbc-5b27-48ac-b87d-532f5d01c773','95e1a648-2785-4d51-9d42-90bb0f644d8a','Hello this is grace','2025-12-01 12:36:25.527');
/*!40000 ALTER TABLE `Message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Milestone`
--

DROP TABLE IF EXISTS `Milestone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Milestone` (
  `id` varchar(191) NOT NULL,
  `service_request_id` varchar(191) NOT NULL,
  `title` varchar(191) NOT NULL,
  `deadline` datetime(3) NOT NULL,
  `deliverable_file_url` varchar(191) DEFAULT NULL,
  `deliverable_file_name` varchar(191) DEFAULT NULL,
  `deliverable_link_url` varchar(191) DEFAULT NULL,
  `status` enum('PENDING_ADMIN_UPLOAD','PENDING_CLIENT_APPROVAL','APPROVED','REJECTED') NOT NULL DEFAULT 'PENDING_ADMIN_UPLOAD',
  `rejection_reason` varchar(191) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Milestone_service_request_id_fkey` (`service_request_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Milestone`
--

LOCK TABLES `Milestone` WRITE;
/*!40000 ALTER TABLE `Milestone` DISABLE KEYS */;
INSERT INTO `Milestone` VALUES
('af22bbc0-a50f-4fa9-a02d-a3b242ff7dfc','0ff9d1f8-2498-4db2-a36f-b17d8309fa09','Final Design','2025-10-22 00:00:00.000','https://res.cloudinary.com/ddrutuohj/image/upload/v1761221380/deliverables/af22bbc0-a50f-4fa9-a02d-a3b242ff7dfc/fdymtemoqq4ztyrhqvg1.png','RepairWolf  - 4.png','https://drive.google.com/file/d/1Ncue90LbriEHd-rPplPNszxkihVwyAND/view?usp=drive_link','PENDING_CLIENT_APPROVAL',NULL,'2025-10-22 13:34:29.531','2025-10-23 12:09:41.517');
/*!40000 ALTER TABLE `Milestone` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Notification`
--

DROP TABLE IF EXISTS `Notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Notification` (
  `id` char(36) NOT NULL,
  `activity` text NOT NULL,
  `completed_at` timestamp NULL DEFAULT current_timestamp(),
  `user_id` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Notification_user_id_fkey` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Notification`
--

LOCK TABLES `Notification` WRITE;
/*!40000 ALTER TABLE `Notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `Notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Notification_settings`
--

DROP TABLE IF EXISTS `Notification_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Notification_settings` (
  `id` char(36) NOT NULL,
  `alerts` tinyint(1) NOT NULL DEFAULT 1,
  `messages` tinyint(1) NOT NULL DEFAULT 1,
  `updates` tinyint(1) NOT NULL DEFAULT 1,
  `billing_alerts` tinyint(1) NOT NULL DEFAULT 1,
  `email` tinyint(1) NOT NULL DEFAULT 1,
  `in_app` tinyint(1) NOT NULL DEFAULT 1,
  `user_id` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Notification_settings_user_id_fkey` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Notification_settings`
--

LOCK TABLES `Notification_settings` WRITE;
/*!40000 ALTER TABLE `Notification_settings` DISABLE KEYS */;
INSERT INTO `Notification_settings` VALUES
('5436e1b1-3dfa-42f9-8eba-d4dc0464fa4c',1,1,1,1,1,1,'1d0ee97c-c72c-40ff-bd10-3ff86a2cb7c8'),
('df80c993-f294-4158-b86f-3904afa7866b',1,1,1,1,1,1,'b5f87ce0-e3b5-4a00-992c-c3666bdef154'),
('d0bcaf84-93fe-4287-841c-3d3f232b8c52',1,1,1,1,1,1,'c0090779-93e9-4648-9504-07c0efb9a8c5'),
('5d76ed45-0c18-45f7-8379-eeea2cb58f0f',1,1,1,1,1,1,'38f2c5fe-b708-4ae5-85e2-5b1fb974fe25'),
('31f9ca39-fa88-45f5-a947-4fadd37858f3',1,1,1,1,1,1,'fa639c0d-fff1-49c7-81c9-4e11ec563e20'),
('3fe826f6-857f-405a-abcc-68b756029736',1,1,1,1,1,1,'3b9cb719-bb98-438c-b0da-a97f36cd8e43'),
('67eec012-6c60-4475-9865-bea3bb22fb39',1,1,1,1,1,1,'dcb92470-2499-4cc3-9d4d-0601dd901674'),
('bd3c4457-253a-4c59-967e-e866c48ba5b6',1,1,1,1,1,1,'3131267a-0afc-4b63-b95d-10e8238381c1'),
('771f9a63-f0aa-4e51-9f1a-cb1458bd00af',1,1,1,1,1,1,'fcba6ceb-f506-458d-b5f1-4cca8af09608'),
('7f63bb57-5108-4f5a-8dd8-4bd1181bf49c',1,1,1,1,1,1,'9cb0da9d-b7b0-44f1-8442-3fc952de963f'),
('4cd03974-ce33-48bf-8014-d3fcfcf1c98a',1,1,1,1,1,1,'17f24fe1-aa2b-436a-82cd-dcc216a47df5'),
('6e092646-4304-4ac8-8434-df472d695062',1,1,1,1,1,1,'825d0530-0267-45f0-bc5e-dd46fddc415e'),
('65cb2226-b661-4472-a3b0-cab930fd3a40',1,1,1,1,1,1,'f7c22824-5cc4-44c3-80a9-460baa1284a5'),
('00fe4ae7-3f97-483a-a0f0-ed18f7e838ba',1,1,1,1,1,1,'b197e1ff-76b4-446b-b75a-aea265a9d4c4'),
('8e1c8692-1ee2-40f0-967b-f0923960d6ad',1,1,1,1,1,1,'95e1a648-2785-4d51-9d42-90bb0f644d8a'),
('4c939f7a-e2b7-419d-afeb-9cbd0c42a198',1,1,1,1,1,1,'e3edf68d-a291-4705-b3b3-41f03385b785'),
('b8b0b7e6-fd20-4c1d-9f83-3ac2e31e2a3b',1,1,1,1,1,1,'232f7ed9-037a-4920-a859-843a4cf80ff1'),
('d91dc5c9-8954-4d28-82f9-4846b454b060',1,1,1,1,1,1,'09b85110-ea6d-441f-8fb3-01e75f9d4b22'),
('893266ea-0a48-4e70-82b1-a6c4d1f6c754',1,1,1,1,1,1,'12157a9e-f33c-42e5-980b-1df42a1df11a'),
('345c48ef-ce0c-4533-91f8-c67d08db1e97',1,1,1,1,1,1,'4a92a5b7-7922-4144-8299-8479e7c7157c'),
('88f99310-173f-42a6-b380-ca9d97ba5c7f',1,1,1,1,1,1,'4b1ec1f7-bd2e-43d0-867d-a2861132c263'),
('81afaaf0-327a-4842-91ee-90c58217c1ac',1,1,1,1,1,1,'292bb7c3-9824-470d-9340-eca4e4ea66e7'),
('63463a8b-64d7-4bfe-9980-34f749070c58',1,1,1,1,1,1,'840c1bca-4b39-4f6f-bcdf-ffba6bb9ec9a'),
('bd3011d8-7318-466e-a91d-167d79b35780',1,1,1,1,1,1,'eb289c1a-46c4-401a-b8b6-13c13e870c08'),
('d844307e-aec9-4587-ae01-2139f58144c2',1,1,1,1,1,1,'5fb1c8c8-44ef-4c86-b0b0-679c991b7a79'),
('41a049c2-e340-4130-abd0-2c21e53b9709',1,1,1,1,1,1,'e0dcf21b-8187-4006-b932-693dcb855b34'),
('856e75e1-f997-4691-b78d-7e48d3884a6d',1,1,1,1,1,1,'cdc34d54-6879-47f6-af52-b5d8412f8034'),
('e749ebf1-91ee-46d3-86f9-2031ecf34703',1,1,1,1,1,1,'125dc9a8-0a91-47bb-b8a6-42cbd378d0c4'),
('81671962-64d3-488c-a247-a139b46c7b59',1,1,1,1,1,1,'8c9dc235-737d-4563-9eb5-099971d84e15'),
('e6e2e131-6b24-4d48-a80f-41226cb956fc',1,1,1,1,1,1,'1256bb0f-bed6-488b-ab8b-84cfcad54220'),
('3f39f092-ce85-4ab9-8660-73f4ffad63e9',1,1,1,1,1,1,'211c15d3-6eba-4bbc-b276-3ec3ea46ad9b'),
('f6809e66-6650-4ebe-90fb-5bdec88183d4',1,1,1,1,1,1,'c87a282b-9d49-443b-8567-6d90f24933e0'),
('3fe26002-5535-49d6-a2cc-96bb75ddbc6f',1,1,1,1,1,1,'28d31f78-3fe9-43ac-a20f-8a2730879296'),
('7e3ad567-5e68-4c6c-8254-e9994c29adcf',1,1,1,1,1,1,'f4aa2960-1829-4084-adfb-68fef7d4d527'),
('eaeff66d-e430-4fd2-8dc3-d42228cd5cd6',1,1,1,1,1,1,'8aee7c57-7b67-4383-8a4e-061f6667c852'),
('33da2292-04c3-4721-ac5a-7cdc09322b65',1,1,1,1,1,1,'954f0742-a728-41c2-b73f-06cf617a809c'),
('4cd79fa2-5342-4847-b48a-f48b9ebb9ea4',1,1,1,1,1,1,'1d761c7c-a133-4924-9a67-e7013136be0c');
/*!40000 ALTER TABLE `Notification_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Organisation`
--

DROP TABLE IF EXISTS `Organisation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Organisation` (
  `id` char(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `country` varchar(64) NOT NULL,
  `industry` text NOT NULL,
  `logo_url` text NOT NULL,
  `rc_number` varchar(20) NOT NULL,
  `staff_size` varchar(15) NOT NULL,
  `type` varchar(50) NOT NULL,
  `cert_of_inc_url` text NOT NULL,
  `mem_of_assoc_url` text NOT NULL,
  `proof_of_address_url` text NOT NULL,
  `company_status_report_url` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `user_id` char(36) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rc_number` (`rc_number`),
  UNIQUE KEY `Organisation_user_id_key` (`user_id`),
  UNIQUE KEY `email` (`email`) USING HASH
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Organisation`
--

LOCK TABLES `Organisation` WRITE;
/*!40000 ALTER TABLE `Organisation` DISABLE KEYS */;
INSERT INTO `Organisation` VALUES
('39166324-4416-4164-9bef-a38e6af5a0f6','Seedbuilders','ola@seedbuildersng.com','6a embu street','Nigeria','Agriculture','https://res.cloudinary.com/ddrutuohj/image/upload/v1760596069/orgs/logos/cnny2oooak9ngahs7mge.jpg','6788890','11-50','Limited Liability Company','https://res.cloudinary.com/ddrutuohj/image/upload/v1760596069/orgs/documents/qy7s8qp1ei6pmmxpguhn.jpg','https://res.cloudinary.com/ddrutuohj/image/upload/v1760596069/orgs/documents/xbr5gnnsk3cwvxh2grl6.jpg','https://res.cloudinary.com/ddrutuohj/image/upload/v1760596069/orgs/documents/fq1euc4qvqzp0ftvjyys.jpg','https://res.cloudinary.com/ddrutuohj/image/upload/v1760596069/orgs/documents/jnnlraqnikvtrild9r44.jpg','2025-10-16 10:27:50','fa639c0d-fff1-49c7-81c9-4e11ec563e20',NULL),
('0d51db93-c8f1-4f61-8448-496fae3b4127','ssg','sgsg@hgsh.ss','sggshshshshshsh','Nigeria','Public Sector','https://res.cloudinary.com/ddrutuohj/image/upload/v1761123407/orgs/logos/omccdqeavaixmjx0im13.avif','shshsh','1-10','Sole Proprietorship','https://res.cloudinary.com/ddrutuohj/image/upload/v1761123408/orgs/documents/ibti3schzw42itkeqyh5.avif','https://res.cloudinary.com/ddrutuohj/image/upload/v1761123408/orgs/documents/fehuzbgplahtxcvexzbb.avif','https://res.cloudinary.com/ddrutuohj/image/upload/v1761123407/orgs/documents/exj37gzce7uhmkxqfm92.avif','https://res.cloudinary.com/ddrutuohj/image/upload/v1761123407/orgs/documents/q30pcg61tf5bbendzpz2.avif','2025-10-22 12:56:49','a20b1f85-d726-4ff1-9259-872f2d2b0b1f',NULL),
('422e48b8-f8ba-43f0-b66b-ab634b5f44e5','soks','soks@gmail.com','soks man is amazing','Nigeria','Public Sector','https://res.cloudinary.com/ddrutuohj/image/upload/v1761572003/organization_documents/bzr9gm2nm3ipbbpwywqt.jpg','38383','1-10','Sole Proprietorship','https://res.cloudinary.com/ddrutuohj/image/upload/v1761572004/organization_documents/gsq8odgcjhk9btzbmypf.jpg','https://res.cloudinary.com/ddrutuohj/image/upload/v1761572004/organization_documents/f0cyn7wdvm3toigh6zkv.jpg','https://res.cloudinary.com/ddrutuohj/image/upload/v1761572004/organization_documents/aaslcpxhjg7gcak8yc75.jpg','https://res.cloudinary.com/ddrutuohj/image/upload/v1761572004/organization_documents/fiw6zzz7zfyrntqp6oya.jpg','2025-10-27 17:33:26','b197e1ff-76b4-446b-b75a-aea265a9d4c4',NULL);
/*!40000 ALTER TABLE `Organisation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Otp`
--

DROP TABLE IF EXISTS `Otp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Otp` (
  `id` char(36) NOT NULL,
  `otp` text NOT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `user_id` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Otp_user_id_fkey` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Otp`
--

LOCK TABLES `Otp` WRITE;
/*!40000 ALTER TABLE `Otp` DISABLE KEYS */;
INSERT INTO `Otp` VALUES
('499119a1-9f12-4c8e-b9de-21994df0097b','$2b$10$I/j7KgrgJWNWyctyXeyMieMLdY4OYiWIziBkYv.RUerMbNWVZVJVu','2025-10-13 20:19:17','2025-10-13 20:14:17','1d0ee97c-c72c-40ff-bd10-3ff86a2cb7c8'),
('9e1c5d38-a7b2-47bf-b5a1-087bd06098b7','$2b$10$WXC3SgmhmiG3CxLu8iAOLeYFwKiiGkkZmpCXQr6fYY9jET4wj.TCa','2025-10-13 21:46:17','2025-10-13 21:41:17','b5f87ce0-e3b5-4a00-992c-c3666bdef154'),
('fa7eda31-030f-4f11-8509-192a26c85d57','$2b$10$kvz2i5YQ9jgZ6GcT.OXFFuv3cviHIkHl6mkx6rh5Mue6vhPmfQrj2','2025-10-14 09:28:31','2025-10-14 09:23:31','c0090779-93e9-4648-9504-07c0efb9a8c5'),
('770cbb0b-4f76-4cbf-8ec9-4e708056cfe1','$2b$10$6SYIpxwZZvlS1EWkBqHXjOtjWx9Ut3fnzZIL4t/tG9J1evAWE/6bO','2025-10-14 10:17:05','2025-10-14 10:12:05','38f2c5fe-b708-4ae5-85e2-5b1fb974fe25'),
('fdbcf514-ead6-425f-9a9e-057e936449fe','$2b$10$KpJ4r7MKCIxY28s51E9JOeSyIH..uSYD.ql9DbJY0N2FW7BgU7JzS','2025-10-16 10:23:02','2025-10-16 10:18:02','fa639c0d-fff1-49c7-81c9-4e11ec563e20'),
('c3031092-1874-4fb0-8ec6-225c4b50aeab','$2b$10$ukGG9Hqwrq.kYMFEaWvHNepq23Fs2MZ0UUrz.9bbHLN5smaRCWyha','2025-10-20 19:18:46','2025-10-20 19:13:46','3b9cb719-bb98-438c-b0da-a97f36cd8e43'),
('ec417a0a-87ed-436c-8c11-5f231f537c15','$2b$10$qZAPLdXuJiODzGt6oY180uKsqCFmLP7GSleCDMaXx8mvzD5Jl/EIe','2025-10-21 13:48:31','2025-10-21 13:43:31','dcb92470-2499-4cc3-9d4d-0601dd901674'),
('90c4d958-91f6-44ee-9059-57b897f821d1','$2b$10$v70bOoUADdqd2liH7fHN/u9viyGJMdoBQCTrptCpExksyH5VPWHOG','2025-10-21 14:02:05','2025-10-21 13:57:05','3131267a-0afc-4b63-b95d-10e8238381c1'),
('8778113b-ca72-4793-a3e1-e4fc62a85f9b','$2b$10$4DsEqRDIG4NuJ8iNXcBVuObsvoloi8DNNMLirCoA1vdCd2gNmnb6q','2025-10-21 14:20:43','2025-10-21 14:15:43','fcba6ceb-f506-458d-b5f1-4cca8af09608'),
('c38eceaf-69d6-46a7-a6db-e56b28aeefd6','$2b$10$9.kvGCit3AfJjRdm0omSVOZt97uE3a5eU7y/y/hYGokoxrdMu51C6','2025-10-21 14:45:58','2025-10-21 14:40:58','9cb0da9d-b7b0-44f1-8442-3fc952de963f'),
('ae50d7b7-6f92-45ea-ac2b-ab6bc4e46b95','$2b$10$mUakDY4hhhJxzeXSV9XpEewtWV6uOBOzTfj7cHEzyUJ6H6DVgiYhG','2025-10-21 15:06:07','2025-10-21 15:01:07','17f24fe1-aa2b-436a-82cd-dcc216a47df5'),
('f213833e-141c-409e-bcf0-f8a21f5c0217','$2b$10$skBTArtrAI9YM1PdoV9Hce7SX/xIooxNv15p9mU2uho76dY6fd806','2025-10-27 16:26:28','2025-10-27 16:21:28','825d0530-0267-45f0-bc5e-dd46fddc415e'),
('b0c0100d-125f-485c-9586-2053f3259e36','$2b$10$hZTCtOaRkVnYAijAJxrh1ep4aNjtPa62pDHCqh9kXqJ60UgXnCx9q','2025-10-27 17:19:15','2025-10-27 17:14:15','f7c22824-5cc4-44c3-80a9-460baa1284a5'),
('803778f5-b096-4544-bd36-da3fa34263c4','$2b$10$WOXEjTlkDghpsCMSCwZp1.bOV.krH5i4nLhFftKEgI6BceLoYup6y','2025-10-27 17:20:22','2025-10-27 17:15:22','b197e1ff-76b4-446b-b75a-aea265a9d4c4'),
('62029818-656c-4391-89fe-dbb3c0150231','$2b$10$76FlktCpU3MnnN995zWu1OXtQUXopnZg39RFdhGChsXAdwsWTDW9O','2025-12-01 15:42:55','2025-12-01 15:37:55','95e1a648-2785-4d51-9d42-90bb0f644d8a'),
('ae9efeb5-efd5-4fa2-be91-6301126ed473','$2b$10$BJtJY.64XljobHDcxQuEAe21vfVdApw.kpHxQd/fBLDvkv99QjZQG','2025-12-09 19:22:55','2025-12-09 19:17:55','e3edf68d-a291-4705-b3b3-41f03385b785'),
('550110a7-5708-4ca3-80ea-bd19a5211bba','$2b$10$gWJG8xsUpOD0u9p0xoFZvefoUu/BPo8cJWOkgbn8Znz2T1ydHknHi','2025-12-16 18:28:22','2025-12-16 18:23:22','232f7ed9-037a-4920-a859-843a4cf80ff1'),
('5a7fdeda-c3f0-414f-8ef3-eca0e92b1513','$2b$10$9C9BYwc.2YDJOED41qXbdu0XJGOhAEXKWddMjngAvylD29SV.W0vO','2025-12-16 18:31:01','2025-12-16 18:26:01','09b85110-ea6d-441f-8fb3-01e75f9d4b22'),
('d75f824a-1b1e-43b1-93b5-607d4b0d42f7','$2b$10$WyA1JGJuImuOR/Ffm7iBOOJPamncLslnOhzkDfS9aaGlGyUBJITIK','2025-12-16 18:40:30','2025-12-16 18:35:30','12157a9e-f33c-42e5-980b-1df42a1df11a'),
('ddd7d004-1b46-4ec6-b4fc-9b21c21f30bf','$2b$10$KEXmZvLv4N63FNMV/scUAODjRAnIpN/zAW.nGgFjHDCHxpRya.jFG','2025-12-16 18:42:40','2025-12-16 18:37:41','4a92a5b7-7922-4144-8299-8479e7c7157c'),
('6d754e70-7f0f-47a4-90dd-a3895f611c43','$2b$10$slqGlyedsJYDyRsRxsGaqepLrLBT7vD/xoM2UTt5qZy0w7MVKt0C6','2025-12-20 05:51:09','2025-12-20 05:46:09','4b1ec1f7-bd2e-43d0-867d-a2861132c263'),
('89ed6f21-37db-4c8f-a6cf-27605d6bd6d2','$2b$10$NAXF0EPWOJLQ.esU3N3qy.B4D7TJlKPGDruaG7UMnLcrAiuj2u4Fa','2025-12-21 04:42:22','2025-12-21 04:37:22','292bb7c3-9824-470d-9340-eca4e4ea66e7'),
('226b7a64-ec8b-4273-8add-7a36da2435ba','$2b$10$WmQFEL6IN7ldnnIShu8pgOMHjf3fCKdw1YySTLp.pyvROA3bFdlzG','2025-12-21 05:30:16','2025-12-21 05:25:16','840c1bca-4b39-4f6f-bcdf-ffba6bb9ec9a'),
('b1798914-5461-47b7-9d35-0a86695cff6d','$2b$10$3o2ugdTR78.ycH5nFO8mV.KeNoYI7GCLjxhhP5/86GVP4Yt1JQkCq','2025-12-21 08:29:56','2025-12-21 08:24:56','eb289c1a-46c4-401a-b8b6-13c13e870c08'),
('7e5ecf60-d9d4-4c9d-9984-d0ec1dfb518d','$2b$10$nIyKgDiE9Uvsy.VFyKTknO1UInp0Hm.PN18g/hxmDt0Hcmr6PRW/C','2025-12-22 04:38:24','2025-12-22 04:33:24','5fb1c8c8-44ef-4c86-b0b0-679c991b7a79'),
('b99b42fe-3803-4273-b876-f483248bb46d','$2b$10$qFFguiAlK0K.F8rONY1b1uJBZBe5y6.3vH9rESslNKSJlrbhiyRh6','2025-12-22 18:29:24','2025-12-22 18:24:24','e0dcf21b-8187-4006-b932-693dcb855b34'),
('1a18b341-a260-4c2a-9fe2-f1216668c6ce','$2b$10$ttWPdEO5YAGvGr5S49A0i.YjBwMg6FxLl1H8LHgOyHKuvIA00RRkG','2025-12-29 16:23:21','2025-12-29 16:18:21','cdc34d54-6879-47f6-af52-b5d8412f8034'),
('e4c8c0c8-58a4-426c-b56a-077f2c8e4628','$2b$10$fGO.KVrymDvBZLb2enhjNOUBAHvFEogjfbx/d6x31IrCVuMaPQ56q','2026-01-13 15:28:20','2026-01-13 15:23:20','125dc9a8-0a91-47bb-b8a6-42cbd378d0c4'),
('d54366fd-4ea5-435d-a875-02f73c43a6f2','$2b$10$ZTNrheWG8TU0K9fv9d5tEuvvOc3dHiaCPtqfOz5mW2mVb9uTU0EKq','2026-01-13 17:32:07','2026-01-13 17:27:08','8c9dc235-737d-4563-9eb5-099971d84e15'),
('577ba722-4f9f-409b-b457-72b1d8a6b605','$2b$10$jZLurCXw7CiIYLsvje0ECeAS8ax3cZz9fSV45211SijBS/AZHOdc6','2026-01-15 05:39:08','2026-01-15 05:34:08','1256bb0f-bed6-488b-ab8b-84cfcad54220'),
('3eef361e-204a-46c6-9af0-3019f0fbfb86','$2b$10$n5kIUHk.7f0i55ltj.ktY.UyKqboXGbiDK29362wDmjSTproPiQmC','2026-01-15 05:51:39','2026-01-15 05:46:40','1256bb0f-bed6-488b-ab8b-84cfcad54220'),
('d6024f47-cfd9-4164-8dfe-69b2e2ff2a43','$2b$10$ihNzAZcS5XJFUg3zQrN7YeAzgrlbyhrRKz.Bq8L41yM60VMJuknIa','2026-01-15 05:58:18','2026-01-15 05:53:18','1256bb0f-bed6-488b-ab8b-84cfcad54220'),
('2b0f2ed0-09b5-40bb-997e-7e26f68a25e5','$2b$10$OW0dIbIyYNYQMRsuiHT3u./SFyZxhRG3GMCSsokrL.xixqyTKnOMG','2026-01-15 15:35:00','2026-01-15 15:30:00','211c15d3-6eba-4bbc-b276-3ec3ea46ad9b'),
('2c7c9586-a669-47bc-ab2d-9bedc2873e32','$2b$10$AGetZDHb0ETy2B6XIEhlf.R4bfWMQQVrTVrlCsCSNMUIs0kAmbDB2','2026-01-15 19:10:20','2026-01-15 19:05:20','c87a282b-9d49-443b-8567-6d90f24933e0'),
('54234d46-aedf-4297-8a91-1a1a4055e45d','$2b$10$50gwMmppoqYHzKhNnZ2lmOaTfRjVwsjspIdzC00APD0xdJFQ3Tax2','2026-01-15 19:30:53','2026-01-15 19:25:53','28d31f78-3fe9-43ac-a20f-8a2730879296'),
('7a4fde9e-820d-430f-a03d-183123d6f8c1','$2b$10$88jjYANcTI8MMYCO3v6NnuS0P222br5oUsr5.beS3Aoth6X0rlbvK','2026-01-16 04:05:15','2026-01-16 04:00:15','f4aa2960-1829-4084-adfb-68fef7d4d527'),
('503e6628-1cfd-4e5c-bc90-b81d5af5a322','$2b$10$sHdI6hVw/XrCfvUqm8iRKuNCJo6szc1dUTiuKFUsF/9VtTa24CW2.','2026-01-16 18:01:13','2026-01-16 17:56:13','8aee7c57-7b67-4383-8a4e-061f6667c852'),
('fc40fedd-c980-4579-9384-550f46efc94a','$2b$10$.oQPyo2XIfR7/acDpASeJuiBJMfNzMCT0pkG6Oiihj6hv7tZHP50.','2026-01-16 18:29:32','2026-01-16 18:24:32','954f0742-a728-41c2-b73f-06cf617a809c'),
('18dd2bc7-11a4-438c-83ec-c520db54f84c','$2b$10$g0Anxge2wFetaJzRl89L6.yvCdAFfpTxEjFz/31lkqDUoXqJmf9FC','2026-01-17 13:27:03','2026-01-17 13:22:03','1d761c7c-a133-4924-9a67-e7013136be0c');
/*!40000 ALTER TABLE `Otp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Password_token`
--

DROP TABLE IF EXISTS `Password_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Password_token` (
  `id` char(36) NOT NULL,
  `token` text NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `expires_at` timestamp NULL DEFAULT NULL,
  `user_id` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Password_token_user_id_fkey` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Password_token`
--

LOCK TABLES `Password_token` WRITE;
/*!40000 ALTER TABLE `Password_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `Password_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Plan`
--

DROP TABLE IF EXISTS `Plan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Plan` (
  `id` char(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` varchar(191) NOT NULL,
  `priceUnit` varchar(20) NOT NULL,
  `audience` varchar(100) NOT NULL,
  `features` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`features`)),
  `service_id` char(36) NOT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `plan_typeId` char(36) DEFAULT NULL,
  `billing_cycleId` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Plan_service_id_idx` (`service_id`),
  KEY `Plan_plan_typeId_fkey` (`plan_typeId`),
  KEY `Plan_billing_cycleId_fkey` (`billing_cycleId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Plan`
--

LOCK TABLES `Plan` WRITE;
/*!40000 ALTER TABLE `Plan` DISABLE KEYS */;
INSERT INTO `Plan` VALUES
('288dc1ec-5082-4c26-b84d-4b70ada3e832','Complete Digital Audit','0','one-off','For businesses ready to scale','[\"Website & UX Review – speed, design, mobile responsiveness, user journey.\",\"SEO Performance – on-page, technical, off-page, and local SEO checks.\",\"Social Media Presence – engagement, audience growth, and content effectiveness.\",\"Email Marketing Health – list quality, automation, open/click rates.\",\"Paid Advertising (PPC) Analysis – ROI, targeting, creatives, and conversion.\",\"Content Effectiveness – relevance, SEO alignment, and distribution strategy.\",\"Analytics & Tracking – accuracy of GA4, KPIs, and conversion tracking.\",\"Competitor Benchmarking – strengths, weaknesses, and opportunities vs. peers.\",\"Branding & Messaging – consistency, clarity, and positioning across channels.\"]','732c5bff-4eef-4c38-9504-e214f1b3162c',0,NULL,NULL),
('92093195-6729-4df8-9ef1-55bdd44f6d2d','Single Design (Flyer/Graphic)','5000','one-off','For quick, single-item needs','[\"One Social Media Graphic/Flier\"]','6d8a2315-6e5a-4eb2-88ac-68e725909668',9,NULL,NULL),
('new_1760273151135',' Digital Assets','960000','/year','','[\"Digital Assets – social media graphics and ads\"]','6d8a2315-6e5a-4eb2-88ac-68e725909668',8,NULL,NULL),
('new_1760273149896',' Digital Assets','220000','/quarter','','[\"Digital Assets – social media graphics and ads\"]','6d8a2315-6e5a-4eb2-88ac-68e725909668',7,NULL,NULL),
('new_1760273148575',' Digital Assets','80000','/month','','[\"Digital Assets – social media graphics and ads\"]','6d8a2315-6e5a-4eb2-88ac-68e725909668',6,NULL,NULL),
('efbef075-35ee-48bd-94d8-9f5c366aa51d','Digital Assets Only','120000','/month','Social media focus','[\"Social Media Graphics & Ads\"]','f2e9dd94-95cc-49d9-aabe-a3c1059b1175',1,NULL,NULL),
('bec4bb35-bc4b-4a86-bdda-3330902f6f6f','Marketing & Digital Assets','150000','/month','Full creative support','[\"Flyers, Brochures, Banners\",\"Social Media Graphics & Ads\"]','f2e9dd94-95cc-49d9-aabe-a3c1059b1175',0,NULL,NULL),
('4d2a9c40-fbe0-411f-ad90-0bfe6a970f4e','UI/UX Retainer (Monthly)','150000','/month','For MVP design & short-term needs','[\"User research & persona development (basic scope)\",\"Wireframes & low-fidelity prototypes\",\"UI design for 1–2 key screens/pages\",\"Mobile & desktop responsiveness setup\",\"1 round of usability feedback + revisions\"]','715dde68-2e65-4dda-bc28-6616c0ec62f8',1,NULL,NULL),
('da815431-f9b6-4aa9-b2fa-ffc16aad2de1','Full UI/UX Product Design','600000','one-off','For new web or mobile apps','[\"User Research & Personas – understand target users’ needs and behaviors.\",\"Information Architecture – structure content and navigation for clarity.\",\"Wireframing & Prototyping – create layouts and interactive mockups.\",\"Visual Design – modern, consistent, and brand-aligned interfaces.\",\"User Experience Optimization – intuitive flows for web and mobile apps.\",\"Usability Testing – gather feedback to refine design decisions.\",\"Responsive Design – seamless experience across devices.\",\"UI Components & Design Systems – reusable elements for consistency.\",\"Interaction & Motion Design – engaging micro-interactions and animations\"]','715dde68-2e65-4dda-bc28-6616c0ec62f8',0,NULL,NULL),
('951eec33-576d-48d9-a796-42d2d616451f','Weekly Campaign - Excluding ads budget','30000','/week','Short-term promotions','[\"Forms and generation of leads\",\"PPC strategy development tailored to your business goals\",\"Keyword research & targeting for maximum ROI\",\"Campaign setup across platforms (Google Ads, Facebook/Instagram Ads, LinkedIn Ads, X/Twitter Ads, TikTok Ads, YouTube Ads, etc.)\",\"Ad copywriting & creative design (text, banners, video ads, carousels)\",\"Audience segmentation & targeting (demographics, interests, retargeting, lookalike audiences)\",\"Landing page optimization for higher conversions\",\"A/B testing of ad creatives, formats, and audiences\",\"Bid management & budget optimization\",\"Conversion tracking setup (pixels, tags, UTM links)\",\"Retargeting & remarketing campaigns to re-engage leads\",\"Competitor analysis & benchmarking\",\"Analytics & performance reporting (CTR, CPC, CPA, ROAS, conversions)\",\"Continuous optimization for cost efficiency & improved ROI\",\"Compliance with ad policies to avoid disapprovals/bans\"]','b198646f-ac79-41eb-bcad-487e13d48387',0,NULL,NULL),
('e121ecbe-a354-4831-951a-e77a7dc35700','Monthly','150000','/month','Steady Improvement','[\"Comprehensive website SEO audit & strategy\",\"Keyword research & competitor analysis\",\"On-page SEO (titles, meta tags, content, images, internal links)\",\"Technical SEO (speed, mobile, crawl errors, schema markup)\",\"Content creation & optimization for ranking\",\"Local SEO (Google Business Profile, citations, reviews)\",\"Off-page SEO & quality link building\",\"Analytics, tracking & performance reporting\",\"Continuous optimization & updates\"]','55ba978c-962d-46bd-83fd-62ab6198dd99',0,NULL,NULL),
('f609f4d6-4c2b-4d74-88d6-c979920b1601','Monthly','150000','/month','Consistent Performance','[\"SEM strategy development tailored to business goals\",\"Keyword research & targeting for paid search campaigns\",\"Campaign setup & management on Google Ads, Bing Ads, etc.\",\"Ad copywriting & creative design for maximum conversions\",\"Audience targeting & segmentation (demographics, retargeting, lookalikes)\",\"Landing page optimization to improve Quality Score & ROI\",\"Bid management & budget optimization\",\"A/B testing of ads & campaign elements\",\"Conversion tracking & analytics setup\",\"Performance monitoring, reporting & continuous optimization\"]','eb59f293-1e8b-41a4-9584-78bd20a5002f',0,NULL,NULL),
('4f3ff452-1abc-4977-a1e8-b851f48f8078','Monthly','150000','/month','Ongoing Insights','[\"Setup & integration of analytics tools (Google Analytics, Tag Manager, etc.)\",\"Website & app traffic tracking\",\"Conversion tracking (forms, sales, leads, events)\",\"Custom dashboards & KPI monitoring\",\"Audience behavior & journey analysis\",\"Campaign performance measurement (SEO, SEM, PPC, Social Media)\",\"Funnel analysis & attribution modeling\",\"Competitor & benchmark analytics\",\"Actionable insights & data-driven recommendations\",\"Regular reporting & optimization guidance\"]','fbe08dd4-8c85-4ab7-b61b-b4a3a2f4656c',0,NULL,NULL),
('80063986-b464-4fb8-bc14-2e05441a9e20','Basic Website Design','800000','one-off','For professional business sites','[\"Up to 10 pages\",\"Responsive Design\",\"Contact Forms & Blog\",\"SEO-ready structure\"]','592c042f-68ed-407d-a6c2-23a08a547e25',3,NULL,NULL),
('cc8672e4-0727-44e0-a799-541ee944e125','Mobile Application Only','6000000','one-off','For iOS & Android apps','[\"Native or Cross-Platform\",\"UI/UX Design\",\"Backend Connectivity\",\"App Store Deployment\"]','592c042f-68ed-407d-a6c2-23a08a547e25',2,NULL,NULL),
('84ac3587-9fb3-40c1-bddf-1527b6bfd90e','Web Application Only','3000000','one-off','For custom software & platforms','[\"Custom web app development\",\"Backend & Database\",\"API Integrations\",\"Cloud Deployment\"]','592c042f-68ed-407d-a6c2-23a08a547e25',1,NULL,NULL),
('af2a2fbd-70c8-41c7-add2-2fdbe8418d6e','Full Web & Mobile App','8000000','one-off','For enterprise-level projects','[\"Custom design & development\",\"iOS & Android Apps\",\"Backend & APIs\",\"E-commerce Integration\"]','592c042f-68ed-407d-a6c2-23a08a547e25',0,NULL,NULL),
('249c48a0-4942-474b-968f-775580d93080','Yearly','1000000','/year','Full-Service Partnership','[\"Includes content updates & SEO monitoring\"]','7485248f-5f54-4c9f-9c9c-8e2850847ade',1,NULL,NULL),
('58d531b9-d1e0-41c7-970f-63c97fb4df66','Quarterly','400000','/quarter','Essential Maintenance','[\"Security, backups, updates\"]','7485248f-5f54-4c9f-9c9c-8e2850847ade',0,NULL,NULL),
('ea2f0418-c6d1-4787-a26b-590fdbb4977c','Brand & Marketing Essentials','250000','one-off','For established businesses needing assets','[\"Brand Identity Design – logos, color palettes, and visual guidelines.\",\"Marketing Collateral – flyers, brochures, posters, and banners.\",\"Digital Assets – social media graphics and ads\",\"Product & Packaging Design – labels, packaging, and mockups.\"]','6d8a2315-6e5a-4eb2-88ac-68e725909668',1,NULL,NULL),
('new_1760273135423','Marketing Collateral and Digital Assets','110000','/month','','[\"Marketing Collateral – flyers, brochures, posters, and banners.\",\"Digital Assets – social media graphics and ads\"]','6d8a2315-6e5a-4eb2-88ac-68e725909668',3,NULL,NULL),
('new_1760273139637','Marketing Collateral and Digital Assets','310000','/quarter','','[\"Marketing Collateral – flyers, brochures, posters, and banners.\",\"Digital Assets – social media graphics and ads\"]','6d8a2315-6e5a-4eb2-88ac-68e725909668',4,NULL,NULL),
('new_1760273140940','Marketing Collateral and Digital Assets','1300000','/year','','[\"Marketing Collateral – flyers, brochures, posters, and banners.\",\"Digital Assets – social media graphics and ads\"]','6d8a2315-6e5a-4eb2-88ac-68e725909668',5,NULL,NULL),
('ec9de5e4-6866-4c34-a1f8-7609cb085639','Brand Identity Starter','95000','one-off','For startups needing a logo & guide','[\"Brand Identity Design – logos, color palettes, and visual guidelines.\"]','6d8a2315-6e5a-4eb2-88ac-68e725909668',2,NULL,NULL),
('12807a44-13b7-43a1-8f08-e8111aaeacea','Full Design Suite','500000','one-off','For new brands or full rebrands','[\"Brand Identity Design – logos, color palettes, and visual guidelines.\",\"Marketing Collateral – flyers, brochures, posters, and banners.\",\"Digital Assets – social media graphics and ads\",\"Product & Packaging Design – labels, packaging, and mockups.\",\"Presentations & Reports – company profile, pitch decks, business reports, and infographics.\"]','6d8a2315-6e5a-4eb2-88ac-68e725909668',0,NULL,NULL),
('4ffe0789-12cd-4d00-8804-666aecd69e20','Custom Growth Strategy','150000','one-off','For founders & marketing leaders','[\"Market & Audience Research – identify target customers, behaviors, and needs.\",\"Competitive Analysis – benchmark against competitors and uncover gaps.\",\"Brand Positioning – define unique value proposition and messaging.\",\"Channel Strategy – select the right mix (SEO, social, email, PPC, content, etc.).\",\"Content Planning – campaigns, storytelling, and editorial calendar.\",\"Customer Journey Mapping – align marketing with awareness → conversion → loyalty.\",\"Budget & ROI Planning – optimize spend for maximum returns.\",\"KPI & Measurement Framework – track results with clear metrics and reporting.\",\"Execution Roadmap – step-by-step plan for 3–12 months of growth.\"]','fa63c25c-7826-4b36-acbc-b49b05c07f46',0,NULL,NULL),
('2b9f3e83-79df-40ef-a542-b6138c665e4c','UI/UX Retainer (Quarterly)','400000','/quarter','For growth-stage businesses','[\"In-depth user research & journey mapping\",\"Information architecture design\",\"Wireframing & high-fidelity prototyping for full product flow\",\"UI design for multiple screens/pages (website or app)\",\"Design system creation (typography, colors, components)\",\"Usability testing with feedback implementation\",\"2–3 rounds of design revisions\",\"Conversion-focused optimization\"]','715dde68-2e65-4dda-bc28-6616c0ec62f8',2,NULL,NULL),
('639cc154-025a-4663-ae79-38d27c00e211','UI/UX Retainer (Yearly)','1200000','/year','For continuous improvement & scaling','[\"Ongoing user research & behavioral analytics\",\"Full product UI/UX overhaul or new product design\",\"Design system management & continuous updates\",\"Monthly usability testing & reporting\",\"Continuous iteration based on user data\",\"Dedicated support & design consultation\",\"Unlimited revisions across the year\",\"Collaboration with development team for implementation\"]','715dde68-2e65-4dda-bc28-6616c0ec62f8',3,NULL,NULL),
('f70ebc5a-87a3-4fe0-a84d-df1be3e38bdb','Monthly Management - Excluding ads budget','200000','/month','Ongoing lead generation','[\"Forms and generation of leads\",\"PPC strategy development tailored to your business goals\",\"Keyword research & targeting for maximum ROI\",\"Campaign setup across platforms (Google Ads, Facebook/Instagram Ads, LinkedIn Ads, X/Twitter Ads, TikTok Ads, YouTube Ads, etc.)\",\"Ad copywriting & creative design (text, banners, video ads, carousels)\",\"Audience segmentation & targeting (demographics, interests, retargeting, lookalike audiences)\",\"Landing page optimization for higher conversions\",\"A/B testing of ad creatives, formats, and audiences\",\"Bid management & budget optimization\",\"Conversion tracking setup (pixels, tags, UTM links)\",\"Retargeting & remarketing campaigns to re-engage leads\",\"Competitor analysis & benchmarking\",\"Analytics & performance reporting (CTR, CPC, CPA, ROAS, conversions)\",\"Continuous optimization for cost efficiency & improved ROI\",\"Compliance with ad policies to avoid disapprovals/bans\"]','b198646f-ac79-41eb-bcad-487e13d48387',1,NULL,NULL),
('99236f67-1cc1-408e-9b0a-5022f9210e71','Quarterly Strategy - Excluding ads budget','500000','/quarter','Sustained growth','[\"Forms and generation of leads\",\"PPC strategy development tailored to your business goals\",\"Keyword research & targeting for maximum ROI\",\"Campaign setup across platforms (Google Ads, Facebook/Instagram Ads, LinkedIn Ads, X/Twitter Ads, TikTok Ads, YouTube Ads, etc.)\",\"Ad copywriting & creative design (text, banners, video ads, carousels)\",\"Audience segmentation & targeting (demographics, interests, retargeting, lookalike audiences)\",\"Landing page optimization for higher conversions\",\"A/B testing of ad creatives, formats, and audiences\",\"Bid management & budget optimization\",\"Conversion tracking setup (pixels, tags, UTM links)\",\"Retargeting & remarketing campaigns to re-engage leads\",\"Competitor analysis & benchmarking\",\"Analytics & performance reporting (CTR, CPC, CPA, ROAS, conversions)\",\"Continuous optimization for cost efficiency & improved ROI\",\"Compliance with ad policies to avoid disapprovals/bans\"]','b198646f-ac79-41eb-bcad-487e13d48387',2,NULL,NULL),
('820625d2-df91-43cf-8a39-e4adc4d70354','Yearly Partnership - Excluding ads budget','1200000','/year','Long-term scaling','[\"Forms and generation of leads\",\"PPC strategy development tailored to your business goals\",\"Keyword research & targeting for maximum ROI\",\"Campaign setup across platforms (Google Ads, Facebook/Instagram Ads, LinkedIn Ads, X/Twitter Ads, TikTok Ads, YouTube Ads, etc.)\",\"Ad copywriting & creative design (text, banners, video ads, carousels)\",\"Audience segmentation & targeting (demographics, interests, retargeting, lookalike audiences)\",\"Landing page optimization for higher conversions\",\"A/B testing of ad creatives, formats, and audiences\",\"Bid management & budget optimization\",\"Conversion tracking setup (pixels, tags, UTM links)\",\"Retargeting & remarketing campaigns to re-engage leads\",\"Competitor analysis & benchmarking\",\"Analytics & performance reporting (CTR, CPC, CPA, ROAS, conversions)\",\"Continuous optimization for cost efficiency & improved ROI\",\"Compliance with ad policies to avoid disapprovals/bans\"]','b198646f-ac79-41eb-bcad-487e13d48387',3,NULL,NULL),
('a0c91bbd-055f-4c06-ae83-092d1dee5460','Quarterly','400000','/quarter','Accelerated Growth','[\"Comprehensive website SEO audit & strategy\",\"Keyword research & competitor analysis\",\"On-page SEO (titles, meta tags, content, images, internal links)\",\"Technical SEO (speed, mobile, crawl errors, schema markup)\",\"Content creation & optimization for ranking\",\"Local SEO (Google Business Profile, citations, reviews)\",\"Off-page SEO & quality link building\",\"Analytics, tracking & performance reporting\",\"Continuous optimization & updates\"]','55ba978c-962d-46bd-83fd-62ab6198dd99',1,NULL,NULL),
('65a2c679-2748-4f4c-924e-d0b4a82671c8','Yearly','1000000','/year','Market Domination','[\"Comprehensive website SEO audit & strategy\",\"Keyword research & competitor analysis\",\"On-page SEO (titles, meta tags, content, images, internal links)\",\"Technical SEO (speed, mobile, crawl errors, schema markup)\",\"Content creation & optimization for ranking\",\"Local SEO (Google Business Profile, citations, reviews)\",\"Off-page SEO & quality link building\",\"Analytics, tracking & performance reporting\",\"Continuous optimization & updates\"]','55ba978c-962d-46bd-83fd-62ab6198dd99',2,NULL,NULL),
('eaa38f31-7208-44f6-b691-2c0d73f21645','Quarterly','400000','/quarter','Aggressive Campaigns','[\"SEM strategy development tailored to business goals\",\"Keyword research & targeting for paid search campaigns\",\"Campaign setup & management on Google Ads, Bing Ads, etc.\",\"Ad copywriting & creative design for maximum conversions\",\"Audience targeting & segmentation (demographics, retargeting, lookalikes)\",\"Landing page optimization to improve Quality Score & ROI\",\"Bid management & budget optimization\",\"A/B testing of ads & campaign elements\",\"Conversion tracking & analytics setup\",\"Performance monitoring, reporting & continuous optimization\"]','eb59f293-1e8b-41a4-9584-78bd20a5002f',1,NULL,NULL),
('8006a23d-ecbe-4ff1-95bb-22af145b0f29','Yearly','1000000','/year','Sustained Market Lead','[\"SEM strategy development tailored to business goals\",\"Keyword research & targeting for paid search campaigns\",\"Campaign setup & management on Google Ads, Bing Ads, etc.\",\"Ad copywriting & creative design for maximum conversions\",\"Audience targeting & segmentation (demographics, retargeting, lookalikes)\",\"Landing page optimization to improve Quality Score & ROI\",\"Bid management & budget optimization\",\"A/B testing of ads & campaign elements\",\"Conversion tracking & analytics setup\",\"Performance monitoring, reporting & continuous optimization\"]','eb59f293-1e8b-41a4-9584-78bd20a5002f',2,NULL,NULL),
('dae9593e-f364-403b-8757-dbfe412b9324','Quarterly','400000','/quarter','Deep-Dive Analysis','[\"Setup & integration of analytics tools (Google Analytics, Tag Manager, etc.)\",\"Website & app traffic tracking\",\"Conversion tracking (forms, sales, leads, events)\",\"Custom dashboards & KPI monitoring\",\"Audience behavior & journey analysis\",\"Campaign performance measurement (SEO, SEM, PPC, Social Media)\",\"Funnel analysis & attribution modeling\",\"Competitor & benchmark analytics\",\"Actionable insights & data-driven recommendations\",\"Regular reporting & optimization guidance\"]','fbe08dd4-8c85-4ab7-b61b-b4a3a2f4656c',1,NULL,NULL),
('723fea94-b093-4f59-9d72-11c118b83527','Yearly','1000000','/year','Data Partnership','[\"Setup & integration of analytics tools (Google Analytics, Tag Manager, etc.)\",\"Website & app traffic tracking\",\"Conversion tracking (forms, sales, leads, events)\",\"Custom dashboards & KPI monitoring\",\"Audience behavior & journey analysis\",\"Campaign performance measurement (SEO, SEM, PPC, Social Media)\",\"Funnel analysis & attribution modeling\",\"Competitor & benchmark analytics\",\"Actionable insights & data-driven recommendations\",\"Regular reporting & optimization guidance\"]','fbe08dd4-8c85-4ab7-b61b-b4a3a2f4656c',2,NULL,NULL),
('9052aaac-0c58-451f-b3ff-a0aff6f4b99b','Yearly','2200000','/year','Long-term partnership','[\"Social media account setup & optimization (Facebook, Instagram, LinkedIn, X/Twitter)\",\"Social media content strategy & calendar planning\",\"Content creation (graphics, carousels, reels, short videos, stories, infographics)\",\"Copywriting & captions tailored to audience engagement\",\"Hashtag research & trend monitoring\",\"Community management (responding to comments, DMs, and audience engagement)\",\"Social listening & reputation management\",\"Analytics & performance reporting (reach, engagement, conversions, ROI tracking)\",\"Competitor analysis & benchmarking\",\"Continuous optimization to keep up with trends & platform algorithm changes\"]','2d436f84-7312-4a5f-8a6c-2aec456d49fe',2,NULL,NULL),
('c40675fb-8c4b-43f3-8dcf-4e70c3da0822','Quarterly','550000','/quarter','Strategic Campaigns','[\"Social media account setup & optimization (Facebook, Instagram, LinkedIn, X/Twitter)\",\"Social media content strategy & calendar planning\",\"Content creation (graphics, carousels, reels, short videos, stories, infographics)\",\"Copywriting & captions tailored to audience engagement\",\"Hashtag research & trend monitoring\",\"Community management (responding to comments, DMs, and audience engagement)\",\"Social listening & reputation management\",\"Analytics & performance reporting (reach, engagement, conversions, ROI tracking)\",\"Competitor analysis & benchmarking\",\"Continuous optimization to keep up with trends & platform algorithm changes\"]','2d436f84-7312-4a5f-8a6c-2aec456d49fe',1,NULL,NULL),
('5e461687-6cfe-46b4-85d9-b55f1288451a','Monthly','200000','/month','Consistent Growth','[\"Social media account setup & optimization (Facebook, Instagram, LinkedIn, X/Twitter)\",\"Social media content strategy & calendar planning\",\"Content creation (graphics, carousels, reels, short videos, stories, infographics)\",\"Copywriting & captions tailored to audience engagement\",\"Hashtag research & trend monitoring\",\"Community management (responding to comments, DMs, and audience engagement)\",\"Social listening & reputation management\",\"Analytics & performance reporting (reach, engagement, conversions, ROI tracking)\",\"Competitor analysis & benchmarking\",\"Continuous optimization to keep up with trends & platform algorithm changes\"]','2d436f84-7312-4a5f-8a6c-2aec456d49fe',0,NULL,NULL);
/*!40000 ALTER TABLE `Plan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Plan_type`
--

DROP TABLE IF EXISTS `Plan_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Plan_type` (
  `id` char(36) NOT NULL,
  `name` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` char(36) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Plan_type_created_by_idx` (`created_by`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Plan_type`
--

LOCK TABLES `Plan_type` WRITE;
/*!40000 ALTER TABLE `Plan_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `Plan_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Privacy_settings`
--

DROP TABLE IF EXISTS `Privacy_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Privacy_settings` (
  `id` char(36) NOT NULL,
  `ads` tinyint(1) NOT NULL DEFAULT 1,
  `data_sharing` tinyint(1) NOT NULL DEFAULT 1,
  `marketing_status` tinyint(1) NOT NULL DEFAULT 1,
  `activity_status` tinyint(1) NOT NULL DEFAULT 1,
  `user_id` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Privacy_settings_user_id_fkey` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Privacy_settings`
--

LOCK TABLES `Privacy_settings` WRITE;
/*!40000 ALTER TABLE `Privacy_settings` DISABLE KEYS */;
INSERT INTO `Privacy_settings` VALUES
('3c4fef93-915f-45bc-8ef4-3bd5dbde2bf5',1,1,1,1,'1d0ee97c-c72c-40ff-bd10-3ff86a2cb7c8'),
('1415e427-ddba-4f89-8b17-30e5ef2db930',1,1,1,1,'b5f87ce0-e3b5-4a00-992c-c3666bdef154'),
('4feb1afa-3860-44d4-b0fc-325e590f44d5',1,1,1,1,'c0090779-93e9-4648-9504-07c0efb9a8c5'),
('43897f33-19a3-475e-9eb2-34b7fd87493f',1,1,1,1,'38f2c5fe-b708-4ae5-85e2-5b1fb974fe25'),
('484b13b8-586c-401e-9b39-7fb829a70617',1,1,1,1,'fa639c0d-fff1-49c7-81c9-4e11ec563e20'),
('216a108c-3287-477c-8a0c-06bee7ec69df',1,1,1,1,'3b9cb719-bb98-438c-b0da-a97f36cd8e43'),
('a4df018a-2575-4527-beaf-6e255bb4fb69',1,1,1,1,'dcb92470-2499-4cc3-9d4d-0601dd901674'),
('aedcaab2-c9af-44fa-b79e-1c94db6bdaf7',1,1,1,1,'3131267a-0afc-4b63-b95d-10e8238381c1'),
('64634074-75e2-4895-9328-754690302b70',1,1,1,1,'fcba6ceb-f506-458d-b5f1-4cca8af09608'),
('e19b321b-33b6-401c-aead-e97521ca61ba',1,1,1,1,'9cb0da9d-b7b0-44f1-8442-3fc952de963f'),
('86c3d26b-4fd0-49e5-90eb-fd011c6086b8',1,1,1,1,'17f24fe1-aa2b-436a-82cd-dcc216a47df5'),
('5f8996f7-6f7a-418a-8d5b-bd071bed5efd',1,1,1,1,'825d0530-0267-45f0-bc5e-dd46fddc415e'),
('11a193ae-a47f-4a40-a960-5d3cdf201d0f',1,1,1,1,'f7c22824-5cc4-44c3-80a9-460baa1284a5'),
('f9eaf106-35b8-4e0e-ac56-1f47f6d7981f',1,1,1,1,'b197e1ff-76b4-446b-b75a-aea265a9d4c4'),
('bde1a3f3-1ac9-4ebb-91f9-6ccb34ed870b',1,1,1,1,'95e1a648-2785-4d51-9d42-90bb0f644d8a'),
('b5b4b0cd-150e-4863-b1fa-d2707bf044d1',1,1,1,1,'e3edf68d-a291-4705-b3b3-41f03385b785'),
('740cb3e0-a46f-433a-93b0-4a4e6bc502e7',1,1,1,1,'232f7ed9-037a-4920-a859-843a4cf80ff1'),
('0a3ffeea-7cec-478e-8781-cc19631f223f',1,1,1,1,'09b85110-ea6d-441f-8fb3-01e75f9d4b22'),
('99cc2e22-d7d9-4a6a-a52e-9f763ae68c92',1,1,1,1,'12157a9e-f33c-42e5-980b-1df42a1df11a'),
('65455520-6c31-49f0-b966-adbddaef5c1f',1,1,1,1,'4a92a5b7-7922-4144-8299-8479e7c7157c'),
('2aacad87-5141-4a25-827e-57a0c3e9a35e',1,1,1,1,'4b1ec1f7-bd2e-43d0-867d-a2861132c263'),
('86c3c9ff-de05-4ea1-a50b-bf1c9851712a',1,1,1,1,'292bb7c3-9824-470d-9340-eca4e4ea66e7'),
('2c9d4c67-dba4-495c-857c-30154e388b23',1,1,1,1,'840c1bca-4b39-4f6f-bcdf-ffba6bb9ec9a'),
('b6bd21b4-6b71-43bb-ad6b-e085b76e4e30',1,1,1,1,'eb289c1a-46c4-401a-b8b6-13c13e870c08'),
('99b6e554-8592-4525-b5ef-882fad42eb58',1,1,1,1,'5fb1c8c8-44ef-4c86-b0b0-679c991b7a79'),
('ffbecf96-fd67-4e22-b404-726fa20ff91d',1,1,1,1,'e0dcf21b-8187-4006-b932-693dcb855b34'),
('34733e5c-9874-4436-95fc-3577d23173c1',1,1,1,1,'cdc34d54-6879-47f6-af52-b5d8412f8034'),
('fbe92afe-4b32-4387-8062-07bc7cea0765',1,1,1,1,'125dc9a8-0a91-47bb-b8a6-42cbd378d0c4'),
('fe0ecfa2-8ed7-4fa6-a01d-c15d4061efec',1,1,1,1,'8c9dc235-737d-4563-9eb5-099971d84e15'),
('de8842b7-9bba-44b8-b5be-e3889e3bf151',1,1,1,1,'1256bb0f-bed6-488b-ab8b-84cfcad54220'),
('aa69f4f5-1726-4fa1-bf3f-d05fb5a73fcc',1,1,1,1,'211c15d3-6eba-4bbc-b276-3ec3ea46ad9b'),
('22f32af1-b46b-44ba-9774-10b2eb05c788',1,1,1,1,'c87a282b-9d49-443b-8567-6d90f24933e0'),
('34dfad95-abba-4db1-a3fc-b94193292cf2',1,1,1,1,'28d31f78-3fe9-43ac-a20f-8a2730879296'),
('a49ef2e2-5f8e-4107-a520-dfca2bcb7f84',1,1,1,1,'f4aa2960-1829-4084-adfb-68fef7d4d527'),
('522246ca-2d88-445b-b75c-801399b324b4',1,1,1,1,'8aee7c57-7b67-4383-8a4e-061f6667c852'),
('7ac64f76-b75d-4c0b-a428-6a985e78de66',1,1,1,1,'954f0742-a728-41c2-b73f-06cf617a809c'),
('6050936e-d81d-4902-a7ba-e06f4513bea8',1,1,1,1,'1d761c7c-a133-4924-9a67-e7013136be0c');
/*!40000 ALTER TABLE `Privacy_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Referral`
--

DROP TABLE IF EXISTS `Referral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Referral` (
  `id` varchar(191) NOT NULL,
  `referrer_id` varchar(191) NOT NULL,
  `referred_email` varchar(191) NOT NULL,
  `referred_user_id` varchar(191) DEFAULT NULL,
  `invoice_id` varchar(191) DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'PENDING',
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Referral_referred_user_id_key` (`referred_user_id`),
  UNIQUE KEY `Referral_invoice_id_key` (`invoice_id`),
  KEY `Referral_referrer_id_fkey` (`referrer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Referral`
--

LOCK TABLES `Referral` WRITE;
/*!40000 ALTER TABLE `Referral` DISABLE KEYS */;
INSERT INTO `Referral` VALUES
('6f2ae2d1-06fb-49ca-af42-0cd0b63f174b','b5f87ce0-e3b5-4a00-992c-c3666bdef154','olaoluwashomo@icloud.com',NULL,'2d13a0e1-8b83-4cef-b43a-d169a7461717','COMPLETED','2025-10-13 20:32:36.981','2025-10-13 20:32:37.002'),
('1668d3bf-d0bc-4da3-9cf9-2cf1bcc76d65','38f2c5fe-b708-4ae5-85e2-5b1fb974fe25','ola@seedbuildersng.com',NULL,'26dfb6a0-7703-493b-bf9b-1115a5b26269','COMPLETED','2025-10-14 06:26:07.824','2025-10-14 06:26:07.869'),
('31b5eb39-7a27-443d-8f61-a3ee022abc05','38f2c5fe-b708-4ae5-85e2-5b1fb974fe25','jo@yahoo.com',NULL,'77993af8-80e4-4023-ac57-bc4b35023e3c','COMPLETED','2025-10-14 06:32:46.474','2025-10-14 06:32:46.503'),
('9623c226-7661-4eae-bfc7-5145f6766b76','38f2c5fe-b708-4ae5-85e2-5b1fb974fe25','jon@gmail.com',NULL,'b1fabcb8-6c5d-49e9-9424-faa06597f5c4','COMPLETED','2025-10-14 06:46:30.639','2025-10-14 06:46:30.665'),
('8a6a28b5-adfb-4905-ba95-16ecd6ed9408','1d0ee97c-c72c-40ff-bd10-3ff86a2cb7c8','soks@gmail.com',NULL,NULL,'PENDING','2025-10-15 11:47:13.191','2025-10-15 11:47:13.191'),
('7138074d-77d9-4665-a0e3-fa9f10ab97e6','1d0ee97c-c72c-40ff-bd10-3ff86a2cb7c8','soks@gmail.com',NULL,NULL,'PENDING','2025-10-15 11:48:22.338','2025-10-15 11:48:22.338'),
('257a9e96-1b72-4d6a-8921-8e9e9d79063e','1d0ee97c-c72c-40ff-bd10-3ff86a2cb7c8','soks@gmail.com',NULL,'93d7021f-5ad2-4b70-8259-0613840f8a0c','COMPLETED','2025-10-15 11:52:10.248','2025-10-15 11:52:10.308'),
('943eae50-4ecd-4330-88ef-02f3d5cc9d0d','1d0ee97c-c72c-40ff-bd10-3ff86a2cb7c8','soks@gmail.comm',NULL,'7d96b947-94c9-4a38-926b-d88462fdeef4','COMPLETED','2025-10-15 11:53:35.184','2025-10-15 11:53:35.202'),
('47d34cb3-8a4d-4e76-945e-98eba77e5841','fa639c0d-fff1-49c7-81c9-4e11ec563e20','john@yahoo.com',NULL,'4382c3a1-a7b1-4b6e-b050-14b99818f9b5','COMPLETED','2025-10-16 06:43:42.929','2025-10-16 06:43:42.949'),
('12809ce2-6296-4057-a2b4-7fcfcb94719c','fa639c0d-fff1-49c7-81c9-4e11ec563e20','olaoluo@yahoo.co.uk',NULL,'c28414b9-de5d-4751-9bf0-8eb7ab483ff3','COMPLETED','2025-10-16 06:49:37.196','2025-10-16 06:49:37.219'),
('f8875ae6-9882-43f2-a608-2b3decef72d2','b5f87ce0-e3b5-4a00-992c-c3666bdef154','de@yahoo.com',NULL,'225037e5-81ef-4bf7-ab63-de767e190199','COMPLETED','2025-10-20 14:12:25.220','2025-10-20 14:12:25.252'),
('70d5e1cf-2c00-439f-87ee-bbf5524116b8','b5f87ce0-e3b5-4a00-992c-c3666bdef154','folajobi@seedbuildersng.com',NULL,'5c17aae5-b058-40c0-8e76-999499e2f147','COMPLETED','2025-10-20 16:24:48.862','2025-10-20 16:24:48.908'),
('1ed7d38f-c697-4260-84dd-76334073d656','fcba6ceb-f506-458d-b5f1-4cca8af09608','ogangeorge84@gmail.com',NULL,'2dd54192-96c5-4de0-82fc-8a6a1d1ded2b','COMPLETED','2025-10-21 13:54:03.120','2025-10-21 13:54:03.144'),
('4c47aed2-0328-4a19-9972-106e009a1ffc','95e1a648-2785-4d51-9d42-90bb0f644d8a','graceyomonua@gmail.com',NULL,'c80035d3-b9c3-4d01-9ca4-4bce90543b63','COMPLETED','2025-12-01 12:30:29.712','2025-12-01 12:30:29.755');
/*!40000 ALTER TABLE `Referral` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Role`
--

DROP TABLE IF EXISTS `Role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Role` (
  `id` char(36) NOT NULL,
  `title` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` char(36) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Role_title_key` (`title`),
  KEY `Role_created_by_idx` (`created_by`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Role`
--

LOCK TABLES `Role` WRITE;
/*!40000 ALTER TABLE `Role` DISABLE KEYS */;
INSERT INTO `Role` VALUES
('a1ee860d-5798-4f80-ab8b-71624f0a4b7f','user','Default user role with client permissions.','2025-10-11 03:14:42',NULL,NULL),
('57c29dbb-8f5a-4c05-8702-d4d8cd5749c9','admin','Administrator role with full permissions.','2025-10-11 03:14:42',NULL,NULL);
/*!40000 ALTER TABLE `Role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Service`
--

DROP TABLE IF EXISTS `Service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Service` (
  `id` char(36) NOT NULL,
  `title` varchar(255) NOT NULL,
  `isPublic` tinyint(1) NOT NULL DEFAULT 1,
  `heroHeadline` text DEFAULT NULL,
  `heroParagraph` text DEFAULT NULL,
  `heroImageUrl` text DEFAULT NULL,
  `blueprintHeadline` text DEFAULT NULL,
  `blueprintParagraph` text DEFAULT NULL,
  `blueprintImageUrl` text DEFAULT NULL,
  `bannerText` text DEFAULT NULL,
  `admin_id` char(36) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Service_admin_id_fkey` (`admin_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Service`
--

LOCK TABLES `Service` WRITE;
/*!40000 ALTER TABLE `Service` DISABLE KEYS */;
INSERT INTO `Service` VALUES
('732c5bff-4eef-4c38-9504-e214f1b3162c','Digital Marketing Audit',1,'Find out what’s costing you growth at no cost','If your marketing isn’t working the way it should, something is broken.\r\nThe problem is most businesses don’t know what or where.\r\nThat’s exactly what this audit is for.\r\n\r\nFor a limited time, we’re offering a free digital marketing audit to help you understand what’s working, what’s wasting money, and what you should fix first.\r\n','https://res.cloudinary.com/ddrutuohj/image/upload/v1760270468/services/digital-marketing-audit/exuthpstps9rbe5i2vqj.png','What This Audit Does','This audit shows you:\r\n\r\nWhere your marketing is leaking results\r\n\r\nWhy traffic isn’t converting\r\n\r\nWhat channels you should focus on (and which to pause)\r\n\r\nWhat to fix now vs what can wait\r\n\r\nThink of it as a second opinion on your marketing from people who do this every day.\r\n\r\nWhat We Review\r\n\r\nWe look at the parts of your digital marketing that directly affect results, including:\r\n\r\nWebsite performance & conversion readiness\r\n\r\nTraffic sources (SEO, ads, social, referrals)\r\n\r\nMessaging & positioning clarity\r\n\r\nContent effectiveness\r\n\r\nFunnel gaps and missed opportunities\r\n\r\nTracking and measurement basics\r\n\r\nNot surface-level feedback.\r\nReal issues, clearly explained.\r\n\r\nWho This Is For\r\n\r\nThis free audit is perfect if:\r\n\r\nYou’re spending on marketing but unsure if it’s working\r\n\r\nYou’re not getting enough leads or sales\r\n\r\nYou want clarity before investing more money\r\n\r\nYou feel stuck and don’t know what to fix first\r\n\r\nIf you care about growth, this is worth your time.\r\n\r\nWhy Are We Offering This for Free?  \r\n\r\nBecause most marketing problems are obvious once you know where to look. \r\n\r\nAnd once you see them, making better decisions becomes easier.  \r\n\r\nThere’s no catch. If you want help implementing the recommendations, we can talk. If not, you still leave with value.  \r\n\r\nLimited-Time Offer  This free audit is available for a limited number of businesses so we can give each one proper attention.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760270467/services/digital-marketing-audit/dx30dqh9f5w1v1mwnov1.png','Get Your Free Digital Marketing Audit','a20b1f85-d726-4ff1-9259-872f2d2b0b1f','2025-10-11 03:14:43',NULL),
('fa63c25c-7826-4b36-acbc-b49b05c07f46','Digital Marketing Strategy',1,'Your Roadmap to Sustainable Growth','Move beyond scattered tactics with a bespoke digital marketing strategy that aligns your brand, budget, and business goals for maximum impact.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760270786/services/digital-marketing-strategy/kopetczpp6rqyey3v7ak.jpg','Strategy Built on Data, Not Assumptions','We combine in-depth market research, competitive analysis, and customer journey mapping to build a clear, actionable 3-12 month plan designed for measurable ROI.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760270786/services/digital-marketing-strategy/nzyy6wfmypdxtonrr2gp.png','Stop reacting and start leading. Let\'s build your winning strategy.','a20b1f85-d726-4ff1-9259-872f2d2b0b1f','2025-10-11 03:14:43',NULL),
('6d8a2315-6e5a-4eb2-88ac-68e725909668','Graphics Design',1,'Visuals That Captivate, Communicate, and Convert','From a memorable brand identity to stunning marketing materials, our full design suite provides everything you need to make a powerful visual impact.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272209/services/full-graphics-design-suite/tv4g34hnjblm8ze1k3uj.jpg','Comprehensive Design, From Concept to Creation','We cover every visual touchpoint, including brand identity, marketing collateral, digital assets, product packaging, and professional presentations, ensuring brand consistency everywhere.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272173/services/full-graphics-design-suite/x0d1l4wytofrtqtkxbxk.png','Elevate your brand with world-class design. Let\'s create something unforgettable.','a20b1f85-d726-4ff1-9259-872f2d2b0b1f','2025-10-11 03:14:43',NULL),
('f2e9dd94-95cc-49d9-aabe-a3c1059b1175','Graphics Design (Retainer)',1,'Your On-Demand Creative Partner','Get consistent, high-quality design assets every month without the overhead of a full-time hire. Perfect for ongoing marketing and social media needs.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272236/services/graphics-design-retainer/so2s4neglnb9rmgds39h.jpg','Consistent Branding, Delivered Monthly','Our retainer plans ensure your brand stays fresh and active with a steady stream of marketing collateral and digital assets, from social media graphics to flyers and banners.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272236/services/graphics-design-retainer/bswt7fo9t0elwinwf3d5.png','Never worry about design again. Secure your dedicated creative resource.','a20b1f85-d726-4ff1-9259-872f2d2b0b1f','2025-10-11 03:14:43','2025-10-12 16:51:48'),
('715dde68-2e65-4dda-bc28-6616c0ec62f8','UI/UX Design',1,'Intuitive Digital Experiences Users Love','We design beautiful, user-centric websites and applications that are not only visually stunning but also easy to use, driving engagement and conversions.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272301/services/uiux-design/lsdaotsnjhgdzkp708y3.webp','From User Research to Pixel-Perfect Interfaces','Our process involves deep user research, information architecture, wireframing, prototyping, and rigorous usability testing to create seamless and effective digital products.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272301/services/uiux-design/w1fnvdci9rkwoxhrqflt.png','Turn your idea into an experience. Let\'s design your digital future.','a20b1f85-d726-4ff1-9259-872f2d2b0b1f','2025-10-11 03:14:43',NULL),
('2d436f84-7312-4a5f-8a6c-2aec456d49fe','Social Media Marketing',1,'Build Your Tribe, Grow Your Brand','We manage your social media presence from strategy to execution, creating engaging content and fostering a loyal community around your brand.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272393/services/social-media-marketing/dwfvj7u3tmualbtdty4f.webp','Content, Community, and Conversions','Our service covers everything: content strategy, creation (graphics, reels, videos), community management, and in-depth analytics to ensure your social media efforts drive business results.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272392/services/social-media-marketing/roavfzydkofcxpazf3n5.png','Ready to dominate social media? Let\'s get started.','a20b1f85-d726-4ff1-9259-872f2d2b0b1f','2025-10-11 03:14:43',NULL),
('b198646f-ac79-41eb-bcad-487e13d48387','Sponsored Ads / Pay-Per-Click (PPC)',1,'Generate Leads and Sales, Instantly','Reach your ideal customers at the exact moment they\'re ready to buy with targeted, high-ROI ad campaigns on Google, Facebook, LinkedIn, and more.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272434/services/sponsored-ads-pay-per-click-ppc/t81m79woxgaaxostwhra.webp','Precision Targeting for Maximum ROI','We handle everything from keyword research and audience segmentation to ad creative, A/B testing, and landing page optimization to ensure every click counts.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272434/services/sponsored-ads-pay-per-click-ppc/htdf5slencsaiptwttke.png','Don\'t wait for customers to find you. Reach them now.','a20b1f85-d726-4ff1-9259-872f2d2b0b1f','2025-10-11 03:14:43',NULL),
('55ba978c-962d-46bd-83fd-62ab6198dd99','Search Engine Optimization (SEO)',1,'Climb to the Top of Google and Stay There','Our comprehensive SEO service improves your search engine rankings, drives organic traffic, and establishes your brand as an authority in your industry.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272490/services/search-engine-optimization-seo/dn5lznplonyuqodsvfpx.jpg','A Holistic Approach to SEO Success','We combine technical SEO, on-page optimization, quality content creation, and strategic link building to create a sustainable foundation for long-term organic growth.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272491/services/search-engine-optimization-seo/e7ztnob56dv8ftpwfpup.png','Be the first answer your customers find. Invest in SEO.','a20b1f85-d726-4ff1-9259-872f2d2b0b1f','2025-10-11 03:14:43',NULL),
('eb59f293-1e8b-41a4-9584-78bd20a5002f','Search Engine Marketing (SEM)',1,'Capture High-Intent Customers with Paid Search','Combine the power of SEO and PPC with a unified Search Engine Marketing strategy that guarantees visibility and drives qualified leads from search engines.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272546/services/search-engine-marketing-sem/zz5w87tjcmnjr836cfhg.webp','Dominate the Entire Search Page','Our SEM service integrates keyword strategy, ad campaign management, and landing page optimization to ensure you capture users at every stage of their search journey.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272547/services/search-engine-marketing-sem/dgyyiazj87xmsdmadhrc.png','Own your keywords. Drive conversions with a powerful SEM strategy.','a20b1f85-d726-4ff1-9259-872f2d2b0b1f','2025-10-11 03:14:43',NULL),
('fbe08dd4-8c85-4ab7-b61b-b4a3a2f4656c','Analytics & Data Insights',1,'Turn Your Data Into Your Biggest Advantage','Stop drowning in data and start making smarter decisions. We set up, manage, and interpret your analytics to provide clear, actionable insights for growth.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272626/services/analytics-and-data-insights/luqwaptmljyg5tdt0p8v.avif','From Tracking Setup to Actionable Recommendations','We cover everything from Google Analytics setup and conversion tracking to custom dashboard creation, funnel analysis, and regular reporting that tells you what\'s working and why.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272626/services/analytics-and-data-insights/ofedgejjstq4uxeuvty7.png','Make data-driven decisions with confidence. Let\'s unlock your insights.','a20b1f85-d726-4ff1-9259-872f2d2b0b1f','2025-10-11 03:14:43',NULL),
('592c042f-68ed-407d-a6c2-23a08a547e25','Web & Mobile App Development',1,'Build Scalable, High-Performance Digital Products','From custom websites to cross-platform mobile apps, our development team brings your vision to life with secure, scalable, and user-friendly solutions.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272700/services/web-and-mobile-app-development/rvhqkohgjcowxl9wvhhg.jpg','End-to-End Development, From Design to Deployment','We handle the entire lifecycle: UI/UX design, backend architecture, API integrations, e-commerce setup, and post-launch maintenance, ensuring your product is built for success.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272701/services/web-and-mobile-app-development/mzxjcqqaqxwy4d1w8hzw.png','Have a big idea? Let\'s build it, together.','a20b1f85-d726-4ff1-9259-872f2d2b0b1f','2025-10-11 03:14:43',NULL),
('7485248f-5f54-4c9f-9c9c-8e2850847ade','Website Management & Maintenance',1,'Keep Your Website Secure, Fast, and Fresh','Focus on your business while we handle the technical side. Our website management service ensures your site is always updated, secure, and performing at its best.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272795/services/website-management-and-maintenance/scftdspgdjuu4qewikhm.jpg','Proactive Care for Your Most Important Asset','We provide comprehensive support, including hosting, security monitoring, regular backups, performance optimization, content updates, and technical troubleshooting.','https://res.cloudinary.com/ddrutuohj/image/upload/v1760272795/services/website-management-and-maintenance/w8b2t6ibh16qwm9emopw.png','Enjoy peace of mind. Put your website on autopilot.','a20b1f85-d726-4ff1-9259-872f2d2b0b1f','2025-10-11 03:14:43',NULL);
/*!40000 ALTER TABLE `Service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ServiceForm`
--

DROP TABLE IF EXISTS `ServiceForm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ServiceForm` (
  `id` varchar(191) NOT NULL,
  `service_id` varchar(191) NOT NULL,
  `formFields` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`formFields`)),
  `created_at` datetime(3) DEFAULT current_timestamp(3),
  `updated_at` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ServiceForm_service_id_key` (`service_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServiceForm`
--

LOCK TABLES `ServiceForm` WRITE;
/*!40000 ALTER TABLE `ServiceForm` DISABLE KEYS */;
INSERT INTO `ServiceForm` VALUES
('d144de30-3219-4e3c-92ba-e3bc9a689d7c','732c5bff-4eef-4c38-9504-e214f1b3162c','[{\"id\":\"a43f8847-5520-49c7-b157-753e0808dc47\",\"name\":\"user_name\",\"label\":\"Name\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"ea0a4d58-b0e0-454f-a790-d09309aceb8f\",\"name\":\"user_address\",\"label\":\"Address\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"e5e444ac-1b19-4220-9c2c-78ac69a7cd6e\",\"name\":\"user_phone\",\"label\":\"Phone No\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"4e2476bb-a870-40a8-9707-edf753c220f4\",\"name\":\"user_email\",\"label\":\"Email\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"6bbe027f-785c-4f6d-acb3-bd58b1f8da7d\",\"name\":\"website\",\"label\":\"Website\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"7a5bf436-f83f-42bc-93a1-14b673e2e66f\",\"name\":\"social_media_handles\",\"label\":\"Social Medial Handles\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"9170e90d-fdf0-4018-9eca-d25a2c52377f\",\"name\":\"contact_person_name\",\"label\":\"Contact Person Name\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"8db6cc20-542b-4326-9d23-efffc3682252\",\"name\":\"contact_person_phone\",\"label\":\"Contact Person Phone Number\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"484d8cf7-622f-4411-bb0a-8256dc64ab1e\",\"name\":\"about_the_company\",\"label\":\"About the company\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"e5a5cbc1-b52b-471f-9d05-99c428ddf73c\",\"name\":\"info_about_product_service\",\"label\":\"Information About Product/Service rendered\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"a2a62460-80fd-4250-9bce-c97888e74337\",\"name\":\"sector\",\"label\":\"Sector\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"afcda467-bb85-4466-a372-15b0087db406\",\"name\":\"target_age\",\"label\":\"Target Age\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Target Audience\"},{\"id\":\"a65265c3-afdc-4be6-898e-10acddc84470\",\"name\":\"target_sex\",\"label\":\"Target Sex\",\"type\":\"select\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Target Audience\",\"options\":[\"Male\",\"Female\",\"Both\",\"Others\"]},{\"id\":\"6336a192-addb-4588-83d8-06b954ac1b2d\",\"name\":\"target_demography\",\"label\":\"Target Demography\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Target Audience\"},{\"id\":\"d267516b-ac0c-4822-81ea-0dacc05646f5\",\"name\":\"target_location\",\"label\":\"Target Location\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Target Audience\"},{\"id\":\"e98a98cf-1a1b-48d7-963d-dc869247a7ba\",\"name\":\"additional_resource\",\"label\":\"Link to any additional resource\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Additional Information\"},{\"id\":\"387c6a7e-578c-4a41-83b1-b2933766a17c\",\"name\":\"additional_file\",\"label\":\"Additional File\",\"type\":\"file\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Additional Information\"}]','2025-10-12 12:05:29.451','2025-10-20 13:40:52.674'),
('dbfe2a74-ff50-4b56-a5d7-30781de29cd4','fa63c25c-7826-4b36-acbc-b49b05c07f46','[{\"id\":\"a43f8847-5520-49c7-b157-753e0808dc47\",\"name\":\"user_name\",\"label\":\"Name\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"ea0a4d58-b0e0-454f-a790-d09309aceb8f\",\"name\":\"user_address\",\"label\":\"Address\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"e5e444ac-1b19-4220-9c2c-78ac69a7cd6e\",\"name\":\"user_phone\",\"label\":\"Phone No\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"4e2476bb-a870-40a8-9707-edf753c220f4\",\"name\":\"user_email\",\"label\":\"Email\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"0b8eb442-5234-467d-b3d0-ccd38d974183\",\"name\":\"exisitng_social_media\",\"label\":\"Do you have an existing digital marketing/social account? Such as websites and social media platforms?\",\"type\":\"radio\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"61454809-0794-4d7c-bcf8-0929180f77be\",\"name\":\"what_platforms_on\",\"label\":\"If yes, what social platforms are you on?\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"01ae0445-275d-4e4d-8a02-c3ad719852df\",\"name\":\"should_we_create_social_media_acct\",\"label\":\"Should we create a social media account for you?\",\"type\":\"radio\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"c386893b-7558-45d6-b4fb-b01572095728\",\"name\":\"name_suggestions\",\"label\":\"If yes, name suggestions\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"701d1cf6-8d90-445d-8ece-6b423edc9178\",\"name\":\"website\",\"label\":\"Website (optional)\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"742b2cd3-fd05-4377-b194-9b4e51aa590f\",\"name\":\"logo\",\"label\":\"Upload Logo (optional)\",\"type\":\"file\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"4a350d2d-60be-4636-89ab-5aa3e0814790\",\"name\":\"brand_colors\",\"label\":\"Brand Colors (optional)\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"3f72cddf-6135-4de9-ab15-d3dea3fea487\",\"name\":\"social_media_handles\",\"label\":\"Social Media Handles\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"45874b06-b345-424d-b897-3d8bfc024628\",\"name\":\"contact_person_name\",\"label\":\"Contact Person Name\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"b2f50275-3ca8-4a4b-a32e-ccda03b54eac\",\"name\":\"contact_person_phone\",\"label\":\"Contact Person Phone Number\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"3d59bd2f-8f42-40c3-8a49-606dd6d2dbf3\",\"name\":\"about_company\",\"label\":\"About the Company\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"2b5abd55-1e00-402b-bcbc-cd4ba053c500\",\"name\":\"info_about_product\",\"label\":\"Information about product or service rendered\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"095c0d19-e1af-4428-8ecd-c387db9cdd60\",\"name\":\"sector\",\"label\":\"Sector\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"88559112-c9c0-496a-be6a-dd4ee91f3fb6\",\"name\":\"target_age\",\"label\":\"Target Age\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Target Audience\"},{\"id\":\"3a256dd8-64cc-4f0e-82e8-f411dcfab7d9\",\"name\":\"target_sex\",\"label\":\"Target Sex\",\"type\":\"select\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Target Audience\",\"options\":[\"male\",\"female\",\"both\",\"others\"]},{\"id\":\"38aa8b3c-9847-4bac-834a-981719a357aa\",\"name\":\"target_demography\",\"label\":\"Target Demography\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Target Audience\"},{\"id\":\"c66bd13e-1936-4381-b45c-f3c3c036f04a\",\"name\":\"target_location\",\"label\":\"Target Location\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Target Audience\"},{\"id\":\"d112f4d2-1456-4f8f-9ee7-88197a8f6823\",\"name\":\"additional_link\",\"label\":\"Any Additional link to a resource\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Additional Information\"},{\"id\":\"b579242c-2e29-4a17-a592-27d20102792c\",\"name\":\"additional_file\",\"label\":\"Additional File\",\"type\":\"file\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Additional Information\"}]','2025-10-12 12:07:49.243','2025-10-20 13:40:43.725'),
('9f4d3cac-4e2c-4f61-b0ce-e9bf791ba168','6d8a2315-6e5a-4eb2-88ac-68e725909668','[{\"id\":\"89e70969-98d4-4e2c-acce-7d4d53f7e570\",\"name\":\"user_name\",\"label\":\"Name\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"e0b570b4-d467-46ce-93b2-edbf4809e746\",\"name\":\"user_address\",\"label\":\"Address\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"4e0d7ae6-3a2b-470e-892e-a28c3476c114\",\"name\":\"user_phone\",\"label\":\"Phone No\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"78616030-f9ed-4afb-8839-9838113b3943\",\"name\":\"user_email\",\"label\":\"Email\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"8f01046d-b9b6-4c95-b122-601ed8fa22cf\",\"name\":\"info_about_service\",\"label\":\"Information to be used for this service (Kindly insert an open link to view if information is large)\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"0308b9dd-27d5-407e-a5ef-c30fd62acbd8\",\"name\":\"about_the_company\",\"label\":\"About the Company\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"603df9de-a904-404a-9735-1a29895fe09f\",\"name\":\"product_or_service_info\",\"label\":\"Product or Service Information\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"63bd852b-703e-41a4-8c30-ac26c99ee525\",\"name\":\"sector\",\"label\":\"Sector\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"928da206-dfd4-489f-959d-565f66f8528d\",\"name\":\"target_age\",\"label\":\"Target Age\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Target Audience\"},{\"id\":\"c9b65a77-ec1d-4033-89ca-a4812a631a11\",\"name\":\"target_sex\",\"label\":\"Target Sex\",\"type\":\"select\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Target Audience\",\"options\":[\"Male\",\"Female\",\"Both\",\"Others\"]},{\"id\":\"e7929cbb-087b-49f8-aabb-e43ac3801d01\",\"name\":\"target_demography\",\"label\":\"Target Demography\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Target Audience\"},{\"id\":\"301638a2-ce4b-4034-850a-c43d7abb87a8\",\"name\":\"target_location\",\"label\":\"Target Location\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Target Audience\"},{\"id\":\"e9b8f84d-545a-4b28-801c-ca1fef8bf1ed\",\"name\":\"additional_link\",\"label\":\"Additional information/content for the service  (Kindly insert an open link to view large information/content)\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Additional Information\"},{\"id\":\"d5eb9656-b16a-4cb4-8787-729842689d16\",\"name\":\"social_media_handles\",\"label\":\"Social Media Handles\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"35399c11-d8bd-4fb9-8019-21de850ea46a\",\"name\":\"website\",\"label\":\"Website\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"117808fa-5625-47ad-8de4-8e98a11c64e9\",\"name\":\"logo\",\"label\":\"Upload Logo\",\"type\":\"file\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"c3328117-9b86-4ab4-be1a-45ab92e3a8ed\",\"name\":\"brand_colors\",\"label\":\"Brand colors\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"91d16dde-2de6-4e19-9bf1-49d4db3387e5\",\"name\":\"contact_person_name\",\"label\":\"Contact Person Name\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"1f33da0d-a0cb-4a77-9504-df73ea5a51b4\",\"name\":\"contact_phone\",\"label\":\"Contact Person Phone Number\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"}]','2025-10-12 12:30:48.237','2025-10-22 08:20:21.807'),
('7de718d1-d6f3-47fa-a776-2a61fb92f669','f2e9dd94-95cc-49d9-aabe-a3c1059b1175','[{\"id\":\"89e70969-98d4-4e2c-acce-7d4d53f7e570\",\"name\":\"user_name\",\"label\":\"Name\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"e0b570b4-d467-46ce-93b2-edbf4809e746\",\"name\":\"user_address\",\"label\":\"Address\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"4e0d7ae6-3a2b-470e-892e-a28c3476c114\",\"name\":\"user_phone\",\"label\":\"Phone No\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"78616030-f9ed-4afb-8839-9838113b3943\",\"name\":\"user_email\",\"label\":\"Email\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"}]','2025-10-12 12:30:59.328','2025-10-12 12:30:59.328'),
('d2170bdf-10bb-424b-acd0-b9c80f2441c4','715dde68-2e65-4dda-bc28-6616c0ec62f8','[{\"id\":\"89e70969-98d4-4e2c-acce-7d4d53f7e570\",\"name\":\"user_name\",\"label\":\"Name\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"e0b570b4-d467-46ce-93b2-edbf4809e746\",\"name\":\"user_address\",\"label\":\"Address\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"4e0d7ae6-3a2b-470e-892e-a28c3476c114\",\"name\":\"user_phone\",\"label\":\"Phone No\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"78616030-f9ed-4afb-8839-9838113b3943\",\"name\":\"user_email\",\"label\":\"Email\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"7a9bb869-4d38-4abb-a8a5-7f5dcc911ead\",\"name\":\"website\",\"label\":\"Website\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"c39e054c-6050-4842-b4a9-7bb99828a546\",\"name\":\"logo\",\"label\":\"Upload Logo \",\"type\":\"file\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"d5b837cc-9f0c-4e79-ad84-b3c1349c8beb\",\"name\":\"brand_colors\",\"label\":\"Brand colors\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"5faa9053-d673-4af2-bc4e-a013d60aedde\",\"name\":\"social_media_handles\",\"label\":\"Social Media Handles\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"e9e8e4ca-46e7-4547-a7d5-719e3998d399\",\"name\":\"contact_person_name\",\"label\":\"Contact Person Name\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"03bfec2e-0d0c-4a8d-a3c9-d26cc2ebe71a\",\"name\":\"contact_phone\",\"label\":\"Contact Person Phone Number\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"cc7c421c-1562-4a26-a899-ea190b3394d4\",\"name\":\"about_company\",\"label\":\"About the Company\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"bfa56bf6-a5d3-4fca-a149-bd6596adfb4c\",\"name\":\"about_product\",\"label\":\"About Product or Service\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"01b60bbf-6846-423c-b786-789fe40da3f7\",\"name\":\"sector\",\"label\":\"Sector\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"62618075-f6db-4ed0-8866-594f9556e8f7\",\"name\":\"target_age\",\"label\":\"Target Age\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Target Audience\"},{\"id\":\"1005ba9d-eb49-4cf5-802c-45232e7aec61\",\"name\":\"target_sex\",\"label\":\"Target Sex\",\"type\":\"select\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Target Audience\",\"options\":[\"Male\",\"Female\",\"Both\",\"Others\"]},{\"id\":\"3818d51f-ce54-4060-b100-dba40ada2c2f\",\"name\":\"target_demography\",\"label\":\"Target Demography\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Target Audience\"},{\"id\":\"774e5ecc-d28d-4213-9d1b-8acc184ef3c3\",\"name\":\"target_location\",\"label\":\"Target Location\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Target Audience\"},{\"id\":\"ec1732ff-02cb-4325-a668-950805b52257\",\"name\":\"additional_link\",\"label\":\"Addition Link to Resource\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Additional Info\"},{\"id\":\"b01321bc-cc9a-4571-ae64-caffae016c53\",\"name\":\"additional_file\",\"label\":\"Additional File\",\"type\":\"file\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Target Audience\"}]','2025-10-12 12:32:01.184','2025-10-20 13:47:03.784'),
('7b46fd53-6516-496f-b97c-15cf510ab669','2d436f84-7312-4a5f-8a6c-2aec456d49fe','[{\"id\":\"89e70969-98d4-4e2c-acce-7d4d53f7e570\",\"name\":\"user_name\",\"label\":\"Name\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"e0b570b4-d467-46ce-93b2-edbf4809e746\",\"name\":\"user_address\",\"label\":\"Address\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"4e0d7ae6-3a2b-470e-892e-a28c3476c114\",\"name\":\"user_phone\",\"label\":\"Phone No\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"78616030-f9ed-4afb-8839-9838113b3943\",\"name\":\"user_email\",\"label\":\"Email\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"0fd7163a-2ffd-4191-a8a7-336b785e52fc\",\"name\":\"existing_account\",\"label\":\"Do you have an existing digital marketing/social media account?\",\"type\":\"radio\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Social Media Information\"},{\"id\":\"d0285ad9-1e60-44bb-a168-6f30432a28cd\",\"name\":\"what_social_platforms\",\"label\":\"If yes, what social platforms are you on?\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Social Media Information\"},{\"id\":\"eec34e37-5956-4a20-9011-c0b690254a24\",\"name\":\"create_new_account\",\"label\":\"Should we create a new account?\",\"type\":\"radio\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Social Media Information\"},{\"id\":\"e8c0e90c-b9ab-4fef-a63b-8e108963bcc7\",\"name\":\"social_platforms_to_be_on\",\"label\":\"If yes, what social media platforms do you want to be on?\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Social Media Information\"},{\"id\":\"cca28999-1004-4ffd-89d4-3a87864ea376\",\"name\":\"suggested_names\",\"label\":\"Suggested Names for Social Media Platforms\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Social Media Information\"},{\"id\":\"555f2505-52a0-49ab-9b68-2fb2d0281e3e\",\"name\":\"website\",\"label\":\"Website\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Service Information\"},{\"id\":\"d82a44c2-4fa4-4985-84ae-43857a64fc72\",\"name\":\"logo\",\"label\":\"Upload Logo\",\"type\":\"file\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Service Information\"},{\"id\":\"47aff596-f3e5-4900-b923-904a7e72443e\",\"name\":\"brand_colors\",\"label\":\"Brand Colors\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Service Information\"},{\"id\":\"36aecac5-0887-4429-a4d4-7daf6092c20f\",\"name\":\"social_media_handles\",\"label\":\"Social Media Handles\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Service Information\"},{\"id\":\"058403f2-d2d7-487f-a8e9-6a3096e2f441\",\"name\":\"conact_person_name\",\"label\":\"Contact Person Name\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Service Information\"},{\"id\":\"86464403-6bdb-4207-9ee4-2e97cc59925c\",\"name\":\"contact_phone\",\"label\":\"Contact Person Phone Number\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Service Information\"},{\"id\":\"91989134-5bd6-4642-b1bd-343d55564553\",\"name\":\"about_company\",\"label\":\"About the company\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Service Information\"},{\"id\":\"cf66084f-3163-4d4b-a1fe-be2ea1158f01\",\"name\":\"product_information\",\"label\":\"Product or Service Information\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Service Information\"},{\"id\":\"fb21b5ed-679c-46ee-8158-c29c74a9ab6f\",\"name\":\"sector\",\"label\":\"Sector\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Service Information\"},{\"id\":\"fd08a19b-f9eb-44af-af4e-1e8f4541e807\",\"name\":\"target_age\",\"label\":\"Target Age\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Target Audience\"},{\"id\":\"2ec22dc1-ea63-4acd-aa9b-bd3f9c078a1b\",\"name\":\"target_sex\",\"label\":\"Target Sex\",\"type\":\"select\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Target Audience\",\"options\":[\"Male\",\"Female\",\"Both\",\"Others\"]},{\"id\":\"41602a20-d153-438e-be40-4a1cc37459dd\",\"name\":\"target_demography\",\"label\":\"Target Demography\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Target Audience\"},{\"id\":\"6cba8829-525e-4c21-8ff4-d5f8b6ec5d39\",\"name\":\"target_location\",\"label\":\"Target Location\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Target Audience\"},{\"id\":\"8ed771e1-20ac-4a38-b96c-47796a37e031\",\"name\":\"additional_link\",\"label\":\"Link to additional information\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":5,\"groupName\":\"Additional Info\"},{\"id\":\"bce8cf7e-d250-41e8-9edb-9b7cded91132\",\"name\":\"additional_file\",\"label\":\"Additional File\",\"type\":\"file\",\"required\":false,\"fromUser\":false,\"step\":5,\"groupName\":\"Additional Info\"}]','2025-10-12 12:33:24.360','2025-10-20 13:59:55.010'),
('105ed137-9b1c-4c93-8bfc-c578e4ff58cf','b198646f-ac79-41eb-bcad-487e13d48387','[{\"id\":\"89e70969-98d4-4e2c-acce-7d4d53f7e570\",\"name\":\"user_name\",\"label\":\"Name\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"e0b570b4-d467-46ce-93b2-edbf4809e746\",\"name\":\"user_address\",\"label\":\"Address\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"4e0d7ae6-3a2b-470e-892e-a28c3476c114\",\"name\":\"user_phone\",\"label\":\"Phone No\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"78616030-f9ed-4afb-8839-9838113b3943\",\"name\":\"user_email\",\"label\":\"Email\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"d607e338-4b6f-45b6-a878-d6aa4d7919b8\",\"name\":\"about_company\",\"label\":\"About the Company\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"4f07b740-83f3-4e94-b25d-197e53abeae7\",\"name\":\"product_info\",\"label\":\"Information about the product or service\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"1aa7f6e8-0cd1-4752-a274-56c72606fd2f\",\"name\":\"sector\",\"label\":\"Sector\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"be3a9b4f-6914-469d-974b-121604eecfdb\",\"name\":\"exisiting_social\",\"label\":\"Do you have an existing digital marketing/social media account? (such as websites and social media platforms)\",\"type\":\"radio\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"4107a3d4-68ce-44a0-9be9-9e3bda8bddaf\",\"name\":\"social_platforms\",\"label\":\"If yes, what platforms are you on? List the different social platforms\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"ac3acf92-029b-40e0-9650-0ea5134f7e65\",\"name\":\"login_details\",\"label\":\"Kindly provide login details for existing accounts if any\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"35136d67-d274-47f3-ac8c-c541085ce099\",\"name\":\"website\",\"label\":\"Webiste\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"f6d8ffc7-d3c5-4a93-8231-ae5de06af87d\",\"name\":\"logo\",\"label\":\"Upload Logo\",\"type\":\"file\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"cf366441-e3a6-4b6f-b670-d6d8864e7fdc\",\"name\":\"brand_colors\",\"label\":\"Brand Colors\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"45f63f39-dbff-4482-b73e-2cf394dd7a58\",\"name\":\"contact_person_name\",\"label\":\"Contact Person Name\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Contact Details\"},{\"id\":\"83ff916e-d1a0-401e-81bd-d7843fbc5ed1\",\"name\":\"contact_person_phone\",\"label\":\"Contact Person Phone Number\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Contact Details\"},{\"id\":\"15a6543f-4c6f-446b-b93c-9e79db86586d\",\"name\":\"no_of_ads\",\"label\":\"How many advertisements do you want to do\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"4fd2fcf1-852a-4d28-845f-ddfb492b7873\",\"name\":\"product_to_advertise\",\"label\":\"What particular product or service do you want to advertise?\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"dc0979cf-e2c9-43c6-a7ea-2551a55e54c7\",\"name\":\"target_age\",\"label\":\"Target Age\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"0a2f2af8-e9f3-4008-adc3-0b717bea3e0b\",\"name\":\"target_sex\",\"label\":\"Target Sex\",\"type\":\"select\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\",\"options\":[\"male\",\"female\",\"both\",\"others\"]},{\"id\":\"f2e70d37-5436-4025-9b39-5e199a94345a\",\"name\":\"target_location\",\"label\":\"Target Location\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"dc021e2a-ff04-4c23-8f16-c88c15083f2f\",\"name\":\"additional_info\",\"label\":\"Additional information/content for the service  (Kindly insert an open link to view large information/content)\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"}]','2025-10-12 12:34:06.759','2025-10-29 08:04:01.103'),
('12c67f5a-67e7-4621-a6a9-b5f155159fcb','55ba978c-962d-46bd-83fd-62ab6198dd99','[{\"id\":\"89e70969-98d4-4e2c-acce-7d4d53f7e570\",\"name\":\"user_name\",\"label\":\"Name\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"e0b570b4-d467-46ce-93b2-edbf4809e746\",\"name\":\"user_address\",\"label\":\"Address\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"4e0d7ae6-3a2b-470e-892e-a28c3476c114\",\"name\":\"user_phone\",\"label\":\"Phone No\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"78616030-f9ed-4afb-8839-9838113b3943\",\"name\":\"user_email\",\"label\":\"Email\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"e12a42fd-e511-4d46-9a25-6a416e0dc597\",\"name\":\"about_company\",\"label\":\"About the Company\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"779c6222-b7b3-4112-a028-e474ea53db52\",\"name\":\"product_info\",\"label\":\"Information about the product or service\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"aaf4b168-cbaa-45d4-8d34-46473a2e46ee\",\"name\":\"sector\",\"label\":\"Sector\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"7ff474ff-5254-4cf2-8ec5-275df232785b\",\"name\":\"website\",\"label\":\"Website\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"638cc8e0-d069-4309-8db4-0aef430d4749\",\"name\":\"website_login_details\",\"label\":\"Website Login Details\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"8d2b7536-9f08-4a40-a007-ccf51d3ea0d0\",\"name\":\"logo\",\"label\":\"Upload Logo\",\"type\":\"file\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"7654d7e7-02b5-41ca-a9c3-2073ae3f8cc8\",\"name\":\"brand_colors\",\"label\":\"Brand Colors\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"c6df5242-db58-492b-a25c-4b4d4cca9698\",\"name\":\"contact_person_name\",\"label\":\"Contact Person Name\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Contact Details\"},{\"id\":\"53bb9e99-9c3b-4ea9-b628-a26194609948\",\"name\":\"contact_person_phone\",\"label\":\"Contact Person Phone Number\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Contact Details\"},{\"id\":\"7c0dc0d3-bb4e-4566-b4e8-ea22810716b0\",\"name\":\"target_age\",\"label\":\"Target Age\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"9a186442-13da-4948-9fcb-a68110718f9e\",\"name\":\"target_sex\",\"label\":\"Target Sex\",\"type\":\"select\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\",\"options\":[\"male\",\"female\",\"both\",\"others\"]},{\"id\":\"ff3e5cc2-cceb-48a5-a35a-453bcd033c9f\",\"name\":\"target_location\",\"label\":\"Target Location\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"c01af3fb-b94d-4fc5-b496-15d6b5073bd0\",\"name\":\"keywords\",\"label\":\"Important keywords to insert\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"b88f3992-b80a-4607-b835-543092fa98b8\",\"name\":\"additional_info\",\"label\":\"Additional information/content for the service  (Kindly insert an open link to view large information/content)\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"}]','2025-10-12 12:35:05.845','2025-10-29 08:14:33.263'),
('e4f037a1-a939-4061-bf13-1b6de64b6fba','eb59f293-1e8b-41a4-9584-78bd20a5002f','[{\"id\":\"89e70969-98d4-4e2c-acce-7d4d53f7e570\",\"name\":\"user_name\",\"label\":\"Name\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"e0b570b4-d467-46ce-93b2-edbf4809e746\",\"name\":\"user_address\",\"label\":\"Address\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"4e0d7ae6-3a2b-470e-892e-a28c3476c114\",\"name\":\"user_phone\",\"label\":\"Phone No\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"78616030-f9ed-4afb-8839-9838113b3943\",\"name\":\"user_email\",\"label\":\"Email\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"7a1e41db-ab3c-48f2-971e-559991f6c858\",\"name\":\"about_company\",\"label\":\"About the Company\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"aedd72e0-2c19-4182-b6a9-5a3a3e2156b5\",\"name\":\"product_info\",\"label\":\"Information about the product or service\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"c0b5305f-0994-4069-92a3-97126733d617\",\"name\":\"sector\",\"label\":\"Sector\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"02895131-a412-4569-a049-a1f31ddcec56\",\"name\":\"website\",\"label\":\"Website\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"a7ac8978-1dad-4a59-a0eb-95d1fa93b4ce\",\"name\":\"website_login_details\",\"label\":\"Website Login Details\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"fa7e9180-47a7-407e-b140-608dd5234cd7\",\"name\":\"ads_account\",\"label\":\"Do you have an ads account?\",\"type\":\"radio\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"18de7b8a-b3a4-4b4e-9ce6-fcb62b2f97dd\",\"name\":\"google_credentials\",\"label\":\"If yes, kindly provide google account login credentials\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"8e2783f0-0440-46ad-8d5d-4d61895a4521\",\"name\":\"should_create_ads_account\",\"label\":\"If no, should we an ads account for you?\",\"type\":\"radio\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"43c6e465-960b-4553-80bb-664ed64c7e88\",\"name\":\"logo\",\"label\":\"Upload Logo\",\"type\":\"file\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"96e51de9-f6f9-4647-83dd-773b553de6b3\",\"name\":\"brand_colors\",\"label\":\"Brand Colors\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"cbe5b1a0-d58c-476a-a5db-eb8f3dd57c38\",\"name\":\"contact_person_name\",\"label\":\"Contact Person Name\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Contact Details\"},{\"id\":\"1068fd39-2cd2-4780-ad9d-68106c6a818b\",\"name\":\"contact_person_phone\",\"label\":\"Contact Person Phone Number\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Contact Details\"},{\"id\":\"ede2590d-ad61-477e-8583-92f4721c1e27\",\"name\":\"target_age\",\"label\":\"Target Age\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"a711b20a-3b77-49b5-949c-5f2ecfa12094\",\"name\":\"target_sex\",\"label\":\"Target Sex\",\"type\":\"select\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\",\"options\":[\"male\",\"female\",\"both\",\"others\"]},{\"id\":\"e0446c32-c114-4bd7-ba25-e36c13855696\",\"name\":\"target_location\",\"label\":\"Target Location\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"76bdcd4d-fa0e-469b-bb80-a48d0047ea44\",\"name\":\"product_to_sponsor\",\"label\":\"Product to sponsor\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"d5322400-4c12-4e80-b1a6-13eb497b0352\",\"name\":\"additional_info\",\"label\":\"Additional information/content for the service  (Kindly insert an open link to view large information/content)\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"}]','2025-10-12 12:35:59.262','2025-10-29 08:20:59.280'),
('b446e7e4-568e-4d83-aeb1-013d6bd206b1','fbe08dd4-8c85-4ab7-b61b-b4a3a2f4656c','[{\"id\":\"89e70969-98d4-4e2c-acce-7d4d53f7e570\",\"name\":\"user_name\",\"label\":\"Name\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"e0b570b4-d467-46ce-93b2-edbf4809e746\",\"name\":\"user_address\",\"label\":\"Address\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"4e0d7ae6-3a2b-470e-892e-a28c3476c114\",\"name\":\"user_phone\",\"label\":\"Phone No\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"78616030-f9ed-4afb-8839-9838113b3943\",\"name\":\"user_email\",\"label\":\"Email\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"4eb4a326-85f1-41b0-9933-2549bbcc43d3\",\"name\":\"about_company\",\"label\":\"About the Company\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"2e0aa209-5e82-44fb-8a8f-6cf2c0f766af\",\"name\":\"product_info\",\"label\":\"Information about the product or service\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"64b7627e-2640-475e-a563-6b873dc1dbe2\",\"name\":\"sector\",\"label\":\"Sector\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"c49157da-8f72-4c1e-acb5-45461705100b\",\"name\":\"website\",\"label\":\"Website\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"f16dc689-1d1e-4033-a9d9-b0a5ab4caebf\",\"name\":\"website_login_details\",\"label\":\"Website Login Details\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":1,\"groupName\":\"Service Information\"},{\"id\":\"66cd1c4b-d7f2-4c2e-be7c-1de7f38f8180\",\"name\":\"do_you_have_a_google_account?\",\"label\":\"Do you have a google account?\",\"type\":\"radio\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"d7e458a3-9cec-4f55-92cd-cbd497c73a6b\",\"name\":\"google_credentials\",\"label\":\"If yes, kindly provide google account login credentials\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":1,\"groupName\":\"Service Information\"},{\"id\":\"bb2e0f6e-56cb-44bb-9c3e-364cf81ef905\",\"name\":\"logo\",\"label\":\"Upload Logo\",\"type\":\"file\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"f8e0ddab-3fae-4e4d-91b9-76be4405081d\",\"name\":\"brand_colors\",\"label\":\"Brand Colors\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"c86d72ed-a1d1-411d-92f9-5baa676a378c\",\"name\":\"contact_person_name\",\"label\":\"Contact Person Name\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Contact Details\"},{\"id\":\"1d362539-e8f7-4ff6-90f1-41059fd96488\",\"name\":\"contact_person_phone\",\"label\":\"Contact Person Phone Number\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Contact Details\"},{\"id\":\"87422a7c-3b61-4e92-a236-98b9edde3623\",\"name\":\"social_media_handles\",\"label\":\"Social Media Handles\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"28efb5a4-dae1-40a1-a653-318784a7f49d\",\"name\":\"target_age\",\"label\":\"Target Age\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"5e8c5e28-e76e-450a-bef5-02dfc1ca4a6a\",\"name\":\"target_sex\",\"label\":\"Target Sex\",\"type\":\"select\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\",\"options\":[\"male\",\"female\",\"both\",\"others\"]},{\"id\":\"71a3c26d-5476-4628-8f01-af722a6a895b\",\"name\":\"target_location\",\"label\":\"Target Location\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"e01b99c9-a4d7-46e1-8250-2cf479d97214\",\"name\":\"additional_info\",\"label\":\"Additional information/content for the service  (Kindly insert an open link to view large information/content)\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"}]','2025-10-12 12:37:29.712','2025-10-29 08:20:56.753'),
('8387cfe5-3f06-4700-957d-72f25f62deb8','592c042f-68ed-407d-a6c2-23a08a547e25','[{\"id\":\"89e70969-98d4-4e2c-acce-7d4d53f7e570\",\"name\":\"user_name\",\"label\":\"Name\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"e0b570b4-d467-46ce-93b2-edbf4809e746\",\"name\":\"user_address\",\"label\":\"Address\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"4e0d7ae6-3a2b-470e-892e-a28c3476c114\",\"name\":\"user_phone\",\"label\":\"Phone No\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"78616030-f9ed-4afb-8839-9838113b3943\",\"name\":\"user_email\",\"label\":\"Email\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"7471ee49-93a9-4bc0-b095-2a95678d84f3\",\"name\":\"about_company\",\"label\":\"About the Company\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"05cf6e7c-91d6-493c-8350-8cbab3b57f37\",\"name\":\"product_info\",\"label\":\"Information about the product or service\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"04642ed3-e958-41fd-91d1-49db626d6cbf\",\"name\":\"sector\",\"label\":\"Sector\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"2bca012a-5222-49b9-963d-b97c99469edf\",\"name\":\"do_you_require_a_new_website_mobile_application\",\"label\":\"Do you require a new website/mobile application?\",\"type\":\"radio\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"26192f25-11a3-4099-bb3c-6c3e5bc485e3\",\"name\":\"suggested_names_for_your_website_and_mobile_application:\",\"label\":\"Suggested names for your website and mobile application:\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"33baed8c-4bc3-4524-913f-20468598dc7a\",\"name\":\"website\",\"label\":\"Website\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"b3b695f3-090a-47b4-b8f3-60abffa6b961\",\"name\":\"logo\",\"label\":\"Upload Logo\",\"type\":\"file\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"46697bfd-e1cd-451d-92dc-bfb6b263a24f\",\"name\":\"brand_colors\",\"label\":\"Brand Colors\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"6bec1645-dd26-4967-a50e-ace5852ed584\",\"name\":\"contact_person_name\",\"label\":\"Contact Person Name\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Contact Details\"},{\"id\":\"8996d399-3d45-42f2-ab3d-ac2bd70806e7\",\"name\":\"contact_person_phone\",\"label\":\"Contact Person Phone Number\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Contact Details\"},{\"id\":\"a1890da1-b364-4c9a-bb37-b620e61f1149\",\"name\":\"social_media_handles\",\"label\":\"Social Media Handles\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"97758cb7-c8b2-491b-b1b6-cc8e66909e40\",\"name\":\"target_age\",\"label\":\"Target Age\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"9603cc41-807a-48c0-8ed8-51cc607cd90f\",\"name\":\"target_sex\",\"label\":\"Target Sex\",\"type\":\"select\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\",\"options\":[\"male\",\"female\",\"both\",\"others\"]},{\"id\":\"8ba93ac6-29ac-4cb2-986c-bfa951b6b549\",\"name\":\"target_location\",\"label\":\"Target Location\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"e3e2fa7a-1e4e-45e3-8093-abf91f7cdff3\",\"name\":\"do_you_want_us_to_do_your_copy_content?\",\"label\":\"Do you want us to do your copy/content?\",\"type\":\"radio\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"9e8a6c06-e069-4924-9879-d65971e1f3d0\",\"name\":\"do_you_have_your_domain_name,_hosting_and_ssl_certificate?\",\"label\":\"Do you have your domain name, hosting and SSL certificate?\",\"type\":\"radio\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"dcfcc4ec-0bfc-43ac-acfc-8098fa52eb34\",\"name\":\"additional_info\",\"label\":\"Additional information/content for the service  (Kindly insert an open link to view large information/content)\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"}]','2025-10-12 12:38:49.239','2025-10-29 08:32:45.479'),
('2bee7def-83a6-463b-8f17-06cf7932e928','7485248f-5f54-4c9f-9c9c-8e2850847ade','[{\"id\":\"89e70969-98d4-4e2c-acce-7d4d53f7e570\",\"name\":\"user_name\",\"label\":\"Name\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"e0b570b4-d467-46ce-93b2-edbf4809e746\",\"name\":\"user_address\",\"label\":\"Address\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"4e0d7ae6-3a2b-470e-892e-a28c3476c114\",\"name\":\"user_phone\",\"label\":\"Phone No\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"78616030-f9ed-4afb-8839-9838113b3943\",\"name\":\"user_email\",\"label\":\"Email\",\"type\":\"text\",\"required\":true,\"fromUser\":true,\"step\":1,\"groupName\":\"User Details\"},{\"id\":\"394c10fb-002e-4fc4-a947-39fcae8225d0\",\"name\":\"about_company\",\"label\":\"About the Company\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"2692e1cc-48fa-426e-9b23-a8af0c49e2a2\",\"name\":\"product_info\",\"label\":\"Information about the product or service\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"da4a90ff-3b88-4781-8a6b-7cc265267ea4\",\"name\":\"sector\",\"label\":\"Sector\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"e9400214-96cf-4233-8bcd-b3ce2790d907\",\"name\":\"website\",\"label\":\"Website\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"c6752bde-9a74-43e9-a393-8f543134b819\",\"name\":\"if_your_website_has_an_existing_account,_kindly_share_login_details\",\"label\":\"If your website has an existing account, kindly share login details\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"44fd38eb-3470-4789-885c-37cb99e9e607\",\"name\":\"logo\",\"label\":\"Upload Logo\",\"type\":\"file\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"998b16cc-85ab-4d3e-ae79-49daac6e6910\",\"name\":\"brand_colors\",\"label\":\"Brand Colors\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"a2c59280-5a4f-455d-a1db-9a65f51af26e\",\"name\":\"social_media_handles\",\"label\":\"Social Media Handles\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":2,\"groupName\":\"Service Information\"},{\"id\":\"97297bd1-ab5c-4921-9c49-33c08eab6ed3\",\"name\":\"contact_person_name\",\"label\":\"Contact Person Name\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Contact Details\"},{\"id\":\"b7d6aaf2-0b52-4fc0-a104-22627b521748\",\"name\":\"contact_person_phone\",\"label\":\"Contact Person Phone Number\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":3,\"groupName\":\"Contact Details\"},{\"id\":\"8d53f06f-47e3-46df-a3a6-c82caf7cc6ba\",\"name\":\"target_age\",\"label\":\"Target Age\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"e223b203-4867-41cc-a246-97a6e4a9da8d\",\"name\":\"target_sex\",\"label\":\"Target Sex\",\"type\":\"select\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\",\"options\":[\"male\",\"female\",\"both\",\"others\"]},{\"id\":\"b85ab316-c875-4d55-87ec-cdd04c6c766b\",\"name\":\"target_location\",\"label\":\"Target Location\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"9efd28ef-4b7d-4644-a49b-16706206aaf9\",\"name\":\"do_you_want_us_to_do_your_copy_content?\",\"label\":\"Do you want us to do your copy/content?\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"f13514f4-fac1-4de5-97cf-4f3a56c11b20\",\"name\":\"areas_of_importance_to_maintain_regularly\",\"label\":\"Areas of importance to maintain regularly\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"},{\"id\":\"90c3ef5e-a7af-45b8-9550-5e9fe3f73097\",\"name\":\"additional_info\",\"label\":\"Additional information/content for the service  (Kindly insert an open link to view large information/content)\",\"type\":\"text\",\"required\":false,\"fromUser\":false,\"step\":4,\"groupName\":\"Request Details\"}]','2025-10-12 12:40:48.402','2025-10-29 08:32:40.761');
/*!40000 ALTER TABLE `ServiceForm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ServiceRequest`
--

DROP TABLE IF EXISTS `ServiceRequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ServiceRequest` (
  `id` varchar(191) NOT NULL,
  `user_id` varchar(191) NOT NULL,
  `service_id` varchar(191) NOT NULL,
  `plan_name` varchar(191) NOT NULL,
  `status` enum('PENDING_APPROVAL','ACTIVE','COMPLETED','DECLINED','CANCELLED') NOT NULL DEFAULT 'PENDING_APPROVAL',
  `start_date` datetime(3) DEFAULT NULL,
  `end_date` datetime(3) DEFAULT NULL,
  `formData` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`formData`)),
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL,
  `planId` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ServiceRequest_user_id_fkey` (`user_id`),
  KEY `ServiceRequest_service_id_fkey` (`service_id`),
  KEY `ServiceRequest_planId_fkey` (`planId`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ServiceRequest`
--

LOCK TABLES `ServiceRequest` WRITE;
/*!40000 ALTER TABLE `ServiceRequest` DISABLE KEYS */;
INSERT INTO `ServiceRequest` VALUES
('d1518a44-8b3d-4035-ba4e-4f7b2b1a0415','1d0ee97c-c72c-40ff-bd10-3ff86a2cb7c8','732c5bff-4eef-4c38-9504-e214f1b3162c','Complete Digital Audit','PENDING_APPROVAL','2026-01-01 00:00:00.000','2026-01-30 00:00:00.000','{\"user_name\":\"Abubakar Usman\",\"user_address\":\"Block C23 Flat 1\",\"user_phone\":\"+234 9066300702\",\"user_email\":\"auabdulkadir04@gmail.com\",\"website\":\"\",\"social_media_handles\":\"\",\"contact_person_name\":\"\",\"contact_person_phone\":\"\",\"about_the_company\":\"\",\"info_about_product_service\":\"\",\"sector\":\"\",\"target_age\":\"\",\"target_demography\":\"\",\"target_location\":\"\",\"additional_resource\":\"\",\"additional_file\":{}}','2026-01-26 22:14:08.486','2026-01-26 22:14:08.486','288dc1ec-5082-4c26-b84d-4b70ada3e832'),
('9453b4d8-b700-4411-b56a-9fe0dfa563de','1d0ee97c-c72c-40ff-bd10-3ff86a2cb7c8','732c5bff-4eef-4c38-9504-e214f1b3162c','Complete Digital Audit','PENDING_APPROVAL','2026-01-08 00:00:00.000','2026-01-23 00:00:00.000','{\"user_name\":\"Abubakar Usman\",\"user_address\":\"Block C23 Flat 1\",\"user_phone\":\"+234 9066300702\",\"user_email\":\"auabdulkadir04@gmail.com\",\"website\":\"\",\"social_media_handles\":\"\",\"contact_person_name\":\"\",\"contact_person_phone\":\"\",\"about_the_company\":\"\",\"info_about_product_service\":\"\",\"sector\":\"\",\"target_age\":\"\",\"target_demography\":\"\",\"target_location\":\"\",\"additional_resource\":\"\",\"additional_file\":{}}','2026-01-26 22:17:28.743','2026-01-26 22:17:28.743','288dc1ec-5082-4c26-b84d-4b70ada3e832'),
('b44f4e12-0723-43ed-8962-e725ffb67676','1d0ee97c-c72c-40ff-bd10-3ff86a2cb7c8','732c5bff-4eef-4c38-9504-e214f1b3162c','Complete Digital Audit','PENDING_APPROVAL','2026-01-01 00:00:00.000','2026-01-29 00:00:00.000','{\"user_name\":\"Abubakar Usman\",\"user_address\":\"Block C23 Flat 1\",\"user_phone\":\"+234 9066300702\",\"user_email\":\"auabdulkadir04@gmail.com\",\"website\":\"\",\"social_media_handles\":\"\",\"contact_person_name\":\"\",\"contact_person_phone\":\"\",\"about_the_company\":\"\",\"info_about_product_service\":\"\",\"sector\":\"\",\"target_age\":\"\",\"target_demography\":\"\",\"target_location\":\"\",\"additional_resource\":\"\",\"additional_file\":{}}','2026-01-26 22:08:42.202','2026-01-26 22:08:42.202','288dc1ec-5082-4c26-b84d-4b70ada3e832'),
('0ff9d1f8-2498-4db2-a36f-b17d8309fa09','fcba6ceb-f506-458d-b5f1-4cca8af09608','6d8a2315-6e5a-4eb2-88ac-68e725909668','Single Design (Flyer/Graphic)','ACTIVE','2025-10-21 00:00:00.000','2025-10-25 00:00:00.000','{\"user_name\":\"Repairwolf \",\"user_address\":\"House J1, Abdullahi Adamu Estate, Ijeh ikoyi lagos\",\"user_phone\":\"+234 9030000736\",\"user_email\":\"socialmigratrada@gmail.com\",\"website\":\"www.repairwolf.co.uk\",\"logo\":{\"0\":{}},\"brand_colors\":\"Purple, orange, grey and white\",\"social_media_handles\":\"Repairwolf\",\"contatc_person_name\":\"George\",\"contact_person_phone\":\"09030000736\",\"about_the_company\":\"Repairwolf\",\"product_or_service_info\":\"RepairWolf is a trusted UK-based platform that connects homeowners, tenants, landlords, and businesses with fully vetted local tradespeople. From plumbing and electrical work to cleaning, carpentry, and emergency repairs, we make booking reliable professionals simple and stress-free.\",\"sector\":\"Services\",\"target_age\":\"21-60\",\"target_demography\":\" RepairWolf Target Demographics  1. 🏡 Homeowners  Age: 30–65  ●Looking for: Trusted local tradespeople for home repairs  ●Common needs: Plumbing, electrical, handyman, cleaning  2. 🏢 Landlords & Property Managers  Age: 28–60  ●Looking for: Fast, reliable tradespeople to manage multiple properties  ●Common issues: Missed appointments, poor quality control    3. 🏘 Letting Agents & Housing Associations  Age: 30–60  ●Looking for: Verified tradespeople for ongoing property maintenance  ●Bonus: Section 106 & compliance-ready services    4. 🧑‍💼 Business Owners (Shops, Offices, Salons, etc.)  Age: 30–55  ●Looking for: Quick response repairs to avoid downtime  ●Common requests: Electrical, handyman, cleaning, painting  5. 👩‍🎓 Tenants & Renters  Age: 21–45  ●Looking for: Affordable, fast repairs without landlord delay  ●Common needs: Appliance fixes, minor plumbing, cleaning  6. 🔧 Tradespeople (Plumbers, Electricians, Cleaners, etc.)  Age: 22–55  ●Looking for: Steady job call-outs, fair pay, supportive platform  ●Benefit: No chasing clients, we send verified jobs to you\",\"target_location\":\"London, United Kingdom\",\"target_sex\":\"Both\",\"additional_link\":\"\",\"additional_file\":{\"0\":{}}}','2025-10-21 13:54:03.128','2025-10-22 13:34:29.521','92093195-6729-4df8-9ef1-55bdd44f6d2d'),
('1c16d90a-05a8-4b69-9cf3-44ad7c4997a6','28d31f78-3fe9-43ac-a20f-8a2730879296','6d8a2315-6e5a-4eb2-88ac-68e725909668','Single Design (Flyer/Graphic)','PENDING_APPROVAL','2026-01-22 00:00:00.000','2026-01-30 00:00:00.000','{\"user_name\":\"Joy Arit idara\",\"user_address\":\"23, Edo street off airport road\",\"user_phone\":\"+234 7034414958\",\"user_email\":\"joy4arit@gmail.com\",\"info_about_service\":\"\",\"about_the_company\":\"Into event planning and management \",\"product_or_service_info\":\"Services \",\"sector\":\"Private \",\"social_media_handles\":\"https://www.aiforwork.co/\",\"website\":\"https://www.aiforwork.co/\",\"logo\":\"https://res.cloudinary.com/ddrutuohj/image/upload/v1768488302/service-requests/6d8a2315-6e5a-4eb2-88ac-68e725909668/m0vowqezdblbheuynm7v.png\",\"brand_colors\":\"Pink, white\",\"contact_person_name\":\"Joy Arit Okon\",\"contact_phone\":\"09122455856\",\"target_age\":\"20-45\",\"target_demography\":\"Delta state \",\"target_location\":\"Lagos and Abuja \",\"target_sex\":\"Both\",\"additional_link\":\"\"}','2026-01-15 14:45:03.166','2026-01-15 14:45:03.166','92093195-6729-4df8-9ef1-55bdd44f6d2d'),
('c46777d5-766d-4d2c-a302-769a0ea7a3a4','b5f87ce0-e3b5-4a00-992c-c3666bdef154','732c5bff-4eef-4c38-9504-e214f1b3162c','Complete Digital Audit','PENDING_APPROVAL','2026-01-29 00:00:00.000','2026-01-30 00:00:00.000','{\"user_name\":\"John paul\",\"user_address\":\"Yujkk\",\"user_phone\":\"+234 81062995504\",\"user_email\":\"olaoluo@yahoo.co.uk\",\"website\":\"\",\"social_media_handles\":\"\",\"contact_person_name\":\"\",\"contact_person_phone\":\"\",\"about_the_company\":\"\",\"info_about_product_service\":\"\",\"sector\":\"\",\"target_age\":\"\",\"target_demography\":\"\",\"target_location\":\"\",\"additional_resource\":\"\",\"additional_file\":{}}','2026-01-26 16:23:29.792','2026-01-26 16:23:29.792','288dc1ec-5082-4c26-b84d-4b70ada3e832');
/*!40000 ALTER TABLE `ServiceRequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Subscription`
--

DROP TABLE IF EXISTS `Subscription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Subscription` (
  `id` char(36) NOT NULL,
  `start_date` timestamp NULL DEFAULT current_timestamp(),
  `end_date` timestamp NULL DEFAULT NULL,
  `status` varchar(20) NOT NULL,
  `user_id` char(36) NOT NULL,
  `plan_id` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Subscription_plan_id_idx` (`plan_id`),
  KEY `Subscription_user_id_fkey` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Subscription`
--

LOCK TABLES `Subscription` WRITE;
/*!40000 ALTER TABLE `Subscription` DISABLE KEYS */;
/*!40000 ALTER TABLE `Subscription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Testimonial`
--

DROP TABLE IF EXISTS `Testimonial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Testimonial` (
  `id` char(36) NOT NULL,
  `quote` text NOT NULL,
  `authorName` varchar(100) NOT NULL,
  `authorTitle` varchar(100) NOT NULL,
  `stars` int(11) NOT NULL DEFAULT 5,
  `authorImageUrl` text DEFAULT NULL,
  `service_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Testimonial_service_id_fkey` (`service_id`),
  KEY `Testimonial_user_id_fkey` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Testimonial`
--

LOCK TABLES `Testimonial` WRITE;
/*!40000 ALTER TABLE `Testimonial` DISABLE KEYS */;
/*!40000 ALTER TABLE `Testimonial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `id` char(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `tel` varchar(20) NOT NULL,
  `country` varchar(64) NOT NULL,
  `city` varchar(64) DEFAULT NULL,
  `address` text NOT NULL,
  `category` varchar(15) NOT NULL,
  `pfp_url` text DEFAULT NULL,
  `id_url` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`id_url`)),
  `business_status` tinyint(1) DEFAULT NULL,
  `registered_with_a_business` tinyint(1) DEFAULT NULL,
  `password` text NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'unverified',
  `role_id` char(36) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tel` (`tel`),
  UNIQUE KEY `email` (`email`) USING HASH,
  KEY `user_role_id_fkey` (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES
('a20b1f85-d726-4ff1-9259-872f2d2b0b1f','Admin User','admin@dma.com','00000000000','Nigeria',NULL,'Admin Address','organisation',NULL,NULL,NULL,NULL,'$2b$10$rsLZi6BbuEIKZfstKY5fRONElLfCpsTWD67R/4juwCQVicFXIooLi','verified','57c29dbb-8f5a-4c05-8702-d4d8cd5749c9','2025-10-11 03:14:43',NULL),
('1d0ee97c-c72c-40ff-bd10-3ff86a2cb7c8','Abubakar Usman','auabdulkadir04@gmail.com','+234 9066300702','Nigeria','Gwagwalada','Block C23 Flat 1','individual','https://res.cloudinary.com/ddrutuohj/image/upload/v1760372139/users/profile-pic/kuny2yuovnr5mdtfynjw.jpg','[\"https://res.cloudinary.com/ddrutuohj/image/upload/v1760372139/users/docs/mjxw5wqn3nvcn8zonwar.jpg\"]',NULL,NULL,'$2b$10$qmBrRqZx3nCQYlgb8qp0NOz28rwua2YvBuAvvHmatYBge7PdyedZu','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2025-10-13 20:14:17',NULL),
('b5f87ce0-e3b5-4a00-992c-c3666bdef154','John paul','olaoluo@yahoo.co.uk','+234 81062995504','Nigeria','Abuja','Yujkk','individual','https://res.cloudinary.com/ddrutuohj/image/upload/v1760377383/users/profile-pic/h1ywoya5ttnccncumcfz.jpg','[\"https://res.cloudinary.com/ddrutuohj/image/upload/v1760377384/users/docs/ot6utbwd5xsy90st4owj.jpg\"]',NULL,NULL,'$2b$10$k.CZNbkPNDXH14H8TAp6nuxHW0saigJ42zp6B0BjOqdyTCETf.KZa','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2025-10-13 21:41:17',NULL),
('b197e1ff-76b4-446b-b75a-aea265a9d4c4','Dev Seedbuilders','development@seedbuildersng.com','+234 488494949','Austria','Abuja','C 23 Flat 1','organisation',NULL,NULL,NULL,NULL,'$2b$10$T0HGY3vpfyS8Jida4nYHG.oNs5vqtcxp5e0xybe3uaFK/tLjExT6a','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2025-10-27 17:15:22',NULL),
('38f2c5fe-b708-4ae5-85e2-5b1fb974fe25','Uche John','oolorunnisomo2019@gmail.com','+234 9090008888','Nigeria','abuja','6a embu street','individual','https://res.cloudinary.com/ddrutuohj/image/upload/v1760422483/users/profile-pic/xabeg7rial8boxls5dx3.jpg','[\"https://res.cloudinary.com/ddrutuohj/image/upload/v1760422484/users/docs/invxsilfoesmxlxagzne.jpg\"]',NULL,NULL,'$2b$10$TJZB.oQ054RPmTLOqsHt0.KpzUnlLoX3Tp28.uttE9T5BRN9jcmoe','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2025-10-14 10:12:05',NULL),
('fa639c0d-fff1-49c7-81c9-4e11ec563e20','Ahmed Yusuf','olaolu@seedbuildersng.com','+234 8106299504','Nigeria','abuja','6a embu street, aminu kano ','organisation',NULL,NULL,NULL,NULL,'$2b$10$NyMuSpTnJC6.IsGs6AtsVOpyy1IP9dL4YLOEy4DYZMe33dokyI9Bu','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2025-10-16 10:18:02',NULL),
('fcba6ceb-f506-458d-b5f1-4cca8af09608','Repairwolf ','socialmigratrada@gmail.com','+234 9030000736','Nigeria','Lagos state','House J1, Abdullahi Adamu Estate, Ijeh ikoyi lagos','individual','https://res.cloudinary.com/ddrutuohj/image/upload/v1761041856/users/profile-pic/cnrmlwrdmajqvuueovqf.jpg','[\"https://res.cloudinary.com/ddrutuohj/image/upload/v1761041857/users/docs/pfuhd2gzsob4pba43cwr.jpg\"]',NULL,NULL,'$2b$10$uSy6bZ4FwBiPJDSKGSWBLey8dP7S5TIoDm6GGMcMi6tOy.eX0yApC','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2025-10-21 14:15:43',NULL),
('825d0530-0267-45f0-bc5e-dd46fddc415e','utsu fanny','fannykyrian@gmail.com','+234 08139169716','Nigeria','ABUJA','karu','individual','https://res.cloudinary.com/ddrutuohj/image/upload/v1761568142/users/profile-pic/htiasmzfu5sf01lvwjzo.jpg','[\"https://res.cloudinary.com/ddrutuohj/image/upload/v1761568144/users/docs/y4q9c52pqbusycbkklf0.jpg\"]',NULL,NULL,'$2b$10$clR5ECKR9OzKPutYrcvPJekguVqm6G606AFYJespbkdQtxIH3/CC.','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2025-10-27 16:21:28',NULL),
('17f24fe1-aa2b-436a-82cd-dcc216a47df5','Ano O','azulservicesnig@gmail.com','+234 08106299555','Nigeria','lagos','1 carlcon street','individual',NULL,NULL,NULL,NULL,'$2b$10$5LWHTSpCJcEnNkAiIYX1zuQjoMrJU4CGjq83srVcQ.cow2CdNs5Xa','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2025-10-21 15:01:07',NULL),
('f4aa2960-1829-4084-adfb-68fef7d4d527','Azurefoods','azurefoods1@gmail.com','+234 9115460028','Nigeria','Arepo','House 49 Forthright Road, Forthright Estate, Arepo ','individual',NULL,NULL,NULL,NULL,'$2b$10$Kng1gzU5rRT2a7dWTfQSOunUA2jFzcxOTMr3ajJoaCysRC93gj.b2','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2026-01-16 04:00:15',NULL),
('8aee7c57-7b67-4383-8a4e-061f6667c852','Marvellous','marvellousigbineweka@gmail.com','+234 7076188176','Nigeria','Ifako Ijaiye','39, Segun Adetiba road, Ajegunle bus stop, ifako-ijaiye e lcda, Lagos state.','individual',NULL,NULL,NULL,NULL,'$2b$10$g/h6yVIrhaosxYZ5q7FJTegCOM2B7i2xnghRZSyv9HAm.5SWibyGG','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2026-01-16 17:56:13',NULL),
('954f0742-a728-41c2-b73f-06cf617a809c','Grace Omonua','graceydupe@gmail.com','+234 9058959392','Nigeria','Benin City','Benin Auchi Rd','individual',NULL,NULL,NULL,NULL,'$2b$10$uZfVzn4In2EDcHKNxrCVe.2ZjKBYWtqJ4xRsQJ./ucW4A.Dam4eBq','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2026-01-16 18:24:32',NULL),
('1d761c7c-a133-4924-9a67-e7013136be0c','Novelty homes ','pdkachi2000@yahoo.com','+234 08032122356','Nigeria','Ajah','Olokonla ajah ','organisation',NULL,NULL,NULL,NULL,'$2b$10$LSeUJ8XIuiB1ce6l9C6FxO2BxIcDg0EC/ZYZJv7AvNpuh/jVaKpqC','unverified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2026-01-17 13:22:03',NULL),
('4b1ec1f7-bd2e-43d0-867d-a2861132c263','Chukwuemeka Chukwuemeka','emekatheophilus13@gmail.com','+234 08134911567','Nigeria','Lagos','20 Nasco estate satellite Town Lagos','individual',NULL,NULL,NULL,NULL,'$2b$10$GCVJLfvHk3UTVNItgataceyhgG8T1f32JuKig9WJ1fcQj1yp8nUN.','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2025-12-20 05:46:08',NULL),
('292bb7c3-9824-470d-9340-eca4e4ea66e7','Mayowa olabode Adewara','mayostex@yahoo.com','+234 08037697004','Nigeria','Lagos ','mayostex@gmail.com','organisation',NULL,NULL,NULL,NULL,'$2b$10$QOwGVh/N.JwGmlOmjNhxPuvaPdf.xEqwMMB16IYNNR4rhAZEAwWgK','unverified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2025-12-21 04:37:22',NULL),
('840c1bca-4b39-4f6f-bcdf-ffba6bb9ec9a','Olaide Akintola','tplaide@yahoo.com','+234 8097779088','Nigeria','Lekki phase 1','6, Niyi Okunubi, lekki phase 1','individual','https://res.cloudinary.com/ddrutuohj/image/upload/v1766277048/users/profile-pic/aaw9xqae6tp3bg5hamfr.jpg','[\"https://res.cloudinary.com/ddrutuohj/image/upload/v1766277050/users/docs/goaj1kwksa8fq1wkzbhf.jpg\"]',NULL,NULL,'$2b$10$AagMubRsKJsOty9FqvOWZOocP/OSDzDl0wTPyJkoGneKVjWHoESKy','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2025-12-21 05:25:16',NULL),
('eb289c1a-46c4-401a-b8b6-13c13e870c08','Bright Ogwuh','brightog@yahoo.com','+234 8026174053','Nigeria','LAGOS ','4b Alex Agulefo Street,  Magodo GRA 2','organisation',NULL,NULL,NULL,NULL,'$2b$10$SqP3SZa.IIs.SoexHvjh4OKicrnDagccNW/zK9RcAdZ3S4OKg.IjK','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2025-12-21 08:24:56',NULL),
('5fb1c8c8-44ef-4c86-b0b0-679c991b7a79','otunba bakare','richard.bakare2012@gmail.com','+234 7062420755','Algeria','lagos','3 Association avenue off oluwaseun street Oworoshoki ','individual','https://res.cloudinary.com/ddrutuohj/image/upload/v1766360168/users/profile-pic/wkymr1ztbhpwfgtru1zm.jpg','[\"https://res.cloudinary.com/ddrutuohj/image/upload/v1766360168/users/docs/lrtglmbe3rihno96pxpx.jpg\"]',NULL,NULL,'$2b$10$BiHVVphBSpTgDg6HzmdDzuLp/jYj6biSKc9Ts32P2oX/GY4QBbu4.','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2025-12-22 04:33:24',NULL),
('1256bb0f-bed6-488b-ab8b-84cfcad54220','Justus Oyeleye','bojreal1@gmail.com','+234 8134299550','Nigeria','Ota','Sango ota','organisation',NULL,NULL,NULL,NULL,'$2b$10$.JVTAY9nXyOeScCCF6lwnuVZ2AKmsGLOrF/QGqC0rzLJEabMDWKUy','unverified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2026-01-15 05:34:08',NULL),
('211c15d3-6eba-4bbc-b276-3ec3ea46ad9b','Beauty Memenada','beautiful.bnada@gmail.com','+234 08063631220','Nigeria','Benin City','78 mission Road ','individual',NULL,NULL,NULL,NULL,'$2b$10$tDb4J/2KBtU1rn6YwB.Oc.le4mYcmhLwT4Fo0.QvXl1LJ5AqOSGVC','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2026-01-15 15:30:00',NULL),
('cdc34d54-6879-47f6-af52-b5d8412f8034','ola','hello@seedbuildersfoundation.org','+234 08106299540','Madagascar','yyyy','ttyy','individual','https://res.cloudinary.com/ddrutuohj/image/upload/v1767007407/users/profile-pic/vbap7au54mccgazfc16u.png','[\"https://res.cloudinary.com/ddrutuohj/image/upload/v1767007407/users/docs/tfi8svly0zh8rn3grhfz.png\"]',NULL,NULL,'$2b$10$ypMZa8556zEB3o1pvFTqxu5Z.xafxCkhpNfPI4a0HDxKODjN80qAq','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2025-12-29 16:18:21',NULL),
('c87a282b-9d49-443b-8567-6d90f24933e0','Joy Arit Okon','idarabasi3@gmail.com','+234 9122455856','Nigeria','Benin City','23, Edo street off airport road','individual',NULL,NULL,NULL,NULL,'$2b$10$oi0JF58dy.6Dyz/g/f.VSO6VJFAODZ5QRzYBHbmEinhBhXvO8PMdu','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2026-01-15 19:05:20',NULL),
('28d31f78-3fe9-43ac-a20f-8a2730879296','Joy Arit idara','joy4arit@gmail.com','+234 7034414958','Nigeria','Benin City','23, Edo street off airport road','individual',NULL,NULL,NULL,NULL,'$2b$10$R3g2a30wgm3MsP5IaTRhauzH6pIDgxrZHnHEyAaEG4KEgLpntXR4O','verified','a1ee860d-5798-4f80-ab8b-71624f0a4b7f','2026-01-15 19:25:53',NULL);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `_prisma_migrations`
--

DROP TABLE IF EXISTS `_prisma_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) NOT NULL,
  `checksum` varchar(64) NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) NOT NULL,
  `logs` text DEFAULT NULL,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `applied_steps_count` int(10) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `_prisma_migrations`
--

LOCK TABLES `_prisma_migrations` WRITE;
/*!40000 ALTER TABLE `_prisma_migrations` DISABLE KEYS */;
INSERT INTO `_prisma_migrations` VALUES
('15193393-e2fb-405d-92e4-fbf5316e745f','744009f0629afa68b4cfc31ad3901c72d18fec68597ed00a867aee10a1473199','2025-10-10 23:13:00.829','20251010230418_init',NULL,NULL,'2025-10-10 23:12:59.032',1),
('94b798fe-c5c8-42a5-acd2-4d7588e11f21','dc811b06170d5170d363166df665aaed476049b4d9c2f1d078fcd45d37fcdb63','2025-10-12 11:59:43.637','20251012085934_add_referral_model',NULL,NULL,'2025-10-12 11:59:43.542',1);
/*!40000 ALTER TABLE `_prisma_migrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-01-27  5:26:32
