-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: pizzas
-- ------------------------------------------------------
-- Server version	8.0.37

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
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'Lalo','lomasajeas 54','5554784588'),(2,'Juanito','lomasajeas 47','5553216549'),(3,'Pepe','lomasajeas 789','454554554'),(4,'Bebe','benitojuares 654','47787458745'),(5,'Lalote','lomasajeas 51','5554784588'),(6,'Lalo','lomasajeas 54','5554784588'),(7,'Miguel Lopez','iudgxgfchvjkl  64','4775784512'),(8,'Mario','JEronimo 465','6549876544'),(9,'Davo','Bombonera 912','6546546546'),(10,'Gianluigi','Saraperhce 6544','3256325632'),(11,'Andes','oiufhfcgvjbk 4654','6546546544'),(12,'Mr popo','oiuyxcvbn 654','7897899874'),(13,'Benito ','poiuydcvb 5454','551245544'),(14,'Garbei','Poderosa 645','4554455445'),(15,'Erick Blanco','Lomas Turbias 654','6546546544'),(16,'Paco Perez','Benito Camelo #1','5551234567'),(17,'Blanco','Silapdelpia  45','6546546546');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_pedido`
--

DROP TABLE IF EXISTS `detalle_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_pedido` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_pedido` int NOT NULL,
  `id_pizza` int NOT NULL,
  `cantidad` int NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_pizza` (`id_pizza`),
  CONSTRAINT `detalle_pedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`),
  CONSTRAINT `detalle_pedido_ibfk_2` FOREIGN KEY (`id_pizza`) REFERENCES `pizzas` (`id_pizza`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_pedido`
--

LOCK TABLES `detalle_pedido` WRITE;
/*!40000 ALTER TABLE `detalle_pedido` DISABLE KEYS */;
INSERT INTO `detalle_pedido` VALUES (1,1,1,1,130.00),(2,1,2,1,90.00),(3,2,3,3,390.00),(4,2,4,1,60.00),(5,3,5,1,130.00),(6,4,6,1,130.00),(7,5,7,1,60.00),(8,6,8,2,280.00),(9,7,9,1,140.00),(10,8,10,2,300.00),(11,9,11,2,120.00),(12,10,12,2,200.00),(13,10,13,1,130.00),(14,11,14,1,90.00),(15,12,15,1,100.00),(16,12,16,1,150.00),(17,13,17,2,300.00),(18,14,18,1,130.00),(19,14,19,1,80.00),(20,15,20,1,80.00),(21,16,21,1,100.00),(22,16,22,2,280.00),(23,16,23,1,130.00),(24,17,24,1,110.00);
/*!40000 ALTER TABLE `detalle_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `fecha` date NOT NULL,
  `total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id_cliente`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,1,'2026-02-12',220.00),(2,2,'2026-03-13',450.00),(3,3,'2026-01-13',130.00),(4,4,'2026-01-13',130.00),(5,5,'2026-01-17',60.00),(6,6,'2026-02-19',280.00),(7,7,'2026-01-25',140.00),(8,8,'2026-03-13',300.00),(9,9,'2026-03-13',120.00),(10,10,'2026-03-13',330.00),(11,11,'2026-03-13',90.00),(12,12,'2026-03-13',250.00),(13,13,'2026-03-13',300.00),(14,14,'2026-03-13',210.00),(15,15,'2026-03-13',80.00),(16,16,'2026-03-13',510.00),(17,17,'2026-03-13',110.00);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pizzas`
--

DROP TABLE IF EXISTS `pizzas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pizzas` (
  `id_pizza` int NOT NULL AUTO_INCREMENT,
  `tamano` varchar(20) NOT NULL,
  `ingredientes` varchar(200) NOT NULL,
  `precio` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id_pizza`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pizzas`
--

LOCK TABLES `pizzas` WRITE;
/*!40000 ALTER TABLE `pizzas` DISABLE KEYS */;
INSERT INTO `pizzas` VALUES (1,'Grande','Piña',130.00),(2,'Mediana','Jamón',90.00),(3,'Grande','Champiñones',130.00),(4,'Chica','Jamón, Piña',60.00),(5,'Grande','Champiñones',130.00),(6,'Grande','Champiñones',130.00),(7,'Chica','Jamón, Piña',60.00),(8,'Grande','Piña, Champiñones',140.00),(9,'Grande','Piña, Champiñones',140.00),(10,'Grande','Jamón, Piña, Champiñones',150.00),(11,'Chica','Jamón, Piña',60.00),(12,'Mediana','Piña, Champiñones',100.00),(13,'Grande','Piña',130.00),(14,'Mediana','Jamón',90.00),(15,'Mediana','Jamón, Piña',100.00),(16,'Grande','Jamón, Piña, Champiñones',150.00),(17,'Grande','Jamón, Piña, Champiñones',150.00),(18,'Grande','Champiñones',130.00),(19,'Mediana','Queso',80.00),(20,'Mediana','Queso',80.00),(21,'Mediana','Jamón, Piña',100.00),(22,'Grande','Piña, Champiñones',140.00),(23,'Grande','Champiñones',130.00),(24,'Mediana','Jamón, Piña, Champiñones',110.00);
/*!40000 ALTER TABLE `pizzas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-13 20:08:44
