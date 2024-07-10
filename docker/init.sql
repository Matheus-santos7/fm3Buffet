-- MySQL dump 10.13  Distrib 8.3.0, for macos14.2 (arm64)
--
-- Host: localhost    Database: deliveryOnline
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `deliveryOnline`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `deliveryOnline` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `deliveryOnline`;

--
-- Table structure for table `categoria`
--
-- Permissao para acesso ao banco
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '123';
FLUSH PRIVILEGES;
---

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `idcategoria` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `icone` varchar(45) DEFAULT NULL,
  `ordem` int DEFAULT NULL,
  `apagado` int DEFAULT '0',
  PRIMARY KEY (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (32,'Taça','beer',NULL,1),(33,'Copos e Jarras','wine-glass',1,0),(34,'Louças','stroopwafel',3,0),(35,'Garfo','utensils',5,1),(36,'Talheres','utensils',5,0),(37,'Mesa e Cadeiras','cheese',6,0),(38,'Forros de Mesa, Tecidos, e Malhas','utensils',7,0),(39,'Talheres','cookie',2,1),(40,'Rechoud, Travessas e bandejas','utensils',4,0),(41,'Freezer e Expositor de bebidas','beer',2,0),(42,'Outros','stroopwafel',NULL,0),(43,'Brincados Inflaveis','utensils',NULL,1);
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empresa`
--

DROP TABLE IF EXISTS `empresa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empresa` (
  `idempresa` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `ativo` int NOT NULL DEFAULT '1',
  `cep` varchar(10) NOT NULL,
  `endereco` varchar(255) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `bairro` varchar(255) NOT NULL,
  `complemento` varchar(255) DEFAULT NULL,
  `cidade` varchar(255) NOT NULL,
  `estado` varchar(2) NOT NULL,
  `sobre` varchar(1000) DEFAULT NULL,
  `logotipo` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`idempresa`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empresa`
--

LOCK TABLES `empresa` WRITE;
/*!40000 ALTER TABLE `empresa` DISABLE KEYS */;
INSERT INTO `empresa` VALUES (1,'Buffet FM3','teste@teste.com','6d6cd63284be4a47ba7aec4a3458939a95dcbdd5cd0438f23d7457099b4b917c',1,'35777000','Av. Ulisses Batista','574','Centro','Comercio','Araçaoí','MG','Transforme sua festa em um evento inesquecível com nosso buffer de festa! Somos a solução perfeita para garantir uma festa de qualidade, mantendo a excelencia durante toda a noite. Deixe-nos cuidar da sua festa, enquanto você se concentra em aproveitar cada momento da festa!','logo.png');
/*!40000 ALTER TABLE `empresa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formapagamento`
--

DROP TABLE IF EXISTS `formapagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formapagamento` (
  `idformapagamento` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `ativo` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`idformapagamento`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formapagamento`
--

LOCK TABLES `formapagamento` WRITE;
/*!40000 ALTER TABLE `formapagamento` DISABLE KEYS */;
INSERT INTO `formapagamento` VALUES (1,'Pix',1),(2,'Dinheiro',1),(3,'Cartão de Crédito',1),(4,'Cartão de Débito',1);
/*!40000 ALTER TABLE `formapagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horario`
--

DROP TABLE IF EXISTS `horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horario` (
  `idhorario` int NOT NULL AUTO_INCREMENT,
  `idempresa` int NOT NULL,
  `diainicio` int NOT NULL,
  `diafim` int NOT NULL,
  `iniciohorarioum` varchar(5) NOT NULL,
  `fimhorarioum` varchar(5) NOT NULL,
  `iniciohorariodois` varchar(5) DEFAULT NULL,
  `fimhorariodois` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`idhorario`),
  KEY `FK_HORARIO_EMPRESA_idx` (`idempresa`),
  CONSTRAINT `FK_HORARIO_EMPRESA` FOREIGN KEY (`idempresa`) REFERENCES `empresa` (`idempresa`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horario`
--

LOCK TABLES `horario` WRITE;
/*!40000 ALTER TABLE `horario` DISABLE KEYS */;
INSERT INTO `horario` VALUES (94,1,0,0,'00:01','23:58','00:01','23:59'),(95,1,1,1,'00:01','23:59','00:04','23:56'),(96,1,2,5,'00:07','23:58','00:04','23:46');
/*!40000 ALTER TABLE `horario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcional`
--

DROP TABLE IF EXISTS `opcional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opcional` (
  `idopcional` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `tiposimples` int NOT NULL DEFAULT '1',
  `minimo` int NOT NULL DEFAULT '0',
  `maximo` int NOT NULL DEFAULT '0',
  `apagado` int DEFAULT '0',
  PRIMARY KEY (`idopcional`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcional`
--

LOCK TABLES `opcional` WRITE;
/*!40000 ALTER TABLE `opcional` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opcionalitem`
--

DROP TABLE IF EXISTS `opcionalitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `opcionalitem` (
  `idopcionalitem` int NOT NULL AUTO_INCREMENT,
  `idopcional` int NOT NULL,
  `nome` varchar(100) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `apagado` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`idopcionalitem`),
  KEY `FK_OPCIONAL_ITEM_idx` (`idopcional`),
  CONSTRAINT `FK_OPCIONAL_ITEM` FOREIGN KEY (`idopcional`) REFERENCES `opcional` (`idopcional`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opcionalitem`
--

LOCK TABLES `opcionalitem` WRITE;
/*!40000 ALTER TABLE `opcionalitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `opcionalitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `idpedido` int NOT NULL AUTO_INCREMENT,
  `idpedidostatus` int NOT NULL,
  `idtipoentrega` int NOT NULL,
  `idtaxaentrega` int DEFAULT NULL,
  `idformapagamento` int NOT NULL,
  `troco` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  `cep` varchar(10) DEFAULT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `numero` varchar(10) DEFAULT NULL,
  `bairro` varchar(255) DEFAULT NULL,
  `complemento` varchar(255) DEFAULT NULL,
  `cidade` varchar(255) DEFAULT NULL,
  `estado` varchar(2) DEFAULT NULL,
  `nomecliente` varchar(255) NOT NULL,
  `telefonecliente` varchar(255) NOT NULL,
  `datacadastro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `datafinalizado` datetime DEFAULT NULL,
  PRIMARY KEY (`idpedido`),
  KEY `FK_PEDIDO_TIPO_ENTREGA_idx` (`idtipoentrega`),
  KEY `FK_PEDIDO_TAXA_ENTREGA_idx` (`idtaxaentrega`),
  KEY `FK_PEDIDO_STATUS_idx` (`idpedidostatus`),
  KEY `FK_PEDIDO_FORMA_PAG_idx` (`idformapagamento`),
  CONSTRAINT `FK_PEDIDO_FORMA_PAG` FOREIGN KEY (`idformapagamento`) REFERENCES `formapagamento` (`idformapagamento`),
  CONSTRAINT `FK_PEDIDO_STATUS` FOREIGN KEY (`idpedidostatus`) REFERENCES `pedidostatus` (`idpedidostatus`),
  CONSTRAINT `FK_PEDIDO_TAXA_ENTREGA` FOREIGN KEY (`idtaxaentrega`) REFERENCES `taxaentrega` (`idtaxaentrega`),
  CONSTRAINT `FK_PEDIDO_TIPO_ENTREGA` FOREIGN KEY (`idtipoentrega`) REFERENCES `tipoentrega` (`idtipoentrega`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (1,5,1,NULL,1,NULL,30.00,'35777-000','Av Ulisses Batista','574','Centro','casa','Araçaí','MG','Matheus Santos','(31) 98313-4505','2024-03-06 21:17:28',NULL),(2,5,1,NULL,1,NULL,38.00,'35777-000','Av. Ulisses Batista','574','Centro','','Araçaoí','MG','Matheus dos Santos Gonçalves','(31) 98313-4505','2024-05-06 08:02:39','2024-05-06 22:55:09'),(3,5,1,NULL,2,30.00,210.00,'35777-000','Av Ulisses Batista','574','Centro','Casa teste','Araçaí','MG','Matheus Santos','(31) 98313-4595','2024-05-12 01:06:36','2024-06-30 22:37:20'),(4,5,1,NULL,1,NULL,233.00,'35777-000','Av Ulisses Batista','574','Centro','Casa teste','Araçaí','MG','Matheus Santos','(31) 98313-4505','2024-05-12 12:42:31','2024-05-12 12:44:13'),(5,5,1,NULL,1,NULL,309.00,'35777-000','Av. Ulisses Batista','574','Centro','Comercio','Araçaí','MG','Matheus dos Santos Gonçalves','(31) 98313-4505','2024-05-21 21:54:56','2024-06-06 22:03:51'),(6,3,1,NULL,2,200.00,234.00,'35777-000','Av. Ulisses Batista','574','Centro','Comercio','Araçaí','MG','Matheus dos Santos Gonçalves','(31) 98313-4505','2024-06-30 22:36:26',NULL);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidoitem`
--

DROP TABLE IF EXISTS `pedidoitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidoitem` (
  `idpedidoitem` int NOT NULL AUTO_INCREMENT,
  `idpedido` int NOT NULL,
  `idproduto` int NOT NULL,
  `quantidade` int NOT NULL,
  `observacao` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`idpedidoitem`),
  KEY `FK_PRODUTO_PEDIDO_idx` (`idproduto`),
  KEY `FK_PEDIDO_PRODUTO_idx` (`idpedido`),
  CONSTRAINT `FK_PEDIDO_PRODUTO` FOREIGN KEY (`idpedido`) REFERENCES `pedido` (`idpedido`),
  CONSTRAINT `FK_PRODUTO_PEDIDO` FOREIGN KEY (`idproduto`) REFERENCES `produto` (`idproduto`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidoitem`
--

LOCK TABLES `pedidoitem` WRITE;
/*!40000 ALTER TABLE `pedidoitem` DISABLE KEYS */;
INSERT INTO `pedidoitem` VALUES (1,1,108,3,NULL),(2,2,108,2,NULL),(3,2,111,1,NULL),(4,2,110,1,NULL),(5,3,138,2,NULL),(6,3,137,1,NULL),(7,4,108,4,NULL),(8,4,124,15,NULL),(9,4,137,1,NULL),(10,4,110,2,NULL),(11,5,139,1,NULL),(12,5,118,30,NULL),(13,5,108,2,NULL),(14,5,117,1,NULL),(15,6,108,2,NULL),(16,6,115,2,NULL),(17,6,115,2,NULL),(18,6,135,2,NULL),(19,6,108,2,NULL),(20,6,138,2,NULL);
/*!40000 ALTER TABLE `pedidoitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidoitemopcional`
--

DROP TABLE IF EXISTS `pedidoitemopcional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidoitemopcional` (
  `idpedidoitemopcional` int NOT NULL AUTO_INCREMENT,
  `idpedidoitem` int NOT NULL,
  `idopcionalitem` int NOT NULL,
  PRIMARY KEY (`idpedidoitemopcional`),
  KEY `FK_PEDIDO_ITEM_idx` (`idpedidoitem`),
  KEY `FK_OPCIONAL_ITEM_idx` (`idopcionalitem`),
  CONSTRAINT `FK_PEDIDO_ITEM` FOREIGN KEY (`idpedidoitem`) REFERENCES `pedidoitem` (`idpedidoitem`),
  CONSTRAINT `FK_PEDIDO_OPCIONAL_ITEM` FOREIGN KEY (`idopcionalitem`) REFERENCES `opcionalitem` (`idopcionalitem`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidoitemopcional`
--

LOCK TABLES `pedidoitemopcional` WRITE;
/*!40000 ALTER TABLE `pedidoitemopcional` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidoitemopcional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidostatus`
--

DROP TABLE IF EXISTS `pedidostatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidostatus` (
  `idpedidostatus` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(100) NOT NULL,
  PRIMARY KEY (`idpedidostatus`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidostatus`
--

LOCK TABLES `pedidostatus` WRITE;
/*!40000 ALTER TABLE `pedidostatus` DISABLE KEYS */;
INSERT INTO `pedidostatus` VALUES (1,'Pendente'),(2,'Aceito'),(3,'Em preparo'),(4,'Em entrega'),(5,'Concluído'),(6,'Recusado');
/*!40000 ALTER TABLE `pedidostatus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produto`
--

DROP TABLE IF EXISTS `produto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produto` (
  `idproduto` int NOT NULL AUTO_INCREMENT,
  `idcategoria` int DEFAULT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(500) DEFAULT NULL,
  `valor` decimal(10,2) NOT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `ordem` int DEFAULT NULL,
  `apagado` int DEFAULT '0',
  PRIMARY KEY (`idproduto`),
  KEY `FK_CATEGORIA_PRODUTO_idx` (`idcategoria`),
  CONSTRAINT `FK_CATEGORIA_PRODUTO` FOREIGN KEY (`idcategoria`) REFERENCES `categoria` (`idcategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produto`
--

LOCK TABLES `produto` WRITE;
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` VALUES (107,32,'Duzia de Taça','teste',12.00,NULL,NULL,1),(108,33,'Taça de cerveja (Dúzia)','Nossas taças de cerveja uma opçao para deixar sua festa com um toque de elegância.',11.50,'1708993877990-taça.jpeg',1,0),(109,33,'Taça (meia Duzia)','Nossas taças para aluguel são elegantes e de alta qualidade, disponíveis em conjuntos de duzia ou meia duzia. Perfeitas para qualquer evento, desde casamentos até jantares formais, elas adicionam um toque de sofisticação à sua festa.',5.00,'1708993895804-1708993877990-taça.jpeg',NULL,1),(110,34,'Prato de Jantar (Dúzia)','Adicione um toque de sofisticação à sua mesa com nossos pratos de louça.',9.00,'1708994215678-prato.jpg',NULL,0),(111,35,'Garfo de Jantar (Dúzia)','Eleve a experiência gastronômica do seu evento com nossos garfos de jantar.',9.00,'1708994589074-garfo.jpeg',NULL,1),(112,35,'Garfo de sobremesa (Dúzia)','Complete sua mesa com sofisticação com nossos garfos de sobremesa.',9.00,'1708994774746-garfoSobremesa.png',NULL,1),(113,34,'Prato de Sobremesa (Dúzia)','Encante seus convidados com nossos pratos de sobremesa.',9.00,'1708995019025-pratoSobremesa.png',NULL,0),(114,36,'Colher (Dúzia)','Complete sua mesa com sofisticação com nossas colheres.',9.00,'1708995229600-colher.png',NULL,0),(115,36,'Colher de Sobremesa (Dúzia)','Termine sua refeição com um toque de elegância usando nossas colheres de sobremesa.',9.00,'1708995989641-colherSobremesa.png',NULL,0),(116,34,'Cubuca Mexicana (Dúzia)','Versatilidade em cada refeição! desde sopas e ensopados até saladas e sobremesas.',10.00,'1708995647187-cumbucaMexicana.jpeg',NULL,0),(117,33,'Xicará (Dúzia)','Desfrute de momentos de puro prazer com nossa xícara elegante.',9.00,'1708995836493-xicara.png',2,0),(118,37,'Jogo de Mesa','Aprimore seu evento com nossas mesas brancas de plástico disponíveis para aluguel.  São ideais para adicionar um toque de sofisticação temporária a sua festa, tornando sua experiência mais conveniente e memorável.',7.00,'1715044445650-Screenshot 2024-05-06 at 22.png',1,0),(119,37,'Mesa para bolo (Grande)','',20.00,NULL,5,0),(120,37,'Mesa branca (Unidade)','Adicione um toque de sofisticação instantânea ao seu evento com nossa mesa branca de plástico disponível para aluguel, proporcionando praticidade e estilo em uma única peça.',5.00,'1715044841387-Screenshot 2024-05-06 at 22.png',2,0),(121,37,'Cadeira (Unidade)','Adicione um toque de sofisticação instantânea ao seu evento com nossa cadeira branca de plástico disponível para aluguel, proporcionando praticidade e estilo em uma única peça.',2.00,'1715044909571-Screenshot 2024-05-06 at 22.png',3,0),(122,37,'Mesa para Bolo (Média)','',15.00,NULL,4,0),(123,38,'Malha branca 3,00m x 4,00m  (com suporte)','',20.00,'1715045360405-Screenshot 2024-05-06 at 22.png',1,0),(124,38,'Forro de mesa (AZUL)','',7.00,'1715045732769-Screenshot 2024-05-06 at 22.png',3,0),(125,38,'Forro de mesa (BRANCO)','',7.00,'1715045446467-Screenshot 2024-05-06 at 22.png',4,0),(126,38,'Forro de mesa (AMERELO)','',7.00,'1715045521233-Screenshot 2024-05-06 at 22.png',5,0),(127,38,'Forro de mesa (ROSA)','',7.00,'1715045664372-Screenshot 2024-05-06 at 22.png',6,0),(128,38,'Forro de mesa (VERMELHO)','',7.00,'1715045823503-Screenshot 2024-05-06 at 22.png',7,0),(129,38,'Forro de mesa (VERDE ESCURO)','',7.00,'1715045991959-Screenshot 2024-05-06 at 22.png',8,0),(130,36,'Garfo de Jantar (Dúzia)','Complete sua mesa com sofisticação com nossos garfos,',9.00,'1715046405017-1708994589074-garfo.jpeg',NULL,0),(131,36,'Garfo de sobremesa (Dúzia)','Termine sua refeição com um toque de elegância usando nossos garfos de sobremesa.',9.00,'1715046421321-1708994774746-garfoSobremesa.png',NULL,0),(132,36,'Faca de Jantar','Complete sua mesa com sofisticação com nossas facas.',9.00,NULL,NULL,0),(133,36,'Faca de sobremesa','Termine sua refeição com um toque de elegância usando nossas facas de sobremesa.',9.00,NULL,NULL,0),(134,38,'Malha branca 3,00m x 4,00m  (com suporte) - Cópia','',20.00,'1715077795940-1715045360405-Screenshot 2024-05-06 at 22.png',2,1),(135,33,'Jarra (Unidade)','Nossas jarras de suco/agua uma opção para deixar sua festa com um toque de elegância.',9.00,'1715485379138-Screenshot 2024-05-12 at 00.png',NULL,0),(136,40,'Bandeja para garçom','',9.00,'1715485510461-Screenshot 2024-05-12 at 00.png',NULL,0),(137,41,'Freezer 430L (2 tampas)','O Freezer Buffet é a solução ideal para manter seus alimentos resfriados e prontos para servir em qualquer evento, seja uma festa em casa,',70.00,'1715485727081-Screenshot 2024-05-12 at 00.png',1,0),(138,41,'Geladeira vertical','O Freezer Vertical oferece uma solução compacta e prática para manter alimentos congelados e acessíveis em qualquer ambiente. Com seu design vertical, este freezer maximiza o espaço de armazenamento.',70.00,'1715485797148-Screenshot 2024-05-12 at 00.png',3,0),(139,41,'Freezer vertical','O Freezer Vertical oferece uma solução compacta e prática para manter alimentos congelados e acessíveis em qualquer ambiente. Com seu design vertical, este freezer maximiza o espaço de armazenamento.',70.00,'1715486004920-Screenshot 2024-05-12 at 00.png',4,0),(140,41,'Freezer 230L (1 tampa)','O Freezer Buffet é a solução ideal para manter seus alimentos resfriados e prontos para servir em qualquer evento, seja uma festa em casa,',50.00,'1715485934177-Screenshot 2024-05-12 at 00.png',2,0),(141,42,'Caixa para festa','',70.00,NULL,1,0),(142,42,'Chapa para lanches','',120.00,NULL,3,0),(143,42,'Estufa de salgados','',40.00,NULL,4,0),(144,42,'Tamborete grade para caixa','',10.00,NULL,2,0),(145,40,'Rechoud','',70.00,NULL,NULL,0),(146,43,'Pula pula','',100.00,NULL,NULL,1);
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtoopcional`
--

DROP TABLE IF EXISTS `produtoopcional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtoopcional` (
  `idprodutoopcional` int NOT NULL AUTO_INCREMENT,
  `idproduto` int NOT NULL,
  `idopcional` int NOT NULL,
  PRIMARY KEY (`idprodutoopcional`),
  KEY `FK_PRODUTO_OPCIONAL_idx` (`idproduto`),
  KEY `FK_OPCIONAL_PRODUTO_idx` (`idopcional`),
  CONSTRAINT `FK_OPCIONAL_PRODUTO` FOREIGN KEY (`idopcional`) REFERENCES `opcional` (`idopcional`),
  CONSTRAINT `FK_PRODUTO_OPCIONAL` FOREIGN KEY (`idproduto`) REFERENCES `produto` (`idproduto`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtoopcional`
--

LOCK TABLES `produtoopcional` WRITE;
/*!40000 ALTER TABLE `produtoopcional` DISABLE KEYS */;
/*!40000 ALTER TABLE `produtoopcional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxaentrega`
--

DROP TABLE IF EXISTS `taxaentrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taxaentrega` (
  `idtaxaentrega` int NOT NULL AUTO_INCREMENT,
  `idtaxaentregatipo` int NOT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `distancia` decimal(10,2) DEFAULT NULL,
  `tempominimo` int DEFAULT NULL,
  `tempomaximo` int DEFAULT NULL,
  `ativo` int NOT NULL DEFAULT '1',
  `apagado` int DEFAULT '0',
  PRIMARY KEY (`idtaxaentrega`),
  KEY `FK_TAXA_ENTREGA_TIPO_idx` (`idtaxaentregatipo`),
  CONSTRAINT `FK_TAXA_ENTREGA_TIPO` FOREIGN KEY (`idtaxaentregatipo`) REFERENCES `taxaentregatipo` (`idtaxaentregatipo`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxaentrega`
--

LOCK TABLES `taxaentrega` WRITE;
/*!40000 ALTER TABLE `taxaentrega` DISABLE KEYS */;
/*!40000 ALTER TABLE `taxaentrega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `taxaentregatipo`
--

DROP TABLE IF EXISTS `taxaentregatipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `taxaentregatipo` (
  `idtaxaentregatipo` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `ativo` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`idtaxaentregatipo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `taxaentregatipo`
--

LOCK TABLES `taxaentregatipo` WRITE;
/*!40000 ALTER TABLE `taxaentregatipo` DISABLE KEYS */;
INSERT INTO `taxaentregatipo` VALUES (1,'Taxa única',0),(2,'Taxa por distância',1),(3,'Sem taxa',0);
/*!40000 ALTER TABLE `taxaentregatipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoentrega`
--

DROP TABLE IF EXISTS `tipoentrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipoentrega` (
  `idtipoentrega` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `tempominimo` int DEFAULT NULL,
  `tempomaximo` int DEFAULT NULL,
  `ativo` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`idtipoentrega`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoentrega`
--

LOCK TABLES `tipoentrega` WRITE;
/*!40000 ALTER TABLE `tipoentrega` DISABLE KEYS */;
INSERT INTO `tipoentrega` VALUES (1,'Delivery',0,0,1),(2,'Retirada',0,0,0);
/*!40000 ALTER TABLE `tipoentrega` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-03 16:58:33
