-- MySQL dump 10.13  Distrib 5.7.33, for Linux (x86_64)
--
-- Host: localhost    Database: ottoman_db
-- ------------------------------------------------------
-- Server version	5.7.33

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES (1,'Uttara','Uttara, Dhaka','','SHOWROOM'),(2,'Central Factory','Uttara','HeavyMetal','FACTORY'),(3,'Rajshahi','Shaheb Bazar','','SHOWROOM');
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
/*!40000 ALTER TABLE `configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `contact_no` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
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
  CONSTRAINT `FK_A43C74E9395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE,
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
INSERT INTO `invoice_items` VALUES (0,'20210707023239473496-1-3','18-CP001-2-7',400,3,1200,'Coldplay-Black,XL','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(1,'20210707023239473496-1-3','20-D004-2-7',400,7,2800,'Death 04-Black,XL','a328e64e8aa9a75788ce62f396c9508b8394e9041819d253ee99015a83ac0778e2aeff11b32ec3a443a08004eb1f930c0478bc78ca123045c287cab9d0abfa8f.jpg'),(2,'20210707023239473496-1-3','19-CF001-2-6',350,5,1750,'Cryptic Fate-Black,L','0d74cde5f4f7e2b552f6f00a28475be3817f4047d6acadec00bf881d0511d26dee5738ed432cf9be48e0423156920ceea2e5880f242bb5ef4dab243fbf242b59.jpg'),(0,'20210707035648256846-4-3','9-ARTCL001-2-4',350,1,350,'Artcell Red-Black,S','7ecfaa8ed80d8d1d18832412e2265051756d9db91ad7e6bd6d2ad8d56687809481b0075cb6d678d3434a2ecfd7ef2259ca3afee750a1e0031cc55f0b629f7c49.jpg'),(1,'20210707035648256846-4-3','8-ARV001-3-10',600,4,2400,'Arbo-01-Green,4XL','7640f2fd2c849bfd0ea280eb8700d82626f09cfedb585ef5c2bce9ff196f5d50a2879869b4d4221c81c977fbd690e1f25e2c5b8976f0c5c57f12831c55f1a3ae.jpg'),(0,'20210707035925124418-4-3','8-ARV001-3-10',600,2,1200,'Arbo-01-Green,4XL','7640f2fd2c849bfd0ea280eb8700d82626f09cfedb585ef5c2bce9ff196f5d50a2879869b4d4221c81c977fbd690e1f25e2c5b8976f0c5c57f12831c55f1a3ae.jpg'),(1,'20210707035925124418-4-3','9-ARTCL001-2-4',350,6,2100,'Artcell Red-Black,S','7ecfaa8ed80d8d1d18832412e2265051756d9db91ad7e6bd6d2ad8d56687809481b0075cb6d678d3434a2ecfd7ef2259ca3afee750a1e0031cc55f0b629f7c49.jpg'),(2,'20210707035925124418-4-3','21-DT003-2-10',600,6,3600,'Dream Theater 03-Black,4XL','80b041875934bfa734302f2e7ec59149991fa17f555853611e96014827a0c0044116b4552b697d2d2c5eb76a66f1be7ebe5101a3a2d0eeaedea8945370b2f8bd.jpg'),(0,'20210707064053399923-1-3','7-ALR003-2-6',400,5,2000,'Alter Bridge 03-Black,L','e2597b6ccdf060723fe1724649f6efe944713a236e014e63775ee50833b16effd7297da7687832f45e1319440c3ad72c6b1f75b6c0f5659543e61e47b34273c5.jpg'),(0,'20210708034439551311-4-3','18-CP001-2-4',400,3,1200,'Coldplay-Black,S','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(1,'20210708034439551311-4-3','18-CP001-2-6',400,2,800,'Coldplay-Black,L','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(2,'20210708034439551311-4-3','18-CP001-2-5',400,2,800,'Coldplay-Black,M','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(3,'20210708034439551311-4-3','18-CP001-2-7',400,1,400,'Coldplay-Black,XL','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(0,'20210708034720461057-4-3','21-DT003-2-10',600,2,1200,'Dream Theater 03-Black,4XL','80b041875934bfa734302f2e7ec59149991fa17f555853611e96014827a0c0044116b4552b697d2d2c5eb76a66f1be7ebe5101a3a2d0eeaedea8945370b2f8bd.jpg'),(1,'20210708034720461057-4-3','17-COB002-2-5',400,2,800,'Children Of Bodom 02-Black,M','00b317f394b44f212c858b83e2624e1c7b37a5cb4ac0100512c9aa564a2ca647f6d4035f39dd3eea98edc6a3e3b6b68b9e9b856eb1f5a3fa040ed1e0ef31f97d.jpg'),(0,'20210708035418219475-4-3','18-CP001-2-10',600,3,1800,'Coldplay-Black,4XL','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(1,'20210708035418219475-4-3','18-CP001-2-4',400,1,400,'Coldplay-Black,S','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(2,'20210708035418219475-4-3','18-CP001-2-5',400,1,400,'Coldplay-Black,M','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(0,'20210708041619487818-4-3','18-CP001-2-9',600,5,3000,'Coldplay-Black,3XL','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(0,'20210708041717505036-4-3','18-CP001-2-7',400,2,800,'Coldplay-Black,XL','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(1,'20210708041717505036-4-3','18-CP001-2-9',600,2,1200,'Coldplay-Black,3XL','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(0,'20210708041931925853-4-3','1-ABB001-2-10',600,2,1200,'Abbath-Black,4XL','2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg'),(1,'20210708041931925853-4-3','1-ABB001-2-4',400,2,800,'Abbath-Black,S','2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg'),(0,'20210708043859299420-2-1','18-CP001-2-10',600,1,600,'Coldplay-Black,4XL','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(1,'20210708043859299420-2-1','18-CP001-2-4',400,1,400,'Coldplay-Black,S','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(0,'49JUQRX6HGAOO-4-3','1-ABB001-2-10',600,2,1200,'Abbath-Black,4XL','2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg'),(1,'49JUQRX6HGAOO-4-3','1-ABB001-2-4',400,2,800,'Abbath-Black,S','2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg'),(0,'49JUQS068HKWK-4-3','1-ABB001-2-10',600,2,1200,'Abbath-Black,4XL','2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg'),(1,'49JUQS068HKWK-4-3','13-BS005-2-9',600,3,1800,'Black Sabbath 05-Black,3XL','3ca5cc78ca0139dd2d1b2827de831202a25a35a85994887d9517bd6af4dd490d656db44cde308c880138297680c2e14bc03fdf89021854712dc34bb10e3ed32e.jpg'),(0,'49JUQS07N9YCK-4-3','1-ABB001-2-10',600,1,600,'Abbath-Black,4XL','2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg'),(1,'49JUQS07N9YCK-4-3','1-ABB001-2-4',400,1,400,'Abbath-Black,S','2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg'),(0,'49JUQS0H2LYCS-4-3','1-ABB001-2-10',600,2,1200,'Abbath-Black,4XL','2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg'),(0,'49JUQS1J4JS40-4-3','1-ABB001-2-10',600,2,1200,'Abbath-Black,4XL','2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg'),(0,'49JUQS1KSZUOS-4-3','1-ABB001-2-10',600,1,600,'Abbath-Black,4XL','2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg'),(0,'49JUQS1MG6YOC-4-3','1-ABB001-2-4',400,4,1600,'Abbath-Black,S','2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg'),(0,'49JUQS1VAIW4K-4-3','18-CP001-2-10',600,4,2400,'Coldplay-Black,4XL','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(1,'49JUQS1VAIW4K-4-3','18-CP001-2-4',400,6,2400,'Coldplay-Black,S','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(2,'49JUQS1VAIW4K-4-3','18-CP001-2-5',400,7,2800,'Coldplay-Black,M','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(3,'49JUQS1VAIW4K-4-3','18-CP001-2-6',400,3,1200,'Coldplay-Black,L','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(4,'49JUQS1VAIW4K-4-3','18-CP001-2-7',400,3,1200,'Coldplay-Black,XL','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(5,'49JUQS1VAIW4K-4-3','18-CP001-2-8',400,2,800,'Coldplay-Black,XXL','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(6,'49JUQS1VAIW4K-4-3','18-CP001-2-9',600,3,1800,'Coldplay-Black,3XL','c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg');
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
  `total` double NOT NULL,
  `grand_total` double NOT NULL,
  `discount` double NOT NULL,
  `discount_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `delivery_status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `net_total` double NOT NULL,
  `vat_percentage` double NOT NULL,
  `vat_amount` double NOT NULL,
  `date` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_code` (`id`),
  KEY `IDX_6A2F2F95727ACA70` (`parent_id`),
  KEY `IDX_6A2F2F959395C3F3` (`customer_id`),
  KEY `IDX_6A2F2F957D182D95` (`created_by_user_id`),
  KEY `IDX_6A2F2F95DCD6CC49` (`branch_id`),
  CONSTRAINT `FK_6A2F2F95727ACA70` FOREIGN KEY (`parent_id`) REFERENCES `invoices` (`id`),
  CONSTRAINT `FK_6A2F2F957D182D95` FOREIGN KEY (`created_by_user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_6A2F2F959395C3F3` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`),
  CONSTRAINT `FK_6A2F2F95DCD6CC49` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES ('20210707023239473496-1-3',1,NULL,NULL,3,'SALES','SALES','POS',5750,5952,10,'PERCENTAGE','2021-07-07 14:32:39','RECEIVED','COMPLETE',5175,15,777,''),('20210707035648256846-4-3',4,NULL,NULL,3,'SALES','SALES','POS',2750,1375,50,'PERCENTAGE','2021-07-07 15:56:48','RECEIVED','COMPLETE',1375,0,0,''),('20210707035925124418-4-3',4,NULL,NULL,3,'SALES','SALES','POS',6900,0,100,'PERCENTAGE','2021-07-07 15:59:25','RECEIVED','COMPLETE',0,15,0,''),('20210707064053399923-1-3',1,NULL,NULL,3,'SALES','SALES','POS',2000,1000,50,'PERCENTAGE','2021-07-07 18:40:53','RECEIVED','COMPLETE',1000,0,0,''),('20210708034439551311-4-3',4,NULL,NULL,3,'SALES','SALES','POS',3200,3200,0,'FIXED','2021-07-08 15:44:39','RECEIVED','COMPLETE',3200,0,0,''),('20210708034720461057-4-3',4,NULL,NULL,3,'SALES','SALES','POS',2000,1040,50,'PERCENTAGE','2021-07-08 15:47:20','RECEIVED','COMPLETE',1000,4,40,''),('20210708035418219475-4-3',4,NULL,NULL,3,'SALES','SALES','POS',2600,2600,0,'FIXED','2021-07-08 15:54:18','RECEIVED','COMPLETE',2600,0,0,''),('20210708041619487818-4-3',4,NULL,NULL,3,'SALES','SALES','POS',3000,3000,0,'FIXED','2021-07-08 16:16:19','RECEIVED','COMPLETE',3000,0,0,''),('20210708041717505036-4-3',4,NULL,NULL,3,'SALES','SALES','POS',2000,2000,0,'FIXED','2021-07-08 16:17:17','RECEIVED','COMPLETE',2000,0,0,''),('20210708041931925853-4-3',4,NULL,NULL,3,'SALES','SALES','POS',2000,2000,0,'FIXED','2021-07-08 16:19:31','RECEIVED','COMPLETE',2000,0,0,''),('20210708043859299420-2-1',2,NULL,NULL,1,'SALES','SALES','POS',1000,1000,0,'FIXED','2021-07-08 16:38:59','RECEIVED','COMPLETE',1000,0,0,''),('49JUQRX6HGAOO-4-3',4,NULL,NULL,3,'SALES','SALES','POS',2000,1500,500,'FIXED','2021-07-10 15:38:44','RECEIVED','COMPLETE',1500,0,0,'2021-07-10'),('49JUQS068HKWK-4-3',4,NULL,NULL,3,'SALES','SALES','POS',3000,1500,50,'PERCENTAGE','2021-07-10 16:03:59','RECEIVED','COMPLETE',1500,0,0,'2021-07-10'),('49JUQS07N9YCK-4-3',4,NULL,NULL,3,'SALES','SALES','POS',1000,1000,0,'FIXED','2021-07-10 16:04:44','RECEIVED','COMPLETE',1000,0,0,'2021-07-10'),('49JUQS0H2LYCS-4-3',4,NULL,NULL,3,'SALES','SALES','POS',1200,1200,0,'FIXED','2021-07-10 16:10:14','RECEIVED','COMPLETE',1200,0,0,'2021-07-10'),('49JUQS1J4JS40-4-3',4,NULL,NULL,3,'SALES','SALES','POS',1200,1200,0,'FIXED','2021-07-10 16:33:15','RECEIVED','COMPLETE',1200,0,0,'2021-07-10'),('49JUQS1KSZUOS-4-3',4,NULL,NULL,3,'SALES','SALES','POS',600,600,0,'FIXED','2021-07-10 16:34:17','RECEIVED','COMPLETE',600,0,0,'2021-07-10'),('49JUQS1MG6YOC-4-3',4,NULL,NULL,3,'SALES','SALES','POS',1600,1600,0,'FIXED','2021-07-10 16:35:16','RECEIVED','COMPLETE',1600,0,0,'2021-07-10'),('49JUQS1VAIW4K-4-3',4,NULL,NULL,3,'SALES','SALES','POS',12600,12600,0,'FIXED','2021-07-10 16:40:51','RECEIVED','COMPLETE',12600,0,0,'2021-07-10');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_attribute_values`
--

LOCK TABLES `item_attribute_values` WRITE;
/*!40000 ALTER TABLE `item_attribute_values` DISABLE KEYS */;
INSERT INTO `item_attribute_values` VALUES (1,2,'Red',''),(2,2,'Black',''),(3,2,'Green',''),(4,1,'S','S'),(5,1,'M','M'),(6,1,'L','L'),(7,1,'XL','XL'),(8,1,'XXL','XXL'),(9,1,'3XL','3XL'),(10,1,'4XL','4XL'),(11,2,'Yellow',''),(12,2,'Blue',''),(16,2,'White','');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_attributes`
--

LOCK TABLES `item_attributes` WRITE;
/*!40000 ALTER TABLE `item_attributes` DISABLE KEYS */;
INSERT INTO `item_attributes` VALUES (1,'Size',1),(2,'Color',1),(5,'test-attribute-2',0);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lookups`
--

