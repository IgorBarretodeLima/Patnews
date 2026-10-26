-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: patnews_db
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `manutencoes`
--

DROP TABLE IF EXISTS `manutencoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manutencoes` (
  `id_manutencao` int NOT NULL AUTO_INCREMENT,
  `id_ativo` int NOT NULL,
  `data_manutencao` date NOT NULL,
  `tipo_manutencao` varchar(30) NOT NULL,
  `custo` decimal(10,2) NOT NULL,
  `descricao` text,
  PRIMARY KEY (`id_manutencao`),
  KEY `fk_manut_ativo` (`id_ativo`),
  CONSTRAINT `fk_manut_ativo` FOREIGN KEY (`id_ativo`) REFERENCES `ativos` (`id_ativo`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manutencoes`
--

LOCK TABLES `manutencoes` WRITE;
/*!40000 ALTER TABLE `manutencoes` DISABLE KEYS */;
INSERT INTO `manutencoes` VALUES (1,1,'2023-11-10','Corretiva',450.00,'Troca de tela danificada'),(2,2,'2023-12-05','Preventiva',1200.00,'Limpeza interna e troca de pasta térmica'),(3,4,'2024-01-15','Corretiva',3500.00,'Manutenção no sistema de freios'),(4,5,'2023-06-20','Preventiva',800.00,'Revisão das baterias'),(5,4,'2024-02-28','Preventiva',600.00,'Troca de óleo e filtros');
/*!40000 ALTER TABLE `manutencoes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-19 16:18:26
