CREATE DATABASE  IF NOT EXISTS `atelier` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `atelier`;
-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
--
-- Host: localhost    Database: atelier
-- ------------------------------------------------------
-- Server version	8.0.31-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `UserPermissions`
--

DROP TABLE IF EXISTS `UserPermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `UserPermissions` (
  `permissionId` int NOT NULL AUTO_INCREMENT,
  `permissionName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `permissionType` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '00000000000',
  PRIMARY KEY (`permissionId`,`permissionType`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserPermissions`
--

LOCK TABLES `UserPermissions` WRITE;
/*!40000 ALTER TABLE `UserPermissions` DISABLE KEYS */;
INSERT INTO `UserPermissions` VALUES (0,'Alterar Menu-Logo','10000000'),(1,'Alterar Banner-img','01000000'),(2,'Alterar Banner-text','00100000'),(3,'Alterar Banner-Logo','00010000'),(4,'Modificar 1# Section','00001000'),(5,'Alterar 2# Section','00000100'),(6,'Nenhuma Permissão','00000000');
/*!40000 ALTER TABLE `UserPermissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logins`
--

DROP TABLE IF EXISTS `logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logins` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_sid` char(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `token` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `logins_uk_user_sid` (`user_sid`),
  UNIQUE KEY `logins_uk_token` (`token`),
  CONSTRAINT `logins_ck_created_at` CHECK (`created_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'),
  CONSTRAINT `logins_ck_expire_date` CHECK (`expire_date` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'),
  CONSTRAINT `logins_ck_token` CHECK (`token` regexp _utf8mb4'^[A-Za-z0-9]{64}$'),
  CONSTRAINT `logins_ck_updated_at` CHECK (`updated_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$')
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logins`
--

LOCK TABLES `logins` WRITE;
/*!40000 ALTER TABLE `logins` DISABLE KEYS */;
INSERT INTO `logins` VALUES (29,'5wR1pgO7DT6f','e5654a9f2f8db1147f5f38d472744d4720b03877129fc96f9434a3b56a6c7529','2022-12-11 16:59:22','2022-12-08 16:59:22','2022-12-08 16:59:22');
/*!40000 ALTER TABLE `logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_requests`
--

DROP TABLE IF EXISTS `password_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_requests` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(500) COLLATE utf8mb4_general_ci NOT NULL,
  `token` char(64) COLLATE utf8mb4_general_ci NOT NULL,
  `expire_date` datetime NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `password_requests_uk_email` (`email`),
  UNIQUE KEY `password_requests_uk_token` (`token`),
  CONSTRAINT `password_requests_ck_created_at` CHECK (`created_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'),
  CONSTRAINT `password_requests_ck_email` CHECK (`email` regexp _utf8mb4'^[A-Za-z0-9_]+(.[A-Za-z0-9_]+)*@[A-Za-z0-9_]+(.[A-Za-z0-9_]+)+$'),
  CONSTRAINT `password_requests_ck_expire_date` CHECK (`expire_date` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'),
  CONSTRAINT `password_requests_ck_token` CHECK (`token` regexp _utf8mb4'^[A-Za-z0-9]{64}$'),
  CONSTRAINT `password_requests_ck_updated_at` CHECK (`updated_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$')
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_requests`
--

LOCK TABLES `password_requests` WRITE;
/*!40000 ALTER TABLE `password_requests` DISABLE KEYS */;
INSERT INTO `password_requests` VALUES (7,'aztegoshi@gmail.com','d270ae3428a690e86b7a1a8aa798bea9eb3aa65ad2485a5ce15e958df52ac537','2022-12-08 23:58:56','2022-12-07 23:58:56','2022-12-07 23:58:56');
/*!40000 ALTER TABLE `password_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_atelier`
--

DROP TABLE IF EXISTS `site_atelier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `site_atelier` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image` char(64) COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(200) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(2000) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_atelier_uk_image` (`image`),
  CONSTRAINT `site_atelier_ck_created_at` CHECK (`created_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'),
  CONSTRAINT `site_atelier_ck_image` CHECK (`image` regexp _utf8mb4'^[A-Za-z0-9.]{64}$'),
  CONSTRAINT `site_atelier_ck_updated_at` CHECK (`updated_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$')
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_atelier`
--

LOCK TABLES `site_atelier` WRITE;
/*!40000 ALTER TABLE `site_atelier` DISABLE KEYS */;
INSERT INTO `site_atelier` VALUES (1,'papcQOgIqQ85QqxpEGgcM1xPICsY39bECdxl5hx6XvQDH4GIpnixEuOn0Kg.webp','Atelier Elizeu Manoel','Refinamento e classe: os motivos que encontrei para a excelência do meu trabalho. Procuro ser um especialista onde atuo, principalmente na criação e ajustes de violinos, violoncellos e violas. Venho me aperfeiçoando no ramo da lutheria há mais de 5 anos e, muito provavelmente, a consistência e o amor pelo trabalho têm me feito um dos melhores que conheço na cidade.','2022-12-04 21:59:59','2022-12-06 23:18:43'),(2,'k9IuvL1AyTO8Ibn1reJz2SQWnXZrBGgWbyzkEKU1R8xCYSu74AysSwFTuji.webp','Honra de servir à música','Atenção, meticulosidade, inspiração, harmonia... É como se a música fosse um guia, um caminho na minha vida. E ser responsável pela criação dos instrumentos que a produzem é, definitivamente, é a maior honra que poderia ter. Este sou eu, preparado para solucionar qualquer problema que você tenha no seu instrumento...','2022-12-04 21:59:59','2022-12-06 23:21:37');
/*!40000 ALTER TABLE `site_atelier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_colors`
--

DROP TABLE IF EXISTS `site_colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `site_colors` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `value` char(7) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `site_colors_ck_created_at` CHECK (`created_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'),
  CONSTRAINT `site_colors_ck_name` CHECK (`name` regexp _utf8mb4'^--[a-z-]+$'),
  CONSTRAINT `site_colors_ck_updated_at` CHECK (`updated_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'),
  CONSTRAINT `site_colors_ck_value` CHECK (`value` regexp _utf8mb4'^#[0-9A-F]{6}$')
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_colors`
--

LOCK TABLES `site_colors` WRITE;
/*!40000 ALTER TABLE `site_colors` DISABLE KEYS */;
INSERT INTO `site_colors` VALUES (1,'--dark','#260101','2022-12-06 23:43:20','2022-12-08 00:06:10'),(2,'--light','#f2f2f2','2022-12-06 23:43:20','2022-12-08 22:09:05'),(3,'--primary','#a63f03','2022-12-06 23:43:20','2022-12-07 23:22:56'),(4,'--primary-darker','#731702','2022-12-06 23:43:20','2022-12-06 23:43:20'),(5,'--primary-lighter','#d97904','2022-12-06 23:43:20','2022-12-06 23:43:20');
/*!40000 ALTER TABLE `site_colors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_images`
--

DROP TABLE IF EXISTS `site_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `site_images` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `extension` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_images_uk_name` (`name`),
  CONSTRAINT `site_images_ck_created_at` CHECK (`created_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'),
  CONSTRAINT `site_images_ck_extension` CHECK (`extension` regexp _utf8mb4'^[a-z]+$'),
  CONSTRAINT `site_images_ck_name` CHECK (`name` regexp _utf8mb4'^[a-z0-9_]+$'),
  CONSTRAINT `site_images_ck_updated_at` CHECK (`updated_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$')
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_images`
--

LOCK TABLES `site_images` WRITE;
/*!40000 ALTER TABLE `site_images` DISABLE KEYS */;
INSERT INTO `site_images` VALUES (1,'atelier_logo','svg','2022-12-04 17:11:21','2022-12-07 20:03:09'),(2,'atelier_logo_icon','svg','2022-12-04 17:11:21','2022-12-06 23:17:59'),(3,'atelier_banner','webp','2022-12-04 17:11:21','2022-12-06 23:18:18');
/*!40000 ALTER TABLE `site_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_phrases`
--

DROP TABLE IF EXISTS `site_phrases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `site_phrases` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `text` varchar(1000) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `site_phrases_ck_created_at` CHECK (`created_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'),
  CONSTRAINT `site_phrases_ck_updated_at` CHECK (`updated_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$')
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_phrases`
--

LOCK TABLES `site_phrases` WRITE;
/*!40000 ALTER TABLE `site_phrases` DISABLE KEYS */;
INSERT INTO `site_phrases` VALUES (1,'Visando a excelência, ofereço os mais variados serviços na lutheria com o uso dos mais sofisticados materiais. Reconheço o propósito do músico com seu instrumento e estou disposto a colaborar tanto com a criação quanto com os ajustes necessários nessa jornada.','2022-12-06 19:25:30','2022-12-06 23:25:18');
/*!40000 ALTER TABLE `site_phrases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_services`
--

DROP TABLE IF EXISTS `site_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `site_services` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `image` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `site_services_uk_image` (`image`),
  CONSTRAINT `site_services_ck_created_at` CHECK (`created_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'),
  CONSTRAINT `site_services_ck_image` CHECK (`image` regexp _utf8mb4'^[A-Za-z0-9.]{64}$'),
  CONSTRAINT `site_services_ck_updated_at` CHECK (`updated_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$')
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_services`
--

LOCK TABLES `site_services` WRITE;
/*!40000 ALTER TABLE `site_services` DISABLE KEYS */;
INSERT INTO `site_services` VALUES (18,'94zrzIJhiPEUCnBcL7suW2XV17Qzosvk7KoM9tpKQz1SMxvSfD3utUZdxw2u.svg','Título','Descrição','2022-12-08 17:40:31','2022-12-08 17:40:31');
/*!40000 ALTER TABLE `site_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_permissions`
--

DROP TABLE IF EXISTS `user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `type` char(5) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `user_permissions_ck_created_at` CHECK (`created_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'),
  CONSTRAINT `user_permissions_ck_type` CHECK (`type` regexp _utf8mb4'^[01]{5}$'),
  CONSTRAINT `user_permissions_ck_updated_at` CHECK (`updated_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$')
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_permissions`
--

LOCK TABLES `user_permissions` WRITE;
/*!40000 ALTER TABLE `user_permissions` DISABLE KEYS */;
INSERT INTO `user_permissions` VALUES (1,'Alterar paleta de cores','10000','2022-12-08 22:21:20','2022-12-08 22:21:20'),(2,'Criar elementos','01000','2022-12-08 22:21:20','2022-12-08 22:21:20'),(3,'Alterar e remover elementos','00100','2022-12-08 22:21:20','2022-12-08 22:21:20'),(4,'Criar usuários','00010','2022-12-08 22:21:20','2022-12-08 22:21:20'),(5,'Alterar e remover usuários','00001','2022-12-08 22:21:20','2022-12-08 22:21:20');
/*!40000 ALTER TABLE `user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `sid` char(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `permission_type` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '00000',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_uk_sid` (`sid`),
  UNIQUE KEY `users_uk_email` (`email`),
  CONSTRAINT `users_ck_created_at` CHECK (`created_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'),
  CONSTRAINT `users_ck_email` CHECK (`email` regexp _utf8mb4'^[A-Za-z0-9_]+(.[A-Za-z0-9_]+)*@[A-Za-z0-9_]+(.[A-Za-z0-9_]+)+$'),
  CONSTRAINT `users_ck_password` CHECK (`password` regexp _utf8mb4'^[a-z0-9]{64}$'),
  CONSTRAINT `users_ck_permission_type` CHECK (`permission_type` regexp _utf8mb4'^[01]{5}$'),
  CONSTRAINT `users_ck_sid` CHECK (`sid` regexp _utf8mb4'^[A-Za-z0-9]{12}$'),
  CONSTRAINT `users_ck_updated_at` CHECK (`updated_at` regexp _utf8mb4'^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$')
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'5wR1pgO7DT6f','Anthony Zito Tegoshi','aztegoshi@gmail.com','4b51396e1d5003baab3589a70e8efaa1ac9e4aa704eacb2fd9c74a172d02c617','11101','2022-11-12 17:02:43','2022-12-06 20:01:42'),(2,'VGfYqtq9hGWE','asd','asd@asd.com','99084873c0a1081819e6182924d79cb84c10a02fc465f5ed991a186418fe9eed','11111','2022-12-04 21:35:49','2022-12-04 21:35:49');
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

-- Dump completed on 2022-12-08 22:24:15
