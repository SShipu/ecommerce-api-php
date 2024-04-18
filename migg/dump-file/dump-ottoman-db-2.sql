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
-- Table structure for table `Cusmoters`
--

DROP TABLE IF EXISTS `Cusmoters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cusmoters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `contact_no` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cusmoters`
--

LOCK TABLES `Cusmoters` WRITE;
/*!40000 ALTER TABLE `Cusmoters` DISABLE KEYS */;
/*!40000 ALTER TABLE `Cusmoters` ENABLE KEYS */;
UNLOCK TABLES;

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
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`branch_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branches`
--

LOCK TABLES `branches` WRITE;
/*!40000 ALTER TABLE `branches` DISABLE KEYS */;
INSERT INTO `branches` VALUES (1,'Mohammadpur','Mohammadpur, Dhaka',''),(3,'Shyamoli','Shyamoli, Dhaka','');
/*!40000 ALTER TABLE `branches` ENABLE KEYS */;
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
  KEY `IDX_4049BA01DCD6CC49` (`branch_id`),
  CONSTRAINT `FK_4049BA01D4B8BAA0` FOREIGN KEY (`cusmoter_id`) REFERENCES `Cusmoters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_4049BA01DCD6CC49` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE
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
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoices` (
  `id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `total` double NOT NULL,
  `grand_total` double NOT NULL,
  `discount` double NOT NULL,
  `discount_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_code` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_attribute_values`
--

LOCK TABLES `item_attribute_values` WRITE;
/*!40000 ALTER TABLE `item_attribute_values` DISABLE KEYS */;
INSERT INTO `item_attribute_values` VALUES (1,1,'Red','#FF0000'),(2,1,'Yellow','#FFFF00'),(3,1,'Blue','#0000FF'),(4,2,'Small',''),(5,2,'Large',''),(6,2,'X',''),(7,2,'XL',''),(20,2,'Medium',''),(29,22,'text-value-4',''),(30,22,'text-value-5',''),(33,22,'tttttt-3','#tt');
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
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_attributes`
--