LOCK TABLES `lookups` WRITE;
/*!40000 ALTER TABLE `lookups` DISABLE KEYS */;
INSERT INTO `lookups` VALUES (1,NULL,'brand','Heavy Metal T-Shirt','',0,'ACTIVE'),(2,NULL,'band','Abbath','',0,'ACTIVE'),(3,NULL,'band','Aborted','',0,'ACTIVE'),(4,NULL,'band','About Dark','',0,'ACTIVE'),(5,NULL,'band','Ac Dc','',0,'INACTIVE'),(6,NULL,'band','AC DC','',0,'ACTIVE'),(7,NULL,'band','Adverb','',0,'ACTIVE'),(8,NULL,'band','August Burns Red','',0,'ACTIVE'),(9,NULL,'band','Alice In Chains','',0,'ACTIVE'),(10,NULL,'band','Alter Bridge','',0,'ACTIVE'),(11,NULL,'band','Amon Amarth','',0,'ACTIVE'),(12,NULL,'band','Anthrax','',0,'ACTIVE'),(13,NULL,'band','Apekkhik','',0,'ACTIVE'),(14,NULL,'brand','Riot','',0,'ACTIVE'),(15,NULL,'band','Arbovirus','',0,'ACTIVE'),(16,NULL,'band','Arch Enemy','',0,'ACTIVE'),(17,NULL,'band','Arctic Moneky','',0,'ACTIVE'),(18,NULL,'band','Arekta Rock Band','',0,'ACTIVE'),(19,NULL,'band','Artcell','',0,'ACTIVE'),(20,NULL,'band','As I Lay Dying','',0,'ACTIVE'),(21,NULL,'band','Asking Alexandria','',0,'ACTIVE'),(22,NULL,'band','Audioslave','',0,'ACTIVE'),(23,NULL,'band','Avenged Sevenfold','',0,'ACTIVE'),(24,NULL,'band','Avash','',0,'ACTIVE'),(25,NULL,'band','Bangla Five','',0,'ACTIVE'),(26,NULL,'band','Behemoth','',0,'ACTIVE'),(27,NULL,'band','Black ','',0,'ACTIVE'),(28,NULL,'band','Black Dhalia Murder ','',0,'ACTIVE'),(29,NULL,'band','Black Sabbath','',0,'ACTIVE'),(30,NULL,'band','Bleeding For Survival','',0,'ACTIVE'),(31,NULL,'band','Blind Guardian','',0,'ACTIVE'),(32,NULL,'band','Bon Jovi','',0,'ACTIVE'),(33,NULL,'band','Brake Van','',0,'ACTIVE'),(34,NULL,'band','Breaking Benjamin','',0,'ACTIVE'),(35,NULL,'band','Bullet For My Valentine','',0,'ACTIVE'),(36,NULL,'band','Burzum','',0,'ACTIVE'),(37,NULL,'band','Cannibal Crops','',0,'ACTIVE'),(38,NULL,'band','Carnifex','',0,'ACTIVE'),(39,NULL,'band','Children Of Bodom','',0,'ACTIVE'),(40,NULL,'band','Chronic Xorn','',0,'ACTIVE'),(41,NULL,'band','Cigarettes After Sex','',0,'ACTIVE'),(42,NULL,'band','Coldplay','',0,'ACTIVE'),(43,NULL,'band','Conclution','',0,'ACTIVE'),(44,NULL,'band','Cotton In My Brain','',0,'ACTIVE'),(45,NULL,'band','Cradle Of Filth','',0,'ACTIVE'),(46,NULL,'band','Creed','',0,'ACTIVE'),(47,NULL,'band','Crunch','',0,'ACTIVE'),(48,NULL,'band','Cryptic Fate','',0,'ACTIVE'),(49,NULL,'band','Daknam','',0,'ACTIVE'),(50,NULL,'band','Dean Guiters','',0,'ACTIVE'),(51,NULL,'band','Death','',0,'ACTIVE'),(52,NULL,'band','Deep Purple','',0,'ACTIVE'),(53,NULL,'band','Def Leppard','',0,'ACTIVE'),(54,NULL,'band','Decide','',0,'ACTIVE'),(55,NULL,'band','Demonic Assault','',0,'ACTIVE'),(56,NULL,'band','Demonic Obidient','',0,'ACTIVE'),(57,NULL,'band','Destruction','',0,'ACTIVE'),(58,NULL,'band','Dimmo Borgir','',0,'ACTIVE'),(59,NULL,'band','Dimmu Borgir','',0,'ACTIVE'),(60,NULL,'band','Dissection','',0,'ACTIVE'),(61,NULL,'band','Disturbed','',0,'ACTIVE'),(62,NULL,'band','Doors','',0,'ACTIVE'),(63,NULL,'band','Dorgo','',0,'ACTIVE'),(64,NULL,'band','Dragonforce','',0,'ACTIVE'),(65,NULL,'band','Dream Theater','',0,'ACTIVE'),(66,NULL,'band','Drohokal','',0,'ACTIVE'),(67,NULL,'band','Dying Fetus','',0,'ACTIVE'),(68,NULL,'band','Echo Friendly ','',0,'ACTIVE'),(69,NULL,'band','DIO','',0,'ACTIVE'),(70,NULL,'band','Eluvietie','',0,'ACTIVE'),(71,NULL,'band','Encore','',0,'ACTIVE'),(72,NULL,'band','Equilibrium','',0,'ACTIVE'),(73,NULL,'band','ESP','',0,'ACTIVE'),(74,NULL,'band','EF','',0,'ACTIVE'),(75,NULL,'band','Exodus','',0,'ACTIVE'),(76,NULL,'band','Fendar','',0,'ACTIVE'),(77,NULL,'band','Five Finger','',0,'ACTIVE'),(78,NULL,'band','Foo Fighter','',0,'ACTIVE'),(79,NULL,'band','Faused','',0,'ACTIVE'),(80,NULL,'band','Ghost','',0,'ACTIVE'),(81,NULL,'band','GIG','',0,'ACTIVE'),(82,NULL,'band','Gojira','',0,'ACTIVE'),(83,NULL,'band','Gontobbohin','',0,'ACTIVE'),(84,NULL,'band','Gorguts','',0,'ACTIVE'),(85,NULL,'band','Green Army','',0,'ACTIVE'),(86,NULL,'band','Green Day','',0,'ACTIVE'),(87,NULL,'band','Guns N Roses','',0,'ACTIVE'),(88,NULL,'band','Gutslit Black','',0,'INACTIVE'),(89,NULL,'band','Gutslit','',0,'ACTIVE'),(90,NULL,'band','H2SO4','',0,'ACTIVE'),(91,NULL,'category','Mens Fashion','',0,'ACTIVE'),(92,NULL,'band','Hammerfall','',0,'ACTIVE'),(93,NULL,'category','T-Shirt','',0,'INACTIVE'),(94,NULL,'band','Heiniken','',0,'ACTIVE'),(95,91,'category','T-Shirt','',0,'ACTIVE'),(96,95,'category','Half Sleeve','',0,'ACTIVE'),(97,NULL,'band','Hypnotize','',0,'ACTIVE'),(98,NULL,'band','Imagine Dragon','',0,'INACTIVE'),(99,NULL,'band','Imagine Dragons','',0,'ACTIVE'),(100,NULL,'band','Immortan Deathcave','',0,'ACTIVE'),(101,NULL,'band','Implicit','',0,'ACTIVE'),(102,NULL,'band','Inflames','',0,'ACTIVE'),(103,NULL,'band','Introit','',0,'ACTIVE'),(104,NULL,'band','Invocation Of Sinners','',0,'ACTIVE'),(105,NULL,'band','Ionic ','',0,'INACTIVE'),(106,NULL,'band','Ionic Bond','',0,'ACTIVE'),(107,NULL,'band','Iron Maiden','',0,'ACTIVE'),(108,NULL,'band','Judas Priest','',0,'ACTIVE'),(109,NULL,'band','Jumang','',0,'ACTIVE'),(110,NULL,'band','Kaal','',0,'ACTIVE'),(111,NULL,'band','Kalmah','',0,'ACTIVE'),(112,NULL,'band','Karmat','',0,'ACTIVE'),(113,NULL,'band','Karnival Mohomukti','',0,'ACTIVE'),(114,NULL,'band','Killswitch Engage','',0,'ACTIVE'),(115,NULL,'band','Kiss','',0,'ACTIVE'),(116,NULL,'band','Korn','',0,'ACTIVE'),(117,NULL,'band','Kreator','',0,'ACTIVE'),(118,NULL,'band','Lamb Of God','',0,'ACTIVE'),(119,NULL,'band','Led Zeppelin','',0,'ACTIVE'),(120,NULL,'band','Linkin Park','',0,'ACTIVE'),(121,NULL,'band','LSD','',0,'ACTIVE'),(122,NULL,'band','Machine Head','',0,'ACTIVE'),(123,NULL,'band','Mastoden','',0,'ACTIVE'),(124,NULL,'band','Mayhem','',0,'ACTIVE'),(125,NULL,'band','Mechanix ','',0,'ACTIVE'),(126,NULL,'band','Megadeath','',0,'ACTIVE'),(127,NULL,'band','Meshuggah','',0,'ACTIVE'),(128,NULL,'band','Messainic Era','',0,'ACTIVE'),(129,NULL,'band','Metalica','',0,'ACTIVE'),(130,NULL,'band','Misfits','',0,'ACTIVE'),(131,NULL,'band','Morbid Angle','',0,'ACTIVE'),(132,NULL,'band','Motorhead','',0,'ACTIVE'),(133,NULL,'band','Municipal Waste','',0,'ACTIVE'),(134,NULL,'band','My Chemical Romance','',0,'ACTIVE'),(135,NULL,'band','Napalm Death','',0,'ACTIVE'),(136,NULL,'band','Nile','',0,'ACTIVE'),(137,NULL,'band','Nirvana','',0,'ACTIVE'),(138,NULL,'band','Obituary','',0,'ACTIVE'),(139,NULL,'band','Opeth','',0,'ACTIVE'),(140,NULL,'band','Overload','',0,'ACTIVE'),(141,NULL,'band','Owned','',0,'ACTIVE'),(142,NULL,'band','Pantera','',0,'ACTIVE'),(143,NULL,'band','Pearl Jam','',0,'ACTIVE'),(144,NULL,'band','Pink Floyd','',0,'ACTIVE'),(145,NULL,'band','Poits Of The Fall ','',0,'ACTIVE'),(146,NULL,'band','Poizon','',0,'ACTIVE'),(147,NULL,'band','Porcupine Tree','',0,'ACTIVE'),(148,NULL,'band','Possessed','',0,'ACTIVE'),(149,NULL,'band','Power Of Ground','',0,'ACTIVE'),(150,NULL,'band','Powerwolf','',0,'ACTIVE'),(151,NULL,'band','Prism','',0,'ACTIVE'),(152,NULL,'band','Queen','',0,'ACTIVE'),(153,NULL,'band','Radiohead','',0,'ACTIVE'),(154,NULL,'band','Rage Against The Machine','',0,'ACTIVE'),(155,NULL,'band','Ramones','',0,'ACTIVE'),(156,NULL,'band','Red Hot Chili Peppers ','',0,'ACTIVE'),(157,NULL,'band','Revolution','',0,'ACTIVE'),(158,NULL,'band','Rock','',0,'ACTIVE'),(159,NULL,'band','Rockphobic','',0,'INACTIVE'),(160,NULL,'band','Rockaphobic','',0,'ACTIVE'),(161,NULL,'band','Rock Strata','',0,'ACTIVE'),(162,NULL,'band','Rolling Stones','',0,'ACTIVE'),(163,NULL,'band','scarecrow ','',0,'ACTIVE'),(164,NULL,'band','Scorpions','',0,'ACTIVE'),(165,NULL,'band','Septicflesh','',0,'ACTIVE'),(166,NULL,'band','Seputura','',0,'ACTIVE'),(167,NULL,'band','Sex Pistols','',0,'ACTIVE'),(168,NULL,'band','Shironamhin','',0,'ACTIVE'),(169,NULL,'band','Shohortoli','',0,'ACTIVE'),(170,NULL,'band','Shonar Bangla','',0,'ACTIVE'),(171,NULL,'band','Shunno','',0,'ACTIVE'),(172,NULL,'band','Sin','',0,'ACTIVE'),(173,NULL,'band','Six Feet Under','',0,'ACTIVE'),(174,NULL,'band','Skid Row','',0,'ACTIVE'),(175,NULL,'band','Slayer','',0,'ACTIVE'),(176,NULL,'band','Slipknot','',0,'ACTIVE'),(177,NULL,'band','Sodom','',0,'ACTIVE'),(178,NULL,'band','StarBucks','',0,'ACTIVE'),(179,NULL,'band','Suicide Silence','',0,'ACTIVE'),(180,NULL,'band','Summoring The Eternal ','',0,'ACTIVE'),(181,NULL,'band','Surtur','',0,'ACTIVE'),(182,NULL,'band','System Of A Down','',0,'ACTIVE'),(183,NULL,'band','Tama','',0,'ACTIVE'),(184,NULL,'band','Terondaj','',0,'ACTIVE'),(185,NULL,'band','Testament','',0,'ACTIVE'),(186,NULL,'band','The Beatles','',0,'ACTIVE'),(187,NULL,'band','The Big Gun','',0,'ACTIVE'),(188,NULL,'band','The Tree','',0,'ACTIVE'),(189,NULL,'band','Thrash','',0,'ACTIVE'),(190,NULL,'band','Thunder','',0,'ACTIVE'),(191,NULL,'band','Tool','',0,'ACTIVE'),(192,NULL,'band','Tormentor','',0,'ACTIVE'),(193,NULL,'band','Toxic Brain','',0,'ACTIVE'),(194,NULL,'band','Trainwreck ','',0,'ACTIVE'),(195,NULL,'band','Unmaad','',0,'ACTIVE'),(196,NULL,'band','Veil Of Maya','',0,'ACTIVE'),(197,NULL,'band','Venom','',0,'ACTIVE'),(198,NULL,'band','Xenocryst ','',0,'ACTIVE'),(199,NULL,'band','Rammstein','',0,'ACTIVE'),(200,NULL,'band','Avoid Rafa','',0,'ACTIVE'),(201,NULL,'band','Exelter','',0,'ACTIVE'),(202,NULL,'band','Eternal Armageddon','',0,'ACTIVE'),(203,NULL,'band','Demolition Of Death','',0,'ACTIVE'),(204,NULL,'band','Death\'s Wrath','',0,'ACTIVE'),(205,NULL,'band','Chronicles','',0,'ACTIVE'),(206,NULL,'band','Chander Gari ','',0,'ACTIVE'),(207,NULL,'band','Averse ','',0,'ACTIVE'),(208,NULL,'band','Ashes','',0,'ACTIVE'),(209,NULL,'band','Opsongskriti','',0,'ACTIVE'),(210,NULL,'band','War Journal','',0,'ACTIVE'),(211,NULL,'band','Warsite','',0,'ACTIVE'),(212,NULL,'band','Arcanimus','',0,'ACTIVE'),(213,NULL,'band','Art of Heaven','',0,'ACTIVE'),(214,NULL,'band','Art Rock','',0,'ACTIVE'),(215,NULL,'band','Beshi Joss Drums','',0,'ACTIVE'),(216,NULL,'band','Culminar Terror','',0,'ACTIVE'),(217,NULL,'band','Jack Daniels','',0,'ACTIVE'),(218,NULL,'band','Levels','',0,'ACTIVE'),(219,NULL,'band','Offened Us','',0,'ACTIVE'),(220,NULL,'band','Plasmic Knock','',0,'ACTIVE'),(221,NULL,'band','Rage Of Samyel','',0,'ACTIVE');
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
INSERT INTO `mfg_order_items` VALUES (0,2,'18-CP001-2-4',20),(1,2,'18-CP001-2-10',20),(2,2,'18-CP001-2-4',20),(3,2,'18-CP001-2-5',20),(4,2,'18-CP001-2-6',20),(5,2,'18-CP001-2-7',20),(6,2,'18-CP001-2-8',20),(7,2,'18-CP001-2-9',20),(0,3,'9-ARTCL001-2-7',100),(1,3,'9-ARTCL001-2-10',100),(2,3,'9-ARTCL001-2-4',100),(3,3,'9-ARTCL001-2-5',100),(4,3,'9-ARTCL001-2-6',100),(5,3,'9-ARTCL001-2-7',100),(6,3,'9-ARTCL001-2-8',100),(7,3,'9-ARTCL001-2-9',100),(0,6,'17-COB002-2-7',100),(1,6,'17-COB002-2-10',100),(2,6,'17-COB002-2-4',100),(3,6,'17-COB002-2-5',100),(4,6,'17-COB002-2-6',100),(5,6,'17-COB002-2-7',100),(6,6,'17-COB002-2-8',100),(7,6,'17-COB002-2-9',100),(0,7,'17-COB002-2-10',5),(1,7,'17-COB002-2-4',5),(2,7,'17-COB002-2-5',5),(3,7,'17-COB002-2-6',5),(4,7,'17-COB002-2-7',5),(5,7,'17-COB002-2-8',5),(6,7,'17-COB002-2-9',5),(0,8,'17-COB002-2-10',5),(1,8,'17-COB002-2-4',5),(2,8,'17-COB002-2-5',5),(3,8,'17-COB002-2-6',5),(4,8,'17-COB002-2-7',5),(5,8,'17-COB002-2-8',5),(6,8,'17-COB002-2-9',5),(0,9,'7-ALR003-2-8',5),(1,9,'7-ALR003-2-10',5),(2,9,'7-ALR003-2-4',5),(3,9,'7-ALR003-2-5',5),(4,9,'7-ALR003-2-6',5),(5,9,'7-ALR003-2-7',5),(6,9,'7-ALR003-2-8',5),(7,9,'7-ALR003-2-9',5);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mfg_order_sets`
--

LOCK TABLES `mfg_order_sets` WRITE;
/*!40000 ALTER TABLE `mfg_order_sets` DISABLE KEYS */;
INSERT INTO `mfg_order_sets` VALUES (1,'coldplay','2021-07-10 03:18:27'),(2,'eid specials','2021-07-10 03:23:55'),(3,'Eid special','2021-07-10 04:35:44'),(6,'boishaki special','2021-07-10 04:54:14'),(7,'boishaki Jor','2021-07-10 04:57:28'),(8,'boishakhi Jor','2021-07-10 04:59:07'),(9,'FIFA Specials','2021-07-10 05:01:56');
/*!40000 ALTER TABLE `mfg_order_sets` ENABLE KEYS */;
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
INSERT INTO `mfg_order_states` VALUES ('COMPLETE','ORD-49JUQSE92TA84-1-2',1,'2021-07-10 04:12:53'),('PLACED','ORD-49JUQSE92TA84-1-2',1,'2021-07-10 19:10:06'),('COMPLETE','ORD-49JUQSEG7IGWC-1-2',1,'2021-07-10 04:15:49'),('PLACED','ORD-49JUQSEG7IGWC-1-2',1,'2021-07-10 19:14:37'),('COMPLETE','ORD-49JUQSEXWLIC4-1-2',1,'2021-07-10 04:33:05'),('PLACED','ORD-49JUQSEXWLIC4-1-2',1,'2021-07-10 19:25:07'),('COMPLETE','ORD-49JUQSF59Q684-1-2',1,'2021-07-10 04:33:10'),('PLACED','ORD-49JUQSF59Q684-1-2',1,'2021-07-10 19:29:52'),('COMPLETE','ORD-49JUQSF6C1USW-1-2',1,'2021-07-10 04:31:03'),('PLACED','ORD-49JUQSF6C1USW-1-2',1,'2021-07-10 19:30:17'),('COMPLETE','ORD-49JUQSFG9COWS-1-2',1,'2021-07-10 04:37:15'),('PLACED','ORD-49JUQSFG9COWS-1-2',1,'2021-07-10 19:36:17'),('COMPLETE','ORD-49JUQSGAI6IO8-1-2',1,'2021-07-10 04:55:11'),('PLACED','ORD-49JUQSGAI6IO8-1-2',1,'2021-07-10 19:54:46'),('COMPLETE','ORD-49JUQSGFEASKK-1-2',1,'2021-07-10 04:57:51'),('PLACED','ORD-49JUQSGFEASKK-1-2',1,'2021-07-10 19:57:41'),('COMPLETE','ORD-49JUQSGII7I8S-1-2',1,'2021-07-10 04:59:38'),('PLACED','ORD-49JUQSGII7I8S-1-2',1,'2021-07-10 19:59:29'),('COMPLETE','ORD-49JUQSIHELKW4-1-2',1,'2021-07-10 05:02:29'),('PLACED','ORD-49JUQSIHELKW4-1-2',1,'2021-07-10 20:02:16');
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
INSERT INTO `mfg_orders` VALUES ('ORD-49JUQSE92TA84-1-2',2,2,'COMPLETE','2021-07-10 19:10:06'),('ORD-49JUQSEG7IGWC-1-2',2,2,'COMPLETE','2021-07-10 19:14:37'),('ORD-49JUQSEXWLIC4-1-2',2,2,'COMPLETE','2021-07-10 19:25:07'),('ORD-49JUQSF59Q684-1-2',2,2,'COMPLETE','2021-07-10 19:29:52'),('ORD-49JUQSF6C1USW-1-2',2,2,'COMPLETE','2021-07-10 19:30:17'),('ORD-49JUQSFG9COWS-1-2',3,2,'COMPLETE','2021-07-10 19:36:17'),('ORD-49JUQSGAI6IO8-1-2',6,2,'COMPLETE','2021-07-10 19:54:46'),('ORD-49JUQSGFEASKK-1-2',7,2,'COMPLETE','2021-07-10 19:57:41'),('ORD-49JUQSGII7I8S-1-2',8,2,'COMPLETE','2021-07-10 19:59:29'),('ORD-49JUQSIHELKW4-1-2',9,2,'COMPLETE','2021-07-10 20:02:16');
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
INSERT INTO `ottoman_files` VALUES ('00b317f394b44f212c858b83e2624e1c7b37a5cb4ac0100512c9aa564a2ca647f6d4035f39dd3eea98edc6a3e3b6b68b9e9b856eb1f5a3fa040ed1e0ef31f97d.jpg','IMAGE','jpg','Children of boddom.jpg',0,'2021-07-05 00:55:33'),('0d74cde5f4f7e2b552f6f00a28475be3817f4047d6acadec00bf881d0511d26dee5738ed432cf9be48e0423156920ceea2e5880f242bb5ef4dab243fbf242b59.jpg','IMAGE','jpg','Cryptic-Fate.jpg',0,'2021-07-05 01:11:36'),('1297a2396a30ca46712bd966e0f5a704beb99b368a5f8a08d7497f98f50368ecb0dc9a1eec2403e023051980d048c0f2a6cb88f8f5aaa05b1729b7031b16c29a.jpg','IMAGE','jpg','Bullet.jpg',0,'2021-07-05 00:41:23'),('21dcb886099b7fff57554f553b7b5e1ea76f663c14425943da7a7fdf9c697c970eabe719badd201bcfe6664314a10058e11155b5335f31aeb27528c4a3cc0c3c.jpg','IMAGE','jpg','Buttet for my valentine 04.jpg',0,'2021-07-05 00:51:33'),('240471f00c1689e4f576ce5c2dece2a6d9c0934de0d3dd9233cfc1919d2ca19e3fa55caf68517856a6e6d850cf6fbd94bede70a5c23e8c5005735a71f1c6277f.jpg','IMAGE','jpg','Behemoth (5).jpg',0,'2021-07-05 00:25:35'),('2abb97bbfa21d1104446329b2322c41909ad3f8eb7646d3f4e3d5b8209f2e12a381a2a28847da724877f3b16e4476b205d99217bd969a0f0ccd58816344f3cf5.jpg','IMAGE','jpg','Judas Priest (2).jpg',0,'2021-07-05 01:46:37'),('2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg','IMAGE','jpg','Abbath Tem.jpg',0,'2021-07-04 23:35:17'),('2ded2c215ee6d265254ff53369ec7a60b186080bc19d768c1df98932b455aa607bcaaf1dcba51804c58c39ad6f206ef0a628cfcade29fa4315d5ec912ab102e8.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:47'),('312b9c2815cc5e2c12b3203c9108b6a514ebae1ff6b3c31a7bc84042dd21170df08e261726db7460e8f2f4185b8b64ad50f7874693df548d01595e0e0e28cb10.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:24'),('3ca5cc78ca0139dd2d1b2827de831202a25a35a85994887d9517bd6af4dd490d656db44cde308c880138297680c2e14bc03fdf89021854712dc34bb10e3ed32e.jpg','IMAGE','jpg','Black Sabbath 05.jpg',0,'2021-07-05 00:36:55'),('4d883a410bcef57722397d21978d882a353c7105914bfd145b776fe9eb7bc2a055f1fd17c3eb311d1ab0e3be8c5e5f71eea8c403f12183754618cdc59ca8d177.jpg','IMAGE','jpg','Green-Army.jpg',0,'2021-07-05 01:32:45'),('4f45ed406ba8bc090593dadbfcbf50c624ae8e0048e1bbbbf1c0fbbb0c40ce67283197be1ac382ac11a298d2a7896e940986a64114d74ba648b7c1f38862c6d3.jpg','IMAGE','jpg','Iron maiden 04.jpg',0,'2021-07-05 01:38:41'),('575429d839bbf41a3485eb88522e59c42d45539b1a478534442992dcf2854cdfc6ef153b31e015c35e255500ee53d91f7277a00915d633cb4a048fff94e7ac8e.jpg','IMAGE','jpg','Black sabbath 02.jpg',0,'2021-07-05 00:29:27'),('6359e6902f1a22c92dd3d42b2d2625fd858a82bc952a51da9f8c99939dba6db21fe7a21f9ce457967c4452bddda4c9c0c6a1210725385c3d79d632a2cb02e829.jpg','IMAGE','jpg','Dream Theater 04.jpg',0,'2021-07-05 01:21:46'),('71fa76d3bd767c106c05cc82063141409e705b4ec3641ad55c3998321f94218767a64038a2bc98d75bafb992c1fa16770b20b4b1062c0625e87e006ee5dbabb5.jpg','IMAGE','jpg','Exodus 03.jpg',0,'2021-07-05 01:29:35'),('7640f2fd2c849bfd0ea280eb8700d82626f09cfedb585ef5c2bce9ff196f5d50a2879869b4d4221c81c977fbd690e1f25e2c5b8976f0c5c57f12831c55f1a3ae.jpg','IMAGE','jpg','Arbo-1.jpg',0,'2021-07-05 00:06:39'),('787f31075fc96d8d597d26b1cecd42467bf51d51fdda1d68ca4d9dd691b755e3cec35c0a2436d23424ee780fdb39dcf2d52f62211c3b138dd5f07af64965b47b.jpg','IMAGE','jpg','Green-Day-2.jpg',0,'2021-07-05 01:35:29'),('7ddc27f6856a00e06fefa1e576c6c9f12a23ecede086ff47e9b4d9b7c1674eab624d785abec701917ec944ec306c11a7c6b1d7b63ed3ea42caa772e485174a3f.jpg','IMAGE','jpg','Jack-dan.jpg',0,'2021-07-05 01:44:08'),('7ecfaa8ed80d8d1d18832412e2265051756d9db91ad7e6bd6d2ad8d56687809481b0075cb6d678d3434a2ecfd7ef2259ca3afee750a1e0031cc55f0b629f7c49.jpg','IMAGE','jpg','Artcell.jpg',0,'2021-07-05 00:16:04'),('80b041875934bfa734302f2e7ec59149991fa17f555853611e96014827a0c0044116b4552b697d2d2c5eb76a66f1be7ebe5101a3a2d0eeaedea8945370b2f8bd.jpg','IMAGE','jpg','Dream Theater 03.jpg',0,'2021-07-05 01:18:31'),('88c0a63cb0df7e8d4731bedf467615cd529f541c1502683a2f60f862d8bc4ff28a064e40b9d60dbdaa4b4290050a73d7a3321acde1a2d59204263d1436c8fb96.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:07'),('995152b3dd66a3fbeab945ee66a9c2e6eb3ce9fa087717334a398e74a98c0f6714e5dfcdca2f3a8184e6bb316ff5214b3caae02dc157716a5f7f5b5d56058c4c.jpg','IMAGE','jpg','EF.jpg',0,'2021-07-05 01:26:34'),('a328e64e8aa9a75788ce62f396c9508b8394e9041819d253ee99015a83ac0778e2aeff11b32ec3a443a08004eb1f930c0478bc78ca123045c287cab9d0abfa8f.jpg','IMAGE','jpg','Death 04.jpg',0,'2021-07-05 01:15:47'),('c06d03e8da9cf8e823998da92603931eafc6236bea236ffe0c3a5fb95f44270ccaa487774f429103dcd099d7dd1c7e49ad1563f4337f6d947fce7b657ffed83f.jpg','IMAGE','jpg','Iron Maiden Tem.jpg',0,'2021-07-05 01:41:18'),('c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg','IMAGE','jpeg','Clodplay.jpeg',0,'2021-07-05 00:58:26'),('d8e6f8cb88a5f4a3c54eccefd488d992f965c9d8dce932f270c9af1516dca4d61bd5d93a68e2fa95600ef0397c333de590a074a2dabf92527e7c8b4e97ad5ac6.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:55:28'),('e2597b6ccdf060723fe1724649f6efe944713a236e014e63775ee50833b16effd7297da7687832f45e1319440c3ad72c6b1f75b6c0f5659543e61e47b34273c5.jpg','IMAGE','jpg','Alter Bridge 03.jpg',0,'2021-07-04 23:59:54'),('fc56cea2062c19295965fb10a1027da5a0482dad6496ac4de22e9276c1a70bd0e9401e8c533aaa9670b1ba8178b2480ca5d23674f3ad1288989e7eb269b31b76.jpg','IMAGE','jpg','Black Sabbath 03.jpg',0,'2021-07-05 00:33:33'),('gallery-thumb-00b317f394b44f212c858b83e2624e1c7b37a5cb4ac0100512c9aa564a2ca647f6d4035f39dd3eea98edc6a3e3b6b68b9e9b856eb1f5a3fa040ed1e0ef31f97d.jpg','IMAGE','jpg','Children of boddom.jpg',0,'2021-07-05 00:55:33'),('gallery-thumb-0d74cde5f4f7e2b552f6f00a28475be3817f4047d6acadec00bf881d0511d26dee5738ed432cf9be48e0423156920ceea2e5880f242bb5ef4dab243fbf242b59.jpg','IMAGE','jpg','Cryptic-Fate.jpg',0,'2021-07-05 01:11:36'),('gallery-thumb-1297a2396a30ca46712bd966e0f5a704beb99b368a5f8a08d7497f98f50368ecb0dc9a1eec2403e023051980d048c0f2a6cb88f8f5aaa05b1729b7031b16c29a.jpg','IMAGE','jpg','Bullet.jpg',0,'2021-07-05 00:41:23'),('gallery-thumb-21dcb886099b7fff57554f553b7b5e1ea76f663c14425943da7a7fdf9c697c970eabe719badd201bcfe6664314a10058e11155b5335f31aeb27528c4a3cc0c3c.jpg','IMAGE','jpg','Buttet for my valentine 04.jpg',0,'2021-07-05 00:51:33'),('gallery-thumb-240471f00c1689e4f576ce5c2dece2a6d9c0934de0d3dd9233cfc1919d2ca19e3fa55caf68517856a6e6d850cf6fbd94bede70a5c23e8c5005735a71f1c6277f.jpg','IMAGE','jpg','Behemoth (5).jpg',0,'2021-07-05 00:25:35'),('gallery-thumb-2abb97bbfa21d1104446329b2322c41909ad3f8eb7646d3f4e3d5b8209f2e12a381a2a28847da724877f3b16e4476b205d99217bd969a0f0ccd58816344f3cf5.jpg','IMAGE','jpg','Judas Priest (2).jpg',0,'2021-07-05 01:46:37'),('gallery-thumb-2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg','IMAGE','jpg','Abbath Tem.jpg',0,'2021-07-04 23:35:18'),('gallery-thumb-2ded2c215ee6d265254ff53369ec7a60b186080bc19d768c1df98932b455aa607bcaaf1dcba51804c58c39ad6f206ef0a628cfcade29fa4315d5ec912ab102e8.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:48'),('gallery-thumb-312b9c2815cc5e2c12b3203c9108b6a514ebae1ff6b3c31a7bc84042dd21170df08e261726db7460e8f2f4185b8b64ad50f7874693df548d01595e0e0e28cb10.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:24'),('gallery-thumb-3ca5cc78ca0139dd2d1b2827de831202a25a35a85994887d9517bd6af4dd490d656db44cde308c880138297680c2e14bc03fdf89021854712dc34bb10e3ed32e.jpg','IMAGE','jpg','Black Sabbath 05.jpg',0,'2021-07-05 00:36:55'),('gallery-thumb-4d883a410bcef57722397d21978d882a353c7105914bfd145b776fe9eb7bc2a055f1fd17c3eb311d1ab0e3be8c5e5f71eea8c403f12183754618cdc59ca8d177.jpg','IMAGE','jpg','Green-Army.jpg',0,'2021-07-05 01:32:46'),('gallery-thumb-4f45ed406ba8bc090593dadbfcbf50c624ae8e0048e1bbbbf1c0fbbb0c40ce67283197be1ac382ac11a298d2a7896e940986a64114d74ba648b7c1f38862c6d3.jpg','IMAGE','jpg','Iron maiden 04.jpg',0,'2021-07-05 01:38:41'),('gallery-thumb-575429d839bbf41a3485eb88522e59c42d45539b1a478534442992dcf2854cdfc6ef153b31e015c35e255500ee53d91f7277a00915d633cb4a048fff94e7ac8e.jpg','IMAGE','jpg','Black sabbath 02.jpg',0,'2021-07-05 00:29:28'),('gallery-thumb-6359e6902f1a22c92dd3d42b2d2625fd858a82bc952a51da9f8c99939dba6db21fe7a21f9ce457967c4452bddda4c9c0c6a1210725385c3d79d632a2cb02e829.jpg','IMAGE','jpg','Dream Theater 04.jpg',0,'2021-07-05 01:21:47'),('gallery-thumb-71fa76d3bd767c106c05cc82063141409e705b4ec3641ad55c3998321f94218767a64038a2bc98d75bafb992c1fa16770b20b4b1062c0625e87e006ee5dbabb5.jpg','IMAGE','jpg','Exodus 03.jpg',0,'2021-07-05 01:29:36'),('gallery-thumb-7640f2fd2c849bfd0ea280eb8700d82626f09cfedb585ef5c2bce9ff196f5d50a2879869b4d4221c81c977fbd690e1f25e2c5b8976f0c5c57f12831c55f1a3ae.jpg','IMAGE','jpg','Arbo-1.jpg',0,'2021-07-05 00:06:40'),('gallery-thumb-787f31075fc96d8d597d26b1cecd42467bf51d51fdda1d68ca4d9dd691b755e3cec35c0a2436d23424ee780fdb39dcf2d52f62211c3b138dd5f07af64965b47b.jpg','IMAGE','jpg','Green-Day-2.jpg',0,'2021-07-05 01:35:29'),('gallery-thumb-7ddc27f6856a00e06fefa1e576c6c9f12a23ecede086ff47e9b4d9b7c1674eab624d785abec701917ec944ec306c11a7c6b1d7b63ed3ea42caa772e485174a3f.jpg','IMAGE','jpg','Jack-dan.jpg',0,'2021-07-05 01:44:08'),('gallery-thumb-7ecfaa8ed80d8d1d18832412e2265051756d9db91ad7e6bd6d2ad8d56687809481b0075cb6d678d3434a2ecfd7ef2259ca3afee750a1e0031cc55f0b629f7c49.jpg','IMAGE','jpg','Artcell.jpg',0,'2021-07-05 00:16:04'),('gallery-thumb-80b041875934bfa734302f2e7ec59149991fa17f555853611e96014827a0c0044116b4552b697d2d2c5eb76a66f1be7ebe5101a3a2d0eeaedea8945370b2f8bd.jpg','IMAGE','jpg','Dream Theater 03.jpg',0,'2021-07-05 01:18:31'),('gallery-thumb-88c0a63cb0df7e8d4731bedf467615cd529f541c1502683a2f60f862d8bc4ff28a064e40b9d60dbdaa4b4290050a73d7a3321acde1a2d59204263d1436c8fb96.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:07'),('gallery-thumb-995152b3dd66a3fbeab945ee66a9c2e6eb3ce9fa087717334a398e74a98c0f6714e5dfcdca2f3a8184e6bb316ff5214b3caae02dc157716a5f7f5b5d56058c4c.jpg','IMAGE','jpg','EF.jpg',0,'2021-07-05 01:26:34'),('gallery-thumb-a328e64e8aa9a75788ce62f396c9508b8394e9041819d253ee99015a83ac0778e2aeff11b32ec3a443a08004eb1f930c0478bc78ca123045c287cab9d0abfa8f.jpg','IMAGE','jpg','Death 04.jpg',0,'2021-07-05 01:15:47'),('gallery-thumb-c06d03e8da9cf8e823998da92603931eafc6236bea236ffe0c3a5fb95f44270ccaa487774f429103dcd099d7dd1c7e49ad1563f4337f6d947fce7b657ffed83f.jpg','IMAGE','jpg','Iron Maiden Tem.jpg',0,'2021-07-05 01:41:19'),('gallery-thumb-c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpg','IMAGE','jpg','Clodplay.jpeg',0,'2021-07-05 00:58:26'),('gallery-thumb-d8e6f8cb88a5f4a3c54eccefd488d992f965c9d8dce932f270c9af1516dca4d61bd5d93a68e2fa95600ef0397c333de590a074a2dabf92527e7c8b4e97ad5ac6.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:55:28'),('gallery-thumb-e2597b6ccdf060723fe1724649f6efe944713a236e014e63775ee50833b16effd7297da7687832f45e1319440c3ad72c6b1f75b6c0f5659543e61e47b34273c5.jpg','IMAGE','jpg','Alter Bridge 03.jpg',0,'2021-07-04 23:59:54'),('gallery-thumb-fc56cea2062c19295965fb10a1027da5a0482dad6496ac4de22e9276c1a70bd0e9401e8c533aaa9670b1ba8178b2480ca5d23674f3ad1288989e7eb269b31b76.jpg','IMAGE','jpg','Black Sabbath 03.jpg',0,'2021-07-05 00:33:33'),('list-thumb-00b317f394b44f212c858b83e2624e1c7b37a5cb4ac0100512c9aa564a2ca647f6d4035f39dd3eea98edc6a3e3b6b68b9e9b856eb1f5a3fa040ed1e0ef31f97d.jpg','IMAGE','jpg','Children of boddom.jpg',0,'2021-07-05 00:55:33'),('list-thumb-0d74cde5f4f7e2b552f6f00a28475be3817f4047d6acadec00bf881d0511d26dee5738ed432cf9be48e0423156920ceea2e5880f242bb5ef4dab243fbf242b59.jpg','IMAGE','jpg','Cryptic-Fate.jpg',0,'2021-07-05 01:11:36'),('list-thumb-1297a2396a30ca46712bd966e0f5a704beb99b368a5f8a08d7497f98f50368ecb0dc9a1eec2403e023051980d048c0f2a6cb88f8f5aaa05b1729b7031b16c29a.jpg','IMAGE','jpg','Bullet.jpg',0,'2021-07-05 00:41:23'),('list-thumb-21dcb886099b7fff57554f553b7b5e1ea76f663c14425943da7a7fdf9c697c970eabe719badd201bcfe6664314a10058e11155b5335f31aeb27528c4a3cc0c3c.jpg','IMAGE','jpg','Buttet for my valentine 04.jpg',0,'2021-07-05 00:51:33'),('list-thumb-240471f00c1689e4f576ce5c2dece2a6d9c0934de0d3dd9233cfc1919d2ca19e3fa55caf68517856a6e6d850cf6fbd94bede70a5c23e8c5005735a71f1c6277f.jpg','IMAGE','jpg','Behemoth (5).jpg',0,'2021-07-05 00:25:35'),('list-thumb-2abb97bbfa21d1104446329b2322c41909ad3f8eb7646d3f4e3d5b8209f2e12a381a2a28847da724877f3b16e4476b205d99217bd969a0f0ccd58816344f3cf5.jpg','IMAGE','jpg','Judas Priest (2).jpg',0,'2021-07-05 01:46:37'),('list-thumb-2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg','IMAGE','jpg','Abbath Tem.jpg',0,'2021-07-04 23:35:18'),('list-thumb-2ded2c215ee6d265254ff53369ec7a60b186080bc19d768c1df98932b455aa607bcaaf1dcba51804c58c39ad6f206ef0a628cfcade29fa4315d5ec912ab102e8.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:48'),('list-thumb-312b9c2815cc5e2c12b3203c9108b6a514ebae1ff6b3c31a7bc84042dd21170df08e261726db7460e8f2f4185b8b64ad50f7874693df548d01595e0e0e28cb10.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:24'),('list-thumb-3ca5cc78ca0139dd2d1b2827de831202a25a35a85994887d9517bd6af4dd490d656db44cde308c880138297680c2e14bc03fdf89021854712dc34bb10e3ed32e.jpg','IMAGE','jpg','Black Sabbath 05.jpg',0,'2021-07-05 00:36:55'),('list-thumb-4d883a410bcef57722397d21978d882a353c7105914bfd145b776fe9eb7bc2a055f1fd17c3eb311d1ab0e3be8c5e5f71eea8c403f12183754618cdc59ca8d177.jpg','IMAGE','jpg','Green-Army.jpg',0,'2021-07-05 01:32:46'),('list-thumb-4f45ed406ba8bc090593dadbfcbf50c624ae8e0048e1bbbbf1c0fbbb0c40ce67283197be1ac382ac11a298d2a7896e940986a64114d74ba648b7c1f38862c6d3.jpg','IMAGE','jpg','Iron maiden 04.jpg',0,'2021-07-05 01:38:41'),('list-thumb-575429d839bbf41a3485eb88522e59c42d45539b1a478534442992dcf2854cdfc6ef153b31e015c35e255500ee53d91f7277a00915d633cb4a048fff94e7ac8e.jpg','IMAGE','jpg','Black sabbath 02.jpg',0,'2021-07-05 00:29:28'),('list-thumb-6359e6902f1a22c92dd3d42b2d2625fd858a82bc952a51da9f8c99939dba6db21fe7a21f9ce457967c4452bddda4c9c0c6a1210725385c3d79d632a2cb02e829.jpg','IMAGE','jpg','Dream Theater 04.jpg',0,'2021-07-05 01:21:47'),('list-thumb-71fa76d3bd767c106c05cc82063141409e705b4ec3641ad55c3998321f94218767a64038a2bc98d75bafb992c1fa16770b20b4b1062c0625e87e006ee5dbabb5.jpg','IMAGE','jpg','Exodus 03.jpg',0,'2021-07-05 01:29:36'),('list-thumb-7640f2fd2c849bfd0ea280eb8700d82626f09cfedb585ef5c2bce9ff196f5d50a2879869b4d4221c81c977fbd690e1f25e2c5b8976f0c5c57f12831c55f1a3ae.jpg','IMAGE','jpg','Arbo-1.jpg',0,'2021-07-05 00:06:40'),('list-thumb-787f31075fc96d8d597d26b1cecd42467bf51d51fdda1d68ca4d9dd691b755e3cec35c0a2436d23424ee780fdb39dcf2d52f62211c3b138dd5f07af64965b47b.jpg','IMAGE','jpg','Green-Day-2.jpg',0,'2021-07-05 01:35:29'),('list-thumb-7ddc27f6856a00e06fefa1e576c6c9f12a23ecede086ff47e9b4d9b7c1674eab624d785abec701917ec944ec306c11a7c6b1d7b63ed3ea42caa772e485174a3f.jpg','IMAGE','jpg','Jack-dan.jpg',0,'2021-07-05 01:44:08'),('list-thumb-7ecfaa8ed80d8d1d18832412e2265051756d9db91ad7e6bd6d2ad8d56687809481b0075cb6d678d3434a2ecfd7ef2259ca3afee750a1e0031cc55f0b629f7c49.jpg','IMAGE','jpg','Artcell.jpg',0,'2021-07-05 00:16:04'),('list-thumb-80b041875934bfa734302f2e7ec59149991fa17f555853611e96014827a0c0044116b4552b697d2d2c5eb76a66f1be7ebe5101a3a2d0eeaedea8945370b2f8bd.jpg','IMAGE','jpg','Dream Theater 03.jpg',0,'2021-07-05 01:18:31'),('list-thumb-88c0a63cb0df7e8d4731bedf467615cd529f541c1502683a2f60f862d8bc4ff28a064e40b9d60dbdaa4b4290050a73d7a3321acde1a2d59204263d1436c8fb96.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:07'),('list-thumb-995152b3dd66a3fbeab945ee66a9c2e6eb3ce9fa087717334a398e74a98c0f6714e5dfcdca2f3a8184e6bb316ff5214b3caae02dc157716a5f7f5b5d56058c4c.jpg','IMAGE','jpg','EF.jpg',0,'2021-07-05 01:26:34'),('list-thumb-a328e64e8aa9a75788ce62f396c9508b8394e9041819d253ee99015a83ac0778e2aeff11b32ec3a443a08004eb1f930c0478bc78ca123045c287cab9d0abfa8f.jpg','IMAGE','jpg','Death 04.jpg',0,'2021-07-05 01:15:47'),('list-thumb-c06d03e8da9cf8e823998da92603931eafc6236bea236ffe0c3a5fb95f44270ccaa487774f429103dcd099d7dd1c7e49ad1563f4337f6d947fce7b657ffed83f.jpg','IMAGE','jpg','Iron Maiden Tem.jpg',0,'2021-07-05 01:41:19'),('list-thumb-c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpg','IMAGE','jpg','Clodplay.jpeg',0,'2021-07-05 00:58:26'),('list-thumb-d8e6f8cb88a5f4a3c54eccefd488d992f965c9d8dce932f270c9af1516dca4d61bd5d93a68e2fa95600ef0397c333de590a074a2dabf92527e7c8b4e97ad5ac6.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:55:28'),('list-thumb-e2597b6ccdf060723fe1724649f6efe944713a236e014e63775ee50833b16effd7297da7687832f45e1319440c3ad72c6b1f75b6c0f5659543e61e47b34273c5.jpg','IMAGE','jpg','Alter Bridge 03.jpg',0,'2021-07-04 23:59:54'),('list-thumb-fc56cea2062c19295965fb10a1027da5a0482dad6496ac4de22e9276c1a70bd0e9401e8c533aaa9670b1ba8178b2480ca5d23674f3ad1288989e7eb269b31b76.jpg','IMAGE','jpg','Black Sabbath 03.jpg',0,'2021-07-05 00:33:33'),('main-thumb-00b317f394b44f212c858b83e2624e1c7b37a5cb4ac0100512c9aa564a2ca647f6d4035f39dd3eea98edc6a3e3b6b68b9e9b856eb1f5a3fa040ed1e0ef31f97d.jpg','IMAGE','jpg','Children of boddom.jpg',0,'2021-07-05 00:55:33'),('main-thumb-0d74cde5f4f7e2b552f6f00a28475be3817f4047d6acadec00bf881d0511d26dee5738ed432cf9be48e0423156920ceea2e5880f242bb5ef4dab243fbf242b59.jpg','IMAGE','jpg','Cryptic-Fate.jpg',0,'2021-07-05 01:11:36'),('main-thumb-1297a2396a30ca46712bd966e0f5a704beb99b368a5f8a08d7497f98f50368ecb0dc9a1eec2403e023051980d048c0f2a6cb88f8f5aaa05b1729b7031b16c29a.jpg','IMAGE','jpg','Bullet.jpg',0,'2021-07-05 00:41:23'),('main-thumb-21dcb886099b7fff57554f553b7b5e1ea76f663c14425943da7a7fdf9c697c970eabe719badd201bcfe6664314a10058e11155b5335f31aeb27528c4a3cc0c3c.jpg','IMAGE','jpg','Buttet for my valentine 04.jpg',0,'2021-07-05 00:51:33'),('main-thumb-240471f00c1689e4f576ce5c2dece2a6d9c0934de0d3dd9233cfc1919d2ca19e3fa55caf68517856a6e6d850cf6fbd94bede70a5c23e8c5005735a71f1c6277f.jpg','IMAGE','jpg','Behemoth (5).jpg',0,'2021-07-05 00:25:35'),('main-thumb-2abb97bbfa21d1104446329b2322c41909ad3f8eb7646d3f4e3d5b8209f2e12a381a2a28847da724877f3b16e4476b205d99217bd969a0f0ccd58816344f3cf5.jpg','IMAGE','jpg','Judas Priest (2).jpg',0,'2021-07-05 01:46:37'),('main-thumb-2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg','IMAGE','jpg','Abbath Tem.jpg',0,'2021-07-04 23:35:18'),('main-thumb-2ded2c215ee6d265254ff53369ec7a60b186080bc19d768c1df98932b455aa607bcaaf1dcba51804c58c39ad6f206ef0a628cfcade29fa4315d5ec912ab102e8.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:48'),('main-thumb-312b9c2815cc5e2c12b3203c9108b6a514ebae1ff6b3c31a7bc84042dd21170df08e261726db7460e8f2f4185b8b64ad50f7874693df548d01595e0e0e28cb10.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:24'),('main-thumb-3ca5cc78ca0139dd2d1b2827de831202a25a35a85994887d9517bd6af4dd490d656db44cde308c880138297680c2e14bc03fdf89021854712dc34bb10e3ed32e.jpg','IMAGE','jpg','Black Sabbath 05.jpg',0,'2021-07-05 00:36:55'),('main-thumb-4d883a410bcef57722397d21978d882a353c7105914bfd145b776fe9eb7bc2a055f1fd17c3eb311d1ab0e3be8c5e5f71eea8c403f12183754618cdc59ca8d177.jpg','IMAGE','jpg','Green-Army.jpg',0,'2021-07-05 01:32:46'),('main-thumb-4f45ed406ba8bc090593dadbfcbf50c624ae8e0048e1bbbbf1c0fbbb0c40ce67283197be1ac382ac11a298d2a7896e940986a64114d74ba648b7c1f38862c6d3.jpg','IMAGE','jpg','Iron maiden 04.jpg',0,'2021-07-05 01:38:41'),('main-thumb-575429d839bbf41a3485eb88522e59c42d45539b1a478534442992dcf2854cdfc6ef153b31e015c35e255500ee53d91f7277a00915d633cb4a048fff94e7ac8e.jpg','IMAGE','jpg','Black sabbath 02.jpg',0,'2021-07-05 00:29:28'),('main-thumb-6359e6902f1a22c92dd3d42b2d2625fd858a82bc952a51da9f8c99939dba6db21fe7a21f9ce457967c4452bddda4c9c0c6a1210725385c3d79d632a2cb02e829.jpg','IMAGE','jpg','Dream Theater 04.jpg',0,'2021-07-05 01:21:47'),('main-thumb-71fa76d3bd767c106c05cc82063141409e705b4ec3641ad55c3998321f94218767a64038a2bc98d75bafb992c1fa16770b20b4b1062c0625e87e006ee5dbabb5.jpg','IMAGE','jpg','Exodus 03.jpg',0,'2021-07-05 01:29:36'),('main-thumb-7640f2fd2c849bfd0ea280eb8700d82626f09cfedb585ef5c2bce9ff196f5d50a2879869b4d4221c81c977fbd690e1f25e2c5b8976f0c5c57f12831c55f1a3ae.jpg','IMAGE','jpg','Arbo-1.jpg',0,'2021-07-05 00:06:40'),('main-thumb-787f31075fc96d8d597d26b1cecd42467bf51d51fdda1d68ca4d9dd691b755e3cec35c0a2436d23424ee780fdb39dcf2d52f62211c3b138dd5f07af64965b47b.jpg','IMAGE','jpg','Green-Day-2.jpg',0,'2021-07-05 01:35:29'),('main-thumb-7ddc27f6856a00e06fefa1e576c6c9f12a23ecede086ff47e9b4d9b7c1674eab624d785abec701917ec944ec306c11a7c6b1d7b63ed3ea42caa772e485174a3f.jpg','IMAGE','jpg','Jack-dan.jpg',0,'2021-07-05 01:44:08'),('main-thumb-7ecfaa8ed80d8d1d18832412e2265051756d9db91ad7e6bd6d2ad8d56687809481b0075cb6d678d3434a2ecfd7ef2259ca3afee750a1e0031cc55f0b629f7c49.jpg','IMAGE','jpg','Artcell.jpg',0,'2021-07-05 00:16:04'),('main-thumb-80b041875934bfa734302f2e7ec59149991fa17f555853611e96014827a0c0044116b4552b697d2d2c5eb76a66f1be7ebe5101a3a2d0eeaedea8945370b2f8bd.jpg','IMAGE','jpg','Dream Theater 03.jpg',0,'2021-07-05 01:18:31'),('main-thumb-88c0a63cb0df7e8d4731bedf467615cd529f541c1502683a2f60f862d8bc4ff28a064e40b9d60dbdaa4b4290050a73d7a3321acde1a2d59204263d1436c8fb96.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:07'),('main-thumb-995152b3dd66a3fbeab945ee66a9c2e6eb3ce9fa087717334a398e74a98c0f6714e5dfcdca2f3a8184e6bb316ff5214b3caae02dc157716a5f7f5b5d56058c4c.jpg','IMAGE','jpg','EF.jpg',0,'2021-07-05 01:26:34'),('main-thumb-a328e64e8aa9a75788ce62f396c9508b8394e9041819d253ee99015a83ac0778e2aeff11b32ec3a443a08004eb1f930c0478bc78ca123045c287cab9d0abfa8f.jpg','IMAGE','jpg','Death 04.jpg',0,'2021-07-05 01:15:47'),('main-thumb-c06d03e8da9cf8e823998da92603931eafc6236bea236ffe0c3a5fb95f44270ccaa487774f429103dcd099d7dd1c7e49ad1563f4337f6d947fce7b657ffed83f.jpg','IMAGE','jpg','Iron Maiden Tem.jpg',0,'2021-07-05 01:41:19'),('main-thumb-c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpg','IMAGE','jpg','Clodplay.jpeg',0,'2021-07-05 00:58:26'),('main-thumb-d8e6f8cb88a5f4a3c54eccefd488d992f965c9d8dce932f270c9af1516dca4d61bd5d93a68e2fa95600ef0397c333de590a074a2dabf92527e7c8b4e97ad5ac6.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:55:28'),('main-thumb-e2597b6ccdf060723fe1724649f6efe944713a236e014e63775ee50833b16effd7297da7687832f45e1319440c3ad72c6b1f75b6c0f5659543e61e47b34273c5.jpg','IMAGE','jpg','Alter Bridge 03.jpg',0,'2021-07-04 23:59:54'),('main-thumb-fc56cea2062c19295965fb10a1027da5a0482dad6496ac4de22e9276c1a70bd0e9401e8c533aaa9670b1ba8178b2480ca5d23674f3ad1288989e7eb269b31b76.jpg','IMAGE','jpg','Black Sabbath 03.jpg',0,'2021-07-05 00:33:33'),('pos-details-thumb-00b317f394b44f212c858b83e2624e1c7b37a5cb4ac0100512c9aa564a2ca647f6d4035f39dd3eea98edc6a3e3b6b68b9e9b856eb1f5a3fa040ed1e0ef31f97d.jpg','IMAGE','jpg','Children of boddom.jpg',0,'2021-07-05 00:55:33'),('pos-details-thumb-0d74cde5f4f7e2b552f6f00a28475be3817f4047d6acadec00bf881d0511d26dee5738ed432cf9be48e0423156920ceea2e5880f242bb5ef4dab243fbf242b59.jpg','IMAGE','jpg','Cryptic-Fate.jpg',0,'2021-07-05 01:11:36'),('pos-details-thumb-1297a2396a30ca46712bd966e0f5a704beb99b368a5f8a08d7497f98f50368ecb0dc9a1eec2403e023051980d048c0f2a6cb88f8f5aaa05b1729b7031b16c29a.jpg','IMAGE','jpg','Bullet.jpg',0,'2021-07-05 00:41:23'),('pos-details-thumb-21dcb886099b7fff57554f553b7b5e1ea76f663c14425943da7a7fdf9c697c970eabe719badd201bcfe6664314a10058e11155b5335f31aeb27528c4a3cc0c3c.jpg','IMAGE','jpg','Buttet for my valentine 04.jpg',0,'2021-07-05 00:51:33'),('pos-details-thumb-240471f00c1689e4f576ce5c2dece2a6d9c0934de0d3dd9233cfc1919d2ca19e3fa55caf68517856a6e6d850cf6fbd94bede70a5c23e8c5005735a71f1c6277f.jpg','IMAGE','jpg','Behemoth (5).jpg',0,'2021-07-05 00:25:35'),('pos-details-thumb-2abb97bbfa21d1104446329b2322c41909ad3f8eb7646d3f4e3d5b8209f2e12a381a2a28847da724877f3b16e4476b205d99217bd969a0f0ccd58816344f3cf5.jpg','IMAGE','jpg','Judas Priest (2).jpg',0,'2021-07-05 01:46:37'),('pos-details-thumb-2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg','IMAGE','jpg','Abbath Tem.jpg',0,'2021-07-04 23:35:18'),('pos-details-thumb-2ded2c215ee6d265254ff53369ec7a60b186080bc19d768c1df98932b455aa607bcaaf1dcba51804c58c39ad6f206ef0a628cfcade29fa4315d5ec912ab102e8.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:48'),('pos-details-thumb-312b9c2815cc5e2c12b3203c9108b6a514ebae1ff6b3c31a7bc84042dd21170df08e261726db7460e8f2f4185b8b64ad50f7874693df548d01595e0e0e28cb10.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:24'),('pos-details-thumb-3ca5cc78ca0139dd2d1b2827de831202a25a35a85994887d9517bd6af4dd490d656db44cde308c880138297680c2e14bc03fdf89021854712dc34bb10e3ed32e.jpg','IMAGE','jpg','Black Sabbath 05.jpg',0,'2021-07-05 00:36:55'),('pos-details-thumb-4d883a410bcef57722397d21978d882a353c7105914bfd145b776fe9eb7bc2a055f1fd17c3eb311d1ab0e3be8c5e5f71eea8c403f12183754618cdc59ca8d177.jpg','IMAGE','jpg','Green-Army.jpg',0,'2021-07-05 01:32:46'),('pos-details-thumb-4f45ed406ba8bc090593dadbfcbf50c624ae8e0048e1bbbbf1c0fbbb0c40ce67283197be1ac382ac11a298d2a7896e940986a64114d74ba648b7c1f38862c6d3.jpg','IMAGE','jpg','Iron maiden 04.jpg',0,'2021-07-05 01:38:41'),('pos-details-thumb-575429d839bbf41a3485eb88522e59c42d45539b1a478534442992dcf2854cdfc6ef153b31e015c35e255500ee53d91f7277a00915d633cb4a048fff94e7ac8e.jpg','IMAGE','jpg','Black sabbath 02.jpg',0,'2021-07-05 00:29:27'),('pos-details-thumb-6359e6902f1a22c92dd3d42b2d2625fd858a82bc952a51da9f8c99939dba6db21fe7a21f9ce457967c4452bddda4c9c0c6a1210725385c3d79d632a2cb02e829.jpg','IMAGE','jpg','Dream Theater 04.jpg',0,'2021-07-05 01:21:47'),('pos-details-thumb-71fa76d3bd767c106c05cc82063141409e705b4ec3641ad55c3998321f94218767a64038a2bc98d75bafb992c1fa16770b20b4b1062c0625e87e006ee5dbabb5.jpg','IMAGE','jpg','Exodus 03.jpg',0,'2021-07-05 01:29:36'),('pos-details-thumb-7640f2fd2c849bfd0ea280eb8700d82626f09cfedb585ef5c2bce9ff196f5d50a2879869b4d4221c81c977fbd690e1f25e2c5b8976f0c5c57f12831c55f1a3ae.jpg','IMAGE','jpg','Arbo-1.jpg',0,'2021-07-05 00:06:40'),('pos-details-thumb-787f31075fc96d8d597d26b1cecd42467bf51d51fdda1d68ca4d9dd691b755e3cec35c0a2436d23424ee780fdb39dcf2d52f62211c3b138dd5f07af64965b47b.jpg','IMAGE','jpg','Green-Day-2.jpg',0,'2021-07-05 01:35:29'),('pos-details-thumb-7ddc27f6856a00e06fefa1e576c6c9f12a23ecede086ff47e9b4d9b7c1674eab624d785abec701917ec944ec306c11a7c6b1d7b63ed3ea42caa772e485174a3f.jpg','IMAGE','jpg','Jack-dan.jpg',0,'2021-07-05 01:44:08'),('pos-details-thumb-7ecfaa8ed80d8d1d18832412e2265051756d9db91ad7e6bd6d2ad8d56687809481b0075cb6d678d3434a2ecfd7ef2259ca3afee750a1e0031cc55f0b629f7c49.jpg','IMAGE','jpg','Artcell.jpg',0,'2021-07-05 00:16:04'),('pos-details-thumb-80b041875934bfa734302f2e7ec59149991fa17f555853611e96014827a0c0044116b4552b697d2d2c5eb76a66f1be7ebe5101a3a2d0eeaedea8945370b2f8bd.jpg','IMAGE','jpg','Dream Theater 03.jpg',0,'2021-07-05 01:18:31'),('pos-details-thumb-88c0a63cb0df7e8d4731bedf467615cd529f541c1502683a2f60f862d8bc4ff28a064e40b9d60dbdaa4b4290050a73d7a3321acde1a2d59204263d1436c8fb96.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:07'),('pos-details-thumb-995152b3dd66a3fbeab945ee66a9c2e6eb3ce9fa087717334a398e74a98c0f6714e5dfcdca2f3a8184e6bb316ff5214b3caae02dc157716a5f7f5b5d56058c4c.jpg','IMAGE','jpg','EF.jpg',0,'2021-07-05 01:26:34'),('pos-details-thumb-a328e64e8aa9a75788ce62f396c9508b8394e9041819d253ee99015a83ac0778e2aeff11b32ec3a443a08004eb1f930c0478bc78ca123045c287cab9d0abfa8f.jpg','IMAGE','jpg','Death 04.jpg',0,'2021-07-05 01:15:47'),('pos-details-thumb-c06d03e8da9cf8e823998da92603931eafc6236bea236ffe0c3a5fb95f44270ccaa487774f429103dcd099d7dd1c7e49ad1563f4337f6d947fce7b657ffed83f.jpg','IMAGE','jpg','Iron Maiden Tem.jpg',0,'2021-07-05 01:41:19'),('pos-details-thumb-c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpg','IMAGE','jpg','Clodplay.jpeg',0,'2021-07-05 00:58:26'),('pos-details-thumb-d8e6f8cb88a5f4a3c54eccefd488d992f965c9d8dce932f270c9af1516dca4d61bd5d93a68e2fa95600ef0397c333de590a074a2dabf92527e7c8b4e97ad5ac6.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:55:28'),('pos-details-thumb-e2597b6ccdf060723fe1724649f6efe944713a236e014e63775ee50833b16effd7297da7687832f45e1319440c3ad72c6b1f75b6c0f5659543e61e47b34273c5.jpg','IMAGE','jpg','Alter Bridge 03.jpg',0,'2021-07-04 23:59:54'),('pos-details-thumb-fc56cea2062c19295965fb10a1027da5a0482dad6496ac4de22e9276c1a70bd0e9401e8c533aaa9670b1ba8178b2480ca5d23674f3ad1288989e7eb269b31b76.jpg','IMAGE','jpg','Black Sabbath 03.jpg',0,'2021-07-05 00:33:33'),('pos-large-thumb-00b317f394b44f212c858b83e2624e1c7b37a5cb4ac0100512c9aa564a2ca647f6d4035f39dd3eea98edc6a3e3b6b68b9e9b856eb1f5a3fa040ed1e0ef31f97d.jpg','IMAGE','jpg','Children of boddom.jpg',0,'2021-07-05 00:55:33'),('pos-large-thumb-0d74cde5f4f7e2b552f6f00a28475be3817f4047d6acadec00bf881d0511d26dee5738ed432cf9be48e0423156920ceea2e5880f242bb5ef4dab243fbf242b59.jpg','IMAGE','jpg','Cryptic-Fate.jpg',0,'2021-07-05 01:11:36'),('pos-large-thumb-1297a2396a30ca46712bd966e0f5a704beb99b368a5f8a08d7497f98f50368ecb0dc9a1eec2403e023051980d048c0f2a6cb88f8f5aaa05b1729b7031b16c29a.jpg','IMAGE','jpg','Bullet.jpg',0,'2021-07-05 00:41:23'),('pos-large-thumb-21dcb886099b7fff57554f553b7b5e1ea76f663c14425943da7a7fdf9c697c970eabe719badd201bcfe6664314a10058e11155b5335f31aeb27528c4a3cc0c3c.jpg','IMAGE','jpg','Buttet for my valentine 04.jpg',0,'2021-07-05 00:51:33'),('pos-large-thumb-240471f00c1689e4f576ce5c2dece2a6d9c0934de0d3dd9233cfc1919d2ca19e3fa55caf68517856a6e6d850cf6fbd94bede70a5c23e8c5005735a71f1c6277f.jpg','IMAGE','jpg','Behemoth (5).jpg',0,'2021-07-05 00:25:35'),('pos-large-thumb-2abb97bbfa21d1104446329b2322c41909ad3f8eb7646d3f4e3d5b8209f2e12a381a2a28847da724877f3b16e4476b205d99217bd969a0f0ccd58816344f3cf5.jpg','IMAGE','jpg','Judas Priest (2).jpg',0,'2021-07-05 01:46:37'),('pos-large-thumb-2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg','IMAGE','jpg','Abbath Tem.jpg',0,'2021-07-04 23:35:18'),('pos-large-thumb-2ded2c215ee6d265254ff53369ec7a60b186080bc19d768c1df98932b455aa607bcaaf1dcba51804c58c39ad6f206ef0a628cfcade29fa4315d5ec912ab102e8.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:48'),('pos-large-thumb-312b9c2815cc5e2c12b3203c9108b6a514ebae1ff6b3c31a7bc84042dd21170df08e261726db7460e8f2f4185b8b64ad50f7874693df548d01595e0e0e28cb10.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:24'),('pos-large-thumb-3ca5cc78ca0139dd2d1b2827de831202a25a35a85994887d9517bd6af4dd490d656db44cde308c880138297680c2e14bc03fdf89021854712dc34bb10e3ed32e.jpg','IMAGE','jpg','Black Sabbath 05.jpg',0,'2021-07-05 00:36:55'),('pos-large-thumb-4d883a410bcef57722397d21978d882a353c7105914bfd145b776fe9eb7bc2a055f1fd17c3eb311d1ab0e3be8c5e5f71eea8c403f12183754618cdc59ca8d177.jpg','IMAGE','jpg','Green-Army.jpg',0,'2021-07-05 01:32:46'),('pos-large-thumb-4f45ed406ba8bc090593dadbfcbf50c624ae8e0048e1bbbbf1c0fbbb0c40ce67283197be1ac382ac11a298d2a7896e940986a64114d74ba648b7c1f38862c6d3.jpg','IMAGE','jpg','Iron maiden 04.jpg',0,'2021-07-05 01:38:41'),('pos-large-thumb-575429d839bbf41a3485eb88522e59c42d45539b1a478534442992dcf2854cdfc6ef153b31e015c35e255500ee53d91f7277a00915d633cb4a048fff94e7ac8e.jpg','IMAGE','jpg','Black sabbath 02.jpg',0,'2021-07-05 00:29:27'),('pos-large-thumb-6359e6902f1a22c92dd3d42b2d2625fd858a82bc952a51da9f8c99939dba6db21fe7a21f9ce457967c4452bddda4c9c0c6a1210725385c3d79d632a2cb02e829.jpg','IMAGE','jpg','Dream Theater 04.jpg',0,'2021-07-05 01:21:47'),('pos-large-thumb-71fa76d3bd767c106c05cc82063141409e705b4ec3641ad55c3998321f94218767a64038a2bc98d75bafb992c1fa16770b20b4b1062c0625e87e006ee5dbabb5.jpg','IMAGE','jpg','Exodus 03.jpg',0,'2021-07-05 01:29:36'),('pos-large-thumb-7640f2fd2c849bfd0ea280eb8700d82626f09cfedb585ef5c2bce9ff196f5d50a2879869b4d4221c81c977fbd690e1f25e2c5b8976f0c5c57f12831c55f1a3ae.jpg','IMAGE','jpg','Arbo-1.jpg',0,'2021-07-05 00:06:39'),('pos-large-thumb-787f31075fc96d8d597d26b1cecd42467bf51d51fdda1d68ca4d9dd691b755e3cec35c0a2436d23424ee780fdb39dcf2d52f62211c3b138dd5f07af64965b47b.jpg','IMAGE','jpg','Green-Day-2.jpg',0,'2021-07-05 01:35:29'),('pos-large-thumb-7ddc27f6856a00e06fefa1e576c6c9f12a23ecede086ff47e9b4d9b7c1674eab624d785abec701917ec944ec306c11a7c6b1d7b63ed3ea42caa772e485174a3f.jpg','IMAGE','jpg','Jack-dan.jpg',0,'2021-07-05 01:44:08'),('pos-large-thumb-7ecfaa8ed80d8d1d18832412e2265051756d9db91ad7e6bd6d2ad8d56687809481b0075cb6d678d3434a2ecfd7ef2259ca3afee750a1e0031cc55f0b629f7c49.jpg','IMAGE','jpg','Artcell.jpg',0,'2021-07-05 00:16:04'),('pos-large-thumb-80b041875934bfa734302f2e7ec59149991fa17f555853611e96014827a0c0044116b4552b697d2d2c5eb76a66f1be7ebe5101a3a2d0eeaedea8945370b2f8bd.jpg','IMAGE','jpg','Dream Theater 03.jpg',0,'2021-07-05 01:18:31'),('pos-large-thumb-88c0a63cb0df7e8d4731bedf467615cd529f541c1502683a2f60f862d8bc4ff28a064e40b9d60dbdaa4b4290050a73d7a3321acde1a2d59204263d1436c8fb96.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:07'),('pos-large-thumb-995152b3dd66a3fbeab945ee66a9c2e6eb3ce9fa087717334a398e74a98c0f6714e5dfcdca2f3a8184e6bb316ff5214b3caae02dc157716a5f7f5b5d56058c4c.jpg','IMAGE','jpg','EF.jpg',0,'2021-07-05 01:26:34'),('pos-large-thumb-a328e64e8aa9a75788ce62f396c9508b8394e9041819d253ee99015a83ac0778e2aeff11b32ec3a443a08004eb1f930c0478bc78ca123045c287cab9d0abfa8f.jpg','IMAGE','jpg','Death 04.jpg',0,'2021-07-05 01:15:47'),('pos-large-thumb-c06d03e8da9cf8e823998da92603931eafc6236bea236ffe0c3a5fb95f44270ccaa487774f429103dcd099d7dd1c7e49ad1563f4337f6d947fce7b657ffed83f.jpg','IMAGE','jpg','Iron Maiden Tem.jpg',0,'2021-07-05 01:41:19'),('pos-large-thumb-c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpg','IMAGE','jpg','Clodplay.jpeg',0,'2021-07-05 00:58:26'),('pos-large-thumb-d8e6f8cb88a5f4a3c54eccefd488d992f965c9d8dce932f270c9af1516dca4d61bd5d93a68e2fa95600ef0397c333de590a074a2dabf92527e7c8b4e97ad5ac6.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:55:28'),('pos-large-thumb-e2597b6ccdf060723fe1724649f6efe944713a236e014e63775ee50833b16effd7297da7687832f45e1319440c3ad72c6b1f75b6c0f5659543e61e47b34273c5.jpg','IMAGE','jpg','Alter Bridge 03.jpg',0,'2021-07-04 23:59:54'),('pos-large-thumb-fc56cea2062c19295965fb10a1027da5a0482dad6496ac4de22e9276c1a70bd0e9401e8c533aaa9670b1ba8178b2480ca5d23674f3ad1288989e7eb269b31b76.jpg','IMAGE','jpg','Black Sabbath 03.jpg',0,'2021-07-05 00:33:33'),('related-thumb-00b317f394b44f212c858b83e2624e1c7b37a5cb4ac0100512c9aa564a2ca647f6d4035f39dd3eea98edc6a3e3b6b68b9e9b856eb1f5a3fa040ed1e0ef31f97d.jpg','IMAGE','jpg','Children of boddom.jpg',0,'2021-07-05 00:55:33'),('related-thumb-0d74cde5f4f7e2b552f6f00a28475be3817f4047d6acadec00bf881d0511d26dee5738ed432cf9be48e0423156920ceea2e5880f242bb5ef4dab243fbf242b59.jpg','IMAGE','jpg','Cryptic-Fate.jpg',0,'2021-07-05 01:11:36'),('related-thumb-1297a2396a30ca46712bd966e0f5a704beb99b368a5f8a08d7497f98f50368ecb0dc9a1eec2403e023051980d048c0f2a6cb88f8f5aaa05b1729b7031b16c29a.jpg','IMAGE','jpg','Bullet.jpg',0,'2021-07-05 00:41:23'),('related-thumb-21dcb886099b7fff57554f553b7b5e1ea76f663c14425943da7a7fdf9c697c970eabe719badd201bcfe6664314a10058e11155b5335f31aeb27528c4a3cc0c3c.jpg','IMAGE','jpg','Buttet for my valentine 04.jpg',0,'2021-07-05 00:51:33'),('related-thumb-240471f00c1689e4f576ce5c2dece2a6d9c0934de0d3dd9233cfc1919d2ca19e3fa55caf68517856a6e6d850cf6fbd94bede70a5c23e8c5005735a71f1c6277f.jpg','IMAGE','jpg','Behemoth (5).jpg',0,'2021-07-05 00:25:35'),('related-thumb-2abb97bbfa21d1104446329b2322c41909ad3f8eb7646d3f4e3d5b8209f2e12a381a2a28847da724877f3b16e4476b205d99217bd969a0f0ccd58816344f3cf5.jpg','IMAGE','jpg','Judas Priest (2).jpg',0,'2021-07-05 01:46:37'),('related-thumb-2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg','IMAGE','jpg','Abbath Tem.jpg',0,'2021-07-04 23:35:18'),('related-thumb-2ded2c215ee6d265254ff53369ec7a60b186080bc19d768c1df98932b455aa607bcaaf1dcba51804c58c39ad6f206ef0a628cfcade29fa4315d5ec912ab102e8.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:48'),('related-thumb-312b9c2815cc5e2c12b3203c9108b6a514ebae1ff6b3c31a7bc84042dd21170df08e261726db7460e8f2f4185b8b64ad50f7874693df548d01595e0e0e28cb10.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:24'),('related-thumb-3ca5cc78ca0139dd2d1b2827de831202a25a35a85994887d9517bd6af4dd490d656db44cde308c880138297680c2e14bc03fdf89021854712dc34bb10e3ed32e.jpg','IMAGE','jpg','Black Sabbath 05.jpg',0,'2021-07-05 00:36:55'),('related-thumb-4d883a410bcef57722397d21978d882a353c7105914bfd145b776fe9eb7bc2a055f1fd17c3eb311d1ab0e3be8c5e5f71eea8c403f12183754618cdc59ca8d177.jpg','IMAGE','jpg','Green-Army.jpg',0,'2021-07-05 01:32:46'),('related-thumb-4f45ed406ba8bc090593dadbfcbf50c624ae8e0048e1bbbbf1c0fbbb0c40ce67283197be1ac382ac11a298d2a7896e940986a64114d74ba648b7c1f38862c6d3.jpg','IMAGE','jpg','Iron maiden 04.jpg',0,'2021-07-05 01:38:41'),('related-thumb-575429d839bbf41a3485eb88522e59c42d45539b1a478534442992dcf2854cdfc6ef153b31e015c35e255500ee53d91f7277a00915d633cb4a048fff94e7ac8e.jpg','IMAGE','jpg','Black sabbath 02.jpg',0,'2021-07-05 00:29:28'),('related-thumb-6359e6902f1a22c92dd3d42b2d2625fd858a82bc952a51da9f8c99939dba6db21fe7a21f9ce457967c4452bddda4c9c0c6a1210725385c3d79d632a2cb02e829.jpg','IMAGE','jpg','Dream Theater 04.jpg',0,'2021-07-05 01:21:47'),('related-thumb-71fa76d3bd767c106c05cc82063141409e705b4ec3641ad55c3998321f94218767a64038a2bc98d75bafb992c1fa16770b20b4b1062c0625e87e006ee5dbabb5.jpg','IMAGE','jpg','Exodus 03.jpg',0,'2021-07-05 01:29:36'),('related-thumb-7640f2fd2c849bfd0ea280eb8700d82626f09cfedb585ef5c2bce9ff196f5d50a2879869b4d4221c81c977fbd690e1f25e2c5b8976f0c5c57f12831c55f1a3ae.jpg','IMAGE','jpg','Arbo-1.jpg',0,'2021-07-05 00:06:40'),('related-thumb-787f31075fc96d8d597d26b1cecd42467bf51d51fdda1d68ca4d9dd691b755e3cec35c0a2436d23424ee780fdb39dcf2d52f62211c3b138dd5f07af64965b47b.jpg','IMAGE','jpg','Green-Day-2.jpg',0,'2021-07-05 01:35:29'),('related-thumb-7ddc27f6856a00e06fefa1e576c6c9f12a23ecede086ff47e9b4d9b7c1674eab624d785abec701917ec944ec306c11a7c6b1d7b63ed3ea42caa772e485174a3f.jpg','IMAGE','jpg','Jack-dan.jpg',0,'2021-07-05 01:44:08'),('related-thumb-7ecfaa8ed80d8d1d18832412e2265051756d9db91ad7e6bd6d2ad8d56687809481b0075cb6d678d3434a2ecfd7ef2259ca3afee750a1e0031cc55f0b629f7c49.jpg','IMAGE','jpg','Artcell.jpg',0,'2021-07-05 00:16:04'),('related-thumb-80b041875934bfa734302f2e7ec59149991fa17f555853611e96014827a0c0044116b4552b697d2d2c5eb76a66f1be7ebe5101a3a2d0eeaedea8945370b2f8bd.jpg','IMAGE','jpg','Dream Theater 03.jpg',0,'2021-07-05 01:18:31'),('related-thumb-88c0a63cb0df7e8d4731bedf467615cd529f541c1502683a2f60f862d8bc4ff28a064e40b9d60dbdaa4b4290050a73d7a3321acde1a2d59204263d1436c8fb96.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:07'),('related-thumb-995152b3dd66a3fbeab945ee66a9c2e6eb3ce9fa087717334a398e74a98c0f6714e5dfcdca2f3a8184e6bb316ff5214b3caae02dc157716a5f7f5b5d56058c4c.jpg','IMAGE','jpg','EF.jpg',0,'2021-07-05 01:26:34'),('related-thumb-a328e64e8aa9a75788ce62f396c9508b8394e9041819d253ee99015a83ac0778e2aeff11b32ec3a443a08004eb1f930c0478bc78ca123045c287cab9d0abfa8f.jpg','IMAGE','jpg','Death 04.jpg',0,'2021-07-05 01:15:47'),('related-thumb-c06d03e8da9cf8e823998da92603931eafc6236bea236ffe0c3a5fb95f44270ccaa487774f429103dcd099d7dd1c7e49ad1563f4337f6d947fce7b657ffed83f.jpg','IMAGE','jpg','Iron Maiden Tem.jpg',0,'2021-07-05 01:41:19'),('related-thumb-c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpg','IMAGE','jpg','Clodplay.jpeg',0,'2021-07-05 00:58:26'),('related-thumb-d8e6f8cb88a5f4a3c54eccefd488d992f965c9d8dce932f270c9af1516dca4d61bd5d93a68e2fa95600ef0397c333de590a074a2dabf92527e7c8b4e97ad5ac6.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:55:28'),('related-thumb-e2597b6ccdf060723fe1724649f6efe944713a236e014e63775ee50833b16effd7297da7687832f45e1319440c3ad72c6b1f75b6c0f5659543e61e47b34273c5.jpg','IMAGE','jpg','Alter Bridge 03.jpg',0,'2021-07-04 23:59:54'),('related-thumb-fc56cea2062c19295965fb10a1027da5a0482dad6496ac4de22e9276c1a70bd0e9401e8c533aaa9670b1ba8178b2480ca5d23674f3ad1288989e7eb269b31b76.jpg','IMAGE','jpg','Black Sabbath 03.jpg',0,'2021-07-05 00:33:33'),('shop-list-thumb-00b317f394b44f212c858b83e2624e1c7b37a5cb4ac0100512c9aa564a2ca647f6d4035f39dd3eea98edc6a3e3b6b68b9e9b856eb1f5a3fa040ed1e0ef31f97d.jpg','IMAGE','jpg','Children of boddom.jpg',0,'2021-07-05 00:55:33'),('shop-list-thumb-0d74cde5f4f7e2b552f6f00a28475be3817f4047d6acadec00bf881d0511d26dee5738ed432cf9be48e0423156920ceea2e5880f242bb5ef4dab243fbf242b59.jpg','IMAGE','jpg','Cryptic-Fate.jpg',0,'2021-07-05 01:11:36'),('shop-list-thumb-1297a2396a30ca46712bd966e0f5a704beb99b368a5f8a08d7497f98f50368ecb0dc9a1eec2403e023051980d048c0f2a6cb88f8f5aaa05b1729b7031b16c29a.jpg','IMAGE','jpg','Bullet.jpg',0,'2021-07-05 00:41:23'),('shop-list-thumb-21dcb886099b7fff57554f553b7b5e1ea76f663c14425943da7a7fdf9c697c970eabe719badd201bcfe6664314a10058e11155b5335f31aeb27528c4a3cc0c3c.jpg','IMAGE','jpg','Buttet for my valentine 04.jpg',0,'2021-07-05 00:51:33'),('shop-list-thumb-240471f00c1689e4f576ce5c2dece2a6d9c0934de0d3dd9233cfc1919d2ca19e3fa55caf68517856a6e6d850cf6fbd94bede70a5c23e8c5005735a71f1c6277f.jpg','IMAGE','jpg','Behemoth (5).jpg',0,'2021-07-05 00:25:35'),('shop-list-thumb-2abb97bbfa21d1104446329b2322c41909ad3f8eb7646d3f4e3d5b8209f2e12a381a2a28847da724877f3b16e4476b205d99217bd969a0f0ccd58816344f3cf5.jpg','IMAGE','jpg','Judas Priest (2).jpg',0,'2021-07-05 01:46:37'),('shop-list-thumb-2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg','IMAGE','jpg','Abbath Tem.jpg',0,'2021-07-04 23:35:18'),('shop-list-thumb-2ded2c215ee6d265254ff53369ec7a60b186080bc19d768c1df98932b455aa607bcaaf1dcba51804c58c39ad6f206ef0a628cfcade29fa4315d5ec912ab102e8.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:48'),('shop-list-thumb-312b9c2815cc5e2c12b3203c9108b6a514ebae1ff6b3c31a7bc84042dd21170df08e261726db7460e8f2f4185b8b64ad50f7874693df548d01595e0e0e28cb10.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:24'),('shop-list-thumb-3ca5cc78ca0139dd2d1b2827de831202a25a35a85994887d9517bd6af4dd490d656db44cde308c880138297680c2e14bc03fdf89021854712dc34bb10e3ed32e.jpg','IMAGE','jpg','Black Sabbath 05.jpg',0,'2021-07-05 00:36:55'),('shop-list-thumb-4d883a410bcef57722397d21978d882a353c7105914bfd145b776fe9eb7bc2a055f1fd17c3eb311d1ab0e3be8c5e5f71eea8c403f12183754618cdc59ca8d177.jpg','IMAGE','jpg','Green-Army.jpg',0,'2021-07-05 01:32:46'),('shop-list-thumb-4f45ed406ba8bc090593dadbfcbf50c624ae8e0048e1bbbbf1c0fbbb0c40ce67283197be1ac382ac11a298d2a7896e940986a64114d74ba648b7c1f38862c6d3.jpg','IMAGE','jpg','Iron maiden 04.jpg',0,'2021-07-05 01:38:41'),('shop-list-thumb-575429d839bbf41a3485eb88522e59c42d45539b1a478534442992dcf2854cdfc6ef153b31e015c35e255500ee53d91f7277a00915d633cb4a048fff94e7ac8e.jpg','IMAGE','jpg','Black sabbath 02.jpg',0,'2021-07-05 00:29:28'),('shop-list-thumb-6359e6902f1a22c92dd3d42b2d2625fd858a82bc952a51da9f8c99939dba6db21fe7a21f9ce457967c4452bddda4c9c0c6a1210725385c3d79d632a2cb02e829.jpg','IMAGE','jpg','Dream Theater 04.jpg',0,'2021-07-05 01:21:47'),('shop-list-thumb-71fa76d3bd767c106c05cc82063141409e705b4ec3641ad55c3998321f94218767a64038a2bc98d75bafb992c1fa16770b20b4b1062c0625e87e006ee5dbabb5.jpg','IMAGE','jpg','Exodus 03.jpg',0,'2021-07-05 01:29:36'),('shop-list-thumb-7640f2fd2c849bfd0ea280eb8700d82626f09cfedb585ef5c2bce9ff196f5d50a2879869b4d4221c81c977fbd690e1f25e2c5b8976f0c5c57f12831c55f1a3ae.jpg','IMAGE','jpg','Arbo-1.jpg',0,'2021-07-05 00:06:40'),('shop-list-thumb-787f31075fc96d8d597d26b1cecd42467bf51d51fdda1d68ca4d9dd691b755e3cec35c0a2436d23424ee780fdb39dcf2d52f62211c3b138dd5f07af64965b47b.jpg','IMAGE','jpg','Green-Day-2.jpg',0,'2021-07-05 01:35:29'),('shop-list-thumb-7ddc27f6856a00e06fefa1e576c6c9f12a23ecede086ff47e9b4d9b7c1674eab624d785abec701917ec944ec306c11a7c6b1d7b63ed3ea42caa772e485174a3f.jpg','IMAGE','jpg','Jack-dan.jpg',0,'2021-07-05 01:44:08'),('shop-list-thumb-7ecfaa8ed80d8d1d18832412e2265051756d9db91ad7e6bd6d2ad8d56687809481b0075cb6d678d3434a2ecfd7ef2259ca3afee750a1e0031cc55f0b629f7c49.jpg','IMAGE','jpg','Artcell.jpg',0,'2021-07-05 00:16:04'),('shop-list-thumb-80b041875934bfa734302f2e7ec59149991fa17f555853611e96014827a0c0044116b4552b697d2d2c5eb76a66f1be7ebe5101a3a2d0eeaedea8945370b2f8bd.jpg','IMAGE','jpg','Dream Theater 03.jpg',0,'2021-07-05 01:18:31'),('shop-list-thumb-88c0a63cb0df7e8d4731bedf467615cd529f541c1502683a2f60f862d8bc4ff28a064e40b9d60dbdaa4b4290050a73d7a3321acde1a2d59204263d1436c8fb96.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:07'),('shop-list-thumb-995152b3dd66a3fbeab945ee66a9c2e6eb3ce9fa087717334a398e74a98c0f6714e5dfcdca2f3a8184e6bb316ff5214b3caae02dc157716a5f7f5b5d56058c4c.jpg','IMAGE','jpg','EF.jpg',0,'2021-07-05 01:26:34'),('shop-list-thumb-a328e64e8aa9a75788ce62f396c9508b8394e9041819d253ee99015a83ac0778e2aeff11b32ec3a443a08004eb1f930c0478bc78ca123045c287cab9d0abfa8f.jpg','IMAGE','jpg','Death 04.jpg',0,'2021-07-05 01:15:47'),('shop-list-thumb-c06d03e8da9cf8e823998da92603931eafc6236bea236ffe0c3a5fb95f44270ccaa487774f429103dcd099d7dd1c7e49ad1563f4337f6d947fce7b657ffed83f.jpg','IMAGE','jpg','Iron Maiden Tem.jpg',0,'2021-07-05 01:41:19'),('shop-list-thumb-c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpg','IMAGE','jpg','Clodplay.jpeg',0,'2021-07-05 00:58:26'),('shop-list-thumb-d8e6f8cb88a5f4a3c54eccefd488d992f965c9d8dce932f270c9af1516dca4d61bd5d93a68e2fa95600ef0397c333de590a074a2dabf92527e7c8b4e97ad5ac6.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:55:28'),('shop-list-thumb-e2597b6ccdf060723fe1724649f6efe944713a236e014e63775ee50833b16effd7297da7687832f45e1319440c3ad72c6b1f75b6c0f5659543e61e47b34273c5.jpg','IMAGE','jpg','Alter Bridge 03.jpg',0,'2021-07-04 23:59:54'),('shop-list-thumb-fc56cea2062c19295965fb10a1027da5a0482dad6496ac4de22e9276c1a70bd0e9401e8c533aaa9670b1ba8178b2480ca5d23674f3ad1288989e7eb269b31b76.jpg','IMAGE','jpg','Black Sabbath 03.jpg',0,'2021-07-05 00:33:33'),('sidebar-thumb-00b317f394b44f212c858b83e2624e1c7b37a5cb4ac0100512c9aa564a2ca647f6d4035f39dd3eea98edc6a3e3b6b68b9e9b856eb1f5a3fa040ed1e0ef31f97d.jpg','IMAGE','jpg','Children of boddom.jpg',0,'2021-07-05 00:55:33'),('sidebar-thumb-0d74cde5f4f7e2b552f6f00a28475be3817f4047d6acadec00bf881d0511d26dee5738ed432cf9be48e0423156920ceea2e5880f242bb5ef4dab243fbf242b59.jpg','IMAGE','jpg','Cryptic-Fate.jpg',0,'2021-07-05 01:11:36'),('sidebar-thumb-1297a2396a30ca46712bd966e0f5a704beb99b368a5f8a08d7497f98f50368ecb0dc9a1eec2403e023051980d048c0f2a6cb88f8f5aaa05b1729b7031b16c29a.jpg','IMAGE','jpg','Bullet.jpg',0,'2021-07-05 00:41:23'),('sidebar-thumb-21dcb886099b7fff57554f553b7b5e1ea76f663c14425943da7a7fdf9c697c970eabe719badd201bcfe6664314a10058e11155b5335f31aeb27528c4a3cc0c3c.jpg','IMAGE','jpg','Buttet for my valentine 04.jpg',0,'2021-07-05 00:51:33'),('sidebar-thumb-240471f00c1689e4f576ce5c2dece2a6d9c0934de0d3dd9233cfc1919d2ca19e3fa55caf68517856a6e6d850cf6fbd94bede70a5c23e8c5005735a71f1c6277f.jpg','IMAGE','jpg','Behemoth (5).jpg',0,'2021-07-05 00:25:35'),('sidebar-thumb-2abb97bbfa21d1104446329b2322c41909ad3f8eb7646d3f4e3d5b8209f2e12a381a2a28847da724877f3b16e4476b205d99217bd969a0f0ccd58816344f3cf5.jpg','IMAGE','jpg','Judas Priest (2).jpg',0,'2021-07-05 01:46:37'),('sidebar-thumb-2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg','IMAGE','jpg','Abbath Tem.jpg',0,'2021-07-04 23:35:18'),('sidebar-thumb-2ded2c215ee6d265254ff53369ec7a60b186080bc19d768c1df98932b455aa607bcaaf1dcba51804c58c39ad6f206ef0a628cfcade29fa4315d5ec912ab102e8.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:48'),('sidebar-thumb-312b9c2815cc5e2c12b3203c9108b6a514ebae1ff6b3c31a7bc84042dd21170df08e261726db7460e8f2f4185b8b64ad50f7874693df548d01595e0e0e28cb10.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:24'),('sidebar-thumb-3ca5cc78ca0139dd2d1b2827de831202a25a35a85994887d9517bd6af4dd490d656db44cde308c880138297680c2e14bc03fdf89021854712dc34bb10e3ed32e.jpg','IMAGE','jpg','Black Sabbath 05.jpg',0,'2021-07-05 00:36:55'),('sidebar-thumb-4d883a410bcef57722397d21978d882a353c7105914bfd145b776fe9eb7bc2a055f1fd17c3eb311d1ab0e3be8c5e5f71eea8c403f12183754618cdc59ca8d177.jpg','IMAGE','jpg','Green-Army.jpg',0,'2021-07-05 01:32:46'),('sidebar-thumb-4f45ed406ba8bc090593dadbfcbf50c624ae8e0048e1bbbbf1c0fbbb0c40ce67283197be1ac382ac11a298d2a7896e940986a64114d74ba648b7c1f38862c6d3.jpg','IMAGE','jpg','Iron maiden 04.jpg',0,'2021-07-05 01:38:41'),('sidebar-thumb-575429d839bbf41a3485eb88522e59c42d45539b1a478534442992dcf2854cdfc6ef153b31e015c35e255500ee53d91f7277a00915d633cb4a048fff94e7ac8e.jpg','IMAGE','jpg','Black sabbath 02.jpg',0,'2021-07-05 00:29:28'),('sidebar-thumb-6359e6902f1a22c92dd3d42b2d2625fd858a82bc952a51da9f8c99939dba6db21fe7a21f9ce457967c4452bddda4c9c0c6a1210725385c3d79d632a2cb02e829.jpg','IMAGE','jpg','Dream Theater 04.jpg',0,'2021-07-05 01:21:47'),('sidebar-thumb-71fa76d3bd767c106c05cc82063141409e705b4ec3641ad55c3998321f94218767a64038a2bc98d75bafb992c1fa16770b20b4b1062c0625e87e006ee5dbabb5.jpg','IMAGE','jpg','Exodus 03.jpg',0,'2021-07-05 01:29:36'),('sidebar-thumb-7640f2fd2c849bfd0ea280eb8700d82626f09cfedb585ef5c2bce9ff196f5d50a2879869b4d4221c81c977fbd690e1f25e2c5b8976f0c5c57f12831c55f1a3ae.jpg','IMAGE','jpg','Arbo-1.jpg',0,'2021-07-05 00:06:40'),('sidebar-thumb-787f31075fc96d8d597d26b1cecd42467bf51d51fdda1d68ca4d9dd691b755e3cec35c0a2436d23424ee780fdb39dcf2d52f62211c3b138dd5f07af64965b47b.jpg','IMAGE','jpg','Green-Day-2.jpg',0,'2021-07-05 01:35:29'),('sidebar-thumb-7ddc27f6856a00e06fefa1e576c6c9f12a23ecede086ff47e9b4d9b7c1674eab624d785abec701917ec944ec306c11a7c6b1d7b63ed3ea42caa772e485174a3f.jpg','IMAGE','jpg','Jack-dan.jpg',0,'2021-07-05 01:44:08'),('sidebar-thumb-7ecfaa8ed80d8d1d18832412e2265051756d9db91ad7e6bd6d2ad8d56687809481b0075cb6d678d3434a2ecfd7ef2259ca3afee750a1e0031cc55f0b629f7c49.jpg','IMAGE','jpg','Artcell.jpg',0,'2021-07-05 00:16:04'),('sidebar-thumb-80b041875934bfa734302f2e7ec59149991fa17f555853611e96014827a0c0044116b4552b697d2d2c5eb76a66f1be7ebe5101a3a2d0eeaedea8945370b2f8bd.jpg','IMAGE','jpg','Dream Theater 03.jpg',0,'2021-07-05 01:18:31'),('sidebar-thumb-88c0a63cb0df7e8d4731bedf467615cd529f541c1502683a2f60f862d8bc4ff28a064e40b9d60dbdaa4b4290050a73d7a3321acde1a2d59204263d1436c8fb96.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:54:07'),('sidebar-thumb-995152b3dd66a3fbeab945ee66a9c2e6eb3ce9fa087717334a398e74a98c0f6714e5dfcdca2f3a8184e6bb316ff5214b3caae02dc157716a5f7f5b5d56058c4c.jpg','IMAGE','jpg','EF.jpg',0,'2021-07-05 01:26:34'),('sidebar-thumb-a328e64e8aa9a75788ce62f396c9508b8394e9041819d253ee99015a83ac0778e2aeff11b32ec3a443a08004eb1f930c0478bc78ca123045c287cab9d0abfa8f.jpg','IMAGE','jpg','Death 04.jpg',0,'2021-07-05 01:15:47'),('sidebar-thumb-c06d03e8da9cf8e823998da92603931eafc6236bea236ffe0c3a5fb95f44270ccaa487774f429103dcd099d7dd1c7e49ad1563f4337f6d947fce7b657ffed83f.jpg','IMAGE','jpg','Iron Maiden Tem.jpg',0,'2021-07-05 01:41:19'),('sidebar-thumb-c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpg','IMAGE','jpg','Clodplay.jpeg',0,'2021-07-05 00:58:26'),('sidebar-thumb-d8e6f8cb88a5f4a3c54eccefd488d992f965c9d8dce932f270c9af1516dca4d61bd5d93a68e2fa95600ef0397c333de590a074a2dabf92527e7c8b4e97ad5ac6.jpg','IMAGE','jpg','Ac dc 04.jpg',0,'2021-07-04 23:55:28'),('sidebar-thumb-e2597b6ccdf060723fe1724649f6efe944713a236e014e63775ee50833b16effd7297da7687832f45e1319440c3ad72c6b1f75b6c0f5659543e61e47b34273c5.jpg','IMAGE','jpg','Alter Bridge 03.jpg',0,'2021-07-04 23:59:54'),('sidebar-thumb-fc56cea2062c19295965fb10a1027da5a0482dad6496ac4de22e9276c1a70bd0e9401e8c533aaa9670b1ba8178b2480ca5d23674f3ad1288989e7eb269b31b76.jpg','IMAGE','jpg','Black Sabbath 03.jpg',0,'2021-07-05 00:33:33');
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
INSERT INTO `product_lookup` VALUES (1,1),(1,2),(1,91),(1,95),(1,96),(6,1),(6,6),(6,91),(6,95),(6,96),(7,1),(7,10),(7,91),(7,95),(7,96),(8,1),(8,15),(8,91),(8,95),(8,96),(9,1),(9,19),(9,91),(9,95),(9,96),(10,1),(10,26),(10,91),(10,95),(10,96),(11,1),(11,29),(11,91),(11,95),(11,96),(12,1),(12,29),(12,91),(12,95),(12,96),(13,1),(13,29),(13,91),(13,95),(13,96),(14,1),(14,35),(14,91),(14,95),(14,96),(16,1),(16,35),(16,91),(16,95),(16,96),(17,1),(17,39),(17,91),(17,95),(17,96),(18,1),(18,42),(18,91),(18,95),(18,96),(19,1),(19,48),(19,91),(19,95),(19,96),(20,1),(20,51),(20,91),(20,95),(20,96),(21,1),(21,65),(21,91),(21,95),(21,96),(22,1),(22,65),(22,91),(22,95),(22,96),(23,1),(23,74),(23,91),(23,95),(23,96),(24,1),(24,75),(24,91),(24,95),(24,96),(25,1),(25,85),(25,91),(25,95),(25,96),(26,1),(26,86),(26,91),(26,95),(26,96),(27,1),(27,91),(27,95),(27,96),(27,107),(28,1),(28,91),(28,95),(28,96),(28,107),(29,1),(29,91),(29,95),(29,96),(29,217),(30,1),(30,91),(30,95),(30,96),(30,108);
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
INSERT INTO `product_ottomanfile` VALUES (1,'2bf1426525275e8a8fffc52e7dc6b82013468a579f8846d91eb68fcc53f3d28b5c6c3c497fa9820b5114b91181ff849641d3591c21f317c0b9fb43492c463c86.jpg'),(6,'d8e6f8cb88a5f4a3c54eccefd488d992f965c9d8dce932f270c9af1516dca4d61bd5d93a68e2fa95600ef0397c333de590a074a2dabf92527e7c8b4e97ad5ac6.jpg'),(7,'e2597b6ccdf060723fe1724649f6efe944713a236e014e63775ee50833b16effd7297da7687832f45e1319440c3ad72c6b1f75b6c0f5659543e61e47b34273c5.jpg'),(8,'7640f2fd2c849bfd0ea280eb8700d82626f09cfedb585ef5c2bce9ff196f5d50a2879869b4d4221c81c977fbd690e1f25e2c5b8976f0c5c57f12831c55f1a3ae.jpg'),(9,'7ecfaa8ed80d8d1d18832412e2265051756d9db91ad7e6bd6d2ad8d56687809481b0075cb6d678d3434a2ecfd7ef2259ca3afee750a1e0031cc55f0b629f7c49.jpg'),(10,'240471f00c1689e4f576ce5c2dece2a6d9c0934de0d3dd9233cfc1919d2ca19e3fa55caf68517856a6e6d850cf6fbd94bede70a5c23e8c5005735a71f1c6277f.jpg'),(11,'575429d839bbf41a3485eb88522e59c42d45539b1a478534442992dcf2854cdfc6ef153b31e015c35e255500ee53d91f7277a00915d633cb4a048fff94e7ac8e.jpg'),(12,'fc56cea2062c19295965fb10a1027da5a0482dad6496ac4de22e9276c1a70bd0e9401e8c533aaa9670b1ba8178b2480ca5d23674f3ad1288989e7eb269b31b76.jpg'),(13,'3ca5cc78ca0139dd2d1b2827de831202a25a35a85994887d9517bd6af4dd490d656db44cde308c880138297680c2e14bc03fdf89021854712dc34bb10e3ed32e.jpg'),(14,'1297a2396a30ca46712bd966e0f5a704beb99b368a5f8a08d7497f98f50368ecb0dc9a1eec2403e023051980d048c0f2a6cb88f8f5aaa05b1729b7031b16c29a.jpg'),(16,'21dcb886099b7fff57554f553b7b5e1ea76f663c14425943da7a7fdf9c697c970eabe719badd201bcfe6664314a10058e11155b5335f31aeb27528c4a3cc0c3c.jpg'),(17,'00b317f394b44f212c858b83e2624e1c7b37a5cb4ac0100512c9aa564a2ca647f6d4035f39dd3eea98edc6a3e3b6b68b9e9b856eb1f5a3fa040ed1e0ef31f97d.jpg'),(18,'c4f0c392ab3cdba84cb097f39335bb1b71dcb67666c937af388ca255c094afc9d874ed94107e3d46cd52a21f7be1225abe206acd9d9a857e8387420d0a796557.jpeg'),(19,'0d74cde5f4f7e2b552f6f00a28475be3817f4047d6acadec00bf881d0511d26dee5738ed432cf9be48e0423156920ceea2e5880f242bb5ef4dab243fbf242b59.jpg'),(20,'a328e64e8aa9a75788ce62f396c9508b8394e9041819d253ee99015a83ac0778e2aeff11b32ec3a443a08004eb1f930c0478bc78ca123045c287cab9d0abfa8f.jpg'),(21,'80b041875934bfa734302f2e7ec59149991fa17f555853611e96014827a0c0044116b4552b697d2d2c5eb76a66f1be7ebe5101a3a2d0eeaedea8945370b2f8bd.jpg'),(22,'6359e6902f1a22c92dd3d42b2d2625fd858a82bc952a51da9f8c99939dba6db21fe7a21f9ce457967c4452bddda4c9c0c6a1210725385c3d79d632a2cb02e829.jpg'),(23,'995152b3dd66a3fbeab945ee66a9c2e6eb3ce9fa087717334a398e74a98c0f6714e5dfcdca2f3a8184e6bb316ff5214b3caae02dc157716a5f7f5b5d56058c4c.jpg'),(24,'71fa76d3bd767c106c05cc82063141409e705b4ec3641ad55c3998321f94218767a64038a2bc98d75bafb992c1fa16770b20b4b1062c0625e87e006ee5dbabb5.jpg'),(25,'4d883a410bcef57722397d21978d882a353c7105914bfd145b776fe9eb7bc2a055f1fd17c3eb311d1ab0e3be8c5e5f71eea8c403f12183754618cdc59ca8d177.jpg'),(26,'787f31075fc96d8d597d26b1cecd42467bf51d51fdda1d68ca4d9dd691b755e3cec35c0a2436d23424ee780fdb39dcf2d52f62211c3b138dd5f07af64965b47b.jpg'),(27,'4f45ed406ba8bc090593dadbfcbf50c624ae8e0048e1bbbbf1c0fbbb0c40ce67283197be1ac382ac11a298d2a7896e940986a64114d74ba648b7c1f38862c6d3.jpg'),(28,'c06d03e8da9cf8e823998da92603931eafc6236bea236ffe0c3a5fb95f44270ccaa487774f429103dcd099d7dd1c7e49ad1563f4337f6d947fce7b657ffed83f.jpg'),(29,'7ddc27f6856a00e06fefa1e576c6c9f12a23ecede086ff47e9b4d9b7c1674eab624d785abec701917ec944ec306c11a7c6b1d7b63ed3ea42caa772e485174a3f.jpg'),(30,'2abb97bbfa21d1104446329b2322c41909ad3f8eb7646d3f4e3d5b8209f2e12a381a2a28847da724877f3b16e4476b205d99217bd969a0f0ccd58816344f3cf5.jpg');
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
  `status` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `plain_description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description_format` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `popularity` double NOT NULL,
  `times_sold` int(11) NOT NULL,
  `rating` double NOT NULL,
  `view_count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Abbath','ABB001',400,0,'1-ABB001-2-5','','ACTIVE','','HTML',0,0,0,0),(6,'AC DC 04','ACDC04',400,0,'6-ACDC04-2-5','','ACTIVE','','HTML',0,0,0,0),(7,'Alter Bridge 03','ALR003',400,0,'7-ALR003-2-5','','ACTIVE','','HTML',0,0,0,0),(8,'Arbo-01','ARV001',400,0,'8-ARV001-3-5','','ACTIVE','','HTML',0,0,0,0),(9,'Artcell Red','ARTCL001',350,0,'9-ARTCL001-2-5','','ACTIVE','','HTML',0,0,0,0),(10,'Behemoth 05','BHMTH005',400,0,'10-BHMTH005-2-5','','ACTIVE','','HTML',0,0,0,0),(11,'Black Sabbath 02','BS002',400,0,'11-BS002-2-5','','ACTIVE','','HTML',0,0,0,0),(12,'Black Sabbath 03','BS003',400,0,'12-BS003-2-5','','ACTIVE','','HTML',0,0,0,0),(13,'Black Sabbath 05','BS005',400,0,'13-BS005-2-5','','ACTIVE','','HTML',0,0,0,0),(14,'Bullet For My Valentine 02','BFMV002',400,0,'14-BFMV002-2-5','','ACTIVE','','HTML',0,0,0,0),(16,'Bullet For My Valentine 04','BFMV004',400,0,'16-BFMV004-2-5','','ACTIVE','','HTML',0,0,0,0),(17,'Children Of Bodom 02','COB002',400,0,'17-COB002-2-5','','ACTIVE','','HTML',0,0,0,0),(18,'Coldplay','CP001',400,0,'18-CP001-2-5','','ACTIVE','','HTML',0,0,0,0),(19,'Cryptic Fate','CF001',350,0,'19-CF001-2-5','','ACTIVE','','HTML',0,0,0,0),(20,'Death 04','D004',400,0,'20-D004-2-5','','ACTIVE','','HTML',0,0,0,0),(21,'Dream Theater 03','DT003',400,0,'21-DT003-2-5','','ACTIVE','','HTML',0,0,0,0),(22,'Dream Theater 04','DT004',400,0,'22-DT004-2-5','','ACTIVE','','HTML',0,0,0,0),(23,'EF 01','EF001',350,0,'23-EF001-2-5','','ACTIVE','','HTML',0,0,0,0),(24,'Exodus 03','EXDS003',400,0,'24-EXDS003-2-5','','ACTIVE','','HTML',0,0,0,0),(25,'Green Army','GA001',400,0,'25-GA001-2-5','','ACTIVE','','HTML',0,0,0,0),(26,'Green Day 02','GD002',400,0,'26-GD002-2-5','','ACTIVE','','HTML',0,0,0,0),(27,'Iron Maiden 04','IM004',400,0,'27-IM004-2-5','','ACTIVE','','HTML',0,0,0,0),(28,'Iron Maiden 07','IM007',400,0,'28-IM007-2-5','','ACTIVE','','HTML',0,0,0,0),(29,'Jack Daniels','JD001',350,0,'29-JD001-2-5','','ACTIVE','','HTML',0,0,0,0),(30,'Judas Priest 02','JP002',350,0,'30-JP002-2-5','','ACTIVE','','HTML',0,0,0,0);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
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
INSERT INTO `sku_attribute_values` VALUES ('1-ABB001-2-10',2),('1-ABB001-2-4',2),('1-ABB001-2-5',2),('1-ABB001-2-6',2),('1-ABB001-2-7',2),('1-ABB001-2-8',2),('1-ABB001-2-9',2),('10-BHMTH005-2-10',2),('10-BHMTH005-2-4',2),('10-BHMTH005-2-5',2),('10-BHMTH005-2-6',2),('10-BHMTH005-2-7',2),('10-BHMTH005-2-8',2),('10-BHMTH005-2-9',2),('11-BS002-2-10',2),('11-BS002-2-4',2),('11-BS002-2-5',2),('11-BS002-2-6',2),('11-BS002-2-7',2),('11-BS002-2-8',2),('11-BS002-2-9',2),('12-BS003-2-10',2),('12-BS003-2-4',2),('12-BS003-2-5',2),('12-BS003-2-6',2),('12-BS003-2-7',2),('12-BS003-2-8',2),('12-BS003-2-9',2),('13-BS005-2-10',2),('13-BS005-2-4',2),('13-BS005-2-5',2),('13-BS005-2-6',2),('13-BS005-2-7',2),('13-BS005-2-8',2),('13-BS005-2-9',2),('14-BFMV002-2-10',2),('14-BFMV002-2-4',2),('14-BFMV002-2-5',2),('14-BFMV002-2-6',2),('14-BFMV002-2-7',2),('14-BFMV002-2-8',2),('14-BFMV002-2-9',2),('16-BFMV004-2-10',2),('16-BFMV004-2-4',2),('16-BFMV004-2-5',2),('16-BFMV004-2-6',2),('16-BFMV004-2-7',2),('16-BFMV004-2-8',2),('16-BFMV004-2-9',2),('17-COB002-2-10',2),('17-COB002-2-4',2),('17-COB002-2-5',2),('17-COB002-2-6',2),('17-COB002-2-7',2),('17-COB002-2-8',2),('17-COB002-2-9',2),('18-CP001-2-10',2),('18-CP001-2-4',2),('18-CP001-2-5',2),('18-CP001-2-6',2),('18-CP001-2-7',2),('18-CP001-2-8',2),('18-CP001-2-9',2),('19-CF001-2-10',2),('19-CF001-2-4',2),('19-CF001-2-5',2),('19-CF001-2-6',2),('19-CF001-2-7',2),('19-CF001-2-8',2),('19-CF001-2-9',2),('20-D004-2-10',2),('20-D004-2-4',2),('20-D004-2-5',2),('20-D004-2-6',2),('20-D004-2-7',2),('20-D004-2-8',2),('20-D004-2-9',2),('21-DT003-2-10',2),('21-DT003-2-4',2),('21-DT003-2-5',2),('21-DT003-2-6',2),('21-DT003-2-7',2),('21-DT003-2-8',2),('21-DT003-2-9',2),('22-DT004-2-10',2),('22-DT004-2-4',2),('22-DT004-2-5',2),('22-DT004-2-6',2),('22-DT004-2-7',2),('22-DT004-2-8',2),('22-DT004-2-9',2),('23-EF001-2-10',2),('23-EF001-2-4',2),('23-EF001-2-5',2),('23-EF001-2-6',2),('23-EF001-2-7',2),('23-EF001-2-8',2),('23-EF001-2-9',2),('24-EXDS003-2-10',2),('24-EXDS003-2-4',2),('24-EXDS003-2-5',2),('24-EXDS003-2-6',2),('24-EXDS003-2-7',2),('24-EXDS003-2-8',2),('24-EXDS003-2-9',2),('25-GA001-2-10',2),('25-GA001-2-4',2),('25-GA001-2-5',2),('25-GA001-2-6',2),('25-GA001-2-7',2),('25-GA001-2-8',2),('25-GA001-2-9',2),('26-GD002-2-10',2),('26-GD002-2-4',2),('26-GD002-2-5',2),('26-GD002-2-6',2),('26-GD002-2-7',2),('26-GD002-2-8',2),('26-GD002-2-9',2),('27-IM004-2-10',2),('27-IM004-2-4',2),('27-IM004-2-5',2),('27-IM004-2-6',2),('27-IM004-2-7',2),('27-IM004-2-8',2),('27-IM004-2-9',2),('28-IM007-2-10',2),('28-IM007-2-4',2),('28-IM007-2-5',2),('28-IM007-2-6',2),('28-IM007-2-7',2),('28-IM007-2-8',2),('28-IM007-2-9',2),('29-JD001-2-10',2),('29-JD001-2-4',2),('29-JD001-2-5',2),('29-JD001-2-6',2),('29-JD001-2-7',2),('29-JD001-2-8',2),('29-JD001-2-9',2),('30-JP002-2-10',2),('30-JP002-2-4',2),('30-JP002-2-5',2),('30-JP002-2-6',2),('30-JP002-2-7',2),('30-JP002-2-8',2),('30-JP002-2-9',2),('6-ACDC04-2-10',2),('6-ACDC04-2-4',2),('6-ACDC04-2-5',2),('6-ACDC04-2-6',2),('6-ACDC04-2-7',2),('6-ACDC04-2-8',2),('6-ACDC04-2-9',2),('7-ALR003-2-10',2),('7-ALR003-2-4',2),('7-ALR003-2-5',2),('7-ALR003-2-6',2),('7-ALR003-2-7',2),('7-ALR003-2-8',2),('7-ALR003-2-9',2),('9-ARTCL001-2-10',2),('9-ARTCL001-2-4',2),('9-ARTCL001-2-5',2),('9-ARTCL001-2-6',2),('9-ARTCL001-2-7',2),('9-ARTCL001-2-8',2),('9-ARTCL001-2-9',2),('8-ARV001-3-10',3),('8-ARV001-3-4',3),('8-ARV001-3-5',3),('8-ARV001-3-6',3),('8-ARV001-3-7',3),('8-ARV001-3-8',3),('8-ARV001-3-9',3),('1-ABB001-2-4',4),('10-BHMTH005-2-4',4),('11-BS002-2-4',4),('12-BS003-2-4',4),('13-BS005-2-4',4),('14-BFMV002-2-4',4),('16-BFMV004-2-4',4),('17-COB002-2-4',4),('18-CP001-2-4',4),('19-CF001-2-4',4),('20-D004-2-4',4),('21-DT003-2-4',4),('22-DT004-2-4',4),('23-EF001-2-4',4),('24-EXDS003-2-4',4),('25-GA001-2-4',4),('26-GD002-2-4',4),('27-IM004-2-4',4),('28-IM007-2-4',4),('29-JD001-2-4',4),('30-JP002-2-4',4),('6-ACDC04-2-4',4),('7-ALR003-2-4',4),('8-ARV001-3-4',4),('9-ARTCL001-2-4',4),('1-ABB001-2-5',5),('10-BHMTH005-2-5',5),('11-BS002-2-5',5),('12-BS003-2-5',5),('13-BS005-2-5',5),('14-BFMV002-2-5',5),('16-BFMV004-2-5',5),('17-COB002-2-5',5),('18-CP001-2-5',5),('19-CF001-2-5',5),('20-D004-2-5',5),('21-DT003-2-5',5),('22-DT004-2-5',5),('23-EF001-2-5',5),('24-EXDS003-2-5',5),('25-GA001-2-5',5),('26-GD002-2-5',5),('27-IM004-2-5',5),('28-IM007-2-5',5),('29-JD001-2-5',5),('30-JP002-2-5',5),('6-ACDC04-2-5',5),('7-ALR003-2-5',5),('8-ARV001-3-5',5),('9-ARTCL001-2-5',5),('1-ABB001-2-6',6),('10-BHMTH005-2-6',6),('11-BS002-2-6',6),('12-BS003-2-6',6),('13-BS005-2-6',6),('14-BFMV002-2-6',6),('16-BFMV004-2-6',6),('17-COB002-2-6',6),('18-CP001-2-6',6),('19-CF001-2-6',6),('20-D004-2-6',6),('21-DT003-2-6',6),('22-DT004-2-6',6),('23-EF001-2-6',6),('24-EXDS003-2-6',6),('25-GA001-2-6',6),('26-GD002-2-6',6),('27-IM004-2-6',6),('28-IM007-2-6',6),('29-JD001-2-6',6),('30-JP002-2-6',6),('6-ACDC04-2-6',6),('7-ALR003-2-6',6),('8-ARV001-3-6',6),('9-ARTCL001-2-6',6),('1-ABB001-2-7',7),('10-BHMTH005-2-7',7),('11-BS002-2-7',7),('12-BS003-2-7',7),('13-BS005-2-7',7),('14-BFMV002-2-7',7),('16-BFMV004-2-7',7),('17-COB002-2-7',7),('18-CP001-2-7',7),('19-CF001-2-7',7),('20-D004-2-7',7),('21-DT003-2-7',7),('22-DT004-2-7',7),('23-EF001-2-7',7),('24-EXDS003-2-7',7),('25-GA001-2-7',7),('26-GD002-2-7',7),('27-IM004-2-7',7),('28-IM007-2-7',7),('29-JD001-2-7',7),('30-JP002-2-7',7),('6-ACDC04-2-7',7),('7-ALR003-2-7',7),('8-ARV001-3-7',7),('9-ARTCL001-2-7',7),('1-ABB001-2-8',8),('10-BHMTH005-2-8',8),('11-BS002-2-8',8),('12-BS003-2-8',8),('13-BS005-2-8',8),('14-BFMV002-2-8',8),('16-BFMV004-2-8',8),('17-COB002-2-8',8),('18-CP001-2-8',8),('19-CF001-2-8',8),('20-D004-2-8',8),('21-DT003-2-8',8),('22-DT004-2-8',8),('23-EF001-2-8',8),('24-EXDS003-2-8',8),('25-GA001-2-8',8),('26-GD002-2-8',8),('27-IM004-2-8',8),('28-IM007-2-8',8),('29-JD001-2-8',8),('30-JP002-2-8',8),('6-ACDC04-2-8',8),('7-ALR003-2-8',8),('8-ARV001-3-8',8),('9-ARTCL001-2-8',8),('1-ABB001-2-9',9),('10-BHMTH005-2-9',9),('11-BS002-2-9',9),('12-BS003-2-9',9),('13-BS005-2-9',9),('14-BFMV002-2-9',9),('16-BFMV004-2-9',9),('17-COB002-2-9',9),('18-CP001-2-9',9),('19-CF001-2-9',9),('20-D004-2-9',9),('21-DT003-2-9',9),('22-DT004-2-9',9),('23-EF001-2-9',9),('24-EXDS003-2-9',9),('25-GA001-2-9',9),('26-GD002-2-9',9),('27-IM004-2-9',9),('28-IM007-2-9',9),('29-JD001-2-9',9),('30-JP002-2-9',9),('6-ACDC04-2-9',9),('7-ALR003-2-9',9),('8-ARV001-3-9',9),('9-ARTCL001-2-9',9),('1-ABB001-2-10',10),('10-BHMTH005-2-10',10),('11-BS002-2-10',10),('12-BS003-2-10',10),('13-BS005-2-10',10),('14-BFMV002-2-10',10),('16-BFMV004-2-10',10),('17-COB002-2-10',10),('18-CP001-2-10',10),('19-CF001-2-10',10),('20-D004-2-10',10),('21-DT003-2-10',10),('22-DT004-2-10',10),('23-EF001-2-10',10),('24-EXDS003-2-10',10),('25-GA001-2-10',10),('26-GD002-2-10',10),('27-IM004-2-10',10),('28-IM007-2-10',10),('29-JD001-2-10',10),('30-JP002-2-10',10),('6-ACDC04-2-10',10),('7-ALR003-2-10',10),('8-ARV001-3-10',10),('9-ARTCL001-2-10',10);
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
INSERT INTO `skus` VALUES ('1-ABB001-2-10',1,600,0,'Black,4XL',0),('1-ABB001-2-4',1,400,0,'Black,S',0),('1-ABB001-2-5',1,400,0,'Black,M',1),('1-ABB001-2-6',1,400,0,'Black,L',0),('1-ABB001-2-7',1,400,0,'Black,XL',0),('1-ABB001-2-8',1,400,0,'Black,XXL',0),('1-ABB001-2-9',1,600,0,'Black,3XL',0),('10-BHMTH005-2-10',10,600,0,'Black,4XL',0),('10-BHMTH005-2-4',10,400,0,'Black,S',0),('10-BHMTH005-2-5',10,400,0,'Black,M',1),('10-BHMTH005-2-6',10,400,0,'Black,L',0),('10-BHMTH005-2-7',10,400,0,'Black,XL',0),('10-BHMTH005-2-8',10,400,0,'Black,XXL',0),('10-BHMTH005-2-9',10,600,0,'Black,3XL',0),('11-BS002-2-10',11,600,0,'Black,4XL',0),('11-BS002-2-4',11,400,0,'Black,S',0),('11-BS002-2-5',11,400,0,'Black,M',1),('11-BS002-2-6',11,400,0,'Black,L',0),('11-BS002-2-7',11,400,0,'Black,XL',0),('11-BS002-2-8',11,400,0,'Black,XXL',0),('11-BS002-2-9',11,600,0,'Black,3XL',0),('12-BS003-2-10',12,600,0,'Black,4XL',0),('12-BS003-2-4',12,400,0,'Black,S',0),('12-BS003-2-5',12,400,0,'Black,M',1),('12-BS003-2-6',12,400,0,'Black,L',0),('12-BS003-2-7',12,400,0,'Black,XL',0),('12-BS003-2-8',12,400,0,'Black,XXL',0),('12-BS003-2-9',12,600,0,'Black,3XL',0),('13-BS005-2-10',13,600,0,'Black,4XL',0),('13-BS005-2-4',13,400,0,'Black,S',0),('13-BS005-2-5',13,400,0,'Black,M',1),('13-BS005-2-6',13,400,0,'Black,L',0),('13-BS005-2-7',13,400,0,'Black,XL',0),('13-BS005-2-8',13,400,0,'Black,XXL',0),('13-BS005-2-9',13,600,0,'Black,3XL',0),('14-BFMV002-2-10',14,600,0,'Black,4XL',0),('14-BFMV002-2-4',14,400,0,'Black,S',0),('14-BFMV002-2-5',14,400,0,'Black,M',1),('14-BFMV002-2-6',14,400,0,'Black,L',0),('14-BFMV002-2-7',14,400,0,'Black,XL',0),('14-BFMV002-2-8',14,400,0,'Black,XXL',0),('14-BFMV002-2-9',14,600,0,'Black,3XL',0),('16-BFMV004-2-10',16,600,0,'Black,4XL',0),('16-BFMV004-2-4',16,400,0,'Black,S',0),('16-BFMV004-2-5',16,400,0,'Black,M',1),('16-BFMV004-2-6',16,400,0,'Black,L',0),('16-BFMV004-2-7',16,400,0,'Black,XL',0),('16-BFMV004-2-8',16,400,0,'Black,XXL',0),('16-BFMV004-2-9',16,600,0,'Black,3XL',0),('17-COB002-2-10',17,600,0,'Black,4XL',0),('17-COB002-2-4',17,400,0,'Black,S',0),('17-COB002-2-5',17,400,0,'Black,M',1),('17-COB002-2-6',17,400,0,'Black,L',0),('17-COB002-2-7',17,400,0,'Black,XL',0),('17-COB002-2-8',17,400,0,'Black,XXL',0),('17-COB002-2-9',17,600,0,'Black,3XL',0),('18-CP001-2-10',18,600,0,'Black,4XL',0),('18-CP001-2-4',18,400,0,'Black,S',0),('18-CP001-2-5',18,400,0,'Black,M',1),('18-CP001-2-6',18,400,0,'Black,L',0),('18-CP001-2-7',18,400,0,'Black,XL',0),('18-CP001-2-8',18,400,0,'Black,XXL',0),('18-CP001-2-9',18,600,0,'Black,3XL',0),('19-CF001-2-10',19,600,0,'Black,4XL',0),('19-CF001-2-4',19,350,0,'Black,S',0),('19-CF001-2-5',19,350,0,'Black,M',1),('19-CF001-2-6',19,350,0,'Black,L',0),('19-CF001-2-7',19,350,0,'Black,XL',0),('19-CF001-2-8',19,350,0,'Black,XXL',0),('19-CF001-2-9',19,600,0,'Black,3XL',0),('20-D004-2-10',20,600,0,'Black,4XL',0),('20-D004-2-4',20,400,0,'Black,S',0),('20-D004-2-5',20,400,0,'Black,M',1),('20-D004-2-6',20,400,0,'Black,L',0),('20-D004-2-7',20,400,0,'Black,XL',0),('20-D004-2-8',20,400,0,'Black,XXL',0),('20-D004-2-9',20,600,0,'Black,3XL',0),('21-DT003-2-10',21,600,0,'Black,4XL',0),('21-DT003-2-4',21,400,0,'Black,S',0),('21-DT003-2-5',21,400,0,'Black,M',1),('21-DT003-2-6',21,400,0,'Black,L',0),('21-DT003-2-7',21,400,0,'Black,XL',0),('21-DT003-2-8',21,400,0,'Black,XXL',0),('21-DT003-2-9',21,700,0,'Black,3XL',0),('22-DT004-2-10',22,750,0,'Black,4XL',0),('22-DT004-2-4',22,400,0,'Black,S',0),('22-DT004-2-5',22,400,0,'Black,M',1),('22-DT004-2-6',22,400,0,'Black,L',0),('22-DT004-2-7',22,400,0,'Black,XL',0),('22-DT004-2-8',22,400,0,'Black,XXL',0),('22-DT004-2-9',22,650,0,'Black,3XL',0),('23-EF001-2-10',23,350,0,'Black,4XL',0),('23-EF001-2-4',23,350,0,'Black,S',0),('23-EF001-2-5',23,350,0,'Black,M',1),('23-EF001-2-6',23,350,0,'Black,L',0),('23-EF001-2-7',23,350,0,'Black,XL',0),('23-EF001-2-8',23,350,0,'Black,XXL',0),('23-EF001-2-9',23,350,0,'Black,3XL',0),('24-EXDS003-2-10',24,400,0,'Black,4XL',0),('24-EXDS003-2-4',24,400,0,'Black,S',0),('24-EXDS003-2-5',24,400,0,'Black,M',1),('24-EXDS003-2-6',24,400,0,'Black,L',0),('24-EXDS003-2-7',24,400,0,'Black,XL',0),('24-EXDS003-2-8',24,400,0,'Black,XXL',0),('24-EXDS003-2-9',24,400,0,'Black,3XL',0),('25-GA001-2-10',25,400,0,'Black,4XL',0),('25-GA001-2-4',25,400,0,'Black,S',0),('25-GA001-2-5',25,400,0,'Black,M',1),('25-GA001-2-6',25,400,0,'Black,L',0),('25-GA001-2-7',25,400,0,'Black,XL',0),('25-GA001-2-8',25,400,0,'Black,XXL',0),('25-GA001-2-9',25,400,0,'Black,3XL',0),('26-GD002-2-10',26,500,0,'Black,4XL',0),('26-GD002-2-4',26,400,0,'Black,S',0),('26-GD002-2-5',26,400,0,'Black,M',1),('26-GD002-2-6',26,400,0,'Black,L',0),('26-GD002-2-7',26,400,0,'Black,XL',0),('26-GD002-2-8',26,400,0,'Black,XXL',0),('26-GD002-2-9',26,400,0,'Black,3XL',0),('27-IM004-2-10',27,600,0,'Black,4XL',0),('27-IM004-2-4',27,400,0,'Black,S',0),('27-IM004-2-5',27,400,0,'Black,M',1),('27-IM004-2-6',27,400,0,'Black,L',0),('27-IM004-2-7',27,400,0,'Black,XL',0),('27-IM004-2-8',27,400,0,'Black,XXL',0),('27-IM004-2-9',27,600,0,'Black,3XL',0),('28-IM007-2-10',28,500,0,'Black,4XL',0),('28-IM007-2-4',28,400,0,'Black,S',0),('28-IM007-2-5',28,400,0,'Black,M',1),('28-IM007-2-6',28,400,0,'Black,L',0),('28-IM007-2-7',28,400,0,'Black,XL',0),('28-IM007-2-8',28,400,0,'Black,XXL',0),('28-IM007-2-9',28,400,0,'Black,3XL',0),('29-JD001-2-10',29,500,0,'Black,4XL',0),('29-JD001-2-4',29,350,0,'Black,S',0),('29-JD001-2-5',29,350,0,'Black,M',1),('29-JD001-2-6',29,350,0,'Black,L',0),('29-JD001-2-7',29,350,0,'Black,XL',0),('29-JD001-2-8',29,350,0,'Black,XXL',0),('29-JD001-2-9',29,500,0,'Black,3XL',0),('30-JP002-2-10',30,400,0,'Black,4XL',0),('30-JP002-2-4',30,350,0,'Black,S',0),('30-JP002-2-5',30,350,0,'Black,M',1),('30-JP002-2-6',30,350,0,'Black,L',0),('30-JP002-2-7',30,350,0,'Black,XL',0),('30-JP002-2-8',30,350,0,'Black,XXL',0),('30-JP002-2-9',30,400,0,'Black,3XL',0),('6-ACDC04-2-10',6,600,0,'Black,4XL',0),('6-ACDC04-2-4',6,400,0,'Black,S',0),('6-ACDC04-2-5',6,400,0,'Black,M',1),('6-ACDC04-2-6',6,400,0,'Black,L',0),('6-ACDC04-2-7',6,400,0,'Black,XL',0),('6-ACDC04-2-8',6,400,0,'Black,XXL',0),('6-ACDC04-2-9',6,600,0,'Black,3XL',0),('7-ALR003-2-10',7,600,0,'Black,4XL',0),('7-ALR003-2-4',7,400,0,'Black,S',0),('7-ALR003-2-5',7,400,0,'Black,M',1),('7-ALR003-2-6',7,400,0,'Black,L',0),('7-ALR003-2-7',7,400,0,'Black,XL',0),('7-ALR003-2-8',7,400,0,'Black,XXL',0),('7-ALR003-2-9',7,600,0,'Black,3XL',0),('8-ARV001-3-10',8,600,0,'Green,4XL',0),('8-ARV001-3-4',8,400,0,'Green,S',0),('8-ARV001-3-5',8,400,0,'Green,M',1),('8-ARV001-3-6',8,400,0,'Green,L',0),('8-ARV001-3-7',8,400,0,'Green,XL',0),('8-ARV001-3-8',8,400,0,'Green,XXL',0),('8-ARV001-3-9',8,600,0,'Green,3XL',0),('9-ARTCL001-2-10',9,600,0,'Black,4XL',0),('9-ARTCL001-2-4',9,350,0,'Black,S',0),('9-ARTCL001-2-5',9,350,0,'Black,M',1),('9-ARTCL001-2-6',9,350,0,'Black,L',0),('9-ARTCL001-2-7',9,350,0,'Black,XL',0),('9-ARTCL001-2-8',9,350,0,'Black,XXL',0),('9-ARTCL001-2-9',9,600,0,'Black,3XL',0);
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
  `total` int(11) NOT NULL,
  `damaged` int(11) NOT NULL,
  `on_hold` int(11) NOT NULL,
  `sales_booked` int(11) NOT NULL,
  `branch_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_sku_branch` (`sku_code`,`branch_id`),
  KEY `IDX_56F7980579B17AE9` (`sku_code`),
  KEY `IDX_56F79805DCD6CC49` (`branch_id`),
  CONSTRAINT `FK_56F7980579B17AE9` FOREIGN KEY (`sku_code`) REFERENCES `skus` (`code`),
  CONSTRAINT `FK_56F79805DCD6CC49` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocks`
--

LOCK TABLES `stocks` WRITE;
/*!40000 ALTER TABLE `stocks` DISABLE KEYS */;
INSERT INTO `stocks` VALUES (15,'18-CP001-2-7',100,0,0,0,1),(16,'18-CP001-2-9',100,0,0,0,1),(17,'18-CP001-2-7',14,2,4,2,3),(18,'18-CP001-2-8',100,0,0,0,1),(19,'18-CP001-2-8',35,0,0,0,3),(20,'18-CP001-2-9',23,0,0,0,3),(21,'19-CF001-2-10',100,0,0,0,1),(22,'19-CF001-2-10',99,0,0,0,3),(23,'19-CF001-2-4',150,0,0,0,3),(24,'19-CF001-2-4',50,0,0,0,1),(25,'19-CF001-2-5',100,0,0,0,1),(26,'19-CF001-2-5',100,0,0,0,3),(27,'19-CF001-2-6',95,0,0,0,3),(28,'19-CF001-2-6',100,0,0,0,1),(29,'19-CF001-2-7',100,0,0,0,1),(30,'19-CF001-2-7',100,0,0,0,3),(31,'19-CF001-2-8',100,0,0,0,3),(32,'19-CF001-2-8',100,0,0,0,1),(33,'19-CF001-2-9',100,0,0,0,1),(34,'19-CF001-2-9',100,0,0,0,3),(35,'20-D004-2-10',100,0,0,0,3),(36,'20-D004-2-10',100,0,0,0,1),(37,'20-D004-2-4',100,0,0,0,1),(38,'20-D004-2-4',100,0,0,0,3),(39,'20-D004-2-6',100,0,0,0,3),(40,'20-D004-2-6',100,0,0,0,1),(41,'20-D004-2-7',100,0,0,0,1),(42,'20-D004-2-7',93,0,0,0,3),(43,'21-DT003-2-10',92,0,0,0,3),(44,'21-DT003-2-10',100,0,0,0,1),(45,'7-ALR003-2-6',100,0,0,0,1),(46,'7-ALR003-2-6',95,0,0,0,3),(47,'8-ARV001-3-10',94,0,0,0,3),(48,'8-ARV001-3-10',100,0,0,0,1),(49,'9-ARTCL001-2-4',100,0,0,0,1),(50,'9-ARTCL001-2-4',90,0,0,0,3),(51,'18-CP001-2-5',97,0,0,0,3),(52,'18-CP001-2-6',98,0,0,0,3),(53,'18-CP001-2-4',100,0,0,0,3),(54,'16-BFMV004-2-7',100,0,0,0,3),(55,'16-BFMV004-2-5',100,0,0,0,3),(56,'16-BFMV004-2-10',100,0,0,0,3),(57,'16-BFMV004-2-4',100,0,0,0,3),(58,'17-COB002-2-5',98,0,0,0,3),(59,'18-CP001-2-10',97,0,0,0,3),(60,'17-COB002-2-8',100,0,0,0,3),(61,'17-COB002-2-9',100,0,0,0,3),(62,'17-COB002-2-7',100,0,0,0,3),(63,'18-CP001-2-10',99,0,0,0,1),(64,'18-CP001-2-4',99,0,0,0,1),(65,'18-CP001-2-5',100,0,0,0,1),(66,'18-CP001-2-6',100,0,0,0,1),(67,'1-ABB001-2-10',98,0,0,0,3),(68,'1-ABB001-2-4',98,0,0,0,3),(69,'1-ABB001-2-5',100,0,0,0,3),(70,'1-ABB001-2-6',100,0,0,0,3),(71,'1-ABB001-2-7',100,0,0,0,3),(72,'1-ABB001-2-8',100,0,0,0,3),(73,'1-ABB001-2-9',100,0,0,0,3),(74,'11-BS002-2-10',100,0,0,0,3),(75,'11-BS002-2-4',100,0,0,0,3),(76,'11-BS002-2-5',100,0,0,0,3),(77,'11-BS002-2-6',100,0,0,0,3),(78,'11-BS002-2-7',100,0,0,0,3),(79,'11-BS002-2-8',100,0,0,0,3),(80,'11-BS002-2-9',100,0,0,0,3),(81,'12-BS003-2-10',100,0,0,0,3),(82,'12-BS003-2-4',100,0,0,0,3),(83,'12-BS003-2-5',100,0,0,0,3),(84,'12-BS003-2-6',100,0,0,0,3),(85,'12-BS003-2-7',100,0,0,0,3),(86,'12-BS003-2-8',100,0,0,0,3),(87,'12-BS003-2-9',100,0,0,0,3),(88,'13-BS005-2-10',100,0,0,0,3),(89,'13-BS005-2-4',100,0,0,0,3),(90,'13-BS005-2-5',100,0,0,0,3),(91,'13-BS005-2-6',100,0,0,0,3),(92,'13-BS005-2-7',100,0,0,0,3),(93,'13-BS005-2-8',100,0,0,0,3),(94,'13-BS005-2-9',100,0,0,0,3),(95,'6-ACDC04-2-10',100,0,0,0,3),(96,'6-ACDC04-2-4',100,0,0,0,3),(97,'6-ACDC04-2-5',100,0,0,0,3),(98,'6-ACDC04-2-6',100,0,0,0,3),(99,'6-ACDC04-2-7',100,0,0,0,3),(100,'6-ACDC04-2-8',100,0,0,0,3),(101,'6-ACDC04-2-9',100,0,0,0,3),(102,'7-ALR003-2-10',100,0,0,0,3),(103,'7-ALR003-2-4',100,0,0,0,3),(104,'7-ALR003-2-5',100,0,0,0,3),(105,'7-ALR003-2-7',100,0,0,0,3),(106,'7-ALR003-2-8',100,0,0,0,3),(107,'7-ALR003-2-9',100,0,0,0,3),(108,'8-ARV001-3-4',100,0,0,0,3),(109,'8-ARV001-3-5',100,0,0,0,3),(110,'8-ARV001-3-6',100,0,0,0,3),(111,'8-ARV001-3-7',100,0,0,0,3),(112,'8-ARV001-3-8',100,0,0,0,3),(113,'8-ARV001-3-9',100,0,0,0,3),(114,'9-ARTCL001-2-10',100,0,0,0,3),(115,'9-ARTCL001-2-5',100,0,0,0,3),(116,'9-ARTCL001-2-6',100,0,0,0,3),(117,'9-ARTCL001-2-7',100,0,0,0,3),(118,'9-ARTCL001-2-8',100,0,0,0,3),(119,'9-ARTCL001-2-9',100,0,0,0,3),(120,'14-BFMV002-2-10',100,0,0,0,3),(121,'14-BFMV002-2-4',100,0,0,0,3),(122,'14-BFMV002-2-5',100,0,0,0,3),(123,'14-BFMV002-2-6',100,0,0,0,3),(124,'14-BFMV002-2-7',100,0,0,0,3),(125,'14-BFMV002-2-8',100,0,0,0,3),(126,'14-BFMV002-2-9',100,0,0,0,3),(127,'16-BFMV004-2-6',100,0,0,0,3),(128,'16-BFMV004-2-8',100,0,0,0,3),(129,'16-BFMV004-2-9',100,0,0,0,3),(130,'20-D004-2-5',100,0,0,0,3),(131,'20-D004-2-8',100,0,0,0,3),(132,'20-D004-2-9',100,0,0,0,3),(133,'21-DT003-2-4',100,0,0,0,3),(134,'21-DT003-2-5',100,0,0,0,3),(135,'21-DT003-2-6',100,0,0,0,3),(136,'21-DT003-2-7',100,0,0,0,3),(137,'21-DT003-2-8',100,0,0,0,3),(138,'21-DT003-2-9',100,0,0,0,3),(139,'22-DT004-2-10',100,0,0,0,3),(140,'22-DT004-2-4',100,0,0,0,3),(141,'22-DT004-2-5',100,0,0,0,3),(142,'22-DT004-2-6',100,0,0,0,3),(143,'22-DT004-2-7',100,0,0,0,3),(144,'22-DT004-2-8',100,0,0,0,3),(145,'22-DT004-2-9',100,0,0,0,3),(146,'25-GA001-2-10',100,0,0,0,3),(147,'25-GA001-2-4',100,0,0,0,3),(148,'25-GA001-2-5',100,0,0,0,3),(149,'25-GA001-2-6',100,0,0,0,3),(150,'25-GA001-2-7',100,0,0,0,3),(151,'25-GA001-2-8',100,0,0,0,3),(152,'25-GA001-2-9',100,0,0,0,3),(153,'26-GD002-2-10',100,0,0,0,3),(154,'26-GD002-2-4',100,0,0,0,3),(155,'26-GD002-2-5',100,0,0,0,3),(156,'26-GD002-2-6',100,0,0,0,3),(157,'26-GD002-2-7',100,0,0,0,3),(158,'26-GD002-2-8',100,0,0,0,3),(159,'26-GD002-2-9',100,0,0,0,3),(160,'27-IM004-2-10',100,0,0,0,3),(161,'27-IM004-2-4',100,0,0,0,3),(162,'27-IM004-2-5',100,0,0,0,3),(163,'27-IM004-2-6',100,0,0,0,3),(164,'27-IM004-2-7',100,0,0,0,3),(165,'27-IM004-2-8',100,0,0,0,3),(166,'27-IM004-2-9',100,0,0,0,3),(167,'28-IM007-2-10',100,0,0,0,3),(168,'28-IM007-2-4',100,0,0,0,3),(169,'28-IM007-2-5',100,0,0,0,3),(170,'28-IM007-2-6',100,0,0,0,3),(171,'28-IM007-2-7',100,0,0,0,3),(172,'28-IM007-2-8',100,0,0,0,3),(173,'28-IM007-2-9',100,0,0,0,3),(174,'29-JD001-2-10',100,0,0,0,3),(175,'29-JD001-2-4',100,0,0,0,3),(176,'29-JD001-2-5',100,0,0,0,3),(177,'29-JD001-2-6',100,0,0,0,3),(178,'29-JD001-2-7',100,0,0,0,3),(179,'29-JD001-2-8',100,0,0,0,3),(180,'29-JD001-2-9',100,0,0,0,3),(181,'30-JP002-2-10',100,0,0,0,3),(182,'30-JP002-2-4',100,0,0,0,3),(183,'30-JP002-2-5',100,0,0,0,3),(184,'30-JP002-2-6',100,0,0,0,3),(185,'30-JP002-2-7',100,0,0,0,3),(186,'30-JP002-2-8',100,0,0,0,3),(187,'30-JP002-2-9',100,0,0,0,3),(188,'21-DT003-2-6',100,0,0,0,1);
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
INSERT INTO `stocks_v2` VALUES ('1-ABB001-2-10',1,200,0,0,0),('1-ABB001-2-10',3,70,0,10,10),('1-ABB001-2-4',1,200,0,0,0),('1-ABB001-2-4',3,93,0,0,0),('1-ABB001-2-5',1,200,0,0,0),('1-ABB001-2-5',3,100,0,0,0),('1-ABB001-2-6',1,100,0,0,0),('1-ABB001-2-6',3,100,0,0,0),('1-ABB001-2-7',1,100,0,0,0),('1-ABB001-2-7',3,100,0,0,0),('1-ABB001-2-8',1,100,0,0,0),('1-ABB001-2-8',3,100,0,0,0),('1-ABB001-2-9',1,100,0,0,0),('1-ABB001-2-9',3,100,0,0,0),('10-BHMTH005-2-10',1,100,0,0,0),('10-BHMTH005-2-10',3,100,0,0,0),('10-BHMTH005-2-4',1,100,0,0,0),('10-BHMTH005-2-4',3,100,0,0,0),('10-BHMTH005-2-5',1,100,0,0,0),('10-BHMTH005-2-5',3,100,0,0,0),('10-BHMTH005-2-6',1,100,0,0,0),('10-BHMTH005-2-6',3,100,0,0,0),('10-BHMTH005-2-7',1,100,0,0,0),('10-BHMTH005-2-7',3,100,0,0,0),('10-BHMTH005-2-8',1,100,0,0,0),('10-BHMTH005-2-8',3,100,0,0,0),('10-BHMTH005-2-9',1,100,0,0,0),('10-BHMTH005-2-9',3,100,0,0,0),('11-BS002-2-10',1,100,0,0,0),('11-BS002-2-10',3,100,0,0,0),('11-BS002-2-4',1,100,0,0,0),('11-BS002-2-4',3,100,0,0,0),('11-BS002-2-5',1,100,0,0,0),('11-BS002-2-5',3,100,0,0,0),('11-BS002-2-6',1,100,0,0,0),('11-BS002-2-6',3,100,0,0,0),('11-BS002-2-7',1,100,0,0,0),('11-BS002-2-7',3,100,0,0,0),('11-BS002-2-8',1,100,0,0,0),('11-BS002-2-8',3,100,0,0,0),('11-BS002-2-9',1,100,0,0,0),('11-BS002-2-9',3,100,0,0,0),('12-BS003-2-10',1,100,0,0,0),('12-BS003-2-10',3,100,0,0,0),('12-BS003-2-4',1,100,0,0,0),('12-BS003-2-4',3,100,0,0,0),('12-BS003-2-5',1,100,0,0,0),('12-BS003-2-5',3,100,0,0,0),('12-BS003-2-6',1,100,0,0,0),('12-BS003-2-6',3,100,0,0,0),('12-BS003-2-7',1,100,0,0,0),('12-BS003-2-7',3,100,0,0,0),('12-BS003-2-8',1,100,0,0,0),('12-BS003-2-8',3,100,0,0,0),('12-BS003-2-9',1,100,0,0,0),('12-BS003-2-9',3,100,0,0,0),('13-BS005-2-10',1,100,0,0,0),('13-BS005-2-10',3,100,0,0,0),('13-BS005-2-4',1,100,0,0,0),('13-BS005-2-4',3,100,0,0,0),('13-BS005-2-5',1,100,0,0,0),('13-BS005-2-5',3,100,0,0,0),('13-BS005-2-6',1,100,0,0,0),('13-BS005-2-6',3,100,0,0,0),('13-BS005-2-7',1,100,0,0,0),('13-BS005-2-7',3,100,0,0,0),('13-BS005-2-8',1,100,0,0,0),('13-BS005-2-8',3,100,0,0,0),('13-BS005-2-9',1,100,0,0,0),('13-BS005-2-9',3,97,0,0,0),('14-BFMV002-2-10',1,100,0,0,0),('14-BFMV002-2-10',3,100,0,0,0),('14-BFMV002-2-4',1,100,0,0,0),('14-BFMV002-2-4',3,100,0,0,0),('14-BFMV002-2-5',1,100,0,0,0),('14-BFMV002-2-5',3,100,0,0,0),('14-BFMV002-2-6',1,100,0,0,0),('14-BFMV002-2-6',3,100,0,0,0),('14-BFMV002-2-7',1,100,0,0,0),('14-BFMV002-2-7',3,100,0,0,0),('14-BFMV002-2-8',1,100,0,0,0),('14-BFMV002-2-8',3,100,0,0,0),('14-BFMV002-2-9',1,100,0,0,0),('14-BFMV002-2-9',3,100,0,0,0),('16-BFMV004-2-10',1,100,0,0,0),('16-BFMV004-2-10',3,100,0,0,0),('16-BFMV004-2-4',1,100,0,0,0),('16-BFMV004-2-4',3,100,0,0,0),('16-BFMV004-2-5',1,100,0,0,0),('16-BFMV004-2-5',3,100,0,0,0),('16-BFMV004-2-6',1,100,0,0,0),('16-BFMV004-2-6',3,100,0,0,0),('16-BFMV004-2-7',1,100,0,0,0),('16-BFMV004-2-7',3,100,0,0,0),('16-BFMV004-2-8',1,100,0,0,0),('16-BFMV004-2-8',3,100,0,0,0),('16-BFMV004-2-9',1,100,0,0,0),('16-BFMV004-2-9',3,100,0,0,0),('17-COB002-2-10',1,100,0,0,0),('17-COB002-2-10',2,110,0,0,0),('17-COB002-2-10',3,100,0,0,0),('17-COB002-2-4',1,100,0,0,0),('17-COB002-2-4',2,110,0,0,0),('17-COB002-2-4',3,100,0,0,0),('17-COB002-2-5',1,100,0,0,0),('17-COB002-2-5',2,110,0,0,0),('17-COB002-2-5',3,200,0,0,0),('17-COB002-2-6',1,100,0,0,0),('17-COB002-2-6',2,110,0,0,0),('17-COB002-2-6',3,100,0,0,0),('17-COB002-2-7',1,100,0,0,0),('17-COB002-2-7',2,210,0,0,0),('17-COB002-2-7',3,100,0,0,0),('17-COB002-2-8',1,100,0,0,0),('17-COB002-2-8',2,110,0,0,0),('17-COB002-2-8',3,100,0,0,0),('17-COB002-2-9',1,100,0,0,0),('17-COB002-2-9',2,110,0,0,0),('17-COB002-2-9',3,100,0,0,0),('18-CP001-2-10',1,100,0,0,0),('18-CP001-2-10',2,100,0,0,0),('18-CP001-2-10',3,96,0,0,0),('18-CP001-2-4',1,100,0,0,0),('18-CP001-2-4',2,200,0,0,0),('18-CP001-2-4',3,94,0,0,0),('18-CP001-2-5',1,100,0,0,0),('18-CP001-2-5',2,100,0,0,0),('18-CP001-2-5',3,93,0,0,0),('18-CP001-2-6',1,100,0,0,0),('18-CP001-2-6',2,100,0,0,0),('18-CP001-2-6',3,97,0,0,0),('18-CP001-2-7',1,100,0,0,0),('18-CP001-2-7',2,100,0,0,0),('18-CP001-2-7',3,97,0,0,0),('18-CP001-2-8',1,100,0,0,0),('18-CP001-2-8',2,100,0,0,0),('18-CP001-2-8',3,98,0,0,0),('18-CP001-2-9',1,100,0,0,0),('18-CP001-2-9',2,100,0,0,0),('18-CP001-2-9',3,97,0,0,0),('19-CF001-2-10',1,100,0,0,0),('19-CF001-2-10',3,100,0,0,0),('19-CF001-2-4',1,100,0,0,0),('19-CF001-2-4',3,100,0,0,0),('19-CF001-2-5',1,100,0,0,0),('19-CF001-2-5',3,100,0,0,0),('19-CF001-2-6',1,100,0,0,0),('19-CF001-2-6',3,100,0,0,0),('19-CF001-2-7',1,100,0,0,0),('19-CF001-2-7',3,100,0,0,0),('19-CF001-2-8',1,100,0,0,0),('19-CF001-2-8',3,100,0,0,0),('19-CF001-2-9',1,100,0,0,0),('19-CF001-2-9',3,100,0,0,0),('20-D004-2-10',1,100,0,0,0),('20-D004-2-10',3,100,0,0,0),('20-D004-2-4',1,100,0,0,0),('20-D004-2-4',3,100,0,0,0),('20-D004-2-5',1,100,0,0,0),('20-D004-2-5',3,100,0,0,0),('20-D004-2-6',1,100,0,0,0),('20-D004-2-6',3,100,0,0,0),('20-D004-2-7',1,100,0,0,0),('20-D004-2-7',3,100,0,0,0),('20-D004-2-8',1,100,0,0,0),('20-D004-2-8',3,100,0,0,0),('20-D004-2-9',1,100,0,0,0),('20-D004-2-9',3,100,0,0,0),('21-DT003-2-10',1,100,0,0,0),('21-DT003-2-10',3,100,0,0,0),('21-DT003-2-4',1,100,0,0,0),('21-DT003-2-4',3,100,0,0,0),('21-DT003-2-5',1,100,0,0,0),('21-DT003-2-5',3,100,0,0,0),('21-DT003-2-6',1,100,0,0,0),('21-DT003-2-6',3,100,0,0,0),('21-DT003-2-7',1,100,0,0,0),('21-DT003-2-7',3,100,0,0,0),('21-DT003-2-8',1,100,0,0,0),('21-DT003-2-8',3,100,0,0,0),('21-DT003-2-9',1,100,0,0,0),('21-DT003-2-9',3,100,0,0,0),('22-DT004-2-10',1,100,0,0,0),('22-DT004-2-10',3,100,0,0,0),('22-DT004-2-4',1,100,0,0,0),('22-DT004-2-4',3,100,0,0,0),('22-DT004-2-5',1,100,0,0,0),('22-DT004-2-5',3,100,0,0,0),('22-DT004-2-6',1,100,0,0,0),('22-DT004-2-6',3,100,0,0,0),('22-DT004-2-7',1,100,0,0,0),('22-DT004-2-7',3,100,0,0,0),('22-DT004-2-8',1,100,0,0,0),('22-DT004-2-8',3,100,0,0,0),('22-DT004-2-9',1,100,0,0,0),('22-DT004-2-9',3,100,0,0,0),('25-GA001-2-10',1,100,0,0,0),('25-GA001-2-10',3,100,0,0,0),('25-GA001-2-4',1,100,0,0,0),('25-GA001-2-4',3,100,0,0,0),('25-GA001-2-5',1,100,0,0,0),('25-GA001-2-5',3,100,0,0,0),('25-GA001-2-6',1,100,0,0,0),('25-GA001-2-6',3,100,0,0,0),('25-GA001-2-7',1,100,0,0,0),('25-GA001-2-7',3,100,0,0,0),('25-GA001-2-8',1,100,0,0,0),('25-GA001-2-8',3,100,0,0,0),('25-GA001-2-9',1,100,0,0,0),('25-GA001-2-9',3,100,0,0,0),('26-GD002-2-10',1,100,0,0,0),('26-GD002-2-10',3,100,0,0,0),('26-GD002-2-4',1,100,0,0,0),('26-GD002-2-4',3,100,0,0,0),('26-GD002-2-5',1,100,0,0,0),('26-GD002-2-5',3,100,0,0,0),('26-GD002-2-6',1,100,0,0,0),('26-GD002-2-6',3,100,0,0,0),('26-GD002-2-7',1,100,0,0,0),('26-GD002-2-7',3,100,0,0,0),('26-GD002-2-8',1,100,0,0,0),('26-GD002-2-8',3,100,0,0,0),('26-GD002-2-9',1,100,0,0,0),('26-GD002-2-9',3,100,0,0,0),('27-IM004-2-10',1,100,0,0,0),('27-IM004-2-10',3,100,0,0,0),('27-IM004-2-4',1,100,0,0,0),('27-IM004-2-4',3,100,0,0,0),('27-IM004-2-5',1,100,0,0,0),('27-IM004-2-5',3,100,0,0,0),('27-IM004-2-6',1,100,0,0,0),('27-IM004-2-6',3,100,0,0,0),('27-IM004-2-7',1,100,0,0,0),('27-IM004-2-7',3,100,0,0,0),('27-IM004-2-8',1,100,0,0,0),('27-IM004-2-8',3,100,0,0,0),('27-IM004-2-9',1,100,0,0,0),('27-IM004-2-9',3,100,0,0,0),('28-IM007-2-10',1,100,0,0,0),('28-IM007-2-10',3,100,0,0,0),('28-IM007-2-4',1,100,0,0,0),('28-IM007-2-4',3,100,0,0,0),('28-IM007-2-5',1,100,0,0,0),('28-IM007-2-5',3,100,0,0,0),('28-IM007-2-6',1,100,0,0,0),('28-IM007-2-6',3,100,0,0,0),('28-IM007-2-7',1,100,0,0,0),('28-IM007-2-7',3,100,0,0,0),('28-IM007-2-8',1,100,0,0,0),('28-IM007-2-8',3,100,0,0,0),('28-IM007-2-9',1,100,0,0,0),('28-IM007-2-9',3,100,0,0,0),('29-JD001-2-10',1,100,0,0,0),('29-JD001-2-10',3,100,0,0,0),('29-JD001-2-4',1,100,0,0,0),('29-JD001-2-4',3,100,0,0,0),('29-JD001-2-5',1,100,0,0,0),('29-JD001-2-5',3,100,0,0,0),('29-JD001-2-6',1,100,0,0,0),('29-JD001-2-6',3,100,0,0,0),('29-JD001-2-7',1,100,0,0,0),('29-JD001-2-7',3,100,0,0,0),('29-JD001-2-8',1,100,0,0,0),('29-JD001-2-8',3,100,0,0,0),('29-JD001-2-9',1,100,0,0,0),('29-JD001-2-9',3,100,0,0,0),('30-JP002-2-10',1,100,0,0,0),('30-JP002-2-10',3,100,0,0,0),('30-JP002-2-4',1,100,0,0,0),('30-JP002-2-4',3,100,0,0,0),('30-JP002-2-5',1,100,0,0,0),('30-JP002-2-5',3,100,0,0,0),('30-JP002-2-6',1,100,0,0,0),('30-JP002-2-6',3,100,0,0,0),('30-JP002-2-7',1,100,0,0,0),('30-JP002-2-7',3,100,0,0,0),('30-JP002-2-8',1,100,0,0,0),('30-JP002-2-8',3,100,0,0,0),('30-JP002-2-9',1,100,0,0,0),('30-JP002-2-9',3,100,0,0,0),('6-ACDC04-2-10',1,100,0,0,0),('6-ACDC04-2-10',3,100,0,0,0),('6-ACDC04-2-4',1,100,0,0,0),('6-ACDC04-2-4',3,100,0,0,0),('6-ACDC04-2-5',1,100,0,0,0),('6-ACDC04-2-5',3,100,0,0,0),('6-ACDC04-2-6',1,100,0,0,0),('6-ACDC04-2-6',3,100,0,0,0),('6-ACDC04-2-7',1,100,0,0,0),('6-ACDC04-2-7',3,100,0,0,0),('6-ACDC04-2-8',1,100,0,0,0),('6-ACDC04-2-8',3,100,0,0,0),('6-ACDC04-2-9',1,100,0,0,0),('6-ACDC04-2-9',3,100,0,0,0),('7-ALR003-2-10',1,100,0,0,0),('7-ALR003-2-10',2,5,0,0,0),('7-ALR003-2-10',3,100,0,0,0),('7-ALR003-2-4',1,100,0,0,0),('7-ALR003-2-4',2,5,0,0,0),('7-ALR003-2-4',3,100,0,0,0),('7-ALR003-2-5',1,100,0,0,0),('7-ALR003-2-5',2,5,0,0,0),('7-ALR003-2-5',3,100,0,0,0),('7-ALR003-2-6',1,100,0,0,0),('7-ALR003-2-6',2,5,0,0,0),('7-ALR003-2-6',3,100,0,0,0),('7-ALR003-2-7',1,100,0,0,0),('7-ALR003-2-7',2,5,0,0,0),('7-ALR003-2-7',3,100,0,0,0),('7-ALR003-2-8',1,100,0,0,0),('7-ALR003-2-8',2,10,0,0,0),('7-ALR003-2-8',3,100,0,0,0),('7-ALR003-2-9',1,100,0,0,0),('7-ALR003-2-9',2,5,0,0,0),('7-ALR003-2-9',3,100,0,0,0),('8-ARV001-3-10',1,100,0,0,0),('8-ARV001-3-10',3,100,0,0,0),('8-ARV001-3-4',1,100,0,0,0),('8-ARV001-3-4',3,100,0,0,0),('8-ARV001-3-5',1,100,0,0,0),('8-ARV001-3-5',3,100,0,0,0),('8-ARV001-3-6',1,100,0,0,0),('8-ARV001-3-6',3,100,0,0,0),('8-ARV001-3-7',1,100,0,0,0),('8-ARV001-3-7',3,100,0,0,0),('8-ARV001-3-8',1,100,0,0,0),('8-ARV001-3-8',3,100,0,0,0),('8-ARV001-3-9',1,100,0,0,0),('8-ARV001-3-9',3,100,0,0,0),('9-ARTCL001-2-10',1,100,0,0,0),('9-ARTCL001-2-10',2,100,0,0,0),('9-ARTCL001-2-10',3,100,0,0,0),('9-ARTCL001-2-4',1,100,0,0,0),('9-ARTCL001-2-4',2,100,0,0,0),('9-ARTCL001-2-4',3,100,0,0,0),('9-ARTCL001-2-5',1,100,0,0,0),('9-ARTCL001-2-5',2,100,0,0,0),('9-ARTCL001-2-5',3,100,0,0,0),('9-ARTCL001-2-6',1,100,0,0,0),('9-ARTCL001-2-6',2,100,0,0,0),('9-ARTCL001-2-6',3,100,0,0,0),('9-ARTCL001-2-7',1,100,0,0,0),('9-ARTCL001-2-7',2,200,0,0,0),('9-ARTCL001-2-7',3,100,0,0,0),('9-ARTCL001-2-8',1,100,0,0,0),('9-ARTCL001-2-8',2,100,0,0,0),('9-ARTCL001-2-8',3,100,0,0,0),('9-ARTCL001-2-9',1,100,0,0,0),('9-ARTCL001-2-9',2,100,0,0,0),('9-ARTCL001-2-9',3,100,0,0,0);
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
INSERT INTO `user_branch` VALUES (2,1),(3,1),(4,3),(5,3),(6,2);
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
INSERT INTO `user_role` VALUES (1,1),(2,4),(3,2),(4,4),(5,2),(6,3);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tokens`
--

