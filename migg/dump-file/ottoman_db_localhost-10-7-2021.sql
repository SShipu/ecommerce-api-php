-- MySQL dump 10.13  Distrib 5.7.34, for Linux (x86_64)
--
-- Host: localhost    Database: ottoman_db
-- ------------------------------------------------------
-- Server version	5.7.34-0ubuntu0.18.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `branch_address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `note` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`branch_name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES (1,'Uttara','Uttara, Dhaka','','SHOWROOM'),(2,'Mohammadpur','Mohammadpur, Dhaka','','SHOWROOM'),(6,'Shyamoli','Shyamoli, Dhaka','','FACTORY');
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configurations`
--

DROP TABLE IF EXISTS `configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `configurations` (
  `id` int(11) NOT NULL,
  `vat_applicable` tinyint(1) NOT NULL,
  `vat_percentage` double NOT NULL,
  `stock_threshold` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configurations`
--

LOCK TABLES `configurations` WRITE;
/*!40000 ALTER TABLE `configurations` DISABLE KEYS */;
INSERT INTO `configurations` VALUES (1,0,15,10);
/*!40000 ALTER TABLE `configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cusmoter_branch`
--

DROP TABLE IF EXISTS `cusmoter_branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cusmoter_branch` (
  `cusmoter_id` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL,
  PRIMARY KEY (`cusmoter_id`,`branch_id`),
  KEY `IDX_4049BA01D4B8BAA0` (`cusmoter_id`),
  KEY `IDX_4049BA01DCD6CC49` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cusmoter_branch`
--

LOCK TABLES `cusmoter_branch` WRITE;
/*!40000 ALTER TABLE `cusmoter_branch` DISABLE KEYS */;
/*!40000 ALTER TABLE `cusmoter_branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cusmoters`
--

DROP TABLE IF EXISTS `cusmoters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cusmoters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `contact_no` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cusmoters`
--

LOCK TABLES `cusmoters` WRITE;
/*!40000 ALTER TABLE `cusmoters` DISABLE KEYS */;
/*!40000 ALTER TABLE `cusmoters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_branch`
--

DROP TABLE IF EXISTS `customer_branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer_branch` (
  `customer_id` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL,
  PRIMARY KEY (`customer_id`,`branch_id`),
  KEY `IDX_A43C74E9395C3F3` (`customer_id`),
  KEY `IDX_A43C74EDCD6CC49` (`branch_id`),
  CONSTRAINT `FK_A43C74E9395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `cusmoters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_A43C74EDCD6CC49` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_branch`
--

LOCK TABLES `customer_branch` WRITE;
/*!40000 ALTER TABLE `customer_branch` DISABLE KEYS */;
/*!40000 ALTER TABLE `customer_branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice_items`
--

DROP TABLE IF EXISTS `invoice_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice_items` (
  `seq` int(11) NOT NULL,
  `invoice_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sku` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `quantity` double NOT NULL,
  `sub_total` double NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`invoice_id`,`seq`),
  KEY `IDX_DCC4B9F82989F1FD` (`invoice_id`),
  CONSTRAINT `FK_DCC4B9F82989F1FD` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_items`
--

LOCK TABLES `invoice_items` WRITE;
/*!40000 ALTER TABLE `invoice_items` DISABLE KEYS */;
INSERT INTO `invoice_items` VALUES (0,'20210706020443699918-10-1','10-APT032-3-5',880,1,880,'Apple T-Shirt-Blue,Small','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'20210706020552725321-10-1','10-APT032-3-5',880,1,880,'Apple T-Shirt-Blue,Small','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'20210706020602933312-10-1','10-APT032-3-5',880,1,880,'Apple T-Shirt-Blue,Small','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'20210706020607418664-10-1','10-APT032-3-5',880,1,880,'Apple T-Shirt-Blue,Small','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'20210706020949028176-10-1','10-APT032-3-5',880,1,880,'Apple T-Shirt-Blue,Small','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'20210706021156347848-10-1','10-APT032-3-5',880,1,880,'Apple T-Shirt-Blue,Small','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'20210706021328158847-10-1','10-APT032-3-5',880,1,880,'Apple T-Shirt-Blue,Small','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'20210706021357205807-10-1','10-APT032-3-5',880,1,880,'Apple T-Shirt-Blue,Small','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'20210706070832585928-2-1','10-APT032-3-5',700,1,700,'Apple T-Shirt-Blue,Small','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'20210706071217371401-2-1','10-APT032-3-5',700,1,700,'Apple T-Shirt-Blue,Small','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(1,'20210706071217371401-2-1','10-APT032-3-8',900,1,900,'Apple T-Shirt-Blue,XXL','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'20210706071234660439-2-1','10-APT032-3-5',700,2,1400,'Apple T-Shirt-Blue,Small','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(1,'20210706071234660439-2-1','10-APT032-3-8',900,1,900,'Apple T-Shirt-Blue,XXL','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'20210706071258810596-2-1','10-APT032-3-5',700,2,1400,'Apple T-Shirt-Blue,Small','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(1,'20210706071258810596-2-1','10-APT032-3-8',900,1,900,'Apple T-Shirt-Blue,XXL','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'20210706071553922267-2-1','10-APT032-3-5',700,1,700,'Apple T-Shirt-Blue,Small','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'20210706073612390763-2-1','10-APT032-3-5',700,2,1400,'Apple T-Shirt-Blue,Small','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'20210706073633672576-2-1','10-APT032-3-5',700,1,700,'Apple T-Shirt-Blue,Small','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'20210706074452452334-2-1','10-APT032-3-8',900,3,2700,'Apple T-Shirt-Blue,XXL','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'20210706075130729682-2-1','10-APT032-3-8',900,1,900,'Apple T-Shirt-Blue,XXL','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'20210708032329338109-2-1','1-RBX098-3-5',999,1,999,'Rebox t-shirt-Blue,Small','80548fefb941974ff1c68ecedf14f6ff1f68aad778a1fa921e1037e4ea9f236a1d53e972cabfa113b685ecd4a6503e747c50d4e5b0ab87adef3f47b931b703a1.jpg'),(0,'20210708122845319181-2-1','1-RBX098-3-5',999,1,999,'Rebox t-shirt-Blue,Small','80548fefb941974ff1c68ecedf14f6ff1f68aad778a1fa921e1037e4ea9f236a1d53e972cabfa113b685ecd4a6503e747c50d4e5b0ab87adef3f47b931b703a1.jpg'),(0,'20210708124319317857-1-2','10-APT032-3-5',880,1,880,'Apple T-Shirt-Blue,Small','46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(0,'49JUQ314E90KK-1-2','9-TT002-4-7',800,7,5600,'Test T-Shirt-Black,XL','470d63d248fb0f71a27d9bf7a35f5fa3fcef895293c98c113713e70dca953a67f0e8a79ca2fb371a81eb2c2ff556fbfafb16fa22ba07ae2c072bb8037b86ff4d.jpg'),(0,'49JUQ314KYGW8-1-2','9-TT002-4-7',800,6,4800,'Test T-Shirt-Black,XL','470d63d248fb0f71a27d9bf7a35f5fa3fcef895293c98c113713e70dca953a67f0e8a79ca2fb371a81eb2c2ff556fbfafb16fa22ba07ae2c072bb8037b86ff4d.jpg'),(0,'49JUQT19RDGK4-1-2','9-TT002-4-7',800,1,800,'Test T-Shirt-Black,XL','470d63d248fb0f71a27d9bf7a35f5fa3fcef895293c98c113713e70dca953a67f0e8a79ca2fb371a81eb2c2ff556fbfafb16fa22ba07ae2c072bb8037b86ff4d.jpg');
/*!40000 ALTER TABLE `invoice_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoices` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_by_user_id` int(11) DEFAULT NULL,
  `parent_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sub_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `source` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `payment_status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `delivery_status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `total` double NOT NULL,
  `net_total` double NOT NULL,
  `grand_total` double NOT NULL,
  `discount` double NOT NULL,
  `discount_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `vat_percentage` double NOT NULL,
  `vat_amount` double NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_code` (`id`),
  KEY `IDX_6A2F2F957D182D95` (`created_by_user_id`),
  KEY `IDX_6A2F2F95727ACA70` (`parent_id`),
  KEY `IDX_6A2F2F959395C3F3` (`customer_id`),
  KEY `IDX_6A2F2F95DCD6CC49` (`branch_id`),
  CONSTRAINT `FK_6A2F2F95727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `invoices` (`id`),
  CONSTRAINT `FK_6A2F2F957D182D95` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_6A2F2F959395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `cusmoters` (`id`),
  CONSTRAINT `FK_6A2F2F95DCD6CC49` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES ('20210706020443699918-10-1',10,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',880,862.4,991.76,2,'PERCENTAGE',15,129.36,'2021-07-06 14:04:43','2021-07-10 12:00:16'),('20210706020552725321-10-1',10,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',880,862.4,991.76,2,'PERCENTAGE',15,129.36,'2021-07-06 14:05:52','2021-07-10 12:00:16'),('20210706020602933312-10-1',10,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',880,862.4,991.76,2,'PERCENTAGE',15,129.36,'2021-07-06 14:06:02','2021-07-10 12:00:16'),('20210706020607418664-10-1',10,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',880,862.4,991.76,2,'PERCENTAGE',15,129.36,'2021-07-06 14:06:07','2021-07-10 12:00:16'),('20210706020949028176-10-1',10,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',880,863,863,2,'PERCENTAGE',15,0,'2021-07-06 14:09:49','2021-07-10 12:00:16'),('20210706021156347848-10-1',10,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',880,863,992,2,'PERCENTAGE',15,129,'2021-07-06 14:11:56','2021-07-10 12:00:16'),('20210706021328158847-10-1',10,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',880,862,992,2,'PERCENTAGE',15,130,'2021-07-06 14:13:28','2021-07-10 12:00:16'),('20210706021357205807-10-1',10,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',880,863,993,2,'PERCENTAGE',15,130,'2021-07-06 14:13:57','2021-07-10 12:00:16'),('20210706070832585928-2-1',2,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',700,690,794,10,'FIXED',15,104,'2021-07-06 19:08:32','2021-07-10 12:00:16'),('20210706071217371401-2-1',2,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',1600,1590,1829,10,'FIXED',15,239,'2021-07-06 19:12:17','2021-07-10 12:00:16'),('20210706071234660439-2-1',2,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',2300,2290,2634,10,'FIXED',15,344,'2021-07-06 19:12:34','2021-07-10 12:00:16'),('20210706071258810596-2-1',2,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',2300,2070,2381,10,'PERCENTAGE',15,311,'2021-07-06 19:12:58','2021-07-10 12:00:16'),('20210706071553922267-2-1',2,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',700,690,794,10,'FIXED',15,104,'2021-07-06 19:15:53','2021-07-10 12:00:16'),('20210706073612390763-2-1',2,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',1400,1390,1599,10,'FIXED',15,209,'2021-07-06 19:36:12','2021-07-10 12:00:16'),('20210706073633672576-2-1',2,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',700,690,794,10,'FIXED',15,104,'2021-07-06 19:36:33','2021-07-10 12:00:16'),('20210706074452452334-2-1',2,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',2700,2403,2764,11,'PERCENTAGE',15,361,'2021-07-06 19:44:52','2021-07-10 12:00:16'),('20210706075130729682-2-1',2,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',900,801,922,11,'PERCENTAGE',15,121,'2021-07-06 19:51:30','2021-07-10 12:00:16'),('20210708032329338109-2-1',2,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',999,999,999,0,'FIXED',0,0,'2021-07-08 15:23:29','2021-07-10 12:00:16'),('20210708115636279827-4-3',4,NULL,NULL,2,'SALES','SALES','POS','RECEIVED','COMPLETE',400,400,400,0,'FIXED',0,0,'2021-07-08 11:56:36','2021-07-10 12:00:16'),('20210708122845319181-2-1',2,NULL,NULL,1,'SALES','SALES','POS','RECEIVED','COMPLETE',999,976,976,23,'FIXED',0,0,'2021-07-08 12:28:45','2021-07-10 12:00:16'),('20210708124319317857-1-2',1,NULL,NULL,2,'SALES','SALES','POS','RECEIVED','COMPLETE',880,863,993,2,'PERCENTAGE',15,130,'2021-07-08 12:43:19','2021-07-10 12:00:16'),('49JUQ314E90KK-1-2',1,NULL,NULL,2,'SALES','SALES','POS','RECEIVED','COMPLETE',5600,5488,6312,2,'PERCENTAGE',15,824,'2021-07-08 20:33:20','2021-07-10 12:00:16'),('49JUQ314KYGW8-1-2',1,NULL,NULL,2,'SALES','SALES','POS','RECEIVED','COMPLETE',4800,4704,5410,2,'PERCENTAGE',15,706,'2021-07-08 20:33:32','2021-07-10 12:00:16'),('49JUQT19RDGK4-1-2',1,NULL,NULL,2,'SALES','SALES','POS','RECEIVED','COMPLETE',800,784,902,2,'PERCENTAGE',15,118,'2021-07-10 12:11:13','2021-07-10');
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_attribute_values`
--

DROP TABLE IF EXISTS `item_attribute_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_attribute_values` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attribute_id` int(11) DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `extra` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`attribute_id`,`value`),
  KEY `IDX_202461A3B6E62EFA` (`attribute_id`),
  CONSTRAINT `FK_202461A3B6E62EFA` FOREIGN KEY (`attribute_id`) REFERENCES `item_attributes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_attribute_values`
--

LOCK TABLES `item_attribute_values` WRITE;
/*!40000 ALTER TABLE `item_attribute_values` DISABLE KEYS */;
INSERT INTO `item_attribute_values` VALUES (2,2,'Red',''),(3,2,'Blue',''),(4,2,'Black',''),(5,3,'Small',''),(6,3,'L',''),(7,3,'XL',''),(8,3,'XXL',''),(9,3,'M',''),(10,1,'text-value-6','');
/*!40000 ALTER TABLE `item_attribute_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_attributes`
--

DROP TABLE IF EXISTS `item_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `item_attributes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lapse` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_attributes`
--

LOCK TABLES `item_attributes` WRITE;
/*!40000 ALTER TABLE `item_attributes` DISABLE KEYS */;
INSERT INTO `item_attributes` VALUES (1,'test-attribute-2',0),(2,'Color',1),(3,'Size',1),(5,'test-attribute-3',0);
/*!40000 ALTER TABLE `item_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lookup_itemattribute`
--

DROP TABLE IF EXISTS `lookup_itemattribute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lookup_itemattribute` (
  `lookup_id` int(11) NOT NULL,
  `itemattribute_id` int(11) NOT NULL,
  PRIMARY KEY (`lookup_id`,`itemattribute_id`),
  KEY `IDX_69109ABF8955C49D` (`lookup_id`),
  KEY `IDX_69109ABF833C432` (`itemattribute_id`),
  CONSTRAINT `FK_69109ABF833C432` FOREIGN KEY (`itemattribute_id`) REFERENCES `item_attributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_69109ABF8955C49D` FOREIGN KEY (`lookup_id`) REFERENCES `lookups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lookup_itemattribute`
--

LOCK TABLES `lookup_itemattribute` WRITE;
/*!40000 ALTER TABLE `lookup_itemattribute` DISABLE KEYS */;
/*!40000 ALTER TABLE `lookup_itemattribute` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lookups`
--

DROP TABLE IF EXISTS `lookups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lookups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image_url` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `count` int(11) NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`type`,`name`,`parent_id`),
  KEY `IDX_6B942735727ACA70` (`parent_id`),
  CONSTRAINT `FK_6B942735727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `lookups` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lookups`
--

LOCK TABLES `lookups` WRITE;
/*!40000 ALTER TABLE `lookups` DISABLE KEYS */;
INSERT INTO `lookups` VALUES (1,NULL,'category','test-sub-child-category','',0,'ACTIVE'),(2,NULL,'category','test-sub-child-category-2','',0,'INACTIVE'),(3,NULL,'category','test-sub-child-category-1','',0,'ACTIVE'),(4,NULL,'category','test-sub-child-category-2','',0,'ACTIVE'),(5,NULL,'category','test-sub-child-category-3','',0,'ACTIVE');
/*!40000 ALTER TABLE `lookups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfg_order_items`
--

DROP TABLE IF EXISTS `mfg_order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfg_order_items` (
  `seq` int(11) NOT NULL,
  `set_id` int(11) NOT NULL,
  `sku_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quantity` double NOT NULL,
  PRIMARY KEY (`set_id`,`seq`),
  KEY `IDX_2994C5B010FB0D18` (`set_id`),
  KEY `IDX_2994C5B079B17AE9` (`sku_code`),
  CONSTRAINT `FK_2994C5B010FB0D18` FOREIGN KEY (`set_id`) REFERENCES `mfg_order_sets` (`id`),
  CONSTRAINT `FK_2994C5B079B17AE9` FOREIGN KEY (`sku_code`) REFERENCES `skus` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfg_order_items`
--

LOCK TABLES `mfg_order_items` WRITE;
/*!40000 ALTER TABLE `mfg_order_items` DISABLE KEYS */;
INSERT INTO `mfg_order_items` VALUES (0,1,'10-APT032-3-5',1),(0,2,'10-APT032-3-5',2),(0,4,'1-RBX098-3-5',5),(0,5,'1-RBX098-3-5',7),(0,6,'1-RBX098-3-5',7),(0,8,'1-RBX098-3-5',7),(0,10,'1-RBX098-3-5',7),(0,11,'1-RBX098-3-5',22),(1,11,'7-RBX0012-4-5',33),(0,12,'1-RBX098-3-5',11),(1,12,'7-RBX0012-4-5',22),(0,14,'9-TT002-4-6',9);
/*!40000 ALTER TABLE `mfg_order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfg_order_sets`
--

DROP TABLE IF EXISTS `mfg_order_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfg_order_sets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfg_order_sets`
--

LOCK TABLES `mfg_order_sets` WRITE;
/*!40000 ALTER TABLE `mfg_order_sets` DISABLE KEYS */;
INSERT INTO `mfg_order_sets` VALUES (1,'test-mfg-set','2021-07-06 11:24:21'),(2,'test-mfg-set-1','2021-07-06 13:06:09'),(4,'test-mfg-set-2','2021-07-07 07:44:20'),(5,'test-mfg-set-3','2021-07-07 07:50:17'),(6,'test-mfg-set-5','2021-07-07 07:51:52'),(8,'test-mfg-set-6','2021-07-07 13:54:27'),(10,'test-mfg-set-7','2021-07-07 13:58:14'),(11,'MFG-001','2021-07-07 13:59:10'),(12,'MFG-002','2021-07-07 14:00:25'),(14,'set-1','2021-07-08 14:49:26');
/*!40000 ALTER TABLE `mfg_order_sets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfg_order_state`
--

DROP TABLE IF EXISTS `mfg_order_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfg_order_state` (
  `seq` int(11) NOT NULL,
  `mfg_order_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `performed_by_user_id` int(11) DEFAULT NULL,
  `state_name` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`mfg_order_id`,`seq`),
  KEY `IDX_6B19FE06324D40D` (`mfg_order_id`),
  KEY `IDX_6B19FE0643F2ED96` (`performed_by_user_id`),
  CONSTRAINT `FK_6B19FE06324D40D` FOREIGN KEY (`mfg_order_id`) REFERENCES `mfg_orders` (`id`),
  CONSTRAINT `FK_6B19FE0643F2ED96` FOREIGN KEY (`performed_by_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfg_order_state`
--

LOCK TABLES `mfg_order_state` WRITE;
/*!40000 ALTER TABLE `mfg_order_state` DISABLE KEYS */;
/*!40000 ALTER TABLE `mfg_order_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfg_order_states`
--

DROP TABLE IF EXISTS `mfg_order_states`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfg_order_states` (
  `state_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mfg_order_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `performed_by_user_id` int(11) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`mfg_order_id`,`state_name`),
  KEY `IDX_F20673C0324D40D` (`mfg_order_id`),
  KEY `IDX_F20673C043F2ED96` (`performed_by_user_id`),
  CONSTRAINT `FK_F20673C0324D40D` FOREIGN KEY (`mfg_order_id`) REFERENCES `mfg_orders` (`id`),
  CONSTRAINT `FK_F20673C043F2ED96` FOREIGN KEY (`performed_by_user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfg_order_states`
--

LOCK TABLES `mfg_order_states` WRITE;
/*!40000 ALTER TABLE `mfg_order_states` DISABLE KEYS */;
INSERT INTO `mfg_order_states` VALUES ('COMPLETE','ORD-20210707013705111275-1-2',10,'2021-07-07 07:39:08'),('PLACED','ORD-20210707013705111275-1-2',1,'2021-07-07 13:37:05'),('COMPLETE','ORD-20210707014433008285-1-2',10,'2021-07-07 07:45:46'),('PLACED','ORD-20210707014433008285-1-2',1,'2021-07-07 13:44:33'),('COMPLETE','ORD-20210707015024660511-1-2',1,'2021-07-07 07:51:23'),('PLACED','ORD-20210707015024660511-1-2',1,'2021-07-07 13:50:24'),('COMPLETE','ORD-20210707015157712610-1-2',1,'2021-07-07 07:52:08'),('PLACED','ORD-20210707015157712610-1-2',1,'2021-07-07 13:51:57'),('COMPLETE','ORD-49JUQ31WO02SW-1-2',1,'2021-07-10 11:48:07'),('PLACED','ORD-49JUQ31WO02SW-1-2',1,'2021-07-08 20:50:30'),('COMPLETE','ORD-49JUQ326PXGK8-1-1',14,'2021-07-08 14:57:38'),('PLACED','ORD-49JUQ326PXGK8-1-1',1,'2021-07-08 20:56:38'),('COMPLETE','ORD-49JUQS201JK0C-1-6',1,'2021-07-10 11:40:46'),('PLACED','ORD-49JUQS201JK0C-1-6',1,'2021-07-10 16:43:38'),('COMPLETE','ORD-49JUQS26OE4G8-1-6',1,'2021-07-10 11:28:40'),('PLACED','ORD-49JUQS26OE4G8-1-6',1,'2021-07-10 16:47:39');
/*!40000 ALTER TABLE `mfg_order_states` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mfg_orders`
--

DROP TABLE IF EXISTS `mfg_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mfg_orders` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `set_id` int(11) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  `current_state` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_code` (`id`),
  KEY `IDX_B3B4732910FB0D18` (`set_id`),
  KEY `IDX_B3B47329DCD6CC49` (`branch_id`),
  CONSTRAINT `FK_B3B4732910FB0D18` FOREIGN KEY (`set_id`) REFERENCES `mfg_order_sets` (`id`),
  CONSTRAINT `FK_B3B47329DCD6CC49` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfg_orders`
--

LOCK TABLES `mfg_orders` WRITE;
/*!40000 ALTER TABLE `mfg_orders` DISABLE KEYS */;
INSERT INTO `mfg_orders` VALUES ('ORD-20210707013705111275-1-2',2,2,'COMPLETE','2021-07-07 13:37:05'),('ORD-20210707014433008285-1-2',4,2,'COMPLETE','2021-07-07 13:44:33'),('ORD-20210707015024660511-1-2',5,2,'COMPLETE','2021-07-07 13:50:24'),('ORD-20210707015157712610-1-2',6,2,'COMPLETE','2021-07-07 13:51:57'),('ORD-49JUQ31WO02SW-1-2',1,2,'COMPLETE','2021-07-08 20:50:30'),('ORD-49JUQ326PXGK8-1-1',1,1,'COMPLETE','2021-07-08 20:56:38'),('ORD-49JUQS201JK0C-1-6',10,6,'COMPLETE','2021-07-10 16:43:38'),('ORD-49JUQS26OE4G8-1-6',10,6,'COMPLETE','2021-07-10 16:47:39');
/*!40000 ALTER TABLE `mfg_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ottoman_files`
--

DROP TABLE IF EXISTS `ottoman_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ottoman_files` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `extension` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sort_order` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`id`,`sort_order`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ottoman_files`
--

LOCK TABLES `ottoman_files` WRITE;
/*!40000 ALTER TABLE `ottoman_files` DISABLE KEYS */;
INSERT INTO `ottoman_files` VALUES ('14466bb2c6e912e3b7867907b15fc19508d1576e8a12d716521d7fe2dc0f2e5014802785df0c7c209d38bc983b1ef339381201fa697dde4898f0aa86c4a52134.jpeg','IMAGE','jpeg','1.jpeg',1,'2021-07-04 11:40:58'),('170c79813f96933cc9e88eb3ea21a273156b821a7b98c1f0bcc6af65d8f1c244423d597a6956ee381b4ae8d26f03f5f076f29f949959107edac12bf683aa4801.jpg','IMAGE','jpg','Blue_Tshirt.jpg',3,'2021-07-04 11:07:16'),('1d8e3028f26e6e30d9f06b15b42c413ab34162cd047d38ef8cf95c9e1d9dee64b64e9afab8394ee72de3cc63dfddb9d149e97ca93bdc6482db365db5d05ab1d8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:40:58'),('2e007f7f14358aa76ecdec5de9e07fb1c2dbef38d14a55ab3b029a5470f20a52669dd59670218966ab9324e8ed2565cede59422f38377ecda2a7134f6b080423.jpg','IMAGE','jpg','5.jpg',6,'2021-07-04 11:07:16'),('41789ffeb891c3619631a483442d6e602a3224e7d3c498c26dae4be22410e4f7a7db2035457bc645ef2d1ad1116d2d9a1d75c79295446b7d7445b15e7056f866.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:02:54'),('46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg','IMAGE','jpg','5.jpg',2,'2021-07-06 06:32:54'),('470d63d248fb0f71a27d9bf7a35f5fa3fcef895293c98c113713e70dca953a67f0e8a79ca2fb371a81eb2c2ff556fbfafb16fa22ba07ae2c072bb8037b86ff4d.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:41:06'),('4bc99b3a560d3abf6c6e340b32339b23f81aed01805b2144a8e768e7d8e833efc452d3e71ad4b09f59efb7cf25132f568cdde653b6593be45280cbe78c2ee017.jpeg','IMAGE','jpeg','1.jpeg',1,'2021-07-04 11:41:06'),('5bb0453a6b879989f62189d7eaeecd0a42a249a5207827de97aabb33258248b74129ef535ad8ce4ad1465193253ed7e0847ff41fa36dc13db4e81517a9f76853.jpg','IMAGE','jpg','2.jpg',1,'2021-07-04 10:02:54'),('5e888574908c6098b771c7f124116a73bc5de819fb7f3f8b1e9164cbb82d95ed763dd7a0d789b75516447f880a60d0901953615fee359da525ac1a2d490dee75.jpg','IMAGE','jpg','catalog_detail_image_medium.jpg',4,'2021-07-04 11:07:16'),('61c40fc176abea587163b1410e9228272652319913693df8612b9060c92013f880f97a5345b367661dcb9944bc44744efecac05f1cecd488610aa6690c54d552.png','IMAGE','png','2.png',3,'2021-07-04 09:38:52'),('687b8cec426c5784f24a7d9edda4ed4cbd58008be58badbd0e9c006f0121996e2b55c83f65995308b1237d7ddaebc4c96b9a2cce6c3af0684e53de6ba6803527.jpg','IMAGE','jpg','Arbo-1.jpg',5,'2021-07-05 08:19:09'),('79f14453a3fbb76683190283ed37a463c41bf8ea0b6a5c96c2157a8121a21dc16df79e9ca9cb8a8cf58c79b1d1fddc455f07f93715dae4e9133d6ec07d2f92d0.jpeg','IMAGE','jpeg','Ami Banglay Gaan gai.jpeg',4,'2021-07-05 08:18:52'),('7ee0bbf4b823e8ffcd0242327e0e7a19963f6e3d70718a70f4104eb5e9605ccbb024458602220c39959c90f9cf623200ac95462af8b23fa40cd545ae0aa28657.jpg','IMAGE','jpg','Alter Bridge 03.jpg',3,'2021-07-05 08:18:20'),('80548fefb941974ff1c68ecedf14f6ff1f68aad778a1fa921e1037e4ea9f236a1d53e972cabfa113b685ecd4a6503e747c50d4e5b0ab87adef3f47b931b703a1.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 09:25:05'),('8091f0508ead0582d4cd25e9b5e3059087edc27db338421e655f8d21913fc7abccec43279e480687774b4ad83910ecf37b56df2d3cbb41ae7b6277af7ad0d2e4.jpg','IMAGE','jpg','Abbath Tem.jpg',3,'2021-07-05 08:12:23'),('850ae88092df215d5138a38d64d8279ef8d590ffd271113dfa94a8c0e058bef6ef3dc5fd7a01a83d02a6008f133aeb191cdb6c60998ca36cf2bc38e032c62703.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:07:16'),('90a3996110d234c822acc67a5e370d4dc94076a92f6889e7c926571b306bb0a36f43e030c0647d920bbc792b1126cfd3daf12b3ecd79a65abc86cbfd6dfef68d.jpg','IMAGE','jpg','0.jpg',5,'2021-07-04 11:07:16'),('93fb3297317ff02cb6dddcbb77ecaceac2b1064ef4c5bce540eeec452188ccd8322b5baa10704ce245572400f520a2a56f9d5230a4b0e3c63e077fd887b87ef8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:06:01'),('bc31eff649a7b718b5eb412a7a1f9b27ab8cf88966be3397ee74deccda0531e27fc4bd6710a2d4af0b6ae9b51ea3a8227d0adbc8f7ec791bbc01b1e46f044c25.jpg','IMAGE','jpg','Ac dc 04.jpg',3,'2021-07-05 08:14:47'),('da7796ca0bd6d9dfaa24f8ab1887bda94306c50905139cc6eb5bfc278f8f611d2b5755ae5e1d2200e8fd93147283a30c47dd9d867abb9282baf5adc4fed73ef7.jpg','IMAGE','jpg','0.jpg',0,'2021-07-06 06:32:54'),('dd8c2c9f1014e5b0d64467bf17ac49090753f64cfda8ae8a3631cea808db35ccb27af741938b3d566d3120bb2623609e14e2577569b15d3dd648302a8b0c7e90.jpg','IMAGE','jpg','2.jpg',0,'2021-07-04 10:10:19'),('e277a5aa69de84a48b9691c0095808fcda8eb99f14be069fac1d566658b587cc7d1c4e5494af04902f1afd489a15957d5dd5c30f31ebc94cbc081fb63fdf4587.jpg','IMAGE','jpg','Grey_Tshirt.jpg',2,'2021-07-04 11:07:16'),('e509510798832879c55fd3058a997f6e3817cf05ef743311d78c541d4db459e00d1e59107565fad82d029cde004ca48f454abea809d76c7048ce1ad52f663b2d.jpg','IMAGE','jpg','5.jpg',1,'2021-07-04 09:25:05'),('ec185820964ad83c0554b55f1936c856699070be228c6bd32019634f5326a588a98ca0d6b6c72102057e86ff5b75793164cfc7d3aa86a14b971d235fb0d304fc.jpg','IMAGE','jpg','2.jpg',1,'2021-07-06 06:32:54'),('gallery-thumb-14466bb2c6e912e3b7867907b15fc19508d1576e8a12d716521d7fe2dc0f2e5014802785df0c7c209d38bc983b1ef339381201fa697dde4898f0aa86c4a52134.jpg','IMAGE','jpg','1.jpeg',1,'2021-07-04 11:40:59'),('gallery-thumb-170c79813f96933cc9e88eb3ea21a273156b821a7b98c1f0bcc6af65d8f1c244423d597a6956ee381b4ae8d26f03f5f076f29f949959107edac12bf683aa4801.jpg','IMAGE','jpg','Blue_Tshirt.jpg',3,'2021-07-04 11:07:16'),('gallery-thumb-1d8e3028f26e6e30d9f06b15b42c413ab34162cd047d38ef8cf95c9e1d9dee64b64e9afab8394ee72de3cc63dfddb9d149e97ca93bdc6482db365db5d05ab1d8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:40:59'),('gallery-thumb-2e007f7f14358aa76ecdec5de9e07fb1c2dbef38d14a55ab3b029a5470f20a52669dd59670218966ab9324e8ed2565cede59422f38377ecda2a7134f6b080423.jpg','IMAGE','jpg','5.jpg',6,'2021-07-04 11:07:16'),('gallery-thumb-41789ffeb891c3619631a483442d6e602a3224e7d3c498c26dae4be22410e4f7a7db2035457bc645ef2d1ad1116d2d9a1d75c79295446b7d7445b15e7056f866.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:02:54'),('gallery-thumb-46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg','IMAGE','jpg','5.jpg',2,'2021-07-06 06:32:55'),('gallery-thumb-470d63d248fb0f71a27d9bf7a35f5fa3fcef895293c98c113713e70dca953a67f0e8a79ca2fb371a81eb2c2ff556fbfafb16fa22ba07ae2c072bb8037b86ff4d.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:41:06'),('gallery-thumb-4bc99b3a560d3abf6c6e340b32339b23f81aed01805b2144a8e768e7d8e833efc452d3e71ad4b09f59efb7cf25132f568cdde653b6593be45280cbe78c2ee017.jpg','IMAGE','jpg','1.jpeg',1,'2021-07-04 11:41:06'),('gallery-thumb-5bb0453a6b879989f62189d7eaeecd0a42a249a5207827de97aabb33258248b74129ef535ad8ce4ad1465193253ed7e0847ff41fa36dc13db4e81517a9f76853.jpg','IMAGE','jpg','2.jpg',1,'2021-07-04 10:02:54'),('gallery-thumb-5e888574908c6098b771c7f124116a73bc5de819fb7f3f8b1e9164cbb82d95ed763dd7a0d789b75516447f880a60d0901953615fee359da525ac1a2d490dee75.jpg','IMAGE','jpg','catalog_detail_image_medium.jpg',4,'2021-07-04 11:07:16'),('gallery-thumb-61c40fc176abea587163b1410e9228272652319913693df8612b9060c92013f880f97a5345b367661dcb9944bc44744efecac05f1cecd488610aa6690c54d552.jpg','IMAGE','jpg','2.png',3,'2021-07-04 09:38:52'),('gallery-thumb-687b8cec426c5784f24a7d9edda4ed4cbd58008be58badbd0e9c006f0121996e2b55c83f65995308b1237d7ddaebc4c96b9a2cce6c3af0684e53de6ba6803527.jpg','IMAGE','jpg','Arbo-1.jpg',5,'2021-07-05 08:19:09'),('gallery-thumb-79f14453a3fbb76683190283ed37a463c41bf8ea0b6a5c96c2157a8121a21dc16df79e9ca9cb8a8cf58c79b1d1fddc455f07f93715dae4e9133d6ec07d2f92d0.jpg','IMAGE','jpg','Ami Banglay Gaan gai.jpeg',4,'2021-07-05 08:18:53'),('gallery-thumb-7ee0bbf4b823e8ffcd0242327e0e7a19963f6e3d70718a70f4104eb5e9605ccbb024458602220c39959c90f9cf623200ac95462af8b23fa40cd545ae0aa28657.jpg','IMAGE','jpg','Alter Bridge 03.jpg',3,'2021-07-05 08:18:20'),('gallery-thumb-80548fefb941974ff1c68ecedf14f6ff1f68aad778a1fa921e1037e4ea9f236a1d53e972cabfa113b685ecd4a6503e747c50d4e5b0ab87adef3f47b931b703a1.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 09:25:05'),('gallery-thumb-8091f0508ead0582d4cd25e9b5e3059087edc27db338421e655f8d21913fc7abccec43279e480687774b4ad83910ecf37b56df2d3cbb41ae7b6277af7ad0d2e4.jpg','IMAGE','jpg','Abbath Tem.jpg',3,'2021-07-05 08:12:24'),('gallery-thumb-850ae88092df215d5138a38d64d8279ef8d590ffd271113dfa94a8c0e058bef6ef3dc5fd7a01a83d02a6008f133aeb191cdb6c60998ca36cf2bc38e032c62703.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:07:16'),('gallery-thumb-90a3996110d234c822acc67a5e370d4dc94076a92f6889e7c926571b306bb0a36f43e030c0647d920bbc792b1126cfd3daf12b3ecd79a65abc86cbfd6dfef68d.jpg','IMAGE','jpg','0.jpg',5,'2021-07-04 11:07:16'),('gallery-thumb-93fb3297317ff02cb6dddcbb77ecaceac2b1064ef4c5bce540eeec452188ccd8322b5baa10704ce245572400f520a2a56f9d5230a4b0e3c63e077fd887b87ef8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:06:01'),('gallery-thumb-bc31eff649a7b718b5eb412a7a1f9b27ab8cf88966be3397ee74deccda0531e27fc4bd6710a2d4af0b6ae9b51ea3a8227d0adbc8f7ec791bbc01b1e46f044c25.jpg','IMAGE','jpg','Ac dc 04.jpg',3,'2021-07-05 08:14:47'),('gallery-thumb-da7796ca0bd6d9dfaa24f8ab1887bda94306c50905139cc6eb5bfc278f8f611d2b5755ae5e1d2200e8fd93147283a30c47dd9d867abb9282baf5adc4fed73ef7.jpg','IMAGE','jpg','0.jpg',0,'2021-07-06 06:32:55'),('gallery-thumb-dd8c2c9f1014e5b0d64467bf17ac49090753f64cfda8ae8a3631cea808db35ccb27af741938b3d566d3120bb2623609e14e2577569b15d3dd648302a8b0c7e90.jpg','IMAGE','jpg','2.jpg',0,'2021-07-04 10:10:19'),('gallery-thumb-e277a5aa69de84a48b9691c0095808fcda8eb99f14be069fac1d566658b587cc7d1c4e5494af04902f1afd489a15957d5dd5c30f31ebc94cbc081fb63fdf4587.jpg','IMAGE','jpg','Grey_Tshirt.jpg',2,'2021-07-04 11:07:16'),('gallery-thumb-e509510798832879c55fd3058a997f6e3817cf05ef743311d78c541d4db459e00d1e59107565fad82d029cde004ca48f454abea809d76c7048ce1ad52f663b2d.jpg','IMAGE','jpg','5.jpg',1,'2021-07-04 09:25:05'),('gallery-thumb-ec185820964ad83c0554b55f1936c856699070be228c6bd32019634f5326a588a98ca0d6b6c72102057e86ff5b75793164cfc7d3aa86a14b971d235fb0d304fc.jpg','IMAGE','jpg','2.jpg',1,'2021-07-06 06:32:55'),('list-thumb-14466bb2c6e912e3b7867907b15fc19508d1576e8a12d716521d7fe2dc0f2e5014802785df0c7c209d38bc983b1ef339381201fa697dde4898f0aa86c4a52134.jpg','IMAGE','jpg','1.jpeg',1,'2021-07-04 11:40:59'),('list-thumb-170c79813f96933cc9e88eb3ea21a273156b821a7b98c1f0bcc6af65d8f1c244423d597a6956ee381b4ae8d26f03f5f076f29f949959107edac12bf683aa4801.jpg','IMAGE','jpg','Blue_Tshirt.jpg',3,'2021-07-04 11:07:16'),('list-thumb-1d8e3028f26e6e30d9f06b15b42c413ab34162cd047d38ef8cf95c9e1d9dee64b64e9afab8394ee72de3cc63dfddb9d149e97ca93bdc6482db365db5d05ab1d8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:40:59'),('list-thumb-2e007f7f14358aa76ecdec5de9e07fb1c2dbef38d14a55ab3b029a5470f20a52669dd59670218966ab9324e8ed2565cede59422f38377ecda2a7134f6b080423.jpg','IMAGE','jpg','5.jpg',6,'2021-07-04 11:07:16'),('list-thumb-41789ffeb891c3619631a483442d6e602a3224e7d3c498c26dae4be22410e4f7a7db2035457bc645ef2d1ad1116d2d9a1d75c79295446b7d7445b15e7056f866.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:02:54'),('list-thumb-46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg','IMAGE','jpg','5.jpg',2,'2021-07-06 06:32:55'),('list-thumb-470d63d248fb0f71a27d9bf7a35f5fa3fcef895293c98c113713e70dca953a67f0e8a79ca2fb371a81eb2c2ff556fbfafb16fa22ba07ae2c072bb8037b86ff4d.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:41:06'),('list-thumb-4bc99b3a560d3abf6c6e340b32339b23f81aed01805b2144a8e768e7d8e833efc452d3e71ad4b09f59efb7cf25132f568cdde653b6593be45280cbe78c2ee017.jpg','IMAGE','jpg','1.jpeg',1,'2021-07-04 11:41:06'),('list-thumb-5bb0453a6b879989f62189d7eaeecd0a42a249a5207827de97aabb33258248b74129ef535ad8ce4ad1465193253ed7e0847ff41fa36dc13db4e81517a9f76853.jpg','IMAGE','jpg','2.jpg',1,'2021-07-04 10:02:54'),('list-thumb-5e888574908c6098b771c7f124116a73bc5de819fb7f3f8b1e9164cbb82d95ed763dd7a0d789b75516447f880a60d0901953615fee359da525ac1a2d490dee75.jpg','IMAGE','jpg','catalog_detail_image_medium.jpg',4,'2021-07-04 11:07:16'),('list-thumb-61c40fc176abea587163b1410e9228272652319913693df8612b9060c92013f880f97a5345b367661dcb9944bc44744efecac05f1cecd488610aa6690c54d552.jpg','IMAGE','jpg','2.png',3,'2021-07-04 09:38:52'),('list-thumb-687b8cec426c5784f24a7d9edda4ed4cbd58008be58badbd0e9c006f0121996e2b55c83f65995308b1237d7ddaebc4c96b9a2cce6c3af0684e53de6ba6803527.jpg','IMAGE','jpg','Arbo-1.jpg',5,'2021-07-05 08:19:09'),('list-thumb-79f14453a3fbb76683190283ed37a463c41bf8ea0b6a5c96c2157a8121a21dc16df79e9ca9cb8a8cf58c79b1d1fddc455f07f93715dae4e9133d6ec07d2f92d0.jpg','IMAGE','jpg','Ami Banglay Gaan gai.jpeg',4,'2021-07-05 08:18:53'),('list-thumb-7ee0bbf4b823e8ffcd0242327e0e7a19963f6e3d70718a70f4104eb5e9605ccbb024458602220c39959c90f9cf623200ac95462af8b23fa40cd545ae0aa28657.jpg','IMAGE','jpg','Alter Bridge 03.jpg',3,'2021-07-05 08:18:20'),('list-thumb-80548fefb941974ff1c68ecedf14f6ff1f68aad778a1fa921e1037e4ea9f236a1d53e972cabfa113b685ecd4a6503e747c50d4e5b0ab87adef3f47b931b703a1.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 09:25:05'),('list-thumb-8091f0508ead0582d4cd25e9b5e3059087edc27db338421e655f8d21913fc7abccec43279e480687774b4ad83910ecf37b56df2d3cbb41ae7b6277af7ad0d2e4.jpg','IMAGE','jpg','Abbath Tem.jpg',3,'2021-07-05 08:12:24'),('list-thumb-850ae88092df215d5138a38d64d8279ef8d590ffd271113dfa94a8c0e058bef6ef3dc5fd7a01a83d02a6008f133aeb191cdb6c60998ca36cf2bc38e032c62703.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:07:16'),('list-thumb-90a3996110d234c822acc67a5e370d4dc94076a92f6889e7c926571b306bb0a36f43e030c0647d920bbc792b1126cfd3daf12b3ecd79a65abc86cbfd6dfef68d.jpg','IMAGE','jpg','0.jpg',5,'2021-07-04 11:07:16'),('list-thumb-93fb3297317ff02cb6dddcbb77ecaceac2b1064ef4c5bce540eeec452188ccd8322b5baa10704ce245572400f520a2a56f9d5230a4b0e3c63e077fd887b87ef8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:06:01'),('list-thumb-bc31eff649a7b718b5eb412a7a1f9b27ab8cf88966be3397ee74deccda0531e27fc4bd6710a2d4af0b6ae9b51ea3a8227d0adbc8f7ec791bbc01b1e46f044c25.jpg','IMAGE','jpg','Ac dc 04.jpg',3,'2021-07-05 08:14:47'),('list-thumb-da7796ca0bd6d9dfaa24f8ab1887bda94306c50905139cc6eb5bfc278f8f611d2b5755ae5e1d2200e8fd93147283a30c47dd9d867abb9282baf5adc4fed73ef7.jpg','IMAGE','jpg','0.jpg',0,'2021-07-06 06:32:55'),('list-thumb-dd8c2c9f1014e5b0d64467bf17ac49090753f64cfda8ae8a3631cea808db35ccb27af741938b3d566d3120bb2623609e14e2577569b15d3dd648302a8b0c7e90.jpg','IMAGE','jpg','2.jpg',0,'2021-07-04 10:10:19'),('list-thumb-e277a5aa69de84a48b9691c0095808fcda8eb99f14be069fac1d566658b587cc7d1c4e5494af04902f1afd489a15957d5dd5c30f31ebc94cbc081fb63fdf4587.jpg','IMAGE','jpg','Grey_Tshirt.jpg',2,'2021-07-04 11:07:16'),('list-thumb-e509510798832879c55fd3058a997f6e3817cf05ef743311d78c541d4db459e00d1e59107565fad82d029cde004ca48f454abea809d76c7048ce1ad52f663b2d.jpg','IMAGE','jpg','5.jpg',1,'2021-07-04 09:25:05'),('list-thumb-ec185820964ad83c0554b55f1936c856699070be228c6bd32019634f5326a588a98ca0d6b6c72102057e86ff5b75793164cfc7d3aa86a14b971d235fb0d304fc.jpg','IMAGE','jpg','2.jpg',1,'2021-07-06 06:32:55'),('main-thumb-14466bb2c6e912e3b7867907b15fc19508d1576e8a12d716521d7fe2dc0f2e5014802785df0c7c209d38bc983b1ef339381201fa697dde4898f0aa86c4a52134.jpg','IMAGE','jpg','1.jpeg',1,'2021-07-04 11:40:58'),('main-thumb-170c79813f96933cc9e88eb3ea21a273156b821a7b98c1f0bcc6af65d8f1c244423d597a6956ee381b4ae8d26f03f5f076f29f949959107edac12bf683aa4801.jpg','IMAGE','jpg','Blue_Tshirt.jpg',3,'2021-07-04 11:07:16'),('main-thumb-1d8e3028f26e6e30d9f06b15b42c413ab34162cd047d38ef8cf95c9e1d9dee64b64e9afab8394ee72de3cc63dfddb9d149e97ca93bdc6482db365db5d05ab1d8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:40:58'),('main-thumb-2e007f7f14358aa76ecdec5de9e07fb1c2dbef38d14a55ab3b029a5470f20a52669dd59670218966ab9324e8ed2565cede59422f38377ecda2a7134f6b080423.jpg','IMAGE','jpg','5.jpg',6,'2021-07-04 11:07:16'),('main-thumb-41789ffeb891c3619631a483442d6e602a3224e7d3c498c26dae4be22410e4f7a7db2035457bc645ef2d1ad1116d2d9a1d75c79295446b7d7445b15e7056f866.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:02:54'),('main-thumb-46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg','IMAGE','jpg','5.jpg',2,'2021-07-06 06:32:55'),('main-thumb-470d63d248fb0f71a27d9bf7a35f5fa3fcef895293c98c113713e70dca953a67f0e8a79ca2fb371a81eb2c2ff556fbfafb16fa22ba07ae2c072bb8037b86ff4d.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:41:06'),('main-thumb-4bc99b3a560d3abf6c6e340b32339b23f81aed01805b2144a8e768e7d8e833efc452d3e71ad4b09f59efb7cf25132f568cdde653b6593be45280cbe78c2ee017.jpg','IMAGE','jpg','1.jpeg',1,'2021-07-04 11:41:06'),('main-thumb-5bb0453a6b879989f62189d7eaeecd0a42a249a5207827de97aabb33258248b74129ef535ad8ce4ad1465193253ed7e0847ff41fa36dc13db4e81517a9f76853.jpg','IMAGE','jpg','2.jpg',1,'2021-07-04 10:02:54'),('main-thumb-5e888574908c6098b771c7f124116a73bc5de819fb7f3f8b1e9164cbb82d95ed763dd7a0d789b75516447f880a60d0901953615fee359da525ac1a2d490dee75.jpg','IMAGE','jpg','catalog_detail_image_medium.jpg',4,'2021-07-04 11:07:16'),('main-thumb-61c40fc176abea587163b1410e9228272652319913693df8612b9060c92013f880f97a5345b367661dcb9944bc44744efecac05f1cecd488610aa6690c54d552.jpg','IMAGE','jpg','2.png',3,'2021-07-04 09:38:52'),('main-thumb-687b8cec426c5784f24a7d9edda4ed4cbd58008be58badbd0e9c006f0121996e2b55c83f65995308b1237d7ddaebc4c96b9a2cce6c3af0684e53de6ba6803527.jpg','IMAGE','jpg','Arbo-1.jpg',5,'2021-07-05 08:19:09'),('main-thumb-79f14453a3fbb76683190283ed37a463c41bf8ea0b6a5c96c2157a8121a21dc16df79e9ca9cb8a8cf58c79b1d1fddc455f07f93715dae4e9133d6ec07d2f92d0.jpg','IMAGE','jpg','Ami Banglay Gaan gai.jpeg',4,'2021-07-05 08:18:53'),('main-thumb-7ee0bbf4b823e8ffcd0242327e0e7a19963f6e3d70718a70f4104eb5e9605ccbb024458602220c39959c90f9cf623200ac95462af8b23fa40cd545ae0aa28657.jpg','IMAGE','jpg','Alter Bridge 03.jpg',3,'2021-07-05 08:18:20'),('main-thumb-80548fefb941974ff1c68ecedf14f6ff1f68aad778a1fa921e1037e4ea9f236a1d53e972cabfa113b685ecd4a6503e747c50d4e5b0ab87adef3f47b931b703a1.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 09:25:05'),('main-thumb-8091f0508ead0582d4cd25e9b5e3059087edc27db338421e655f8d21913fc7abccec43279e480687774b4ad83910ecf37b56df2d3cbb41ae7b6277af7ad0d2e4.jpg','IMAGE','jpg','Abbath Tem.jpg',3,'2021-07-05 08:12:24'),('main-thumb-850ae88092df215d5138a38d64d8279ef8d590ffd271113dfa94a8c0e058bef6ef3dc5fd7a01a83d02a6008f133aeb191cdb6c60998ca36cf2bc38e032c62703.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:07:16'),('main-thumb-90a3996110d234c822acc67a5e370d4dc94076a92f6889e7c926571b306bb0a36f43e030c0647d920bbc792b1126cfd3daf12b3ecd79a65abc86cbfd6dfef68d.jpg','IMAGE','jpg','0.jpg',5,'2021-07-04 11:07:16'),('main-thumb-93fb3297317ff02cb6dddcbb77ecaceac2b1064ef4c5bce540eeec452188ccd8322b5baa10704ce245572400f520a2a56f9d5230a4b0e3c63e077fd887b87ef8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:06:01'),('main-thumb-bc31eff649a7b718b5eb412a7a1f9b27ab8cf88966be3397ee74deccda0531e27fc4bd6710a2d4af0b6ae9b51ea3a8227d0adbc8f7ec791bbc01b1e46f044c25.jpg','IMAGE','jpg','Ac dc 04.jpg',3,'2021-07-05 08:14:47'),('main-thumb-da7796ca0bd6d9dfaa24f8ab1887bda94306c50905139cc6eb5bfc278f8f611d2b5755ae5e1d2200e8fd93147283a30c47dd9d867abb9282baf5adc4fed73ef7.jpg','IMAGE','jpg','0.jpg',0,'2021-07-06 06:32:55'),('main-thumb-dd8c2c9f1014e5b0d64467bf17ac49090753f64cfda8ae8a3631cea808db35ccb27af741938b3d566d3120bb2623609e14e2577569b15d3dd648302a8b0c7e90.jpg','IMAGE','jpg','2.jpg',0,'2021-07-04 10:10:19'),('main-thumb-e277a5aa69de84a48b9691c0095808fcda8eb99f14be069fac1d566658b587cc7d1c4e5494af04902f1afd489a15957d5dd5c30f31ebc94cbc081fb63fdf4587.jpg','IMAGE','jpg','Grey_Tshirt.jpg',2,'2021-07-04 11:07:16'),('main-thumb-e509510798832879c55fd3058a997f6e3817cf05ef743311d78c541d4db459e00d1e59107565fad82d029cde004ca48f454abea809d76c7048ce1ad52f663b2d.jpg','IMAGE','jpg','5.jpg',1,'2021-07-04 09:25:05'),('main-thumb-ec185820964ad83c0554b55f1936c856699070be228c6bd32019634f5326a588a98ca0d6b6c72102057e86ff5b75793164cfc7d3aa86a14b971d235fb0d304fc.jpg','IMAGE','jpg','2.jpg',1,'2021-07-06 06:32:55'),('pos-details-thumb-14466bb2c6e912e3b7867907b15fc19508d1576e8a12d716521d7fe2dc0f2e5014802785df0c7c209d38bc983b1ef339381201fa697dde4898f0aa86c4a52134.jpg','IMAGE','jpg','1.jpeg',1,'2021-07-04 11:40:58'),('pos-details-thumb-170c79813f96933cc9e88eb3ea21a273156b821a7b98c1f0bcc6af65d8f1c244423d597a6956ee381b4ae8d26f03f5f076f29f949959107edac12bf683aa4801.jpg','IMAGE','jpg','Blue_Tshirt.jpg',3,'2021-07-04 11:07:16'),('pos-details-thumb-1d8e3028f26e6e30d9f06b15b42c413ab34162cd047d38ef8cf95c9e1d9dee64b64e9afab8394ee72de3cc63dfddb9d149e97ca93bdc6482db365db5d05ab1d8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:40:58'),('pos-details-thumb-2e007f7f14358aa76ecdec5de9e07fb1c2dbef38d14a55ab3b029a5470f20a52669dd59670218966ab9324e8ed2565cede59422f38377ecda2a7134f6b080423.jpg','IMAGE','jpg','5.jpg',6,'2021-07-04 11:07:16'),('pos-details-thumb-41789ffeb891c3619631a483442d6e602a3224e7d3c498c26dae4be22410e4f7a7db2035457bc645ef2d1ad1116d2d9a1d75c79295446b7d7445b15e7056f866.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:02:54'),('pos-details-thumb-46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg','IMAGE','jpg','5.jpg',2,'2021-07-06 06:32:54'),('pos-details-thumb-470d63d248fb0f71a27d9bf7a35f5fa3fcef895293c98c113713e70dca953a67f0e8a79ca2fb371a81eb2c2ff556fbfafb16fa22ba07ae2c072bb8037b86ff4d.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:41:06'),('pos-details-thumb-4bc99b3a560d3abf6c6e340b32339b23f81aed01805b2144a8e768e7d8e833efc452d3e71ad4b09f59efb7cf25132f568cdde653b6593be45280cbe78c2ee017.jpg','IMAGE','jpg','1.jpeg',1,'2021-07-04 11:41:06'),('pos-details-thumb-5bb0453a6b879989f62189d7eaeecd0a42a249a5207827de97aabb33258248b74129ef535ad8ce4ad1465193253ed7e0847ff41fa36dc13db4e81517a9f76853.jpg','IMAGE','jpg','2.jpg',1,'2021-07-04 10:02:54'),('pos-details-thumb-5e888574908c6098b771c7f124116a73bc5de819fb7f3f8b1e9164cbb82d95ed763dd7a0d789b75516447f880a60d0901953615fee359da525ac1a2d490dee75.jpg','IMAGE','jpg','catalog_detail_image_medium.jpg',4,'2021-07-04 11:07:16'),('pos-details-thumb-61c40fc176abea587163b1410e9228272652319913693df8612b9060c92013f880f97a5345b367661dcb9944bc44744efecac05f1cecd488610aa6690c54d552.jpg','IMAGE','jpg','2.png',3,'2021-07-04 09:38:52'),('pos-details-thumb-687b8cec426c5784f24a7d9edda4ed4cbd58008be58badbd0e9c006f0121996e2b55c83f65995308b1237d7ddaebc4c96b9a2cce6c3af0684e53de6ba6803527.jpg','IMAGE','jpg','Arbo-1.jpg',5,'2021-07-05 08:19:09'),('pos-details-thumb-79f14453a3fbb76683190283ed37a463c41bf8ea0b6a5c96c2157a8121a21dc16df79e9ca9cb8a8cf58c79b1d1fddc455f07f93715dae4e9133d6ec07d2f92d0.jpg','IMAGE','jpg','Ami Banglay Gaan gai.jpeg',4,'2021-07-05 08:18:53'),('pos-details-thumb-7ee0bbf4b823e8ffcd0242327e0e7a19963f6e3d70718a70f4104eb5e9605ccbb024458602220c39959c90f9cf623200ac95462af8b23fa40cd545ae0aa28657.jpg','IMAGE','jpg','Alter Bridge 03.jpg',3,'2021-07-05 08:18:20'),('pos-details-thumb-80548fefb941974ff1c68ecedf14f6ff1f68aad778a1fa921e1037e4ea9f236a1d53e972cabfa113b685ecd4a6503e747c50d4e5b0ab87adef3f47b931b703a1.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 09:25:05'),('pos-details-thumb-8091f0508ead0582d4cd25e9b5e3059087edc27db338421e655f8d21913fc7abccec43279e480687774b4ad83910ecf37b56df2d3cbb41ae7b6277af7ad0d2e4.jpg','IMAGE','jpg','Abbath Tem.jpg',3,'2021-07-05 08:12:24'),('pos-details-thumb-850ae88092df215d5138a38d64d8279ef8d590ffd271113dfa94a8c0e058bef6ef3dc5fd7a01a83d02a6008f133aeb191cdb6c60998ca36cf2bc38e032c62703.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:07:16'),('pos-details-thumb-90a3996110d234c822acc67a5e370d4dc94076a92f6889e7c926571b306bb0a36f43e030c0647d920bbc792b1126cfd3daf12b3ecd79a65abc86cbfd6dfef68d.jpg','IMAGE','jpg','0.jpg',5,'2021-07-04 11:07:16'),('pos-details-thumb-93fb3297317ff02cb6dddcbb77ecaceac2b1064ef4c5bce540eeec452188ccd8322b5baa10704ce245572400f520a2a56f9d5230a4b0e3c63e077fd887b87ef8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:06:01'),('pos-details-thumb-bc31eff649a7b718b5eb412a7a1f9b27ab8cf88966be3397ee74deccda0531e27fc4bd6710a2d4af0b6ae9b51ea3a8227d0adbc8f7ec791bbc01b1e46f044c25.jpg','IMAGE','jpg','Ac dc 04.jpg',3,'2021-07-05 08:14:47'),('pos-details-thumb-da7796ca0bd6d9dfaa24f8ab1887bda94306c50905139cc6eb5bfc278f8f611d2b5755ae5e1d2200e8fd93147283a30c47dd9d867abb9282baf5adc4fed73ef7.jpg','IMAGE','jpg','0.jpg',0,'2021-07-06 06:32:54'),('pos-details-thumb-dd8c2c9f1014e5b0d64467bf17ac49090753f64cfda8ae8a3631cea808db35ccb27af741938b3d566d3120bb2623609e14e2577569b15d3dd648302a8b0c7e90.jpg','IMAGE','jpg','2.jpg',0,'2021-07-04 10:10:19'),('pos-details-thumb-e277a5aa69de84a48b9691c0095808fcda8eb99f14be069fac1d566658b587cc7d1c4e5494af04902f1afd489a15957d5dd5c30f31ebc94cbc081fb63fdf4587.jpg','IMAGE','jpg','Grey_Tshirt.jpg',2,'2021-07-04 11:07:16'),('pos-details-thumb-e509510798832879c55fd3058a997f6e3817cf05ef743311d78c541d4db459e00d1e59107565fad82d029cde004ca48f454abea809d76c7048ce1ad52f663b2d.jpg','IMAGE','jpg','5.jpg',1,'2021-07-04 09:25:05'),('pos-details-thumb-ec185820964ad83c0554b55f1936c856699070be228c6bd32019634f5326a588a98ca0d6b6c72102057e86ff5b75793164cfc7d3aa86a14b971d235fb0d304fc.jpg','IMAGE','jpg','2.jpg',1,'2021-07-06 06:32:55'),('pos-large-thumb-14466bb2c6e912e3b7867907b15fc19508d1576e8a12d716521d7fe2dc0f2e5014802785df0c7c209d38bc983b1ef339381201fa697dde4898f0aa86c4a52134.jpg','IMAGE','jpg','1.jpeg',1,'2021-07-04 11:40:58'),('pos-large-thumb-170c79813f96933cc9e88eb3ea21a273156b821a7b98c1f0bcc6af65d8f1c244423d597a6956ee381b4ae8d26f03f5f076f29f949959107edac12bf683aa4801.jpg','IMAGE','jpg','Blue_Tshirt.jpg',3,'2021-07-04 11:07:16'),('pos-large-thumb-1d8e3028f26e6e30d9f06b15b42c413ab34162cd047d38ef8cf95c9e1d9dee64b64e9afab8394ee72de3cc63dfddb9d149e97ca93bdc6482db365db5d05ab1d8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:40:58'),('pos-large-thumb-2e007f7f14358aa76ecdec5de9e07fb1c2dbef38d14a55ab3b029a5470f20a52669dd59670218966ab9324e8ed2565cede59422f38377ecda2a7134f6b080423.jpg','IMAGE','jpg','5.jpg',6,'2021-07-04 11:07:16'),('pos-large-thumb-41789ffeb891c3619631a483442d6e602a3224e7d3c498c26dae4be22410e4f7a7db2035457bc645ef2d1ad1116d2d9a1d75c79295446b7d7445b15e7056f866.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:02:54'),('pos-large-thumb-46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg','IMAGE','jpg','5.jpg',2,'2021-07-06 06:32:54'),('pos-large-thumb-470d63d248fb0f71a27d9bf7a35f5fa3fcef895293c98c113713e70dca953a67f0e8a79ca2fb371a81eb2c2ff556fbfafb16fa22ba07ae2c072bb8037b86ff4d.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:41:06'),('pos-large-thumb-4bc99b3a560d3abf6c6e340b32339b23f81aed01805b2144a8e768e7d8e833efc452d3e71ad4b09f59efb7cf25132f568cdde653b6593be45280cbe78c2ee017.jpg','IMAGE','jpg','1.jpeg',1,'2021-07-04 11:41:06'),('pos-large-thumb-5bb0453a6b879989f62189d7eaeecd0a42a249a5207827de97aabb33258248b74129ef535ad8ce4ad1465193253ed7e0847ff41fa36dc13db4e81517a9f76853.jpg','IMAGE','jpg','2.jpg',1,'2021-07-04 10:02:54'),('pos-large-thumb-5e888574908c6098b771c7f124116a73bc5de819fb7f3f8b1e9164cbb82d95ed763dd7a0d789b75516447f880a60d0901953615fee359da525ac1a2d490dee75.jpg','IMAGE','jpg','catalog_detail_image_medium.jpg',4,'2021-07-04 11:07:16'),('pos-large-thumb-61c40fc176abea587163b1410e9228272652319913693df8612b9060c92013f880f97a5345b367661dcb9944bc44744efecac05f1cecd488610aa6690c54d552.jpg','IMAGE','jpg','2.png',3,'2021-07-04 09:38:52'),('pos-large-thumb-687b8cec426c5784f24a7d9edda4ed4cbd58008be58badbd0e9c006f0121996e2b55c83f65995308b1237d7ddaebc4c96b9a2cce6c3af0684e53de6ba6803527.jpg','IMAGE','jpg','Arbo-1.jpg',5,'2021-07-05 08:19:09'),('pos-large-thumb-79f14453a3fbb76683190283ed37a463c41bf8ea0b6a5c96c2157a8121a21dc16df79e9ca9cb8a8cf58c79b1d1fddc455f07f93715dae4e9133d6ec07d2f92d0.jpg','IMAGE','jpg','Ami Banglay Gaan gai.jpeg',4,'2021-07-05 08:18:53'),('pos-large-thumb-7ee0bbf4b823e8ffcd0242327e0e7a19963f6e3d70718a70f4104eb5e9605ccbb024458602220c39959c90f9cf623200ac95462af8b23fa40cd545ae0aa28657.jpg','IMAGE','jpg','Alter Bridge 03.jpg',3,'2021-07-05 08:18:20'),('pos-large-thumb-80548fefb941974ff1c68ecedf14f6ff1f68aad778a1fa921e1037e4ea9f236a1d53e972cabfa113b685ecd4a6503e747c50d4e5b0ab87adef3f47b931b703a1.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 09:25:05'),('pos-large-thumb-8091f0508ead0582d4cd25e9b5e3059087edc27db338421e655f8d21913fc7abccec43279e480687774b4ad83910ecf37b56df2d3cbb41ae7b6277af7ad0d2e4.jpg','IMAGE','jpg','Abbath Tem.jpg',3,'2021-07-05 08:12:24'),('pos-large-thumb-850ae88092df215d5138a38d64d8279ef8d590ffd271113dfa94a8c0e058bef6ef3dc5fd7a01a83d02a6008f133aeb191cdb6c60998ca36cf2bc38e032c62703.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:07:16'),('pos-large-thumb-90a3996110d234c822acc67a5e370d4dc94076a92f6889e7c926571b306bb0a36f43e030c0647d920bbc792b1126cfd3daf12b3ecd79a65abc86cbfd6dfef68d.jpg','IMAGE','jpg','0.jpg',5,'2021-07-04 11:07:16'),('pos-large-thumb-93fb3297317ff02cb6dddcbb77ecaceac2b1064ef4c5bce540eeec452188ccd8322b5baa10704ce245572400f520a2a56f9d5230a4b0e3c63e077fd887b87ef8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:06:01'),('pos-large-thumb-bc31eff649a7b718b5eb412a7a1f9b27ab8cf88966be3397ee74deccda0531e27fc4bd6710a2d4af0b6ae9b51ea3a8227d0adbc8f7ec791bbc01b1e46f044c25.jpg','IMAGE','jpg','Ac dc 04.jpg',3,'2021-07-05 08:14:47'),('pos-large-thumb-da7796ca0bd6d9dfaa24f8ab1887bda94306c50905139cc6eb5bfc278f8f611d2b5755ae5e1d2200e8fd93147283a30c47dd9d867abb9282baf5adc4fed73ef7.jpg','IMAGE','jpg','0.jpg',0,'2021-07-06 06:32:54'),('pos-large-thumb-dd8c2c9f1014e5b0d64467bf17ac49090753f64cfda8ae8a3631cea808db35ccb27af741938b3d566d3120bb2623609e14e2577569b15d3dd648302a8b0c7e90.jpg','IMAGE','jpg','2.jpg',0,'2021-07-04 10:10:19'),('pos-large-thumb-e277a5aa69de84a48b9691c0095808fcda8eb99f14be069fac1d566658b587cc7d1c4e5494af04902f1afd489a15957d5dd5c30f31ebc94cbc081fb63fdf4587.jpg','IMAGE','jpg','Grey_Tshirt.jpg',2,'2021-07-04 11:07:16'),('pos-large-thumb-e509510798832879c55fd3058a997f6e3817cf05ef743311d78c541d4db459e00d1e59107565fad82d029cde004ca48f454abea809d76c7048ce1ad52f663b2d.jpg','IMAGE','jpg','5.jpg',1,'2021-07-04 09:25:05'),('pos-large-thumb-ec185820964ad83c0554b55f1936c856699070be228c6bd32019634f5326a588a98ca0d6b6c72102057e86ff5b75793164cfc7d3aa86a14b971d235fb0d304fc.jpg','IMAGE','jpg','2.jpg',1,'2021-07-06 06:32:55'),('related-thumb-14466bb2c6e912e3b7867907b15fc19508d1576e8a12d716521d7fe2dc0f2e5014802785df0c7c209d38bc983b1ef339381201fa697dde4898f0aa86c4a52134.jpg','IMAGE','jpg','1.jpeg',1,'2021-07-04 11:40:59'),('related-thumb-170c79813f96933cc9e88eb3ea21a273156b821a7b98c1f0bcc6af65d8f1c244423d597a6956ee381b4ae8d26f03f5f076f29f949959107edac12bf683aa4801.jpg','IMAGE','jpg','Blue_Tshirt.jpg',3,'2021-07-04 11:07:16'),('related-thumb-1d8e3028f26e6e30d9f06b15b42c413ab34162cd047d38ef8cf95c9e1d9dee64b64e9afab8394ee72de3cc63dfddb9d149e97ca93bdc6482db365db5d05ab1d8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:40:59'),('related-thumb-2e007f7f14358aa76ecdec5de9e07fb1c2dbef38d14a55ab3b029a5470f20a52669dd59670218966ab9324e8ed2565cede59422f38377ecda2a7134f6b080423.jpg','IMAGE','jpg','5.jpg',6,'2021-07-04 11:07:16'),('related-thumb-41789ffeb891c3619631a483442d6e602a3224e7d3c498c26dae4be22410e4f7a7db2035457bc645ef2d1ad1116d2d9a1d75c79295446b7d7445b15e7056f866.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:02:54'),('related-thumb-46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg','IMAGE','jpg','5.jpg',2,'2021-07-06 06:32:55'),('related-thumb-470d63d248fb0f71a27d9bf7a35f5fa3fcef895293c98c113713e70dca953a67f0e8a79ca2fb371a81eb2c2ff556fbfafb16fa22ba07ae2c072bb8037b86ff4d.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:41:06'),('related-thumb-4bc99b3a560d3abf6c6e340b32339b23f81aed01805b2144a8e768e7d8e833efc452d3e71ad4b09f59efb7cf25132f568cdde653b6593be45280cbe78c2ee017.jpg','IMAGE','jpg','1.jpeg',1,'2021-07-04 11:41:06'),('related-thumb-5bb0453a6b879989f62189d7eaeecd0a42a249a5207827de97aabb33258248b74129ef535ad8ce4ad1465193253ed7e0847ff41fa36dc13db4e81517a9f76853.jpg','IMAGE','jpg','2.jpg',1,'2021-07-04 10:02:54'),('related-thumb-5e888574908c6098b771c7f124116a73bc5de819fb7f3f8b1e9164cbb82d95ed763dd7a0d789b75516447f880a60d0901953615fee359da525ac1a2d490dee75.jpg','IMAGE','jpg','catalog_detail_image_medium.jpg',4,'2021-07-04 11:07:16'),('related-thumb-61c40fc176abea587163b1410e9228272652319913693df8612b9060c92013f880f97a5345b367661dcb9944bc44744efecac05f1cecd488610aa6690c54d552.jpg','IMAGE','jpg','2.png',3,'2021-07-04 09:38:52'),('related-thumb-687b8cec426c5784f24a7d9edda4ed4cbd58008be58badbd0e9c006f0121996e2b55c83f65995308b1237d7ddaebc4c96b9a2cce6c3af0684e53de6ba6803527.jpg','IMAGE','jpg','Arbo-1.jpg',5,'2021-07-05 08:19:09'),('related-thumb-79f14453a3fbb76683190283ed37a463c41bf8ea0b6a5c96c2157a8121a21dc16df79e9ca9cb8a8cf58c79b1d1fddc455f07f93715dae4e9133d6ec07d2f92d0.jpg','IMAGE','jpg','Ami Banglay Gaan gai.jpeg',4,'2021-07-05 08:18:53'),('related-thumb-7ee0bbf4b823e8ffcd0242327e0e7a19963f6e3d70718a70f4104eb5e9605ccbb024458602220c39959c90f9cf623200ac95462af8b23fa40cd545ae0aa28657.jpg','IMAGE','jpg','Alter Bridge 03.jpg',3,'2021-07-05 08:18:20'),('related-thumb-80548fefb941974ff1c68ecedf14f6ff1f68aad778a1fa921e1037e4ea9f236a1d53e972cabfa113b685ecd4a6503e747c50d4e5b0ab87adef3f47b931b703a1.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 09:25:05'),('related-thumb-8091f0508ead0582d4cd25e9b5e3059087edc27db338421e655f8d21913fc7abccec43279e480687774b4ad83910ecf37b56df2d3cbb41ae7b6277af7ad0d2e4.jpg','IMAGE','jpg','Abbath Tem.jpg',3,'2021-07-05 08:12:24'),('related-thumb-850ae88092df215d5138a38d64d8279ef8d590ffd271113dfa94a8c0e058bef6ef3dc5fd7a01a83d02a6008f133aeb191cdb6c60998ca36cf2bc38e032c62703.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:07:16'),('related-thumb-90a3996110d234c822acc67a5e370d4dc94076a92f6889e7c926571b306bb0a36f43e030c0647d920bbc792b1126cfd3daf12b3ecd79a65abc86cbfd6dfef68d.jpg','IMAGE','jpg','0.jpg',5,'2021-07-04 11:07:16'),('related-thumb-93fb3297317ff02cb6dddcbb77ecaceac2b1064ef4c5bce540eeec452188ccd8322b5baa10704ce245572400f520a2a56f9d5230a4b0e3c63e077fd887b87ef8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:06:01'),('related-thumb-bc31eff649a7b718b5eb412a7a1f9b27ab8cf88966be3397ee74deccda0531e27fc4bd6710a2d4af0b6ae9b51ea3a8227d0adbc8f7ec791bbc01b1e46f044c25.jpg','IMAGE','jpg','Ac dc 04.jpg',3,'2021-07-05 08:14:47'),('related-thumb-da7796ca0bd6d9dfaa24f8ab1887bda94306c50905139cc6eb5bfc278f8f611d2b5755ae5e1d2200e8fd93147283a30c47dd9d867abb9282baf5adc4fed73ef7.jpg','IMAGE','jpg','0.jpg',0,'2021-07-06 06:32:55'),('related-thumb-dd8c2c9f1014e5b0d64467bf17ac49090753f64cfda8ae8a3631cea808db35ccb27af741938b3d566d3120bb2623609e14e2577569b15d3dd648302a8b0c7e90.jpg','IMAGE','jpg','2.jpg',0,'2021-07-04 10:10:19'),('related-thumb-e277a5aa69de84a48b9691c0095808fcda8eb99f14be069fac1d566658b587cc7d1c4e5494af04902f1afd489a15957d5dd5c30f31ebc94cbc081fb63fdf4587.jpg','IMAGE','jpg','Grey_Tshirt.jpg',2,'2021-07-04 11:07:16'),('related-thumb-e509510798832879c55fd3058a997f6e3817cf05ef743311d78c541d4db459e00d1e59107565fad82d029cde004ca48f454abea809d76c7048ce1ad52f663b2d.jpg','IMAGE','jpg','5.jpg',1,'2021-07-04 09:25:05'),('related-thumb-ec185820964ad83c0554b55f1936c856699070be228c6bd32019634f5326a588a98ca0d6b6c72102057e86ff5b75793164cfc7d3aa86a14b971d235fb0d304fc.jpg','IMAGE','jpg','2.jpg',1,'2021-07-06 06:32:55'),('shop-list-thumb-14466bb2c6e912e3b7867907b15fc19508d1576e8a12d716521d7fe2dc0f2e5014802785df0c7c209d38bc983b1ef339381201fa697dde4898f0aa86c4a52134.jpg','IMAGE','jpg','1.jpeg',1,'2021-07-04 11:40:59'),('shop-list-thumb-170c79813f96933cc9e88eb3ea21a273156b821a7b98c1f0bcc6af65d8f1c244423d597a6956ee381b4ae8d26f03f5f076f29f949959107edac12bf683aa4801.jpg','IMAGE','jpg','Blue_Tshirt.jpg',3,'2021-07-04 11:07:16'),('shop-list-thumb-1d8e3028f26e6e30d9f06b15b42c413ab34162cd047d38ef8cf95c9e1d9dee64b64e9afab8394ee72de3cc63dfddb9d149e97ca93bdc6482db365db5d05ab1d8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:40:59'),('shop-list-thumb-2e007f7f14358aa76ecdec5de9e07fb1c2dbef38d14a55ab3b029a5470f20a52669dd59670218966ab9324e8ed2565cede59422f38377ecda2a7134f6b080423.jpg','IMAGE','jpg','5.jpg',6,'2021-07-04 11:07:16'),('shop-list-thumb-41789ffeb891c3619631a483442d6e602a3224e7d3c498c26dae4be22410e4f7a7db2035457bc645ef2d1ad1116d2d9a1d75c79295446b7d7445b15e7056f866.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:02:54'),('shop-list-thumb-46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg','IMAGE','jpg','5.jpg',2,'2021-07-06 06:32:55'),('shop-list-thumb-470d63d248fb0f71a27d9bf7a35f5fa3fcef895293c98c113713e70dca953a67f0e8a79ca2fb371a81eb2c2ff556fbfafb16fa22ba07ae2c072bb8037b86ff4d.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:41:06'),('shop-list-thumb-4bc99b3a560d3abf6c6e340b32339b23f81aed01805b2144a8e768e7d8e833efc452d3e71ad4b09f59efb7cf25132f568cdde653b6593be45280cbe78c2ee017.jpg','IMAGE','jpg','1.jpeg',1,'2021-07-04 11:41:06'),('shop-list-thumb-5bb0453a6b879989f62189d7eaeecd0a42a249a5207827de97aabb33258248b74129ef535ad8ce4ad1465193253ed7e0847ff41fa36dc13db4e81517a9f76853.jpg','IMAGE','jpg','2.jpg',1,'2021-07-04 10:02:54'),('shop-list-thumb-5e888574908c6098b771c7f124116a73bc5de819fb7f3f8b1e9164cbb82d95ed763dd7a0d789b75516447f880a60d0901953615fee359da525ac1a2d490dee75.jpg','IMAGE','jpg','catalog_detail_image_medium.jpg',4,'2021-07-04 11:07:16'),('shop-list-thumb-61c40fc176abea587163b1410e9228272652319913693df8612b9060c92013f880f97a5345b367661dcb9944bc44744efecac05f1cecd488610aa6690c54d552.jpg','IMAGE','jpg','2.png',3,'2021-07-04 09:38:52'),('shop-list-thumb-687b8cec426c5784f24a7d9edda4ed4cbd58008be58badbd0e9c006f0121996e2b55c83f65995308b1237d7ddaebc4c96b9a2cce6c3af0684e53de6ba6803527.jpg','IMAGE','jpg','Arbo-1.jpg',5,'2021-07-05 08:19:09'),('shop-list-thumb-79f14453a3fbb76683190283ed37a463c41bf8ea0b6a5c96c2157a8121a21dc16df79e9ca9cb8a8cf58c79b1d1fddc455f07f93715dae4e9133d6ec07d2f92d0.jpg','IMAGE','jpg','Ami Banglay Gaan gai.jpeg',4,'2021-07-05 08:18:53'),('shop-list-thumb-7ee0bbf4b823e8ffcd0242327e0e7a19963f6e3d70718a70f4104eb5e9605ccbb024458602220c39959c90f9cf623200ac95462af8b23fa40cd545ae0aa28657.jpg','IMAGE','jpg','Alter Bridge 03.jpg',3,'2021-07-05 08:18:20'),('shop-list-thumb-80548fefb941974ff1c68ecedf14f6ff1f68aad778a1fa921e1037e4ea9f236a1d53e972cabfa113b685ecd4a6503e747c50d4e5b0ab87adef3f47b931b703a1.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 09:25:05'),('shop-list-thumb-8091f0508ead0582d4cd25e9b5e3059087edc27db338421e655f8d21913fc7abccec43279e480687774b4ad83910ecf37b56df2d3cbb41ae7b6277af7ad0d2e4.jpg','IMAGE','jpg','Abbath Tem.jpg',3,'2021-07-05 08:12:24'),('shop-list-thumb-850ae88092df215d5138a38d64d8279ef8d590ffd271113dfa94a8c0e058bef6ef3dc5fd7a01a83d02a6008f133aeb191cdb6c60998ca36cf2bc38e032c62703.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:07:16'),('shop-list-thumb-90a3996110d234c822acc67a5e370d4dc94076a92f6889e7c926571b306bb0a36f43e030c0647d920bbc792b1126cfd3daf12b3ecd79a65abc86cbfd6dfef68d.jpg','IMAGE','jpg','0.jpg',5,'2021-07-04 11:07:16'),('shop-list-thumb-93fb3297317ff02cb6dddcbb77ecaceac2b1064ef4c5bce540eeec452188ccd8322b5baa10704ce245572400f520a2a56f9d5230a4b0e3c63e077fd887b87ef8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:06:01'),('shop-list-thumb-bc31eff649a7b718b5eb412a7a1f9b27ab8cf88966be3397ee74deccda0531e27fc4bd6710a2d4af0b6ae9b51ea3a8227d0adbc8f7ec791bbc01b1e46f044c25.jpg','IMAGE','jpg','Ac dc 04.jpg',3,'2021-07-05 08:14:47'),('shop-list-thumb-da7796ca0bd6d9dfaa24f8ab1887bda94306c50905139cc6eb5bfc278f8f611d2b5755ae5e1d2200e8fd93147283a30c47dd9d867abb9282baf5adc4fed73ef7.jpg','IMAGE','jpg','0.jpg',0,'2021-07-06 06:32:55'),('shop-list-thumb-dd8c2c9f1014e5b0d64467bf17ac49090753f64cfda8ae8a3631cea808db35ccb27af741938b3d566d3120bb2623609e14e2577569b15d3dd648302a8b0c7e90.jpg','IMAGE','jpg','2.jpg',0,'2021-07-04 10:10:19'),('shop-list-thumb-e277a5aa69de84a48b9691c0095808fcda8eb99f14be069fac1d566658b587cc7d1c4e5494af04902f1afd489a15957d5dd5c30f31ebc94cbc081fb63fdf4587.jpg','IMAGE','jpg','Grey_Tshirt.jpg',2,'2021-07-04 11:07:16'),('shop-list-thumb-e509510798832879c55fd3058a997f6e3817cf05ef743311d78c541d4db459e00d1e59107565fad82d029cde004ca48f454abea809d76c7048ce1ad52f663b2d.jpg','IMAGE','jpg','5.jpg',1,'2021-07-04 09:25:05'),('shop-list-thumb-ec185820964ad83c0554b55f1936c856699070be228c6bd32019634f5326a588a98ca0d6b6c72102057e86ff5b75793164cfc7d3aa86a14b971d235fb0d304fc.jpg','IMAGE','jpg','2.jpg',1,'2021-07-06 06:32:55'),('sidebar-thumb-14466bb2c6e912e3b7867907b15fc19508d1576e8a12d716521d7fe2dc0f2e5014802785df0c7c209d38bc983b1ef339381201fa697dde4898f0aa86c4a52134.jpg','IMAGE','jpg','1.jpeg',1,'2021-07-04 11:40:59'),('sidebar-thumb-170c79813f96933cc9e88eb3ea21a273156b821a7b98c1f0bcc6af65d8f1c244423d597a6956ee381b4ae8d26f03f5f076f29f949959107edac12bf683aa4801.jpg','IMAGE','jpg','Blue_Tshirt.jpg',3,'2021-07-04 11:07:16'),('sidebar-thumb-1d8e3028f26e6e30d9f06b15b42c413ab34162cd047d38ef8cf95c9e1d9dee64b64e9afab8394ee72de3cc63dfddb9d149e97ca93bdc6482db365db5d05ab1d8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:40:59'),('sidebar-thumb-2e007f7f14358aa76ecdec5de9e07fb1c2dbef38d14a55ab3b029a5470f20a52669dd59670218966ab9324e8ed2565cede59422f38377ecda2a7134f6b080423.jpg','IMAGE','jpg','5.jpg',6,'2021-07-04 11:07:16'),('sidebar-thumb-41789ffeb891c3619631a483442d6e602a3224e7d3c498c26dae4be22410e4f7a7db2035457bc645ef2d1ad1116d2d9a1d75c79295446b7d7445b15e7056f866.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:02:54'),('sidebar-thumb-46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg','IMAGE','jpg','5.jpg',2,'2021-07-06 06:32:55'),('sidebar-thumb-470d63d248fb0f71a27d9bf7a35f5fa3fcef895293c98c113713e70dca953a67f0e8a79ca2fb371a81eb2c2ff556fbfafb16fa22ba07ae2c072bb8037b86ff4d.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:41:06'),('sidebar-thumb-4bc99b3a560d3abf6c6e340b32339b23f81aed01805b2144a8e768e7d8e833efc452d3e71ad4b09f59efb7cf25132f568cdde653b6593be45280cbe78c2ee017.jpg','IMAGE','jpg','1.jpeg',1,'2021-07-04 11:41:06'),('sidebar-thumb-5bb0453a6b879989f62189d7eaeecd0a42a249a5207827de97aabb33258248b74129ef535ad8ce4ad1465193253ed7e0847ff41fa36dc13db4e81517a9f76853.jpg','IMAGE','jpg','2.jpg',1,'2021-07-04 10:02:54'),('sidebar-thumb-5e888574908c6098b771c7f124116a73bc5de819fb7f3f8b1e9164cbb82d95ed763dd7a0d789b75516447f880a60d0901953615fee359da525ac1a2d490dee75.jpg','IMAGE','jpg','catalog_detail_image_medium.jpg',4,'2021-07-04 11:07:16'),('sidebar-thumb-61c40fc176abea587163b1410e9228272652319913693df8612b9060c92013f880f97a5345b367661dcb9944bc44744efecac05f1cecd488610aa6690c54d552.jpg','IMAGE','jpg','2.png',3,'2021-07-04 09:38:52'),('sidebar-thumb-687b8cec426c5784f24a7d9edda4ed4cbd58008be58badbd0e9c006f0121996e2b55c83f65995308b1237d7ddaebc4c96b9a2cce6c3af0684e53de6ba6803527.jpg','IMAGE','jpg','Arbo-1.jpg',5,'2021-07-05 08:19:09'),('sidebar-thumb-79f14453a3fbb76683190283ed37a463c41bf8ea0b6a5c96c2157a8121a21dc16df79e9ca9cb8a8cf58c79b1d1fddc455f07f93715dae4e9133d6ec07d2f92d0.jpg','IMAGE','jpg','Ami Banglay Gaan gai.jpeg',4,'2021-07-05 08:18:53'),('sidebar-thumb-7ee0bbf4b823e8ffcd0242327e0e7a19963f6e3d70718a70f4104eb5e9605ccbb024458602220c39959c90f9cf623200ac95462af8b23fa40cd545ae0aa28657.jpg','IMAGE','jpg','Alter Bridge 03.jpg',3,'2021-07-05 08:18:20'),('sidebar-thumb-80548fefb941974ff1c68ecedf14f6ff1f68aad778a1fa921e1037e4ea9f236a1d53e972cabfa113b685ecd4a6503e747c50d4e5b0ab87adef3f47b931b703a1.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 09:25:05'),('sidebar-thumb-8091f0508ead0582d4cd25e9b5e3059087edc27db338421e655f8d21913fc7abccec43279e480687774b4ad83910ecf37b56df2d3cbb41ae7b6277af7ad0d2e4.jpg','IMAGE','jpg','Abbath Tem.jpg',3,'2021-07-05 08:12:24'),('sidebar-thumb-850ae88092df215d5138a38d64d8279ef8d590ffd271113dfa94a8c0e058bef6ef3dc5fd7a01a83d02a6008f133aeb191cdb6c60998ca36cf2bc38e032c62703.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 11:07:16'),('sidebar-thumb-90a3996110d234c822acc67a5e370d4dc94076a92f6889e7c926571b306bb0a36f43e030c0647d920bbc792b1126cfd3daf12b3ecd79a65abc86cbfd6dfef68d.jpg','IMAGE','jpg','0.jpg',5,'2021-07-04 11:07:16'),('sidebar-thumb-93fb3297317ff02cb6dddcbb77ecaceac2b1064ef4c5bce540eeec452188ccd8322b5baa10704ce245572400f520a2a56f9d5230a4b0e3c63e077fd887b87ef8.jpg','IMAGE','jpg','0.jpg',0,'2021-07-04 10:06:01'),('sidebar-thumb-bc31eff649a7b718b5eb412a7a1f9b27ab8cf88966be3397ee74deccda0531e27fc4bd6710a2d4af0b6ae9b51ea3a8227d0adbc8f7ec791bbc01b1e46f044c25.jpg','IMAGE','jpg','Ac dc 04.jpg',3,'2021-07-05 08:14:47'),('sidebar-thumb-da7796ca0bd6d9dfaa24f8ab1887bda94306c50905139cc6eb5bfc278f8f611d2b5755ae5e1d2200e8fd93147283a30c47dd9d867abb9282baf5adc4fed73ef7.jpg','IMAGE','jpg','0.jpg',0,'2021-07-06 06:32:55'),('sidebar-thumb-dd8c2c9f1014e5b0d64467bf17ac49090753f64cfda8ae8a3631cea808db35ccb27af741938b3d566d3120bb2623609e14e2577569b15d3dd648302a8b0c7e90.jpg','IMAGE','jpg','2.jpg',0,'2021-07-04 10:10:19'),('sidebar-thumb-e277a5aa69de84a48b9691c0095808fcda8eb99f14be069fac1d566658b587cc7d1c4e5494af04902f1afd489a15957d5dd5c30f31ebc94cbc081fb63fdf4587.jpg','IMAGE','jpg','Grey_Tshirt.jpg',2,'2021-07-04 11:07:16'),('sidebar-thumb-e509510798832879c55fd3058a997f6e3817cf05ef743311d78c541d4db459e00d1e59107565fad82d029cde004ca48f454abea809d76c7048ce1ad52f663b2d.jpg','IMAGE','jpg','5.jpg',1,'2021-07-04 09:25:05'),('sidebar-thumb-ec185820964ad83c0554b55f1936c856699070be228c6bd32019634f5326a588a98ca0d6b6c72102057e86ff5b75793164cfc7d3aa86a14b971d235fb0d304fc.jpg','IMAGE','jpg','2.jpg',1,'2021-07-06 06:32:55');
/*!40000 ALTER TABLE `ottoman_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_lookup`
--

DROP TABLE IF EXISTS `product_lookup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_lookup` (
  `product_id` int(11) NOT NULL,
  `lookup_id` int(11) NOT NULL,
  PRIMARY KEY (`product_id`,`lookup_id`),
  KEY `IDX_9260F0A14584665A` (`product_id`),
  KEY `IDX_9260F0A18955C49D` (`lookup_id`),
  CONSTRAINT `FK_9260F0A14584665A` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_9260F0A18955C49D` FOREIGN KEY (`lookup_id`) REFERENCES `lookups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_lookup`
--

LOCK TABLES `product_lookup` WRITE;
/*!40000 ALTER TABLE `product_lookup` DISABLE KEYS */;
INSERT INTO `product_lookup` VALUES (1,1),(3,1),(4,1),(5,1),(6,1),(7,1),(9,1),(10,1),(11,1),(14,1),(15,1),(17,1),(18,1),(19,1),(20,1),(20,3),(20,4),(20,5);
/*!40000 ALTER TABLE `product_lookup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_ottomanfile`
--

DROP TABLE IF EXISTS `product_ottomanfile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_ottomanfile` (
  `product_id` int(11) NOT NULL,
  `ottomanfile_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`product_id`,`ottomanfile_id`),
  KEY `IDX_FDB299DB4584665A` (`product_id`),
  KEY `IDX_FDB299DB311882C3` (`ottomanfile_id`),
  CONSTRAINT `FK_FDB299DB311882C3` FOREIGN KEY (`ottomanfile_id`) REFERENCES `ottoman_files` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_FDB299DB4584665A` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_ottomanfile`
--

LOCK TABLES `product_ottomanfile` WRITE;
/*!40000 ALTER TABLE `product_ottomanfile` DISABLE KEYS */;
INSERT INTO `product_ottomanfile` VALUES (1,'80548fefb941974ff1c68ecedf14f6ff1f68aad778a1fa921e1037e4ea9f236a1d53e972cabfa113b685ecd4a6503e747c50d4e5b0ab87adef3f47b931b703a1.jpg'),(1,'e509510798832879c55fd3058a997f6e3817cf05ef743311d78c541d4db459e00d1e59107565fad82d029cde004ca48f454abea809d76c7048ce1ad52f663b2d.jpg'),(4,'41789ffeb891c3619631a483442d6e602a3224e7d3c498c26dae4be22410e4f7a7db2035457bc645ef2d1ad1116d2d9a1d75c79295446b7d7445b15e7056f866.jpg'),(4,'5bb0453a6b879989f62189d7eaeecd0a42a249a5207827de97aabb33258248b74129ef535ad8ce4ad1465193253ed7e0847ff41fa36dc13db4e81517a9f76853.jpg'),(5,'93fb3297317ff02cb6dddcbb77ecaceac2b1064ef4c5bce540eeec452188ccd8322b5baa10704ce245572400f520a2a56f9d5230a4b0e3c63e077fd887b87ef8.jpg'),(6,'dd8c2c9f1014e5b0d64467bf17ac49090753f64cfda8ae8a3631cea808db35ccb27af741938b3d566d3120bb2623609e14e2577569b15d3dd648302a8b0c7e90.jpg'),(7,'170c79813f96933cc9e88eb3ea21a273156b821a7b98c1f0bcc6af65d8f1c244423d597a6956ee381b4ae8d26f03f5f076f29f949959107edac12bf683aa4801.jpg'),(7,'2e007f7f14358aa76ecdec5de9e07fb1c2dbef38d14a55ab3b029a5470f20a52669dd59670218966ab9324e8ed2565cede59422f38377ecda2a7134f6b080423.jpg'),(7,'5e888574908c6098b771c7f124116a73bc5de819fb7f3f8b1e9164cbb82d95ed763dd7a0d789b75516447f880a60d0901953615fee359da525ac1a2d490dee75.jpg'),(7,'850ae88092df215d5138a38d64d8279ef8d590ffd271113dfa94a8c0e058bef6ef3dc5fd7a01a83d02a6008f133aeb191cdb6c60998ca36cf2bc38e032c62703.jpg'),(7,'90a3996110d234c822acc67a5e370d4dc94076a92f6889e7c926571b306bb0a36f43e030c0647d920bbc792b1126cfd3daf12b3ecd79a65abc86cbfd6dfef68d.jpg'),(7,'e277a5aa69de84a48b9691c0095808fcda8eb99f14be069fac1d566658b587cc7d1c4e5494af04902f1afd489a15957d5dd5c30f31ebc94cbc081fb63fdf4587.jpg'),(9,'470d63d248fb0f71a27d9bf7a35f5fa3fcef895293c98c113713e70dca953a67f0e8a79ca2fb371a81eb2c2ff556fbfafb16fa22ba07ae2c072bb8037b86ff4d.jpg'),(9,'4bc99b3a560d3abf6c6e340b32339b23f81aed01805b2144a8e768e7d8e833efc452d3e71ad4b09f59efb7cf25132f568cdde653b6593be45280cbe78c2ee017.jpeg'),(10,'46d86d398b9d299e43240acf14253a752a4c349a5b0d90700d0dbb54316955458d88d177e40730142b428119201614249f6fcf281c71f3bbe93428368f5fe6ab.jpg'),(10,'da7796ca0bd6d9dfaa24f8ab1887bda94306c50905139cc6eb5bfc278f8f611d2b5755ae5e1d2200e8fd93147283a30c47dd9d867abb9282baf5adc4fed73ef7.jpg'),(10,'ec185820964ad83c0554b55f1936c856699070be228c6bd32019634f5326a588a98ca0d6b6c72102057e86ff5b75793164cfc7d3aa86a14b971d235fb0d304fc.jpg');
/*!40000 ALTER TABLE `product_ottomanfile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `discount_price` double NOT NULL,
  `default_sku_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `plain_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description_format` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `popularity` double NOT NULL,
  `times_sold` int(11) NOT NULL,
  `rating` double NOT NULL,
  `view_count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Rebox t-shirt','RBX098',1000,999,'1-RBX098-3-5','<p>Rebox t-shirt in bd</p>','Rebox t-shirt in bd','HTML','ACTIVE',0,0,0,0),(3,'Metalicca Classic T-Shirt','MCT001',600,-1,'3-MCT001','<h3>The Classic One</h3>','The Classic One','HTML','ACTIVE',0,0,0,0),(4,'Test t-shirt','AFDS876',1111,999,'4-AFDS876-4-5','','','HTML','ACTIVE',0,0,0,0),(5,'Test t-shirt','TST745',111,999,'5-TST745-4-5','','','HTML','ACTIVE',0,0,0,0),(6,'Test T-Shirt','TT001',0,0,'6-TT001-3-7','','','HTML','ACTIVE',0,0,0,0),(7,'Rebox T-shirt','RBX0012',0,999,'7-RBX0012-4-5','<p>Rebox T-shirt in bd</p>','Rebox T-shirt in bd','HTML','ACTIVE',0,0,0,0),(9,'Test T-Shirt','TT002',200,0,'9-TT002-4-5','','','HTML','ACTIVE',0,0,0,0),(10,'Apple T-Shirt','APT032',1111,999,'10-APT032-4-5','<p>Apple t-shirt in bangladesh..</p>','Apple t-shirt in bangladesh..','HTML','ACTIVE',0,0,0,0),(11,'AC DC','ACDC001',200,0,'11-ACDC001-2-5','<p>AC AD t-shirt</p>','AC AD t-shirt','HTML','ACTIVE',0,0,0,0),(14,'test Product1','MCT001-1',600,-1,'14-MCT001-1','<h3>The Classic One</h3>','The Classic One','HTML','ACTIVE',0,0,0,0),(15,'test Product-','MCT001-2',600,-1,'15-MCT001-2','<h3>The Classic One</h3>','The Classic One','HTML','ACTIVE',0,0,0,0),(17,'test Product-2','MCT001-2-2',1600,1000,'','<h3>The Classic One25</h3>','The Classic One','HTML','INACTIVE',0,0,0,0),(18,'test Product-4','MCT001-2-4',600,-1,'18-MCT001-2-4','<h3>The Classic One</h3>','The Classic One','HTML','ACTIVE',0,0,0,0),(19,'test Product-5','MCT001-2-5',600,-1,'19-MCT001-2-5','<h3>The Classic One</h3>','The Classic One','HTML','ACTIVE',0,0,0,0),(20,'test Product-6','MCT001-2-6',600,-1,'20-MCT001-2-6','<h3>The Classic One</h3>','The Classic One','HTML','ACTIVE',0,0,0,0);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`role`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ADMIN'),(3,'DISTRIBUTION_MANAGER'),(2,'SHOWROOM_MANAGER'),(4,'SHOWROOM_SALES'),(5,'USER');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `search_indices`
--

DROP TABLE IF EXISTS `search_indices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `search_indices` (
  `product_id` int(11) NOT NULL,
  `lookups` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `attribute_values` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `FK_8DE6F4E14584665A` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `search_indices`
--

LOCK TABLES `search_indices` WRITE;
/*!40000 ALTER TABLE `search_indices` DISABLE KEYS */;
INSERT INTO `search_indices` VALUES (1,'#1#','#3#5#'),(3,'#1#','#'),(4,'#1#','#4#5#'),(5,'#1#','#4#5#'),(6,'#1#','#3#7#4#6#'),(7,'#1#','#4#5#'),(9,'#1#','#4#5#4#6#4#7#'),(10,'#1#','#3#5#3#8#4#5#'),(11,'#1#','#2#2#5#2#6#2#9#'),(14,'#1#','#'),(15,'#1#','#'),(17,'#1#','#10#'),(18,'#1#','#10#'),(19,'#1#','#10#'),(20,'#1#3#4#5#','#');
/*!40000 ALTER TABLE `search_indices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipment_items`
--

DROP TABLE IF EXISTS `shipment_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipment_items` (
  `seq` int(11) NOT NULL,
  `shipment_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `quantity` double NOT NULL,
  `sku_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`shipment_id`,`seq`),
  KEY `IDX_6DD34BE87BE036FC` (`shipment_id`),
  KEY `IDX_6DD34BE879B17AE9` (`sku_code`),
  CONSTRAINT `FK_6DD34BE879B17AE9` FOREIGN KEY (`sku_code`) REFERENCES `skus` (`code`),
  CONSTRAINT `FK_6DD34BE87BE036FC` FOREIGN KEY (`shipment_id`) REFERENCES `shipments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipment_items`
--

LOCK TABLES `shipment_items` WRITE;
/*!40000 ALTER TABLE `shipment_items` DISABLE KEYS */;
INSERT INTO `shipment_items` VALUES (0,'SHP-20210708050820237210-1-1',2,'3-MCT001'),(1,'SHP-20210708050820237210-1-1',2,'9-TT002-4-7'),(0,'SHP-20210708051031535662-1-1',2,'3-MCT001'),(1,'SHP-20210708051031535662-1-1',2,'9-TT002-4-7');
/*!40000 ALTER TABLE `shipment_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipments`
--

DROP TABLE IF EXISTS `shipments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipments` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `source_branch_id` int(11) DEFAULT NULL,
  `destination_branch_id` int(11) DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dispatch_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `receive_date` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_code` (`id`),
  KEY `IDX_94699AD4B4485F87` (`source_branch_id`),
  KEY `IDX_94699AD48D567CB3` (`destination_branch_id`),
  CONSTRAINT `FK_94699AD48D567CB3` FOREIGN KEY (`destination_branch_id`) REFERENCES `branches` (`id`),
  CONSTRAINT `FK_94699AD4B4485F87` FOREIGN KEY (`source_branch_id`) REFERENCES `branches` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipments`
--

LOCK TABLES `shipments` WRITE;
/*!40000 ALTER TABLE `shipments` DISABLE KEYS */;
INSERT INTO `shipments` VALUES ('SHP-20210708050820237210-1-1',1,1,'FACTORY_DISTRIBUTION','DISPATCHED','2021-07-08 17:08:20',NULL),('SHP-20210708051031535662-1-1',1,1,'FACTORY_DISTRIBUTION','DISPATCHED','2021-07-08 17:10:31',NULL);
/*!40000 ALTER TABLE `shipments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sku_attribute_values`
--

DROP TABLE IF EXISTS `sku_attribute_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sku_attribute_values` (
  `sku_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `attribute_value_id` int(11) NOT NULL,
  PRIMARY KEY (`sku_code`,`attribute_value_id`),
  KEY `IDX_FB3F9F7579B17AE9` (`sku_code`),
  KEY `IDX_FB3F9F7565A22152` (`attribute_value_id`),
  CONSTRAINT `FK_FB3F9F7565A22152` FOREIGN KEY (`attribute_value_id`) REFERENCES `item_attribute_values` (`id`),
  CONSTRAINT `FK_FB3F9F7579B17AE9` FOREIGN KEY (`sku_code`) REFERENCES `skus` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sku_attribute_values`
--

LOCK TABLES `sku_attribute_values` WRITE;
/*!40000 ALTER TABLE `sku_attribute_values` DISABLE KEYS */;
INSERT INTO `sku_attribute_values` VALUES ('11-ACDC001-2',2),('11-ACDC001-2-5',2),('11-ACDC001-2-6',2),('11-ACDC001-2-9',2),('1-RBX098-3-5',3),('10-APT032-3-5',3),('10-APT032-3-8',3),('6-TT001-3-7',3),('10-APT032-4-5',4),('4-AFDS876-4-5',4),('5-TST745-4-5',4),('6-TT001-4-6',4),('7-RBX0012-4-5',4),('9-TT002-4-5',4),('9-TT002-4-6',4),('9-TT002-4-7',4),('1-RBX098-3-5',5),('10-APT032-3-5',5),('10-APT032-4-5',5),('11-ACDC001-2-5',5),('4-AFDS876-4-5',5),('5-TST745-4-5',5),('7-RBX0012-4-5',5),('9-TT002-4-5',5),('11-ACDC001-2-6',6),('6-TT001-4-6',6),('9-TT002-4-6',6),('6-TT001-3-7',7),('9-TT002-4-7',7),('10-APT032-3-8',8),('11-ACDC001-2-9',9),('17-MCT001-2-2-10',10),('18-MCT001-2-4-10',10),('19-MCT001-2-5-10',10);
/*!40000 ALTER TABLE `sku_attribute_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skus`
--

DROP TABLE IF EXISTS `skus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `skus` (
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `price` double NOT NULL,
  `discountPrice` double NOT NULL,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lapse` tinyint(1) NOT NULL,
  PRIMARY KEY (`code`),
  UNIQUE KEY `unique_code` (`code`),
  KEY `IDX_8708599A4584665A` (`product_id`),
  CONSTRAINT `FK_8708599A4584665A` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skus`
--

LOCK TABLES `skus` WRITE;
/*!40000 ALTER TABLE `skus` DISABLE KEYS */;
INSERT INTO `skus` VALUES ('1-RBX098-3-5',1,1000,999,'Blue,Small',1),('10-APT032-3-5',10,880,700,'Blue,Small',0),('10-APT032-3-8',10,999,900,'Blue,XXL',0),('10-APT032-4-5',10,1111,999,'Black,Small',1),('11-ACDC001-2',11,400,0,'Red',0),('11-ACDC001-2-5',11,200,0,'Red,Small',1),('11-ACDC001-2-6',11,300,0,'Red,L',0),('11-ACDC001-2-9',11,500,0,'Red,M',0),('14-MCT001-1',14,600,-1,'',1),('15-MCT001-2',15,600,-1,'',1),('17-MCT001-2-2',17,600,-1,'',1),('17-MCT001-2-2-10',17,600,0,'text-value-6',0),('18-MCT001-2-4',18,600,-1,'',1),('18-MCT001-2-4-10',18,600,0,'text-value-6',0),('19-MCT001-2-5',19,600,-1,'',1),('19-MCT001-2-5-10',19,600,0,'text-value-6',0),('20-MCT001-2-6',20,600,-1,'',1),('3-MCT001',3,600,-1,'',1),('4-AFDS876-4-5',4,1111,999,'Black,Small',1),('5-TST745-4-5',5,111,999,'Black,Small',1),('6-TT001-3-7',6,0,0,'Blue,XL',1),('6-TT001-4-6',6,0,0,'Black,L',0),('7-RBX0012-4-5',7,0,999,'Black,Small',1),('9-TT002-4-5',9,200,0,'Black,Small',1),('9-TT002-4-6',9,400,0,'Black,L',0),('9-TT002-4-7',9,800,0,'Black,XL',0);
/*!40000 ALTER TABLE `skus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocks`
--

DROP TABLE IF EXISTS `stocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stocks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sku_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `branch_id` int(11) DEFAULT NULL,
  `total` int(11) NOT NULL,
  `damaged` int(11) NOT NULL,
  `on_hold` int(11) NOT NULL,
  `sales_booked` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_sku_branch` (`sku_code`,`branch_id`),
  KEY `IDX_56F79805DCD6CC49` (`branch_id`),
  KEY `IDX_56F7980579B17AE9` (`sku_code`),
  CONSTRAINT `FK_56F7980579B17AE9` FOREIGN KEY (`sku_code`) REFERENCES `skus` (`code`),
  CONSTRAINT `FK_56F79805DCD6CC49` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocks`
--

LOCK TABLES `stocks` WRITE;
/*!40000 ALTER TABLE `stocks` DISABLE KEYS */;
INSERT INTO `stocks` VALUES (1,'3-MCT001',1,79,0,0,0),(2,'9-TT002-4-7',1,32,0,0,0),(3,'9-TT002-4-7',2,96,0,0,0),(4,'1-RBX098-3-5',1,45,30,15,25),(5,'7-RBX0012-4-5',1,32,35,10,10),(6,'3-MCT001',2,26,0,0,0),(7,'10-APT032-3-5',1,26,0,0,0),(8,'10-APT032-3-8',1,18,0,0,0),(9,'10-APT032-3-5',2,32,0,0,0),(10,'1-RBX098-3-5',2,14,0,0,0);
/*!40000 ALTER TABLE `stocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocks_v2`
--

DROP TABLE IF EXISTS `stocks_v2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stocks_v2` (
  `sku_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `branch_id` int(11) NOT NULL,
  `total` int(11) NOT NULL,
  `damaged` int(11) NOT NULL,
  `on_hold` int(11) NOT NULL,
  `sales_booked` int(11) NOT NULL,
  PRIMARY KEY (`sku_code`,`branch_id`),
  UNIQUE KEY `unique_sku_branch` (`sku_code`,`branch_id`),
  KEY `IDX_B5999A7F79B17AE9` (`sku_code`),
  KEY `IDX_B5999A7FDCD6CC49` (`branch_id`),
  CONSTRAINT `FK_B5999A7F79B17AE9` FOREIGN KEY (`sku_code`) REFERENCES `skus` (`code`),
  CONSTRAINT `FK_B5999A7FDCD6CC49` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocks_v2`
--

LOCK TABLES `stocks_v2` WRITE;
/*!40000 ALTER TABLE `stocks_v2` DISABLE KEYS */;
INSERT INTO `stocks_v2` VALUES ('1-RBX098-3-5',1,100,0,0,0),('1-RBX098-3-5',6,14,0,0,0),('10-APT032-3-5',1,1,0,0,0),('10-APT032-3-5',2,1,0,0,0),('3-MCT001',1,20,0,0,0),('3-MCT001',6,20,0,0,0),('9-TT002-4-7',2,12,26,13,13);
/*!40000 ALTER TABLE `stocks_v2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_branch`
--

DROP TABLE IF EXISTS `user_branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_branch` (
  `user_id` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`branch_id`),
  KEY `IDX_DED40022A76ED395` (`user_id`),
  KEY `IDX_DED40022DCD6CC49` (`branch_id`),
  CONSTRAINT `FK_DED40022A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_DED40022DCD6CC49` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_branch`
--

LOCK TABLES `user_branch` WRITE;
/*!40000 ALTER TABLE `user_branch` DISABLE KEYS */;
INSERT INTO `user_branch` VALUES (2,1),(3,2),(4,2),(5,2),(7,1),(8,2),(10,1),(10,2),(10,6),(12,2),(13,6),(14,1),(15,1);
/*!40000 ALTER TABLE `user_branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `IDX_2DE8C6A3A76ED395` (`user_id`),
  KEY `IDX_2DE8C6A3D60322AC` (`role_id`),
  CONSTRAINT `FK_2DE8C6A3A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_2DE8C6A3D60322AC` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (1,1),(2,2),(4,2),(5,2),(8,2),(10,3),(12,4),(13,4),(14,3),(15,3);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_tokens`
--

DROP TABLE IF EXISTS `user_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `user_token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tokens`
--

LOCK TABLES `user_tokens` WRITE;
/*!40000 ALTER TABLE `user_tokens` DISABLE KEYS */;
INSERT INTO `user_tokens` VALUES (1,1,'9eeedab303ed2768958bffaed7fe3c84','2021-07-04 08:05:29'),(2,1,'451579ec95cf3e8e6f9c10ef3d4566cd','2021-07-04 09:04:33'),(3,1,'de7b0e30e0f58eea99af449475128337','2021-07-04 09:09:36'),(4,1,'2e6fdda7e496027f87000cfc6e5ae399','2021-07-04 09:38:46'),(5,1,'c7b3254b6fabc71f0719d7be6a1beea0','2021-07-04 11:51:56'),(6,1,'6a98318b5cca4db6bd85d22abf4695e3','2021-07-05 05:45:46'),(7,2,'7333162f6b33a8a24ba93ec81bf6ae11','2021-07-05 06:35:25'),(8,2,'170eb5a0bc1c7870a98ba81bf5a38ac1','2021-07-05 06:42:06'),(9,2,'ec3beec5d3f5f3fcc6848fdb2189e419','2021-07-05 06:42:42'),(10,2,'bf401ff8754139282ac29076453d5940','2021-07-05 06:45:16'),(11,1,'c284523e9314455fba18229391b240d9','2021-07-05 06:49:33'),(12,2,'f959d2874aae5f8fab5085bdab5aa15d','2021-07-05 06:50:20'),(13,1,'a6826bafcdd34001e15739aca1e8d178','2021-07-05 11:04:40'),(14,3,'9a71d536cc92cb2f4e6892509d06c0fa','2021-07-05 12:28:34'),(15,3,'25b4e52eea8d73f0e5dbb4c9af500361','2021-07-05 12:32:44'),(16,3,'6cd690edabe34bfad2802b9af0b532c1','2021-07-05 12:33:53'),(17,1,'467ce142d71cb3dad3f7d63c610a879e','2021-07-05 12:35:57'),(18,3,'e9b36acde6753ea8097691f0c8b4a6f1','2021-07-05 12:37:31'),(19,1,'22c54a43d434863927b22b2e69efccec','2021-07-05 12:37:40'),(20,1,'d3dc69e57cece05baf0de2f64e5edb42','2021-07-05 12:37:47'),(21,3,'7a14656d4365ba645a279186aa9c6b63','2021-07-05 12:38:55'),(22,7,'c6561e62e3fd143358c9b7f876d9239b','2021-07-05 12:49:45'),(23,4,'6a756d9d4ca9f49cdb9bc253147d5af6','2021-07-05 13:12:42'),(24,2,'a355b9c6e36f3f1f2e9b540217822b3f','2021-07-05 13:29:10'),(25,8,'969e89f2ea8ad8f8ba88bd98a95568b5','2021-07-05 13:40:01'),(26,1,'14c444a088307fadc8a4758e40ace500','2021-07-06 06:24:52'),(27,10,'760865802ca5fd81888c393d77da007d','2021-07-06 06:33:55'),(28,10,'a4d59743e0e5699781d94e0fc01628df','2021-07-06 08:00:36'),(29,2,'292f5d4099e71096d3d7da1a857988c7','2021-07-06 08:27:46'),(30,1,'dc9ca90ba1d4a3e2aa9a50db9bc972f1','2021-07-06 11:24:14'),(31,10,'09f87c9855f690a1b7b66250bdd4ffbb','2021-07-06 12:16:40'),(32,10,'15d461c1253e21e4db60437292b09853','2021-07-07 06:27:01'),(33,1,'2c5a46cbcd7a701474d2bb6655e65d32','2021-07-07 07:51:00'),(34,2,'12dfdc2aeca0fecc091a66effc8695b0','2021-07-07 08:43:05'),(35,10,'581bdd9508428fa75bc344ceb53e3203','2021-07-07 10:26:33'),(36,10,'21b7a496dcbf6fcf65525ae8f664424f','2021-07-07 10:27:09'),(37,1,'32192de9fa7ed5b3e5336498c092ece8','2021-07-07 10:57:52'),(38,2,'909ef53d655d4c143802987c91a3842b','2021-07-07 10:58:11'),(39,2,'9db19aab742a363dddab781d68588ba2','2021-07-07 10:58:12'),(40,11,'e6e9dc565d6a14a62f7af42b2ef4b619','2021-07-07 11:06:33'),(41,2,'b7efdf3477e9477daab72075682eb109','2021-07-07 12:40:25'),(42,1,'5d2d41b34fbf694175bfb5e46b266117','2021-07-07 13:50:32'),(43,1,'f543a499ab806f769c1a56732cc9c11b','2021-07-07 13:54:10'),(44,1,'11b0198c7ed519b7c45060c69a7d05ad','2021-07-07 13:58:32'),(45,2,'84277c9c74719289cc16186a6083fc60','2021-07-07 14:17:01'),(46,2,'3924c84df093fd8fc49d1ae9e976d99f','2021-07-08 06:03:40'),(47,1,'7059ea68dd727fae023dfff4bfe9fcbd','2021-07-08 06:12:29'),(48,1,'147a9364f00b028003a03e68850e7328','2021-07-08 06:17:42'),(49,1,'2eee10bf386724322f88d43dac9afa01','2021-07-08 07:41:20'),(50,1,'565d4654dd5b2719ea08f1c6ab3f0143','2021-07-08 10:41:00'),(51,2,'fa454772e78aaff699f21e5e32a370bd','2021-07-08 11:01:20'),(52,2,'57b65c7d67185203d35e53e13351d0f4','2021-07-08 11:01:21'),(53,1,'d550f780d6e920dc6dc995a2afb302dd','2021-07-08 12:38:41'),(54,1,'c3b8bed5a6c41036e52a991dcd9062e5','2021-07-08 13:00:10'),(55,1,'fc053d900900df8b6a8097035a1720ab','2021-07-08 13:02:34'),(56,1,'148dbfec93914709bad089d66af7ae33','2021-07-08 13:09:27'),(57,13,'fbdb37c6508d32d3b6f98db2c7d88427','2021-07-08 14:30:05'),(58,13,'720d51f68b4fcdefa5fe65f816d5c3a9','2021-07-08 14:30:32'),(59,13,'f46226877d5e893f9522360a2b8dda20','2021-07-08 14:30:53'),(60,2,'d89c8f3b61458ec522dca2f748e2f716','2021-07-08 14:31:50'),(61,1,'883d3402889cfc4c734ae606874a7b0f','2021-07-08 14:32:04'),(62,2,'3bf9f49a202ae9aa46c205a0453f025a','2021-07-08 14:33:29'),(63,1,'4c34f3feb43b47dfc0ee0dde645cd402','2021-07-08 14:33:38'),(64,1,'21fd70962e93554690528af62924ff2f','2021-07-08 14:36:14'),(65,1,'f71fcf6f6bc66df809bd162f02e87cde','2021-07-08 14:37:27'),(66,10,'b000382df2f7253c79aa2a31440c1ab9','2021-07-08 14:51:57'),(67,1,'76cb372fc3b14af7f7b80c7a9eec447b','2021-07-08 14:55:24'),(68,14,'33a1fe21b19ebe7b528ace6d4011cb87','2021-07-08 14:56:03'),(69,1,'30d826b022d2057cc6d3f0429da168cc','2021-07-10 05:44:25'),(70,1,'021a94369a1e8480c27d207cdc8b29d0','2021-07-10 06:05:22'),(71,13,'24d5351b73e54a31c0243c4b623a7d7e','2021-07-10 06:09:57'),(72,1,'41e812902c07ae98a060c4a4505f7e20','2021-07-10 06:21:06'),(73,13,'978b8092d87b1f1de5e47466794317c0','2021-07-10 06:23:11'),(74,1,'1cfb41779a420827d711d839748bc923','2021-07-10 06:30:45'),(75,1,'80356de20353cea2ac620ca78255edc0','2021-07-10 06:38:22'),(76,2,'e303de7150dd7eb3a9dc7d6f16a0ecc8','2021-07-10 12:51:23'),(77,1,'c149932d5940f1894f91a65bb302ca3a','2021-07-10 12:51:51'),(78,15,'dabb4a80a30ced451b7d9cfed665a9ba','2021-07-10 12:53:20'),(79,1,'69a2a809b0db3b7e37c0c2781a8b69dd','2021-07-10 13:02:29'),(80,1,'ec6f9be928b0771cfc9a72f1d5d738f7','2021-07-10 13:07:57');
/*!40000 ALTER TABLE `user_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `full_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `contact_no` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','ADMIN','admin@hmt.com','$2y$12$RTFQvoJXbOGBAtVBPUq4.O8DU73C7j8Wd.kT3AtuHvEQ/bvmY.Kky','ACTIVE','1'),(2,'manager.u','Manager U','manager.u@gmail.com','$2y$12$q.l3s5RDy679QX2bfRQ3GurTGBaH87CL7ktFdon0c7begD0CcEBSS','ACTIVE','01712345634'),(4,'manager.mpur','Manager Mohmmadpur','manager.mpur@gmail.com','$2y$12$uxj6Mc9pSmAN/jdfWxutteBICB8O9ChZZ1BWJ19lght/XkOyRybxK','ACTIVE','01312345678'),(5,'dulal','Dulsal Hossin DH','dh@gmail.com','$2y$12$In2h/lBIAOCsNuajWtyOGeXIU7bUIHVsTeKZtdqrWVpnhlVWXU4C2','ACTIVE','1'),(8,'dulal1','Dulsal Hossin DH','dh@gmail.com','$2y$12$X2h0whTee2PJ8eL1SFbWrOw/COJPd2tp77jfHOXCz89c/cUg/6g6q','ACTIVE','1'),(10,'somrat-ui','somrat Hossen','somrat@gmail.com','$2y$12$CNcguxlZ1x3gS7jhGOIPmO2YGn708AnzLxOziGzfNFoGMMb8LHaoS','ACTIVE','125'),(12,'dh.dulal','DH-dulal','dh.dulal@gmail.com','$2y$12$t7cRlWY05COeKwZHa5lo9.0HLTqvHRtLH3wzrnmeFbnRFmOFYPuwy','ACTIVE','01712345678'),(13,'tintin.sales','tintin','tintin.sales@gmail.com','$2y$12$yzgQCG8RSh7EXtHvWxKy.uwsWEOB2RwwNitwDlgia37ZbCj.BFHoq','ACTIVE','3298634'),(14,'somrat-x','somrat Hossen','somrat@gmail.com','$2y$12$V3HEEXc8yE9a9kxoFH5WIeqPF0AHTeYe1rJhOjcr7I4TTWdAwPV2W','ACTIVE','1'),(15,'manager.d.u','manager D U','manager.d.u@gmail.com','$2y$12$9v3Dg9Hh1vVi61ok0FhPzuWmLg86yDTbZNIrhZWRKiAJqBVWT0GuW','ACTIVE','123421356');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-10 20:00:04