LOCK TABLES `item_attributes` WRITE;
/*!40000 ALTER TABLE `item_attributes` DISABLE KEYS */;
INSERT INTO `item_attributes` VALUES (1,'Color',1),(2,'Size',1),(22,'test-attribute',0);
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lookups`
--

LOCK TABLES `lookups` WRITE;
/*!40000 ALTER TABLE `lookups` DISABLE KEYS */;
INSERT INTO `lookups` VALUES (1,NULL,'band','Metallica','',0,'ACTIVE'),(2,NULL,'band','Iron Maiden','',0,'ACTIVE'),(3,NULL,'band','Megadeth','',0,'ACTIVE'),(4,NULL,'band','Dream Theater','',0,'ACTIVE'),(5,NULL,'category','Mens Fashion','',0,'ACTIVE'),(6,NULL,'category','Womens Fashion','',0,'ACTIVE'),(7,5,'category','T-Shirts','',0,'ACTIVE'),(8,6,'category','T-Shirts','',0,'ACTIVE'),(9,7,'category','Full Sleeves','',0,'ACTIVE'),(10,7,'category','Half Sleeves','',0,'ACTIVE'),(11,8,'category','Full Sleeves','',0,'ACTIVE'),(12,8,'category','Half Sleeves','',0,'ACTIVE'),(13,NULL,'category','test-category','',0,'INACTIVE'),(14,13,'category','test-sub-category','',0,'ACTIVE'),(15,NULL,'category','fgydfgdr..','',0,'INACTIVE'),(16,15,'category','dxvsd','',0,'ACTIVE'),(17,NULL,'brand','Yellow','',0,'ACTIVE'),(18,NULL,'brand','dgfgd','',0,'INACTIVE'),(19,NULL,'band','xfgvsegw dg','',0,'INACTIVE'),(20,13,'band','test-band','',0,'ACTIVE'),(21,NULL,'category','test-category','',0,'INACTIVE'),(22,NULL,'band','test-band','',0,'ACTIVE'),(23,NULL,'band','test-band','',0,'INACTIVE'),(24,21,'category','test-sub-category','',0,'ACTIVE'),(25,24,'category','test-sub-child-category','',0,'ACTIVE'),(26,NULL,'category','ytuyrtu','',0,'ACTIVE');
/*!40000 ALTER TABLE `lookups` ENABLE KEYS */;
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
INSERT INTO `ottoman_files` VALUES ('1a7f3f2da814cdb946cfb373d3630a717003b24913fef0f07008e1a7edb48f3102a4c60a62e55a60c191b4952e067eff170698815538f82da564989f81ec7988.jpeg','IMAGE','jpeg','1.jpeg',0,'2021-06-22 08:30:13'),('4171410c07d48d6e1d6469e66ffa7ad7b662a0654cf0174eee4656dc89e2560d9576fb541c27bcf769c7b8a7c51c07f1ee7f92b5a98a4215cb0f9fd8699057d9.jpeg','IMAGE','jpeg','1.jpeg',0,'2021-06-22 08:31:31'),('80ea46a055b8a51f09d96fe55764543f9ea52dc84308627bde1d273d15c48e8660acbb72aaadfb66d72f7b864084f7e00ce4aa28ac05beeca97d4d842523efcd.jpeg','IMAGE','jpeg','1.jpeg',0,'2021-06-22 08:20:58'),('83ddf2dfdfc9f4023180ff024dfa7959f4f7e6ff8d52565cbdcb83736b0e3d751b08921cd9540321ca911acf2c3342f8315f1f4c9b282775b90d6912ccef9d44.png','IMAGE','png','Screenshot from 2021-06-10 20-40-28.png',0,'2021-06-22 12:53:52'),('ac99448dc6c82dc7e6a7f7c88d69cf9887dc488f6c4703b9e805782959dfe603f3a7a608c308c0a1dfb4ce9bda3e8c9429ca13ca15b855129fcad473386e7932.jpg','IMAGE','jpg','20201019161023_IMG_4715.JPG',0,'2021-06-22 11:25:27'),('gallery-thumb-1a7f3f2da814cdb946cfb373d3630a717003b24913fef0f07008e1a7edb48f3102a4c60a62e55a60c191b4952e067eff170698815538f82da564989f81ec7988.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:30:13'),('gallery-thumb-4171410c07d48d6e1d6469e66ffa7ad7b662a0654cf0174eee4656dc89e2560d9576fb541c27bcf769c7b8a7c51c07f1ee7f92b5a98a4215cb0f9fd8699057d9.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:31:31'),('gallery-thumb-80ea46a055b8a51f09d96fe55764543f9ea52dc84308627bde1d273d15c48e8660acbb72aaadfb66d72f7b864084f7e00ce4aa28ac05beeca97d4d842523efcd.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:20:58'),('gallery-thumb-83ddf2dfdfc9f4023180ff024dfa7959f4f7e6ff8d52565cbdcb83736b0e3d751b08921cd9540321ca911acf2c3342f8315f1f4c9b282775b90d6912ccef9d44.jpg','IMAGE','jpg','Screenshot from 2021-06-10 20-40-28.png',0,'2021-06-22 12:53:52'),('gallery-thumb-ac99448dc6c82dc7e6a7f7c88d69cf9887dc488f6c4703b9e805782959dfe603f3a7a608c308c0a1dfb4ce9bda3e8c9429ca13ca15b855129fcad473386e7932.jpg','IMAGE','jpg','20201019161023_IMG_4715.JPG',0,'2021-06-22 11:25:28'),('list-thumb-1a7f3f2da814cdb946cfb373d3630a717003b24913fef0f07008e1a7edb48f3102a4c60a62e55a60c191b4952e067eff170698815538f82da564989f81ec7988.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:30:13'),('list-thumb-4171410c07d48d6e1d6469e66ffa7ad7b662a0654cf0174eee4656dc89e2560d9576fb541c27bcf769c7b8a7c51c07f1ee7f92b5a98a4215cb0f9fd8699057d9.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:31:31'),('list-thumb-80ea46a055b8a51f09d96fe55764543f9ea52dc84308627bde1d273d15c48e8660acbb72aaadfb66d72f7b864084f7e00ce4aa28ac05beeca97d4d842523efcd.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:20:58'),('list-thumb-83ddf2dfdfc9f4023180ff024dfa7959f4f7e6ff8d52565cbdcb83736b0e3d751b08921cd9540321ca911acf2c3342f8315f1f4c9b282775b90d6912ccef9d44.jpg','IMAGE','jpg','Screenshot from 2021-06-10 20-40-28.png',0,'2021-06-22 12:53:52'),('list-thumb-ac99448dc6c82dc7e6a7f7c88d69cf9887dc488f6c4703b9e805782959dfe603f3a7a608c308c0a1dfb4ce9bda3e8c9429ca13ca15b855129fcad473386e7932.jpg','IMAGE','jpg','20201019161023_IMG_4715.JPG',0,'2021-06-22 11:25:28'),('main-thumb-1a7f3f2da814cdb946cfb373d3630a717003b24913fef0f07008e1a7edb48f3102a4c60a62e55a60c191b4952e067eff170698815538f82da564989f81ec7988.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:30:13'),('main-thumb-4171410c07d48d6e1d6469e66ffa7ad7b662a0654cf0174eee4656dc89e2560d9576fb541c27bcf769c7b8a7c51c07f1ee7f92b5a98a4215cb0f9fd8699057d9.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:31:31'),('main-thumb-80ea46a055b8a51f09d96fe55764543f9ea52dc84308627bde1d273d15c48e8660acbb72aaadfb66d72f7b864084f7e00ce4aa28ac05beeca97d4d842523efcd.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:20:58'),('main-thumb-83ddf2dfdfc9f4023180ff024dfa7959f4f7e6ff8d52565cbdcb83736b0e3d751b08921cd9540321ca911acf2c3342f8315f1f4c9b282775b90d6912ccef9d44.jpg','IMAGE','jpg','Screenshot from 2021-06-10 20-40-28.png',0,'2021-06-22 12:53:52'),('main-thumb-ac99448dc6c82dc7e6a7f7c88d69cf9887dc488f6c4703b9e805782959dfe603f3a7a608c308c0a1dfb4ce9bda3e8c9429ca13ca15b855129fcad473386e7932.jpg','IMAGE','jpg','20201019161023_IMG_4715.JPG',0,'2021-06-22 11:25:28'),('pos-details-thumb-1a7f3f2da814cdb946cfb373d3630a717003b24913fef0f07008e1a7edb48f3102a4c60a62e55a60c191b4952e067eff170698815538f82da564989f81ec7988.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:30:13'),('pos-details-thumb-4171410c07d48d6e1d6469e66ffa7ad7b662a0654cf0174eee4656dc89e2560d9576fb541c27bcf769c7b8a7c51c07f1ee7f92b5a98a4215cb0f9fd8699057d9.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:31:31'),('pos-details-thumb-80ea46a055b8a51f09d96fe55764543f9ea52dc84308627bde1d273d15c48e8660acbb72aaadfb66d72f7b864084f7e00ce4aa28ac05beeca97d4d842523efcd.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:20:58'),('pos-details-thumb-83ddf2dfdfc9f4023180ff024dfa7959f4f7e6ff8d52565cbdcb83736b0e3d751b08921cd9540321ca911acf2c3342f8315f1f4c9b282775b90d6912ccef9d44.jpg','IMAGE','jpg','Screenshot from 2021-06-10 20-40-28.png',0,'2021-06-22 12:53:52'),('pos-details-thumb-ac99448dc6c82dc7e6a7f7c88d69cf9887dc488f6c4703b9e805782959dfe603f3a7a608c308c0a1dfb4ce9bda3e8c9429ca13ca15b855129fcad473386e7932.jpg','IMAGE','jpg','20201019161023_IMG_4715.JPG',0,'2021-06-22 11:25:27'),('pos-large-thumb-1a7f3f2da814cdb946cfb373d3630a717003b24913fef0f07008e1a7edb48f3102a4c60a62e55a60c191b4952e067eff170698815538f82da564989f81ec7988.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:30:13'),('pos-large-thumb-4171410c07d48d6e1d6469e66ffa7ad7b662a0654cf0174eee4656dc89e2560d9576fb541c27bcf769c7b8a7c51c07f1ee7f92b5a98a4215cb0f9fd8699057d9.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:31:31'),('pos-large-thumb-80ea46a055b8a51f09d96fe55764543f9ea52dc84308627bde1d273d15c48e8660acbb72aaadfb66d72f7b864084f7e00ce4aa28ac05beeca97d4d842523efcd.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:20:58'),('pos-large-thumb-83ddf2dfdfc9f4023180ff024dfa7959f4f7e6ff8d52565cbdcb83736b0e3d751b08921cd9540321ca911acf2c3342f8315f1f4c9b282775b90d6912ccef9d44.jpg','IMAGE','jpg','Screenshot from 2021-06-10 20-40-28.png',0,'2021-06-22 12:53:52'),('pos-large-thumb-ac99448dc6c82dc7e6a7f7c88d69cf9887dc488f6c4703b9e805782959dfe603f3a7a608c308c0a1dfb4ce9bda3e8c9429ca13ca15b855129fcad473386e7932.jpg','IMAGE','jpg','20201019161023_IMG_4715.JPG',0,'2021-06-22 11:25:27'),('related-thumb-1a7f3f2da814cdb946cfb373d3630a717003b24913fef0f07008e1a7edb48f3102a4c60a62e55a60c191b4952e067eff170698815538f82da564989f81ec7988.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:30:13'),('related-thumb-4171410c07d48d6e1d6469e66ffa7ad7b662a0654cf0174eee4656dc89e2560d9576fb541c27bcf769c7b8a7c51c07f1ee7f92b5a98a4215cb0f9fd8699057d9.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:31:31'),('related-thumb-80ea46a055b8a51f09d96fe55764543f9ea52dc84308627bde1d273d15c48e8660acbb72aaadfb66d72f7b864084f7e00ce4aa28ac05beeca97d4d842523efcd.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:20:58'),('related-thumb-83ddf2dfdfc9f4023180ff024dfa7959f4f7e6ff8d52565cbdcb83736b0e3d751b08921cd9540321ca911acf2c3342f8315f1f4c9b282775b90d6912ccef9d44.jpg','IMAGE','jpg','Screenshot from 2021-06-10 20-40-28.png',0,'2021-06-22 12:53:52'),('related-thumb-ac99448dc6c82dc7e6a7f7c88d69cf9887dc488f6c4703b9e805782959dfe603f3a7a608c308c0a1dfb4ce9bda3e8c9429ca13ca15b855129fcad473386e7932.jpg','IMAGE','jpg','20201019161023_IMG_4715.JPG',0,'2021-06-22 11:25:28'),('shop-list-thumb-1a7f3f2da814cdb946cfb373d3630a717003b24913fef0f07008e1a7edb48f3102a4c60a62e55a60c191b4952e067eff170698815538f82da564989f81ec7988.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:30:13'),('shop-list-thumb-4171410c07d48d6e1d6469e66ffa7ad7b662a0654cf0174eee4656dc89e2560d9576fb541c27bcf769c7b8a7c51c07f1ee7f92b5a98a4215cb0f9fd8699057d9.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:31:31'),('shop-list-thumb-80ea46a055b8a51f09d96fe55764543f9ea52dc84308627bde1d273d15c48e8660acbb72aaadfb66d72f7b864084f7e00ce4aa28ac05beeca97d4d842523efcd.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:20:58'),('shop-list-thumb-83ddf2dfdfc9f4023180ff024dfa7959f4f7e6ff8d52565cbdcb83736b0e3d751b08921cd9540321ca911acf2c3342f8315f1f4c9b282775b90d6912ccef9d44.jpg','IMAGE','jpg','Screenshot from 2021-06-10 20-40-28.png',0,'2021-06-22 12:53:52'),('shop-list-thumb-ac99448dc6c82dc7e6a7f7c88d69cf9887dc488f6c4703b9e805782959dfe603f3a7a608c308c0a1dfb4ce9bda3e8c9429ca13ca15b855129fcad473386e7932.jpg','IMAGE','jpg','20201019161023_IMG_4715.JPG',0,'2021-06-22 11:25:28'),('sidebar-thumb-1a7f3f2da814cdb946cfb373d3630a717003b24913fef0f07008e1a7edb48f3102a4c60a62e55a60c191b4952e067eff170698815538f82da564989f81ec7988.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:30:13'),('sidebar-thumb-4171410c07d48d6e1d6469e66ffa7ad7b662a0654cf0174eee4656dc89e2560d9576fb541c27bcf769c7b8a7c51c07f1ee7f92b5a98a4215cb0f9fd8699057d9.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:31:31'),('sidebar-thumb-80ea46a055b8a51f09d96fe55764543f9ea52dc84308627bde1d273d15c48e8660acbb72aaadfb66d72f7b864084f7e00ce4aa28ac05beeca97d4d842523efcd.jpg','IMAGE','jpg','1.jpeg',0,'2021-06-22 08:20:58'),('sidebar-thumb-83ddf2dfdfc9f4023180ff024dfa7959f4f7e6ff8d52565cbdcb83736b0e3d751b08921cd9540321ca911acf2c3342f8315f1f4c9b282775b90d6912ccef9d44.jpg','IMAGE','jpg','Screenshot from 2021-06-10 20-40-28.png',0,'2021-06-22 12:53:52'),('sidebar-thumb-ac99448dc6c82dc7e6a7f7c88d69cf9887dc488f6c4703b9e805782959dfe603f3a7a608c308c0a1dfb4ce9bda3e8c9429ca13ca15b855129fcad473386e7932.jpg','IMAGE','jpg','20201019161023_IMG_4715.JPG',0,'2021-06-22 11:25:28');
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
INSERT INTO `product_lookup` VALUES (1,2),(1,5),(3,21),(3,22),(4,21),(4,22),(7,21),(7,22),(10,1),(10,17),(12,21),(12,22),(13,17),(14,1),(14,17),(15,21),(15,22),(16,3),(17,3),(18,4),(18,5),(18,7),(18,9),(18,10),(18,17),(19,4),(19,5),(19,7),(19,9),(19,10),(19,17),(21,21),(21,22),(22,21),(22,22),(23,5),(23,6),(23,7),(23,8),(23,9),(23,10),(23,11),(23,12),(23,17),(24,5),(24,6),(24,7),(24,8),(24,9),(24,10),(24,11),(24,12),(24,17),(25,5),(25,6),(25,7),(25,8),(25,9),(25,10),(25,11),(25,12),(25,17),(26,5),(26,7),(26,9),(26,17),(27,17),(28,4),(28,9),(28,17),(29,5),(29,7),(29,9),(29,17);
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
INSERT INTO `product_ottomanfile` VALUES (4,'4171410c07d48d6e1d6469e66ffa7ad7b662a0654cf0174eee4656dc89e2560d9576fb541c27bcf769c7b8a7c51c07f1ee7f92b5a98a4215cb0f9fd8699057d9.jpeg'),(22,'4171410c07d48d6e1d6469e66ffa7ad7b662a0654cf0174eee4656dc89e2560d9576fb541c27bcf769c7b8a7c51c07f1ee7f92b5a98a4215cb0f9fd8699057d9.jpeg');
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
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Dance of Death','Product-1',600,0,'','Iron Maiden - Dance of Death','ACTIVE'),(3,'test product','Product-test',1000,0,'','test product','ACTIVE'),(4,'Product 3','Product-3',120,100,'','Product-3 Description','ACTIVE'),(7,'test product 5','Product-test-5',1000,0,'','test product','ACTIVE'),(10,'Polo t-shart','A-012C',1200,800,'','Polo t-shart dhaka, bangladesh','ACTIVE'),(12,'test product 6','Product-test-6',1000,0,'','test product','ACTIVE'),(13,'fgf345','34tfgsdf',4353,435,'','fgb','ACTIVE'),(14,'Jeans t-shart','AB-125DB',700,599,'','Black Cotton Short Sleeve T-Shirt for Men','ACTIVE'),(15,'test product 7','Product-test-7',1000,0,'','test product','ACTIVE'),(16,'Product xyz','Product- dshf',120,100,'','Product-4 Description','ACTIVE'),(17,'Product yu','Product- dsyhf',0,0,'','Product-4 Description','ACTIVE'),(18,'Neow T-shirt','NEOW-12305',0,0,'','<h1>Neow &nbsp;T-shirt is famous in all over bangladesh</h1>','ACTIVE'),(19,'Rabox T-shirt','RA-102-BOX',0,0,'','<h1>Rabox T-shirt popular all over in bangladesh</h1>','ACTIVE'),(21,'test product 8','Product-test-8',1000,0,'','test product','ACTIVE'),(22,'test product 9','Product-test-9',1000,0,'','test product','ACTIVE'),(23,'Lacoste white t-shirt','LW-89734TS',0,0,'','<h6>Lacoste White Menâ€™s Multicolored Embroidered Signature T-Shirt</h6><h6><br></h6><p><br></p>','ACTIVE'),(24,'Lacoste  white t-shirt','LW-6832TS',0,0,'','<h6>Lacoste White Menâ€™s Multicolored Embroidered Signature T-Shirt</h6><p><br></p>','ACTIVE'),(25,'Lacoste White Menâ€™s  T-Shirt','FSH-674TS',0,0,'','<h6>Lacoste White Menâ€™s Multicolored Embroidered Signature T-Shirt</h6><h6><br></h6>','ACTIVE'),(26,'dtgwet','erter',0,0,'','<h6>Lacoste White Menâ€™s Multicolored Embroidered Signature T-Shirt</h6><p><br></p>','ACTIVE'),(27,'fdghdfdfg','ertfb435',435,232,'','<p>Some initial content</p>','ACTIVE'),(28,'sfsdfgerywe4','43retge',345,435,'','<p>Some initial content</p>','ACTIVE'),(29,'dfgdfgh','435dfgd',435,431,'','<p>Some initial content</p>','ACTIVE');
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
INSERT INTO `sku_attribute_values` VALUES ('19-RA-102-BOX-1-20',1),('19-RA-102-BOX-1-4',1),('26-erter-1-5',1),('13-34tfgsdf-2-20',2),('13-34tfgsdf-2-5',2),('13-34tfgsdf-2-7',2),('14-AB-125DB-3-20',3),('14-AB-125DB-3-5',3),('19-RA-102-BOX-3-5',3),('19-RA-102-BOX-1-4',4),('24-LW-6832TS-5-4',4),('1-Product-1-20-5-7',5),('13-34tfgsdf-2-5',5),('14-AB-125DB-3-5',5),('19-RA-102-BOX-3-5',5),('24-LW-6832TS-5-4',5),('26-erter-1-5',5),('1-Product-1-20-5-7',7),('13-34tfgsdf-2-7',7),('1-Product-1-20-5-7',20),('13-34tfgsdf-2-20',20),('14-AB-125DB-3-20',20),('19-RA-102-BOX-1-20',20),('3-Product-test-21',21),('4-Product-test-2-21',21),('4-Product-test-2-22',22),('4-Product-test-2-23',23),('12-Product-test-6-29',29),('7-Product-test-5-29',29),('12-Product-test-6-30',30),('7-Product-test-5-30',30);
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
INSERT INTO `skus` VALUES ('1-Product-1-20-5-7',1,600,0,'Medium,Large,XL'),('12-Product-test-6-29',12,650,0,'text-value-4'),('12-Product-test-6-30',12,750,0,'text-value-5'),('13-34tfgsdf-2-20',13,435,435,'Yellow,Medium'),('13-34tfgsdf-2-5',13,345,435,'Yellow,Large'),('13-34tfgsdf-2-7',13,345,43,'Yellow,XL'),('14-AB-125DB-3-20',14,433,400,'Blue,Medium'),('14-AB-125DB-3-5',14,444,411,'Blue,Large'),('19-RA-102-BOX-1-20',19,234,123,'Red,Medium'),('19-RA-102-BOX-1-4',19,432,123,'Red,Small'),('19-RA-102-BOX-3-5',19,3456,2332,'Blue,Large'),('24-LW-6832TS-5-4',24,250,220,'Large,Small'),('26-erter-1-5',26,34534,2323,'Red,Large'),('3-Product-test-21',3,600,0,'text-value'),('4-Product-test-2-21',4,800,0,'text-value'),('4-Product-test-2-22',4,700,0,'text-value-1'),('4-Product-test-2-23',4,600,0,'text-value-2'),('7-Product-test-5-29',7,650,0,'text-value-4'),('7-Product-test-5-30',7,750,0,'text-value-5');
/*!40000 ALTER TABLE `skus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stocks`
--

DROP TABLE IF EXISTS `stocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stocks` (
  `sku_code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `branch_id` int(11) NOT NULL,
  `branch_id_2` int(11) DEFAULT NULL,
  `count` int(11) NOT NULL,
  `damaged` int(11) NOT NULL,
  `on_hold` int(11) NOT NULL,
  `sales_booked` int(11) NOT NULL,
  PRIMARY KEY (`sku_code`,`branch_id`),
  UNIQUE KEY `unique_name` (`sku_code`),
  KEY `IDX_56F79805744A4E5` (`branch_id_2`),
  CONSTRAINT `FK_56F79805744A4E5` FOREIGN KEY (`branch_id_2`) REFERENCES `branches` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stocks`
--

LOCK TABLES `stocks` WRITE;
/*!40000 ALTER TABLE `stocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `stocks` ENABLE KEYS */;
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
INSERT INTO `user_role` VALUES (1,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tokens`
--

LOCK TABLES `user_tokens` WRITE;
/*!40000 ALTER TABLE `user_tokens` DISABLE KEYS */;
INSERT INTO `user_tokens` VALUES (1,1,'b3dc0486125eaae3a6e5bc8523c2f7e7','2021-06-15 07:16:03'),(2,1,'e7f4b1cd6e3513438b55c164fc651dab','2021-06-15 07:16:25'),(3,1,'26a631186e630efa52607784308f390c','2021-06-15 07:17:16'),(4,1,'cef7eecfc1a7cefbf0cd1b905474ea4e','2021-06-15 07:20:17'),(5,1,'2e556eacc55be9333cdb9e616328f98d','2021-06-15 07:22:00'),(6,1,'fddbd0f220734ef38e2641cb6940268b','2021-06-15 07:22:34'),(7,1,'e44b2f120e52c98b8012b39e0d4fced2','2021-06-15 07:49:11'),(8,1,'f757c3bc79f1818011dea4534fc9d452','2021-06-15 07:50:39'),(9,1,'a9aa405d07b514b513f84cde039fc11d','2021-06-15 12:10:45'),(10,1,'f386bcaf2aaba894a7c4f344856eb4d0','2021-06-15 12:11:07'),(11,1,'d13d665611ef3cf01cbda3eb386ca3c8','2021-06-15 12:11:41'),(12,1,'53bbacb30fcd1f7ed57cec4505ac2929','2021-06-15 12:11:50'),(13,1,'f8657c92c4f36a9198b9a20d379a7a43','2021-06-15 12:19:45'),(14,1,'d091c646dfefd945879cee65dccd2ce3','2021-06-15 13:05:06'),(15,1,'0bcfc20f40e1fdb17102993aab1d3cc8','2021-06-15 13:05:23'),(16,1,'3af17d20bbf11dd2a7a856d45c4d9bde','2021-06-15 13:16:44'),(17,1,'a71792cceb86e6b449fcad0a8dc30ce1','2021-06-15 13:16:46'),(18,1,'493200d7c197ebd160b40d4d874efc11','2021-06-15 13:17:09'),(19,1,'3cea7feeb100047e56006a7869cc8dd7','2021-06-15 13:19:41'),(20,1,'88d92910bebb6b12851c2f8019ff8258','2021-06-15 13:21:47'),(21,1,'c8a3337f409db136a5f2416c886bbd93','2021-06-15 13:22:45'),(22,1,'587c2fb1165d9fb272eca6ad7d5928ee','2021-06-15 13:23:17'),(23,1,'94f77a7875246d51d241e2e9f08eb74d','2021-06-15 13:26:46'),(24,1,'c2e0d064465d2277e94ec47b5de6bfd0','2021-06-15 13:31:44'),(25,1,'84982c71fb06674142e2e7eaf3a93748','2021-06-15 13:32:38'),(26,1,'5740320cce8034d646243ed24d201539','2021-06-15 13:33:49'),(27,1,'2cd9e4376c48b87bfe1350246fae08b4','2021-06-15 13:34:09'),(28,1,'385c7356be5bdf0ce2b81d0866a37e43','2021-06-15 13:54:15'),(29,1,'4372e588ec03aacf5425563dc3b03fd2','2021-06-15 13:55:07'),(30,1,'58bd6ccc12cb6e57e4c82fbc7ca3455a','2021-06-15 13:55:58'),(31,1,'3674ef69c99e235c3b50673c700d175a','2021-06-15 13:56:43'),(32,1,'a961e1cff854b02b11b82e0f8e478a80','2021-06-15 13:59:44'),(33,1,'791c682d81047c9264835de4ffab2487','2021-06-15 14:00:01'),(34,1,'558131f375e57bb5c99a296d16bb0e76','2021-06-15 14:00:35'),(35,1,'188c5f533d94c3b807cc8ab01bba2835','2021-06-16 07:42:56'),(36,1,'582b16c386d522de71d7964925689c66','2021-06-16 07:50:17'),(37,1,'e80156cb0c3db0330104286e8748d0d1','2021-06-16 07:51:49'),(38,1,'337149f4ef92b6e79f805bbf8b3225b4','2021-06-16 07:52:58'),(39,1,'0e5e6992b1800983742967becd523d7b','2021-06-16 07:54:14'),(40,1,'fa09e03f88d8ff51cb30f09c1d6e08d2','2021-06-16 07:54:51'),(41,1,'192479e0e0ea1cb649c3bd7409b4ae25','2021-06-16 07:57:04'),(42,1,'379150b25045df7f44ebcf0691377de2','2021-06-16 12:38:34'),(43,1,'c08abfe2c6ee725ef56442eb64b70357','2021-06-18 10:01:13'),(44,1,'003b3905e066be5b818cf7628104818e','2021-06-19 07:44:32'),(45,1,'0a48fda98ff8406f7a0d776cae968f81','2021-06-22 13:48:15');
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','ADMIN','admin@hmt.com','$2y$12$G7oKMXTGZC7wfGTUoSFVBu4GcqHHnci./pqoh2kkSf9L/.od8eyXu','ACTIVE','1');
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

-- Dump completed on 2021-06-22 20:01:11
