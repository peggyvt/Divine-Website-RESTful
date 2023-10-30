-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: divine
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `email` varchar(50) DEFAULT NULL,
  `img` varchar(30) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `colour` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES ('johndoe@gmail.com','images/rustic/pic7.jpg','SEA SHELLS',9,3,'carnation'),('johndoe@gmail.com','images/rustic/pic1.jpg','BUBBLE CUBE',6,2,'brown');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `email` varchar(50) DEFAULT NULL,
  `img` varchar(30) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
INSERT INTO `favorites` VALUES ('johndoe@gmail.com','images/silhouette/pic4.jpg','DAVID',28),('johndoe@gmail.com','images/rustic/pic5.jpg','HIVES',10);
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `img` varchar(30) DEFAULT NULL,
  `name` varchar(30) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `availability` int DEFAULT NULL,
  `collection` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES ('images/rustic/pic1.jpg','BUBBLE CUBE',6,30,'RUSTIC'),('images/rustic/pic2.jpg','PILLAR',13,30,'RUSTIC'),('images/rustic/pic3.jpg','LOVERS',12,30,'RUSTIC'),('images/rustic/pic4.jpg','CACTUS',7,30,'RUSTIC'),('images/rustic/pic5.jpg','HIVES',10,30,'RUSTIC'),('images/rustic/pic6.jpg','KNOTS',5,30,'RUSTIC'),('images/rustic/pic7.jpg','SEA SHELLS',9,30,'RUSTIC'),('images/rustic/pic8.jpg','TWIST',11,30,'RUSTIC'),('images/silhouette/pic1.jpg','EMOTIONS REVEALED',27,30,'SILHOUETTE'),('images/silhouette/pic2.jpg','FEMININE BODY',22,30,'SILHOUETTE'),('images/silhouette/pic3.jpg','VENUS',25,30,'SILHOUETTE'),('images/silhouette/pic4.jpg','DAVID',28,30,'SILHOUETTE'),('images/silhouette/pic5.jpg','ARTEMIS',28,30,'SILHOUETTE'),('images/silhouette/pic6.jpg','US',20,30,'SILHOUETTE'),('images/silhouette/pic7.jpg','REINE DES FLAMMES',23,30,'SILHOUETTE'),('images/silhouette/pic8.jpg','BABY ANGEL',24,30,'SILHOUETTE');
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `first_name` varchar(30) DEFAULT NULL,
  `surname` varchar(30) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('peggy','vitsa','peggyvitsa@gmail.com','11111'),('guest','guest','guest@gmail.com','guest'),('john','doe','johndoe@gmail.com','333'),('admin','admin','admin@gmail.com','admin'),('mary','jane','maryjane@gmail.com','222');
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

-- Dump completed on 2022-02-15 23:56:03