LOCK TABLES `user_tokens` WRITE;
/*!40000 ALTER TABLE `user_tokens` DISABLE KEYS */;
INSERT INTO `user_tokens` VALUES (1,1,'d5651ce0269e09716765e9ac0fc5d81d','2021-07-03 21:01:29'),(2,1,'4f517ff9e5f24e1e0d67246f3c649280','2021-07-03 21:04:18'),(3,1,'c165e5c5d6887ef2feb4b4b5cd923742','2021-07-03 21:08:50'),(4,2,'0031818ad055aaf1ef453b8cf30bfe93','2021-07-03 21:10:02'),(5,1,'2264b87e29284e4798b56997c3d4e251','2021-07-03 21:33:47'),(6,1,'6d3d8c27382ea84281ce3c15bd64613d','2021-07-03 22:23:47'),(7,1,'67b171f6e77d9cec126b36615e327f7a','2021-07-04 00:39:56'),(8,1,'3ace4715fd7ae3998012ab130645ac5e','2021-07-04 20:32:46'),(9,1,'8ad12501fe62ce1d1d9e31d766695326','2021-07-04 20:53:44'),(10,1,'02c6b271675562aab59edc49bd6e8cfe','2021-07-05 19:38:26'),(11,1,'5071cb3f42d09bcf12ee5e4768ee6262','2021-07-06 20:30:41'),(12,1,'d9795d7471df3e9f2885ac6772e2849f','2021-07-06 20:40:15'),(13,1,'0f35cead88c28d9601f3d21973752b9c','2021-07-06 22:13:48'),(14,5,'57409a740405a53053632dbdf57783e9','2021-07-06 22:25:28'),(15,5,'17adc861fe8547623d014b2da87a16aa','2021-07-06 22:32:17'),(16,4,'e12c200c66cf8fabf096cff37a533ca2','2021-07-06 23:21:58'),(17,1,'0df7dc4c3bf78f2ddbc25f1e8fd6ebcd','2021-07-06 23:33:22'),(18,4,'98fb5b442b20ad2e8364eeb971fe9104','2021-07-06 23:39:03'),(19,1,'73cea66d04022e901904d8c44ad90140','2021-07-07 03:09:54'),(20,4,'da595a58d8810bc4c6c854bc95f96d47','2021-07-07 03:10:00'),(21,5,'53b1e81e4f488b09f230a85fc0cb6c4c','2021-07-07 03:10:47'),(22,5,'fc50780d67381811c2bcdf6730035b03','2021-07-07 03:11:39'),(23,1,'89e532fff8f23ad5c18b42b56709f13f','2021-07-07 03:13:37'),(24,5,'12c17e0f57ecae792c9c092ff21d4ada','2021-07-07 03:13:48'),(25,4,'62314c52c68351eaa0308dcd1726970b','2021-07-07 03:15:28'),(26,4,'0b9a24471144f7eee1a3abbf42d0386e','2021-07-07 03:15:39'),(27,4,'82b81ba4926c5f9260e2ffa4f63bcf14','2021-07-07 03:16:15'),(28,4,'4ee318c87525fee09b14e3daa0e43b61','2021-07-07 03:18:10'),(29,4,'68ad4cada02b044717296007dc017df2','2021-07-07 03:23:40'),(30,5,'43e286aee0f0c621e122dd6537488855','2021-07-07 03:28:49'),(31,1,'65e12cad24133224d58c8688fcd40c46','2021-07-07 03:38:21'),(32,4,'dd992cd7531b70178dbf6a9336d55011','2021-07-07 03:40:05'),(33,1,'f01f0bd27329b9348a96d4a132f0cf35','2021-07-07 03:41:08'),(34,2,'f565983cea1835ef28774c7927fee694','2021-07-07 03:45:55'),(35,4,'06fb7b817309b69107fadf101f9883ff','2021-07-07 03:47:11'),(36,1,'ed776b6ea8c1da8da4c80d222077b006','2021-07-07 20:32:31'),(37,4,'358f1ba1ea028c1e67c7633b2f5c7402','2021-07-07 20:47:28'),(38,5,'b557d9dc4bc8e7758f09ff6fe22415db','2021-07-07 20:50:23'),(39,4,'55b331c379f14f946a6c6a0b4f760468','2021-07-07 20:54:50'),(40,4,'35514d0aca7da5d0329ac74d44312aae','2021-07-07 20:55:02'),(41,1,'b5514cf453ac65f7736f12b2a8bd3b73','2021-07-07 22:04:29'),(42,4,'26eaa694ae74ed9a12bcd7266068998d','2021-07-08 00:27:01'),(43,1,'86e5018e5c3f90af1bf5204673542f87','2021-07-08 00:27:22'),(44,4,'14eb67f76fe16ca07023b47dac60c2ec','2021-07-08 00:38:38'),(45,1,'53ea23ee0be5b2295357c8ba38ccfd46','2021-07-08 01:06:14'),(46,4,'7e54d14d334eb062f792c57303f92b2e','2021-07-08 01:10:40'),(47,1,'e078c189cbf802a63c3f37fb8ed7698e','2021-07-08 01:17:41'),(48,4,'52999869337351e0ca20367701d32606','2021-07-08 01:18:55'),(49,1,'f4ae0dcb24925d8ad56ad98a28127d36','2021-07-08 01:19:57'),(50,4,'8cce0cd5f55aae6a1df4d386acf5e66b','2021-07-08 01:35:55'),(51,1,'9da507237f31809b69d592f869d12aff','2021-07-08 01:36:16'),(52,2,'f1bc02137634a670555165115c6366aa','2021-07-08 01:38:27'),(53,1,'3c48dedb841288a8e4b92a3f34e29136','2021-07-08 01:39:16'),(54,4,'c89aaadce35214a3b178f30527c3357a','2021-07-08 01:42:09'),(55,1,'cd3d3c2fd369f21f1c52bc6ef7e0c3aa','2021-07-08 01:55:15'),(56,4,'9ec21e6dd538f30ae784a7ae0b15b870','2021-07-08 02:02:41'),(57,1,'bf7c6b65088fdc8826a3feec2ceb46e2','2021-07-08 02:46:24'),(58,2,'4727ef58567a3edfdcd9b7e4afb59b24','2021-07-08 02:46:52'),(59,4,'ac4769ef8e2f449bf9adb91e963bc1f9','2021-07-08 02:47:10'),(60,1,'55deaa76b8467e2b741a82ebf5b4c0a4','2021-07-08 03:58:36'),(61,1,'48c07f53d31d6216f420b44c482f4d34','2021-07-08 05:20:10'),(62,1,'bc22b04df8a76e8152498a5060f225f0','2021-07-09 10:43:05'),(63,1,'271b601174d2826aebe7c3e703c29881','2021-07-09 10:44:07'),(64,1,'db4abf3033647d2fd8ea45b90eb7226e','2021-07-09 23:57:29'),(65,4,'3df9710d9909978ef340260583121eab','2021-07-10 00:14:57'),(66,1,'6fa171e57701329167df371666eb92dd','2021-07-10 00:15:38'),(67,1,'656dfa0d842a1249ee7855f77119464d','2021-07-10 00:19:57'),(68,4,'388effbc429645d6ac3b860006a52101','2021-07-10 00:21:46'),(69,1,'74fc93177eed014573ba0e87990e555b','2021-07-10 00:22:39'),(70,4,'62ac0c1474f6f124aa60a000d8393983','2021-07-10 00:31:01'),(71,5,'1e43cbba76c8f5e012f18e3bda4e19f5','2021-07-10 00:41:04'),(72,4,'c0701c5217cdedbc615ed72841e72527','2021-07-10 00:45:21'),(73,2,'1b8c753c5d0ab367a0dcf6939bcdc497','2021-07-10 00:45:37'),(74,4,'acb3da9ba61b1f7cfc71ec8890264726','2021-07-10 00:58:44'),(75,4,'71e06b3a0497939e0002d535345bb72f','2021-07-10 00:58:53'),(76,5,'aa73138a9e618e1c47a34d912f507a3e','2021-07-10 01:07:15'),(77,4,'3daec9026933b6c924a55dd2de71ad22','2021-07-10 01:10:24'),(78,1,'06f7e60511c75998bf6934795e877ca7','2021-07-10 01:15:41'),(79,4,'0e30ed86c4189ac1013d2e57967ac2c2','2021-07-10 01:16:59'),(80,1,'8a8f2e0b351c62afcbda2c03ad699b16','2021-07-10 01:17:22'),(81,4,'afc4b90451f2e455c906c772e2536a6d','2021-07-10 01:32:51'),(82,5,'72e59abfe086844d2c0c589e1a6e4af7','2021-07-10 01:35:01'),(83,4,'955bf4f3a0f5ce02c28187c3da5971fa','2021-07-10 02:20:31'),(84,1,'a00a3bd72e2d6463e812e2e25614ba39','2021-07-10 02:23:03'),(85,1,'2948fedffe9b94ee66be04901d6300e2','2021-07-10 02:25:22'),(86,4,'2124e4f6cee41f5c2b36f9bdbc3c561d','2021-07-10 02:40:11'),(87,1,'375b402d12bd80d21578619db6e5fce9','2021-07-10 02:40:31'),(88,4,'235a81427b8b5cf66810a2da01ba21af','2021-07-10 02:40:49'),(89,4,'e43d7b3b6ed1962042f5a70a34ba214e','2021-07-10 02:44:38'),(90,5,'9e672e4fb2dfae944fd446524d0cb1d0','2021-07-10 02:47:59'),(91,1,'413d88ee09251995a3a78df86829c354','2021-07-10 02:48:12'),(92,5,'ee312b38d80f4ae8a50744efba459e2e','2021-07-10 04:10:36'),(93,1,'9d4365755ec9c6b4f01e83d763970d6c','2021-07-10 04:10:51'),(94,4,'88a6a35d0f8cdafecd9d7e5347c68837','2021-07-10 04:11:29'),(95,5,'bbbd514ea5d4e9fa5410e81ce3d7066a','2021-07-10 04:11:40'),(96,1,'2a4fe9bff1f11858e5270f602e160270','2021-07-10 04:11:49'),(97,6,'2d00376b81aafd2f0cba597fc89f70ec','2021-07-10 04:20:45'),(98,6,'a939b08bd7036d88d551be275188f286','2021-07-10 04:21:19'),(99,1,'42bfd44e9d7ffa03a6472695c2d8f6c5','2021-07-10 04:23:29'),(100,6,'1d1f57760f399272404bd036e11eea28','2021-07-10 04:24:03'),(101,1,'f7681d1569f6167abf206810189d60c4','2021-07-10 04:28:49'),(102,6,'1dc7239b6d5ed4191d55276e93617df1','2021-07-10 04:30:25'),(103,1,'0d3339131dbae78946dbff608d054b10','2021-07-10 04:30:38'),(104,6,'706cc7d65d743b7103cc39c561f149fa','2021-07-10 04:31:53'),(105,1,'67a9628f5500299c8516eca194fdd4b4','2021-07-10 04:32:46'),(106,6,'c0ca15f569258f48c4ef1a537bdc1ddf','2021-07-10 04:35:54'),(107,1,'09da5d7b18b50340fd6fb3d05760e608','2021-07-10 04:47:57'),(108,1,'8128a4e3deeaef0c44d1d9f893662489','2021-07-10 04:53:11'),(109,6,'bed349d407cdea955c639d2e349de9d2','2021-07-10 04:54:32'),(110,1,'b5ecce84bcc215ae4f31da62843f40b9','2021-07-10 04:56:57'),(111,6,'9f7fd9912c755f5e07bae088d40e00c0','2021-07-10 04:59:16'),(112,1,'795871685c3b47121115ed3ff6a34539','2021-07-10 05:00:01');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','ADMIN','admin@hmt.com','$2y$12$5Gp0XLFoCrjfbfrXACywGOh8k2np/xCF4UsbiCnrqLyL3aOOObVVG','ACTIVE','1'),(2,'sales.uttara','Sales Uttara','sales.uttara@gmail.com','$2y$12$JOsaKynpxhXJS/fLLotzFO2V3S32bzqf8csyQnq3WBycrBNM3GEmu','ACTIVE','01712345678'),(3,'mgr.uttara','Manager Uttara','mgr.uttara@gmail.com','$2y$12$rAe2Sb.0jUyC2g3XO2.43ePasXsdHqdPufjrho2dNFjoaSaCu7WOK','ACTIVE',''),(4,'sales.rajshahi',' Sales Rajshahi','sales.rajshahi@gmail.com','$2y$12$0nnVoTcQcP1neOj3OUSDK.Lo3NU3AVfnmD0WaLxf9DJ2.w35x64sC','ACTIVE',''),(5,'mgr.rajshahi','Manager Rajshahi','mgr.rajshahi@gmail.com','$2y$12$HLPN0EScdeNuKVQGTzcSc.8B0WEgiPc42Ne2IvWzQr3UN7sH3pnDq','ACTIVE',''),(6,'cntrl.fctry','Central Factory','cntrl.fctry@gmail.com','$2y$12$cdxxWphtDtb08Dfquk9akO5AktGkyPtm3g/6YstoKB1zVMXTtBhpu','ACTIVE','');
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

-- Dump completed on 2021-07-10 20:03:11
