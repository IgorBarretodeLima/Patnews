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
-- Table structure for table `ativos`
--

DROP TABLE IF EXISTS `ativos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ativos` (
  `id_ativo` int NOT NULL AUTO_INCREMENT,
  `num_tombamento` varchar(20) NOT NULL,
  `nome_ativo` varchar(100) NOT NULL,
  `data_aquisicao` date NOT NULL,
  `valor_aquisicao` decimal(10,2) NOT NULL,
  `status_ativo` varchar(20) DEFAULT 'Em Uso',
  `id_categoria` int NOT NULL,
  `id_responsavel` int NOT NULL,
  PRIMARY KEY (`id_ativo`),
  UNIQUE KEY `num_tombamento` (`num_tombamento`),
  KEY `fk_ativo_categoria` (`id_categoria`),
  KEY `fk_ativo_responsavel` (`id_responsavel`),
  CONSTRAINT `fk_ativo_categoria` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id_categoria`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_ativo_responsavel` FOREIGN KEY (`id_responsavel`) REFERENCES `responsaveis` (`id_responsavel`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ativos`
--

LOCK TABLES `ativos` WRITE;
/*!40000 ALTER TABLE `ativos` DISABLE KEYS */;
INSERT INTO `ativos` VALUES (1,'PAT-00101','Notebook Dell Latitude 5420','2023-01-15',5500.00,'Em Uso',1,1),(2,'PAT-00102','Servidor Dell PowerEdge R740','2022-05-10',25000.00,'Em Uso',1,1),(3,'PAT-00201','Cadeira Ergonômica Herman Miller','2021-08-20',3200.00,'Em Uso',2,2),(4,'PAT-00301','Furgão Renault Master','2020-03-12',120000.00,'Em Manutenção',3,4),(5,'PAT-00401','Empilhadeira Elétrica Still','2019-11-05',85000.00,'Em Uso',4,4),(6,'PAT-00103','MacBook Pro 16\"','2024-02-01',18000.00,'Em Uso',1,5);
/*!40000 ALTER TABLE `ativos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-19 16:18:25
