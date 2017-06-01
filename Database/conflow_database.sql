-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.2.6-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for conflow
CREATE DATABASE IF NOT EXISTS `conflow` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `conflow`;

-- Dumping structure for table conflow.apartamento
CREATE TABLE IF NOT EXISTS `apartamento` (
  `COD_APARTAMENTO` int(11) NOT NULL AUTO_INCREMENT,
  `NUM_APARTAMENTO` varchar(4) DEFAULT NULL,
  `VAL_FRACAOIDEAL_APARTAMENTO` float DEFAULT 0,
  `COD_PREDIO` int(11) NOT NULL,
  PRIMARY KEY (`COD_APARTAMENTO`),
  UNIQUE KEY `COD_APARTAMENTO` (`COD_APARTAMENTO`),
  KEY `COD_PREDIO` (`COD_PREDIO`),
  CONSTRAINT `apartamento_ibfk_1` FOREIGN KEY (`COD_PREDIO`) REFERENCES `predio` (`COD_PREDIO`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table conflow.bloco
CREATE TABLE IF NOT EXISTS `bloco` (
  `COD_BLOCO` int(11) NOT NULL AUTO_INCREMENT,
  `ID_BLOCO` varchar(80) DEFAULT NULL,
  `COD_CONDOMINIO` int(11) NOT NULL,
  PRIMARY KEY (`COD_BLOCO`),
  UNIQUE KEY `COD_BLOCO` (`COD_BLOCO`),
  KEY `COD_CONDOMINIO` (`COD_CONDOMINIO`),
  CONSTRAINT `bloco_ibfk_1` FOREIGN KEY (`COD_CONDOMINIO`) REFERENCES `condominio` (`COD_CONDOMINIO`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table conflow.condominio
CREATE TABLE IF NOT EXISTS `condominio` (
  `COD_CONDOMINIO` int(11) NOT NULL AUTO_INCREMENT,
  `ID_CONDOMINIO` varchar(80) DEFAULT NULL,
  `TEL_CONTATO_CONDOMINIO` varchar(10) DEFAULT NULL,
  `END_UF_CONDOMINIO` varchar(80) DEFAULT NULL,
  `END_CIDADE_CONDOMINIO` varchar(80) DEFAULT NULL,
  `END_BAIRRO_CONDOMINIO` varchar(80) DEFAULT NULL,
  `END_RUA_CONDOMINIO` varchar(80) DEFAULT NULL,
  `END_NUM_CONDOMINIO` int(11) DEFAULT NULL,
  `IDF_ATIVO` varchar(1) DEFAULT 'S',
  PRIMARY KEY (`COD_CONDOMINIO`),
  UNIQUE KEY `COD_CONDOMINIO` (`COD_CONDOMINIO`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table conflow.condominio_despesa
CREATE TABLE IF NOT EXISTS `condominio_despesa` (
  `COD_DESPESA` int(11) NOT NULL AUTO_INCREMENT,
  `DSC_DESPESA` varchar(255) DEFAULT '',
  `VAL_DESPESA` float DEFAULT 0,
  `DAT_PAGAMENTO` datetime DEFAULT NULL,
  `COD_CONDOMINIO` int(11) NOT NULL,
  PRIMARY KEY (`COD_DESPESA`),
  UNIQUE KEY `COD_DESPESA` (`COD_DESPESA`),
  KEY `COD_CONDOMINIO` (`COD_CONDOMINIO`),
  CONSTRAINT `condominio_despesa_ibfk_1` FOREIGN KEY (`COD_CONDOMINIO`) REFERENCES `condominio` (`COD_CONDOMINIO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table conflow.estacionamento
CREATE TABLE IF NOT EXISTS `estacionamento` (
  `COD_ESTACIONAMENTO` int(11) NOT NULL AUTO_INCREMENT,
  `ID_ESTACIONAMENTO` varchar(8) DEFAULT NULL,
  `COD_PROPRIETARIO` int(11) DEFAULT NULL,
  PRIMARY KEY (`COD_ESTACIONAMENTO`),
  UNIQUE KEY `COD_ESTACIONAMENTO` (`COD_ESTACIONAMENTO`),
  KEY `COD_PROPRIETARIO` (`COD_PROPRIETARIO`),
  CONSTRAINT `estacionamento_ibfk_1` FOREIGN KEY (`COD_PROPRIETARIO`) REFERENCES `proprietario` (`COD_PROPRIETARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table conflow.morador
CREATE TABLE IF NOT EXISTS `morador` (
  `COD_MORADOR` int(11) NOT NULL AUTO_INCREMENT,
  `NOME_MORADOR` varchar(80) DEFAULT NULL,
  `RG_MORADOR` varchar(10) DEFAULT NULL,
  `SEXO_MORADOR` varchar(1) DEFAULT NULL,
  `DAT_NASCIMENTO_MORADOR` datetime DEFAULT NULL,
  `COD_APARTAMENTO_MORADOR` int(11) DEFAULT NULL,
  PRIMARY KEY (`COD_MORADOR`),
  UNIQUE KEY `COD_MORADOR` (`COD_MORADOR`),
  KEY `COD_APARTAMENTO_MORADOR` (`COD_APARTAMENTO_MORADOR`),
  CONSTRAINT `morador_ibfk_1` FOREIGN KEY (`COD_APARTAMENTO_MORADOR`) REFERENCES `apartamento` (`COD_APARTAMENTO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table conflow.predio
CREATE TABLE IF NOT EXISTS `predio` (
  `COD_PREDIO` int(11) NOT NULL AUTO_INCREMENT,
  `ID_PREDIO` varchar(80) DEFAULT NULL,
  `COD_BLOCO` int(11) NOT NULL,
  `ULTIMA_MODIFICACAO` datetime DEFAULT NULL,
  PRIMARY KEY (`COD_PREDIO`),
  UNIQUE KEY `COD_PREDIO` (`COD_PREDIO`),
  KEY `COD_BLOCO` (`COD_BLOCO`),
  CONSTRAINT `predio_ibfk_1` FOREIGN KEY (`COD_BLOCO`) REFERENCES `bloco` (`COD_BLOCO`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table conflow.proprietario
CREATE TABLE IF NOT EXISTS `proprietario` (
  `COD_PROPRIETARIO` int(11) NOT NULL AUTO_INCREMENT,
  `NOME_PROPRIETARIO` varchar(80) NOT NULL,
  `RG_PROPRIETARIO` varchar(10) DEFAULT NULL,
  `SEXO_PROPRIETARIO` varchar(1) DEFAULT NULL,
  `DAT_NASCIMENTO_PROPRIETARIO` date DEFAULT NULL,
  `END_UF_PROPRIETARIO` varchar(80) DEFAULT NULL,
  `END_CIDADE_PROPRIETARIO` varchar(80) DEFAULT NULL,
  `END_BAIRRO_PROPRIETARIO` varchar(80) DEFAULT NULL,
  `END_RUA_PROPRIETARIO` varchar(80) DEFAULT NULL,
  `END_NUM_PROPRIETARIO` int(11) DEFAULT NULL,
  `COD_APARTAMENTO_PROPRIETARIO` int(11) DEFAULT NULL,
  `ULTIMA_MODIFICACAO` datetime DEFAULT NULL,
  `IDF_ATIVO` varchar(1) DEFAULT 'S',
  PRIMARY KEY (`COD_PROPRIETARIO`),
  UNIQUE KEY `COD_PROPRIETARIO` (`COD_PROPRIETARIO`),
  KEY `COD_APARTAMENTO_PROPRIETARIO` (`COD_APARTAMENTO_PROPRIETARIO`),
  CONSTRAINT `proprietario_ibfk_1` FOREIGN KEY (`COD_APARTAMENTO_PROPRIETARIO`) REFERENCES `apartamento` (`COD_APARTAMENTO`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table conflow.proprietario_boleto
CREATE TABLE IF NOT EXISTS `proprietario_boleto` (
  `COD_BOLETO` int(11) NOT NULL AUTO_INCREMENT,
  `COD_APARTAMENTO` int(11) NOT NULL,
  `COD_PROPRIETARIO` int(11) NOT NULL,
  PRIMARY KEY (`COD_BOLETO`),
  UNIQUE KEY `COD_BOLETO` (`COD_BOLETO`),
  KEY `COD_APARTAMENTO` (`COD_APARTAMENTO`),
  KEY `COD_PROPRIETARIO` (`COD_PROPRIETARIO`),
  CONSTRAINT `proprietario_boleto_ibfk_1` FOREIGN KEY (`COD_APARTAMENTO`) REFERENCES `apartamento` (`COD_APARTAMENTO`),
  CONSTRAINT `proprietario_boleto_ibfk_2` FOREIGN KEY (`COD_PROPRIETARIO`) REFERENCES `proprietario` (`COD_PROPRIETARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table conflow.proprietario_cnpj
CREATE TABLE IF NOT EXISTS `proprietario_cnpj` (
  `COD_PROPRIETARIO` int(11) NOT NULL,
  `CNPJ_PROPRIETARIO` varchar(14) DEFAULT NULL,
  KEY `COD_PROPRIETARIO` (`COD_PROPRIETARIO`),
  CONSTRAINT `proprietario_cnpj_ibfk_1` FOREIGN KEY (`COD_PROPRIETARIO`) REFERENCES `proprietario` (`COD_PROPRIETARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table conflow.proprietario_contato
CREATE TABLE IF NOT EXISTS `proprietario_contato` (
  `COD_PROPRIETARIO` int(11) NOT NULL,
  `DSC_CONTATO` varchar(100) NOT NULL,
  KEY `COD_PROPRIETARIO` (`COD_PROPRIETARIO`),
  CONSTRAINT `proprietario_contato_ibfk_1` FOREIGN KEY (`COD_PROPRIETARIO`) REFERENCES `proprietario` (`COD_PROPRIETARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table conflow.proprietario_cpf
CREATE TABLE IF NOT EXISTS `proprietario_cpf` (
  `COD_PROPRIETARIO` int(11) NOT NULL,
  `CPF_PROPRIETARIO` varchar(11) DEFAULT NULL,
  KEY `COD_PROPRIETARIO` (`COD_PROPRIETARIO`),
  CONSTRAINT `proprietario_cpf_ibfk_1` FOREIGN KEY (`COD_PROPRIETARIO`) REFERENCES `proprietario` (`COD_PROPRIETARIO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
