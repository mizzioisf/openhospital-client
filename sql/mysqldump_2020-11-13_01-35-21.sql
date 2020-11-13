-- MySQL dump 10.13  Distrib 5.7.30, for linux-glibc2.12 (x86_64)
--
-- Host: 127.0.0.1    Database: oh
-- ------------------------------------------------------
-- Server version	5.7.30

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
-- Table structure for table `admission`
--

DROP TABLE IF EXISTS `admission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admission` (
  `ADM_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ADM_IN` int(11) NOT NULL DEFAULT '0',
  `ADM_TYPE` char(1) NOT NULL DEFAULT 'N',
  `ADM_WRD_ID_A` char(1) NOT NULL DEFAULT '',
  `ADM_YPROG` int(11) NOT NULL DEFAULT '0',
  `ADM_PAT_ID` int(11) NOT NULL DEFAULT '0',
  `ADM_DATE_ADM` datetime NOT NULL,
  `ADM_ADMT_ID_A_ADM` varchar(10) NOT NULL DEFAULT '',
  `ADM_FHU` varchar(50) DEFAULT NULL,
  `ADM_IN_DIS_ID_A` varchar(10) DEFAULT NULL,
  `ADM_OUT_DIS_ID_A` varchar(10) DEFAULT NULL,
  `ADM_OUT_DIS_ID_A_2` varchar(10) DEFAULT NULL,
  `ADM_OUT_DIS_ID_A_3` varchar(10) DEFAULT NULL,
  `ADM_OPE_ID_A` varchar(10) DEFAULT NULL,
  `ADM_DATE_OP` datetime DEFAULT NULL,
  `ADM_RESOP` varchar(10) DEFAULT NULL,
  `ADM_DATE_DIS` datetime DEFAULT NULL,
  `ADM_DIST_ID_A` varchar(10) DEFAULT NULL,
  `ADM_NOTE` text,
  `ADM_TRANS` float DEFAULT '0',
  `ADM_PRG_DATE_VIS` datetime DEFAULT NULL,
  `ADM_PRG_PTT_ID_A` varchar(10) DEFAULT NULL,
  `ADM_PRG_DATE_DEL` datetime DEFAULT NULL,
  `ADM_PRG_DLT_ID_A` char(1) DEFAULT NULL,
  `ADM_PRG_DRT_ID_A` char(1) DEFAULT NULL,
  `ADM_PRG_WEIGHT` float DEFAULT NULL,
  `ADM_PRG_DATE_CTRL1` datetime DEFAULT NULL,
  `ADM_PRG_DATE_CTRL2` datetime DEFAULT NULL,
  `ADM_PRG_DATE_ABORT` datetime DEFAULT NULL,
  `ADM_USR_ID_A` varchar(50) NOT NULL DEFAULT 'admin',
  `ADM_LOCK` int(11) NOT NULL DEFAULT '0',
  `ADM_DELETED` char(1) NOT NULL DEFAULT 'N',
  `ADM_CREATED_BY` varchar(50) DEFAULT NULL,
  `ADM_CREATED_DATE` datetime DEFAULT NULL,
  `ADM_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `ADM_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `ADM_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ADM_ID`),
  KEY `FK_ADMISSION_DISCHARGETYPE` (`ADM_DIST_ID_A`),
  KEY `FK_ADMISSION_DELIVERYTYPE` (`ADM_PRG_DLT_ID_A`),
  KEY `FK_ADMISSION_DELIVERYRESULTTYPE` (`ADM_PRG_DRT_ID_A`),
  KEY `FK_ADMISSION_ADMISSIONTYPE` (`ADM_ADMT_ID_A_ADM`),
  KEY `FK_ADMISSION_OPERATION` (`ADM_OPE_ID_A`),
  KEY `FK_ADMISSION_WARD` (`ADM_WRD_ID_A`),
  KEY `FK_ADMISSION_PREGNANTTREATMENTTYPE` (`ADM_PRG_PTT_ID_A`),
  KEY `FK_ADMISSION_IN_DISEASE` (`ADM_IN_DIS_ID_A`),
  KEY `FK_ADMISSION_OUT_DISEASE1` (`ADM_OUT_DIS_ID_A`),
  KEY `FK_ADMISSION_OUT_DISEASE2` (`ADM_OUT_DIS_ID_A_2`),
  KEY `FK_ADMISSION_OUT_DISEASE3` (`ADM_OUT_DIS_ID_A_3`),
  KEY `FK_ADMISSION_PATIENT` (`ADM_PAT_ID`),
  CONSTRAINT `FK_ADMISSION_ADMISSIONTYPE` FOREIGN KEY (`ADM_ADMT_ID_A_ADM`) REFERENCES `admissiontype` (`ADMT_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ADMISSION_DELIVERYRESULTTYPE` FOREIGN KEY (`ADM_PRG_DRT_ID_A`) REFERENCES `deliveryresulttype` (`DRT_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ADMISSION_DELIVERYTYPE` FOREIGN KEY (`ADM_PRG_DLT_ID_A`) REFERENCES `deliverytype` (`DLT_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ADMISSION_DISCHARGETYPE` FOREIGN KEY (`ADM_DIST_ID_A`) REFERENCES `dischargetype` (`DIST_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ADMISSION_IN_DISEASE` FOREIGN KEY (`ADM_IN_DIS_ID_A`) REFERENCES `disease` (`DIS_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ADMISSION_OPERATION` FOREIGN KEY (`ADM_OPE_ID_A`) REFERENCES `operation` (`OPE_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ADMISSION_OUT_DISEASE1` FOREIGN KEY (`ADM_OUT_DIS_ID_A`) REFERENCES `disease` (`DIS_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ADMISSION_OUT_DISEASE2` FOREIGN KEY (`ADM_OUT_DIS_ID_A_2`) REFERENCES `disease` (`DIS_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ADMISSION_OUT_DISEASE3` FOREIGN KEY (`ADM_OUT_DIS_ID_A_3`) REFERENCES `disease` (`DIS_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ADMISSION_PATIENT` FOREIGN KEY (`ADM_PAT_ID`) REFERENCES `patient` (`PAT_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_ADMISSION_PREGNANTTREATMENTTYPE` FOREIGN KEY (`ADM_PRG_PTT_ID_A`) REFERENCES `pregnanttreatmenttype` (`PTT_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_ADMISSION_WARD` FOREIGN KEY (`ADM_WRD_ID_A`) REFERENCES `ward` (`WRD_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admission`
--

LOCK TABLES `admission` WRITE;
/*!40000 ALTER TABLE `admission` DISABLE KEYS */;
/*!40000 ALTER TABLE `admission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admissiontype`
--

DROP TABLE IF EXISTS `admissiontype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admissiontype` (
  `ADMT_ID_A` varchar(10) NOT NULL,
  `ADMT_DESC` varchar(50) NOT NULL,
  `ADMT_CREATED_BY` varchar(50) DEFAULT NULL,
  `ADMT_CREATED_DATE` datetime DEFAULT NULL,
  `ADMT_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `ADMT_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `ADMT_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ADMT_ID_A`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admissiontype`
--

LOCK TABLES `admissiontype` WRITE;
/*!40000 ALTER TABLE `admissiontype` DISABLE KEYS */;
INSERT INTO `admissiontype` VALUES ('A','AMBULANCE',NULL,NULL,NULL,NULL,1),('I','SELF',NULL,NULL,NULL,NULL,1),('R','REFERRAL',NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `admissiontype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agetype`
--

DROP TABLE IF EXISTS `agetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agetype` (
  `AT_CODE` varchar(4) NOT NULL DEFAULT '',
  `AT_FROM` int(11) NOT NULL DEFAULT '0',
  `AT_TO` int(11) NOT NULL DEFAULT '0',
  `AT_DESC` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `AT_CREATED_BY` varchar(50) DEFAULT NULL,
  `AT_CREATED_DATE` datetime DEFAULT NULL,
  `AT_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `AT_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `AT_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`AT_CODE`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agetype`
--

LOCK TABLES `agetype` WRITE;
/*!40000 ALTER TABLE `agetype` DISABLE KEYS */;
INSERT INTO `agetype` VALUES ('d0',0,0,'angal.agetype.newborn',NULL,NULL,NULL,NULL,1),('d1',1,5,'angal.agetype.earlychildhood',NULL,NULL,NULL,NULL,1),('d2',6,12,'angal.agetype.latechildhood',NULL,NULL,NULL,NULL,1),('d3',13,24,'angal.agetype.adolescents',NULL,NULL,NULL,NULL,1),('d4',25,59,'angal.agetype.adult',NULL,NULL,NULL,NULL,1),('d5',60,99,'angal.agetype.elderly',NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `agetype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billitems`
--

DROP TABLE IF EXISTS `billitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billitems` (
  `BLI_ID` int(11) NOT NULL AUTO_INCREMENT,
  `BLI_ID_BILL` int(11) DEFAULT NULL,
  `BLI_IS_PRICE` tinyint(1) NOT NULL,
  `BLI_ID_PRICE` varchar(10) DEFAULT NULL,
  `BLI_ITEM_DESC` varchar(100) DEFAULT NULL,
  `BLI_ITEM_AMOUNT` double NOT NULL,
  `BLI_QTY` int(11) NOT NULL,
  `BLI_CREATED_BY` varchar(50) DEFAULT NULL,
  `BLI_CREATED_DATE` datetime DEFAULT NULL,
  `BLI_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `BLI_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `BLI_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`BLI_ID`),
  KEY `FK_BILLITEMS_BILLS` (`BLI_ID_BILL`),
  CONSTRAINT `FK_BILLITEMS_BILLS` FOREIGN KEY (`BLI_ID_BILL`) REFERENCES `bills` (`BLL_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billitems`
--

LOCK TABLES `billitems` WRITE;
/*!40000 ALTER TABLE `billitems` DISABLE KEYS */;
/*!40000 ALTER TABLE `billitems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `billpayments`
--

DROP TABLE IF EXISTS `billpayments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billpayments` (
  `BLP_ID` int(11) NOT NULL AUTO_INCREMENT,
  `BLP_ID_BILL` int(11) DEFAULT NULL,
  `BLP_DATE` datetime NOT NULL,
  `BLP_AMOUNT` double NOT NULL,
  `BLP_USR_ID_A` varchar(50) NOT NULL DEFAULT 'admin',
  `BLP_CREATED_BY` varchar(50) DEFAULT NULL,
  `BLP_CREATED_DATE` datetime DEFAULT NULL,
  `BLP_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `BLP_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `BLP_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`BLP_ID`),
  KEY `FK_BILLPAYMENTS_BILLS` (`BLP_ID_BILL`),
  CONSTRAINT `FK_BILLPAYMENTS_BILLS` FOREIGN KEY (`BLP_ID_BILL`) REFERENCES `bills` (`BLL_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `billpayments`
--

LOCK TABLES `billpayments` WRITE;
/*!40000 ALTER TABLE `billpayments` DISABLE KEYS */;
/*!40000 ALTER TABLE `billpayments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bills` (
  `BLL_ID` int(11) NOT NULL AUTO_INCREMENT,
  `BLL_DATE` datetime NOT NULL,
  `BLL_UPDATE` datetime NOT NULL,
  `BLL_IS_LST` tinyint(1) NOT NULL,
  `BLL_ID_LST` int(11) DEFAULT NULL,
  `BLL_LST_NAME` varchar(50) DEFAULT NULL,
  `BLL_IS_PAT` tinyint(1) NOT NULL,
  `BLL_ID_PAT` int(11) DEFAULT NULL,
  `BLL_PAT_NAME` varchar(100) DEFAULT NULL,
  `BLL_STATUS` varchar(1) DEFAULT NULL,
  `BLL_AMOUNT` double DEFAULT NULL,
  `BLL_BALANCE` double DEFAULT NULL,
  `BLL_USR_ID_A` varchar(50) NOT NULL DEFAULT 'admin',
  `BLL_CREATED_BY` varchar(50) DEFAULT NULL,
  `BLL_CREATED_DATE` datetime DEFAULT NULL,
  `BLL_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `BLL_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `BLL_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`BLL_ID`),
  KEY `FK_BILLS_PATIENT` (`BLL_ID_PAT`),
  KEY `FK_BILLS_PRICELISTS` (`BLL_ID_LST`),
  CONSTRAINT `FK_BILLS_PATIENT` FOREIGN KEY (`BLL_ID_PAT`) REFERENCES `patient` (`PAT_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_BILLS_PRICELISTS` FOREIGN KEY (`BLL_ID_LST`) REFERENCES `pricelists` (`LST_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deliveryresulttype`
--

DROP TABLE IF EXISTS `deliveryresulttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deliveryresulttype` (
  `DRT_ID_A` char(1) NOT NULL,
  `DRT_DESC` varchar(50) NOT NULL,
  `DRT_CREATED_BY` varchar(50) DEFAULT NULL,
  `DRT_CREATED_DATE` datetime DEFAULT NULL,
  `DRT_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `DRT_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `DRT_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`DRT_ID_A`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliveryresulttype`
--

LOCK TABLES `deliveryresulttype` WRITE;
/*!40000 ALTER TABLE `deliveryresulttype` DISABLE KEYS */;
INSERT INTO `deliveryresulttype` VALUES ('A','LIVE BIRTH',NULL,NULL,NULL,NULL,1),('B','MACERATED STILLBIRTH',NULL,NULL,NULL,NULL,1),('M','MATERNAL DEATH',NULL,NULL,NULL,NULL,1),('N','NEWBORN DEATH',NULL,NULL,NULL,NULL,1),('S','FRESH STILL BIRTH',NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `deliveryresulttype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deliverytype`
--

DROP TABLE IF EXISTS `deliverytype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deliverytype` (
  `DLT_ID_A` char(1) NOT NULL,
  `DLT_DESC` varchar(50) NOT NULL,
  `DLT_CREATED_BY` varchar(50) DEFAULT NULL,
  `DLT_CREATED_DATE` datetime DEFAULT NULL,
  `DLT_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `DLT_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `DLT_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`DLT_ID_A`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deliverytype`
--

LOCK TABLES `deliverytype` WRITE;
/*!40000 ALTER TABLE `deliverytype` DISABLE KEYS */;
INSERT INTO `deliverytype` VALUES ('C','DELIVERY ASSISTED BY CESARIAN SECTION',NULL,NULL,NULL,NULL,1),('N','NORMAL DELIVERY',NULL,NULL,NULL,NULL,1),('V','DELIVERY ASSISTED BY VACUUM EXTRACTION',NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `deliverytype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dicom`
--

DROP TABLE IF EXISTS `dicom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dicom` (
  `DM_PAT_ID` int(11) NOT NULL,
  `DM_DATA` longblob,
  `DM_FILE_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `DM_FILE_NOME` varchar(255) NOT NULL,
  `DM_FILE_ACCESSION_NUMBER` varchar(255) DEFAULT NULL,
  `DM_FILE_INSTITUTION_NAME` varchar(255) DEFAULT NULL,
  `DM_FILE_PAT_UID` varchar(255) DEFAULT NULL,
  `DM_FILE_PAT_NAME` varchar(255) DEFAULT NULL,
  `DM_FILE_PAT_ADDR` varchar(255) DEFAULT NULL,
  `DM_FILE_PAT_AGE` varchar(255) DEFAULT NULL,
  `DM_FILE_PAT_SEX` varchar(255) DEFAULT NULL,
  `DM_FILE_PAT_BIRTHDATE` varchar(255) DEFAULT NULL,
  `DM_FILE_ST_UID` varchar(255) NOT NULL,
  `DM_FILE_ST_DATE` datetime DEFAULT NULL,
  `DM_FILE_ST_DESCR` varchar(255) DEFAULT NULL,
  `DM_FILE_SER_UID` varchar(255) NOT NULL,
  `DM_FILE_SER_INST_UID` varchar(255) NOT NULL,
  `DM_FILE_SER_NUMBER` varchar(255) DEFAULT NULL,
  `DM_FILE_SER_DESC_COD_SEQ` varchar(255) DEFAULT NULL,
  `DM_FILE_SER_DATE` datetime DEFAULT NULL,
  `DM_FILE_SER_DESC` varchar(255) DEFAULT NULL,
  `DM_FILE_INST_UID` varchar(255) NOT NULL,
  `DM_FILE_MODALIITY` varchar(255) DEFAULT NULL,
  `DM_THUMBNAIL` blob,
  `DM_DCMT_ID` varchar(3) DEFAULT NULL,
  `DM_CREATED_BY` varchar(50) DEFAULT NULL,
  `DM_CREATED_DATE` datetime DEFAULT NULL,
  `DM_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `DM_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `DM_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`DM_FILE_ID`),
  KEY `FK_DICOM_DICOMTYPE_idx` (`DM_DCMT_ID`),
  CONSTRAINT `FK_DICOM_DICOMTYPE` FOREIGN KEY (`DM_DCMT_ID`) REFERENCES `dicomtype` (`DCMT_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dicom`
--

LOCK TABLES `dicom` WRITE;
/*!40000 ALTER TABLE `dicom` DISABLE KEYS */;
/*!40000 ALTER TABLE `dicom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dicomtype`
--

DROP TABLE IF EXISTS `dicomtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dicomtype` (
  `DCMT_ID` varchar(3) NOT NULL,
  `DCMT_DESC` varchar(50) NOT NULL,
  PRIMARY KEY (`DCMT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dicomtype`
--

LOCK TABLES `dicomtype` WRITE;
/*!40000 ALTER TABLE `dicomtype` DISABLE KEYS */;
/*!40000 ALTER TABLE `dicomtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dischargetype`
--

DROP TABLE IF EXISTS `dischargetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dischargetype` (
  `DIST_ID_A` varchar(10) NOT NULL,
  `DIST_DESC` varchar(50) NOT NULL,
  `DIST_CREATED_BY` varchar(50) DEFAULT NULL,
  `DIST_CREATED_DATE` datetime DEFAULT NULL,
  `DIST_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `DIST_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `DIST_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`DIST_ID_A`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dischargetype`
--

LOCK TABLES `dischargetype` WRITE;
/*!40000 ALTER TABLE `dischargetype` DISABLE KEYS */;
INSERT INTO `dischargetype` VALUES ('B','REFERRED',NULL,NULL,NULL,NULL,1),('D','DEAD',NULL,NULL,NULL,NULL,1),('EQ','NORMAL DISCHARGE',NULL,NULL,NULL,NULL,1),('ES','ESCAPE',NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `dischargetype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `disease`
--

DROP TABLE IF EXISTS `disease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disease` (
  `DIS_ID_A` varchar(10) NOT NULL,
  `DIS_DESC` varchar(160) NOT NULL,
  `DIS_DCL_ID_A` char(2) NOT NULL,
  `DIS_LOCK` int(11) NOT NULL DEFAULT '0',
  `DIS_OPD_INCLUDE` int(11) NOT NULL DEFAULT '0',
  `DIS_IPD_IN_INCLUDE` int(11) NOT NULL DEFAULT '0',
  `DIS_IPD_OUT_INCLUDE` int(11) NOT NULL DEFAULT '0',
  `DIS_CREATED_BY` varchar(50) DEFAULT NULL,
  `DIS_CREATED_DATE` datetime DEFAULT NULL,
  `DIS_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `DIS_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `DIS_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`DIS_ID_A`),
  KEY `FK_DISEASE_DISEASETYPE` (`DIS_DCL_ID_A`),
  CONSTRAINT `FK_DISEASE_DISEASETYPE` FOREIGN KEY (`DIS_DCL_ID_A`) REFERENCES `diseasetype` (`DCL_ID_A`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disease`
--

LOCK TABLES `disease` WRITE;
/*!40000 ALTER TABLE `disease` DISABLE KEYS */;
INSERT INTO `disease` VALUES ('1','Typhoid and paratyphoid fevers','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('10','Miliary tuberculosis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('100','Congenital iodine-deficiency syndrome','E',0,1,1,1,NULL,NULL,NULL,NULL,1),('101','Other hypothyroidism','E',0,1,1,1,NULL,NULL,NULL,NULL,1),('102','Thyrotoxicosis [hyperthyroidism]','E',0,1,1,1,NULL,NULL,NULL,NULL,1),('103','Other disorders of thyroid','E',0,1,1,1,NULL,NULL,NULL,NULL,1),('104','Type 1 diabetes mellitus','E',0,1,1,1,NULL,NULL,NULL,NULL,1),('105','Type 2 diabetes mellitus','E',0,1,1,1,NULL,NULL,NULL,NULL,1),('106','Nondiabetic hypoglycaemic coma','E',0,1,1,1,NULL,NULL,NULL,NULL,1),('107','Other disorders of adrenal gland','E',0,1,1,1,NULL,NULL,NULL,NULL,1),('108','Unspecified severe protein-energy malnutrition','E',0,1,1,1,NULL,NULL,NULL,NULL,1),('109','Retarded development following protein-energy malnutrition','E',0,1,1,1,NULL,NULL,NULL,NULL,1),('11','Plague','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('110','Unspecified protein-energy malnutrition','E',0,1,1,1,NULL,NULL,NULL,NULL,1),('111','Nutritional deficiency, unspecified','E',0,1,1,1,NULL,NULL,NULL,NULL,1),('112','Sequelae of hyperalimentation','E',0,1,1,1,NULL,NULL,NULL,NULL,1),('113','Lactose intolerance','E',0,1,1,1,NULL,NULL,NULL,NULL,1),('114','Volume depletion','E',0,1,1,1,NULL,NULL,NULL,NULL,1),('115','Unspecified dementia','F',0,1,1,1,NULL,NULL,NULL,NULL,1),('116','Mental and behavioural disorders due to use of alcohol','F',0,1,1,1,NULL,NULL,NULL,NULL,1),('117','Mental and behavioural disorders due to multiple drug use and use of other psychoactive substances','F',0,1,1,1,NULL,NULL,NULL,NULL,1),('118','Schizophrenia','F',0,1,1,1,NULL,NULL,NULL,NULL,1),('119','Acute and transient psychotic disorders','F',0,1,1,1,NULL,NULL,NULL,NULL,1),('12','Other zoonotic bacterial diseases, not elsewhere classified','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('120','Unspecified mood [affective] disorder','F',0,1,1,1,NULL,NULL,NULL,NULL,1),('121','Other anxiety disorders','F',0,1,1,1,NULL,NULL,NULL,NULL,1),('122','Somatoform disorders','F',0,1,1,1,NULL,NULL,NULL,NULL,1),('123','Eating disorders','F',0,1,1,1,NULL,NULL,NULL,NULL,1),('124','Sexual dysfunction, not caused by organic disorder or disease','F',0,1,1,1,NULL,NULL,NULL,NULL,1),('125','Unspecified disorder of adult personality and behaviour','F',0,1,1,1,NULL,NULL,NULL,NULL,1),('126','Unspecified mental retardation','F',0,1,1,1,NULL,NULL,NULL,NULL,1),('127','Specific developmental disorders of speech and language','F',0,1,1,1,NULL,NULL,NULL,NULL,1),('128','Specific developmental disorder of motor function','F',0,1,1,1,NULL,NULL,NULL,NULL,1),('129','Hyperkinetic disorders','F',0,1,1,1,NULL,NULL,NULL,NULL,1),('13','Leprosy [Hansen disease]','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('130','Other behavioural and emotional disorders with onset usually occurring in childhood and adolescence','F',0,1,1,1,NULL,NULL,NULL,NULL,1),('131','Meningitis in other infectious and parasitic diseases classified elsewhere','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('132','Meningitis due to other and unspecified causes','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('133','Encephalitis, myelitis and encephalomyelitis','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('134','Spinal muscular atrophy and related syndromes','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('135','Postpolio syndrome','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('136','Parkinson disease','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('137','Alzheimer disease','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('138','Epilepsy','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('139','Status epilepticus','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('14','Other tetanus','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('140','Migraine','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('141','Other headache syndromes','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('142','Transient cerebral ischaemic attacks and related syndromes','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('143','Vascular syndromes of brain in cerebrovascular diseases','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('144','Sleep disorders','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('145','Cranial nerve disorders in diseases classified elsewhere','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('146','Nerve root and plexus disorders','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('147','Hereditary and idiopathic neuropathy','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('148','Polyneuropathy in diseases classified elsewhere','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('149','Primary disorders of muscles','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('15','Diphtheria','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('150','Cerebral palsy','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('151','Hydrocephalus','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('152','Toxic encephalopathy','G',0,1,1,1,NULL,NULL,NULL,NULL,1),('153','Hordeolum and chalazion','H1',0,1,1,1,NULL,NULL,NULL,NULL,1),('154','Conjunctivitis','H1',0,1,1,1,NULL,NULL,NULL,NULL,1),('155','Corneal scars and opacities','H1',0,1,1,1,NULL,NULL,NULL,NULL,1),('156','Senile cataract','H1',0,1,1,1,NULL,NULL,NULL,NULL,1),('157','Glaucoma','H1',0,1,1,1,NULL,NULL,NULL,NULL,1),('158','Other strabismus','H1',0,1,1,1,NULL,NULL,NULL,NULL,1),('159','Visual disturbances','H1',0,1,1,1,NULL,NULL,NULL,NULL,1),('16','Whooping cough','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('160','Visual impairment including blindness (binocular or monocular)','H1',0,1,1,1,NULL,NULL,NULL,NULL,1),('161','Other disorders of eye and adnexa','H1',0,1,1,1,NULL,NULL,NULL,NULL,1),('162','Otitis externa','H2',0,1,1,1,NULL,NULL,NULL,NULL,1),('163','Perforation of tympanic membrane','H2',0,1,1,1,NULL,NULL,NULL,NULL,1),('164','Other disorders of middle ear and mastoid','H2',0,1,1,1,NULL,NULL,NULL,NULL,1),('165','Disorders of vestibular function','H2',0,1,1,1,NULL,NULL,NULL,NULL,1),('166','Conductive and sensorineural hearing loss','H2',0,1,1,1,NULL,NULL,NULL,NULL,1),('167','Other disorders of ear, not elsewhere classified','H2',0,1,1,1,NULL,NULL,NULL,NULL,1),('168','Rheumatic fever without mention of heart involvement','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('169','Essential (primary) hypertension','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('17','Scarlet fever','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('170','Hypertensive heart disease','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('171','Hypertensive renal disease','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('172','Secondary hypertension','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('173','Angina pectoris','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('174','Acute myocardial infarction','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('175','Subsequent myocardial infarction','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('176','Pulmonary embolism','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('177','Other pulmonary heart diseases','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('178','Cardiomiopatia','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('179','Cardiac arrest','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('18','Congenital syphilis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('180','Paroxysmal tachycardia','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('181','Other cardiac arrhythmias','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('182','Heart failure','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('183','Cerebral infarction','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('184','Other aneurysm and dissection','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('185','Phlebitis and thrombophlebitis','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('186','Other venous embolism and thrombosis','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('187','Varicose veins of lower extremities','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('188','Oesophageal varices','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('189','Nonspecific lymphadenitis','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('19','Early syphilis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('190','Hypotension','I',0,1,1,1,NULL,NULL,NULL,NULL,1),('191','Acute nasopharyngitis [common cold]','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('192','Acute sinusitis','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('193','Acute pharyngitis','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('194','Acute tonsillitis','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('195','Acute laryngitis and tracheitis','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('196','Influenza with pneumonia, seasonal influenza virus identified','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('197','Influenza, virus not identified','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('198','Viral pneumonia, not elsewhere classified','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('199','Bacterial pneumonia, not elsewhere classified','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('2','Amebiasis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('20','Late syphilis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('200','Pneumonia due to other infectious organisms, not elsewhere classified','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('201','Acute bronchitis','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('202','Acute bronchiolitis','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('203','Vasomotor and allergic rhinitis','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('204','Chronic rhinitis, nasopharyngitis and pharyngitis','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('205','Chronic sinusitis','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('206','Peritonsillar abscess','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('207','Other diseases of upper respiratory tract','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('208','Emphysema','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('209','Asthma','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('21','Gonococcal infection','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('210','Adult respiratory distress syndrome','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('211','Pulmonary oedema','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('212','Pyothorax','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('213','Pleural effusion, not elsewhere classified','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('214','Pneumothorax','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('215','Other pleural conditions','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('216','Respiratory failure, not elsewhere classified','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('217','Other respiratory disorders','J',0,1,1,1,NULL,NULL,NULL,NULL,1),('218','Embedded and impacted teeth','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('219','Dental caries','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('22','Chlamydial lymphogranuloma (venereum)','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('220','Diseases of pulp and periapical tissues','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('221','Gingivitis and periodontal diseases','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('222','Diseases of salivary glands','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('223','Stomatitis and related lesions','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('224','Other diseases of lip and oral mucosa','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('225','Diseases of tongue','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('226','Gastric ulcer','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('227','Duodenal ulcer','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('228','Gastritis and duodenitis','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('229','Acute appendicitis','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('23','Other sexually transmitted chlamydial diseases','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('230','Inguinal hernia','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('231','Umbilical hernia','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('232','Ventral hernia','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('233','Other abdominal hernia','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('234','Ulcerative colitis','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('235','Paralytic ileus and intestinal obstruction without hernia','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('236','Diverticular disease of intestine','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('237','Other functional intestinal disorders','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('238','Fissure and fistula of anal and rectal regions','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('239','Abscess of anal and rectal regions','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('24','Chancroid','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('240','Haemorrhoids and perianal venous thrombosis','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('241','Peritonitis','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('242','Fibrosis and cirrhosis of liver','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('243','Other inflammatory liver diseases','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('244','Cholelithiasis','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('245','Cholecystitis','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('246','Intestinal malabsorption','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('247','Other diseases of digestive system','K',0,1,1,1,NULL,NULL,NULL,NULL,1),('248','Cutaneous abscess, furuncle and carbuncle','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('249','Pemphigus','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('25','Trichomoniasis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('250','Other bullous disorders','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('251','Seborrhoeic dermatitis','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('252','Diaper [napkin] dermatitis','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('253','Allergic contact dermatitis','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('254','Exfoliative dermatitis','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('255','Other dermatitis','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('256','Other papulosquamous disorders','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('257','Urticaria','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('258','Other erythematous conditions','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('259','Alopecia areata','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('26','Anogenital herpesviral [herpes simplex] infection','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('260','Acne','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('261','Follicular cysts of skin and subcutaneous tissue','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('262','Vitiligo','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('263','Seborrhoeic keratosis','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('264','Decubitus ulcer and pressure area','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('265','Hypertrophic disorders of skin','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('266','Lupus erythematosus','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('267','Ulcer of lower limb, not elsewhere classified','L',0,1,1,1,NULL,NULL,NULL,NULL,1),('268','Pyogenic arthritis','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('269','Other rheumatoid arthritis','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('27','Other predominantly sexually transmitted diseases, not elsewhere classified','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('270','Juvenile arthritis','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('271','Gout','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('272','Other arthritis','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('273','Polyarthrosis','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('274','Coxarthrosis [arthrosis of hip]','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('275','Gonarthrosis [arthrosis of knee]','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('276','Other arthrosis','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('277','Acquired deformities of fingers and toes','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('278','Other specific joint derangements','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('279','Scoliosis','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('28','Acute poliomyelitis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('280','Ankylosing spondylitis','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('281','Dorsalgia','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('282','Myositis','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('283','Soft tissue disorders related to use, overuse and pressure','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('284','Shoulder lesions','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('285','Osteomyelitis','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('286','Other disorders of bone','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('287','Other acquired deformities of musculoskeletal system and connective tissue','M',0,1,1,1,NULL,NULL,NULL,NULL,1),('288','Recurrent and persistent haematuria','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('289','Nephrotic syndrome','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('29','Viral meningitis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('290','Obstructive and reflux uropathy','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('291','Acute renal failure','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('292','Chronic kidney disease','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('293','Calculus of kidney and ureter','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('294','Calculus of lower urinary tract','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('295','Other disorders of kidney and ureter, not elsewhere classified','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('296','Cystitis','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('297','Neuromuscular dysfunction of bladder, not elsewhere classified','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('298','Urethral stricture','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('299','Other disorders of urethra','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('3','Other protozoal intestinal diseases','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('30','Unspecified viral infection of central nervous system','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('300','Hyperplasia of prostate','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('301','Inflammatory diseases of prostate','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('302','Hydrocele and spermatocele','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('303','Torsion of testis','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('304','Orchitis and epididymitis','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('305','Male infertility','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('306','Redundant prepuce, phimosis and paraphimosis','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('307','Inflammatory disorders of male genital organs, not elsewhere classified','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('308','Inflammatory disorders of breast','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('309','Hypertrophy of breast','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('31','Other mosquito-borne viral fevers','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('310','Unspecified lump in breast','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('311','Other disorders of breast','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('312','Salpingitis and oophoritis','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('313','Other female pelvic inflammatory diseases','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('314','Other inflammation of vagina and vulva','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('315','Endometriosis','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('316','Female genital prolapse','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('317','Fistulae involving female genital tract','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('318','Polyp of female genital tract','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('319','Other noninflammatory disorders of uterus, except cervix','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('32','Unspecified viral haemorrhagic fever','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('320','Absent, scanty and rare menstruation','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('321','Excessive, frequent and irregular menstruation','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('322','Other abnormal uterine and vaginal bleeding','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('323','Habitual aborter','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('324','Female infertility','N',0,1,1,1,NULL,NULL,NULL,NULL,1),('325','Ectopic pregnancy','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('326','Spontaneous abortion','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('327','Medical abortion','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('328','Failed attempted abortion','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('329','Pre-existing hypertension complicating pregnancy, childbirth and the puerperium','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('33','Herpesviral [herpes simplex] infections','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('330','Gestational [pregnancy-induced] hypertension','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('331','Eclampsia','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('332','Unspecified maternal hypertension','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('333','Infections of genitourinary tract in pregnancy','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('334','Diabetes mellitus in pregnancy','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('335','Multiple gestation','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('336','Other disorders of amniotic fluid and membranes','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('337','Premature rupture of membranes','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('338','Placenta praevia','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('339','Premature separation of placenta [abruptio placentae]','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('34','Varicella [chickenpox]','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('340','Preterm labour and delivery','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('341','Long labour','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('342','Labour and delivery complicated by intrapartum haemorrhage, not elsewhere classified','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('343','Perineal laceration during delivery','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('344','Other obstetric trauma','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('345','Postpartum haemorrhage','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('346','Retained placenta and membranes, without haemorrhage','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('347','Single spontaneous delivery','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('348','Single delivery by caesarean section','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('349','Multiple delivery','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('35','Zoster [herpes zoster]','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('350','Other disorders of breast and lactation associated with childbirth','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('351','Obstetric death of unspecified cause','O',0,1,1,1,NULL,NULL,NULL,NULL,1),('352','Fetus and newborn affected by complications of placenta, cord and membranes','P',0,1,1,1,NULL,NULL,NULL,NULL,1),('353','Fetus and newborn affected by other complications of labour and delivery','P',0,1,1,1,NULL,NULL,NULL,NULL,1),('354','Fetus and newborn affected by noxious influences transmitted via placenta or breast milk','P',0,1,1,1,NULL,NULL,NULL,NULL,1),('355','Slow fetal growth and fetal malnutrition','P',0,1,1,1,NULL,NULL,NULL,NULL,1),('356','Disorders related to long gestation and high birth weight','P',0,1,1,1,NULL,NULL,NULL,NULL,1),('357','Other birth injuries','P',0,1,1,1,NULL,NULL,NULL,NULL,1),('358','Birth asphyxia','P',0,1,1,1,NULL,NULL,NULL,NULL,1),('359','Respiratory distress of newborn','P',0,1,1,1,NULL,NULL,NULL,NULL,1),('36','Measles','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('360','Bacterial sepsis of newborn','P',0,1,1,1,NULL,NULL,NULL,NULL,1),('361','Other congenital infectious and parasitic diseases','P',0,1,1,1,NULL,NULL,NULL,NULL,1),('362','Other neonatal haemorrhages','P',0,1,1,1,NULL,NULL,NULL,NULL,1),('363','Kernicterus','P',0,1,1,1,NULL,NULL,NULL,NULL,1),('364','Neonatal jaundice from other and unspecified causes','P',0,1,1,1,NULL,NULL,NULL,NULL,1),('365','Other perinatal haematological disorders','P',0,1,1,1,NULL,NULL,NULL,NULL,1),('366','Meconium ileus in cystic fibrosis','P',0,1,1,1,NULL,NULL,NULL,NULL,1),('367','Hypothermia of newborn','P',0,1,1,1,NULL,NULL,NULL,NULL,1),('368','Fetal death of unspecified cause','P',0,1,1,1,NULL,NULL,NULL,NULL,1),('369','Microcephaly','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('37','Rubella [German measles]','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('370','Other congenital malformations of eye','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('371','Other congenital malformations of ear','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('372','Other congenital malformations of face and neck','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('373','Other congenital malformations of heart','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('374','Other congenital malformations of peripheral vascular system','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('375','Other congenital malformations of circulatory system','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('376','Other congenital malformations of respiratory system','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('377','Cleft lip','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('378','Other congenital malformations of tongue, mouth and pharynx','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('379','Other congenital malformations of intestine','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('38','Viral warts','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('380','Other congenital malformations of digestive system','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('381','Other congenital malformations of female genitalia','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('382','Undescended testicle','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('383','Hypospadias','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('384','Other congenital malformations of male genital organs','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('385','Other congenital malformations of kidney','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('386','Other congenital malformations of urinary system','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('387','Other congenital malformations of limb(s)','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('388','Other congenital malformations of skull and face bones','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('389','Congenital malformations of spine and bony thorax','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('39','Unspecified viral infection characterized by skin and mucous membrane lesions','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('390','Other congenital malformations, not elsewhere classified','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('391','Down syndrome','Q',0,1,1,1,NULL,NULL,NULL,NULL,1),('392','Retention of urine','R',0,1,1,1,NULL,NULL,NULL,NULL,1),('393','Somnolence, stupor and coma','R',0,1,1,1,NULL,NULL,NULL,NULL,1),('394','Fever of other and unknown origin','R',0,1,1,1,NULL,NULL,NULL,NULL,1),('395','Headache','R',0,1,1,1,NULL,NULL,NULL,NULL,1),('396','Superficial injury of head','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('397','Open wound of head','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('398','Superficial injury of neck','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('399','Other and unspecified injuries of neck','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('4','Giardiasis [lambliasis]','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('40','Acute hepatitis B','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('400','Superficial injury of thorax','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('401','Open wound of thorax','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('402','Other and unspecified injuries of thorax','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('403','Superficial injury of abdomen, lower back and pelvis','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('404','Open wound of abdomen, lower back and pelvis','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('405','Injury of intra-abdominal organs','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('406','Other and unspecified injuries of abdomen, lower back and pelvis','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('407','Superficial injury of shoulder and upper arm','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('408','Other and unspecified injuries of shoulder and upper arm','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('409','Superficial injury of forearm','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('41','Other acute viral hepatitis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('410','Other and unspecified injuries of forearm','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('411','Superficial injury of wrist and hand','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('412','Other and unspecified injuries of wrist and hand','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('413','Superficial injury of hip and thigh','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('414','Other and unspecified injuries of hip and thigh','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('415','Superficial injury of lower leg','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('416','Other and unspecified injuries of lower leg','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('417','Superficial injury of ankle and foot','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('418','Other and unspecified injuries of ankle and foot','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('419','Superficial injuries involving multiple body regions','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('42','Acute hepatitis C','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('420','Traumatic amputations involving multiple body regions','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('421','Unspecified multiple injuries','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('422','Injury of unspecified body region','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('423','Burns and corrosions of multiple body regions','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('424','Burn and corrosion, body region unspecified','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('425','Poisoning by diuretics and other and unspecified drugs, medicaments and biological substances','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('426','Toxic effect of alcohol','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('427','Toxic effect of other and unspecified substances','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('428','Effects of other external causes','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('429','Adverse effects, not elsewhere classified','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('43','Unspecified human immunodeficiency virus [HIV] disease','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('430','Anaphylactic shock, unspecified','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('431','Angioneurotic oedema','ST',0,1,1,1,NULL,NULL,NULL,NULL,1),('432','Bitten by rat','VY',0,1,1,1,NULL,NULL,NULL,NULL,1),('433','Bitten or struck by other mammals','VY',0,1,1,1,NULL,NULL,NULL,NULL,1),('434','Contact with marine animal','VY',0,1,1,1,NULL,NULL,NULL,NULL,1),('435','Bitten or stung by nonvenomous insect and other nonvenomous arthropods','VY',0,1,1,1,NULL,NULL,NULL,NULL,1),('436','General examination and investigation of persons without complaint and reported diagnosis','Z',0,1,1,1,NULL,NULL,NULL,NULL,1),('437','Examination and observation for other reasons','Z',0,1,1,1,NULL,NULL,NULL,NULL,1),('44','Mumps','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('45','Viral infection of unspecified site','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('46','Candidiasis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('47','Mycetoma','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('48','Unspecified mycosis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('49','Other parasitologically confirmed malaria','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('5','Diarrhea and gastroenteritis of presumed infectious origin','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('50','Unspecified malaria','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('51','Schistosomiasis [bilharziasis]','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('52','Echinococcosis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('53','Taeniasis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('54','Cysticercosis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('55','Onchocerciasis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('56','Filariasis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('57','Ascariasis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('58','Trichuriasis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('59','Unspecified intestinal parasitism','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('6','Gastroenteritis and colitis of unspecified origin','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('60','Other helminthiases','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('61','Pediculosis and phthiriasis','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('62','Scabies','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('63','Other and unspecified infectious diseases','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('64','Malignant neoplasm of other and ill-defined sites in the lip, oral cavity and pharynx','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('65','Malignant neoplasm of stomach','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('66','Malignant neoplasm of small intestine','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('67','Malignant neoplasm of colon','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('68','Malignant neoplasm of gallbladder','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('69','Malignant neoplasm of other and ill-defined digestive organs','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('7','Respiratory tuberculosis, bacteriologically and histologically confirmed','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('70','Malignant melanoma of skin','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('71','Other malignant neoplasms of skin','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('72','Malignant neoplasm of breast','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('73','Malignant neoplasm of cervix uteri','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('74','Malignant neoplasm of corpus uteri','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('75','Malignant neoplasm of ovary','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('76','Malignant neoplasm of testis','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('77','Malignant neoplasm of other and unspecified male genital organs','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('78','Malignant neoplasm of kidney, except renal pelvis','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('79','Malignant neoplasm of ureter','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('8','Respiratory tuberculosis, not confirmed bacteriologically or histologically','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('80','Malignant neoplasm of thyroid gland','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('81','Malignant neoplasm, without specification of site','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('82','Benign neoplasm of colon, rectum, anus and anal canal','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('83','Haemangioma and lymphangioma, any site','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('84','Melanocytic naevi','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('85','Other benign neoplasms of skin','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('86','Benign neoplasm of breast','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('87','Leiomyoma of uterus','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('88','Benign neoplasm of ovary','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('89','Benign neoplasm of male genital organs','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('9','Tuberculosis of other organs','AB',0,1,1,1,NULL,NULL,NULL,NULL,1),('90','Benign neoplasm of thyroid gland','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('91','Benign neoplasm of other and unspecified sites','CD',0,1,1,1,NULL,NULL,NULL,NULL,1),('92','Other nutritional anaemias','D',0,1,1,1,NULL,NULL,NULL,NULL,1),('93','Other hereditary haemolytic anaemias','D',0,1,1,1,NULL,NULL,NULL,NULL,1),('94','Acute posthaemorrhagic anaemia','D',0,1,1,1,NULL,NULL,NULL,NULL,1),('95','Anaemia in chronic diseases classified elsewhere','D',0,1,1,1,NULL,NULL,NULL,NULL,1),('96','Other anaemias','D',0,1,1,1,NULL,NULL,NULL,NULL,1),('97','Other disorders of white blood cells','D',0,1,1,1,NULL,NULL,NULL,NULL,1),('98','Diseases of spleen','D',0,1,1,1,NULL,NULL,NULL,NULL,1),('99','Other diseases of blood and blood-forming organs','D',0,1,1,1,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `disease` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diseasetype`
--

DROP TABLE IF EXISTS `diseasetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diseasetype` (
  `DCL_ID_A` char(2) NOT NULL,
  `DCL_DESC` varchar(110) NOT NULL,
  `DCL_CREATED_BY` varchar(50) DEFAULT NULL,
  `DCL_CREATED_DATE` datetime DEFAULT NULL,
  `DCL_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `DCL_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `DCL_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`DCL_ID_A`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diseasetype`
--

LOCK TABLES `diseasetype` WRITE;
/*!40000 ALTER TABLE `diseasetype` DISABLE KEYS */;
INSERT INTO `diseasetype` VALUES ('AB','A00-B99 Infectious and parasitic',NULL,NULL,NULL,NULL,1),('CD','C00-D48 Neoplasms',NULL,NULL,NULL,NULL,1),('D','D50-D89 Blood, blood-forming organs and immune mechanism',NULL,NULL,NULL,NULL,1),('E','E00-E90 Endocrine, nutritional and metabolic diseases',NULL,NULL,NULL,NULL,1),('F','F00-F99 Mental and behavioural disorders',NULL,NULL,NULL,NULL,1),('G','G00-G99 Nervous system',NULL,NULL,NULL,NULL,1),('H1','H00-H59 Eye and adnexa',NULL,NULL,NULL,NULL,1),('H2','H60-H95 Ear and mastoid process',NULL,NULL,NULL,NULL,1),('I','I00-I99 Circulatory system',NULL,NULL,NULL,NULL,1),('J','J00-J99 Respiratory system',NULL,NULL,NULL,NULL,1),('K','K00-K93 Digestive system',NULL,NULL,NULL,NULL,1),('L','L00-L99 Skin and subcutaneous tissue',NULL,NULL,NULL,NULL,1),('M','M00-M99 Musculoskeletal system and connective tissue',NULL,NULL,NULL,NULL,1),('N','N00-N99 Genitourinary system',NULL,NULL,NULL,NULL,1),('O','O00-O99 Pregnancy, childbirth and the puerperium',NULL,NULL,NULL,NULL,1),('P','P00-P96 Conditions originating in the perinatal period',NULL,NULL,NULL,NULL,1),('Q','Q00-Q99 Congenital malformations, deformations and chromosomal abnormalities',NULL,NULL,NULL,NULL,1),('R','R00-R99 Symptoms, signs and abnormal clinical and laboratory findings, not elsewhere classified',NULL,NULL,NULL,NULL,1),('ST','S00-T98 Injury, poisoning and certain other consequences of external causes',NULL,NULL,NULL,NULL,1),('VY','V01-Y98 External causes of morbidity and mortality',NULL,NULL,NULL,NULL,1),('Z','Z00-Z99 Factors influencing health status and contact with health services',NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `diseasetype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam`
--

DROP TABLE IF EXISTS `exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam` (
  `EXA_ID_A` varchar(10) NOT NULL,
  `EXA_DESC` varchar(100) NOT NULL,
  `EXA_EXC_ID_A` char(2) NOT NULL,
  `EXA_PROC` int(11) NOT NULL,
  `EXA_DEFAULT` varchar(50) DEFAULT NULL,
  `EXA_LOCK` int(11) NOT NULL DEFAULT '0',
  `EXA_CREATED_BY` varchar(50) DEFAULT NULL,
  `EXA_CREATED_DATE` datetime DEFAULT NULL,
  `EXA_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `EXA_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `EXA_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`EXA_ID_A`),
  KEY `FK_EXAM_EXAMTYPE` (`EXA_EXC_ID_A`),
  CONSTRAINT `FK_EXAM_EXAMTYPE` FOREIGN KEY (`EXA_EXC_ID_A`) REFERENCES `examtype` (`EXC_ID_A`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam`
--

LOCK TABLES `exam` WRITE;
/*!40000 ALTER TABLE `exam` DISABLE KEYS */;
INSERT INTO `exam` VALUES ('01.01','1.1 HB','HB',1,'>=12 (NORMAL)',1,NULL,NULL,NULL,NULL,1),('01.01.01','1.1 HB (Procedure 3)','HB',3,'',0,NULL,NULL,NULL,NULL,1),('01.02','1.2 WBC Count','HB',1,'4000 - 7000 (NORMAL)',1,NULL,NULL,NULL,NULL,1),('01.03','1.3 Differential ','HB',1,'RESULTS IN NOTE',0,NULL,NULL,NULL,NULL,1),('01.04','1.4 Film Comment','HB',1,'RESULTS IN NOTE',0,NULL,NULL,NULL,NULL,1),('01.05','1.5 ESR','HB',1,'NORMAL',1,NULL,NULL,NULL,NULL,1),('01.06','1.6 Sickling Test','HB',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('02.01','2.1 Grouping','BT',1,'',2,NULL,NULL,NULL,NULL,1),('02.02','2.2 Comb\'s Test','BT',1,'NEGATIVE',3,NULL,NULL,NULL,NULL,1),('03.01','3.1 Blood Slide (Malaria)','PA',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('03.02','3.2 Blood Slide (OTHERS, E.G. TRIUPHANOSOMIAS, MICRIFILARIA, LEISHMANIA, BORRELIA)','PA',1,'NEGATIVE',2,NULL,NULL,NULL,NULL,1),('03.02.1','3.21 Trypanosomiasis','PA',1,'NEGATIVE',2,NULL,NULL,NULL,NULL,1),('03.02.2','3.22 MICROFILARIA','PA',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('03.02.3','3.23 LEISHMANIA','PA',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('03.02.4','3.24 BORRELIA','PA',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('03.03','3.3 STOOL MICROSCOPY','PA',2,'',2,NULL,NULL,NULL,NULL,1),('03.04','3.4 URINE MICROSCOPY','PA',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('03.05','3.5 TISSUE MICROSCOPY','PA',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('03.06','3.6 CSF WET PREP','PA',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('04.01','4.1 CULTURE AND SENSITIVITY (C&S) FOR HAEMOPHILUS INFUENZA TYPE B','BA',1,'NEGATIVE',2,NULL,NULL,NULL,NULL,1),('04.02','4.2 C&S FOR SALMONELA TYPHI','BA',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('04.03','4.3 C&S FOR VIBRO CHOLERA','BA',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('04.04','4.4 C&S FOR SHIGELLA DYSENTERIAE','BA',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('04.05','4.5 C&S FOR NEISSERIA MENINGITIDES','BA',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('04.06','4.6 OTHER C&S ','BA',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('05.01','5.1 WET PREP','MC',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('05.02','5.2 GRAM STAIN','MC',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('05.03','5.3 INDIA INK','MC',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('05.04','5.4 LEISMANIA','MC',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('05.05','5.5 ZN','MC',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('05.06','5.6 WAYSON','MC',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('05.07','5.7 PAP SMEAR','MC',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('06.01','6.1 VDRL/RPR','SE',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('06.02','6.2 TPHA','SE',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('06.03','6.3 HIV','SE',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('06.04','6.4 HEPATITIS','SE',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('06.05','6.5 OTHERS E.G BRUCELLA, RHEUMATOID FACTOR, WEIL FELIX','SE',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('06.06','6.6 PREGANCY TEST','SE',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('07.01','7.1 PROTEIN','CH',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('07.02','7.2 SUGAR','CH',1,'NORMAL',1,NULL,NULL,NULL,NULL,1),('07.03','7.3 LFTS','CH',1,'NORMAL',1,NULL,NULL,NULL,NULL,1),('07.03.1','7.3.1 BILIRUBIN TOTAL','CH',1,'< 1.2 (NORMAL)',3,NULL,NULL,NULL,NULL,1),('07.03.2','7.3.2 BILIRUBIN DIRECT','CH',1,'< 1.2 (NORMAL)',7,NULL,NULL,NULL,NULL,1),('07.03.3','7.3.3 GOT','CH',1,'<= 50 (NORMAL)',2,NULL,NULL,NULL,NULL,1),('07.03.4','7.3.4 ALT/GPT','CH',1,'<= 50 (NORMAL)',1,NULL,NULL,NULL,NULL,1),('07.04','7.4 RFTS','CH',1,'NORMAL',1,NULL,NULL,NULL,NULL,1),('07.04.1','7.4.1 CREATININA','CH',1,'< 1.4 (NORMAL)',1,NULL,NULL,NULL,NULL,1),('07.04.2','7.4.2 UREA','CH',1,'10-55 (NORMAL)',1,NULL,NULL,NULL,NULL,1),('08.01','8.1 OCCULT BLOOD','OC',1,'NEGATIVE',1,NULL,NULL,NULL,NULL,1),('09.01','9.1 URINALYSIS','OT',2,'',1,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examrow`
--

DROP TABLE IF EXISTS `examrow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `examrow` (
  `EXR_ID` int(11) NOT NULL AUTO_INCREMENT,
  `EXR_EXA_ID_A` varchar(10) NOT NULL,
  `EXR_DESC` varchar(50) NOT NULL,
  `EXR_CREATED_BY` varchar(50) DEFAULT NULL,
  `EXR_CREATED_DATE` datetime DEFAULT NULL,
  `EXR_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `EXR_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `EXR_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`EXR_ID`),
  KEY `FK_EXAMROW_EXAM` (`EXR_EXA_ID_A`),
  CONSTRAINT `FK_EXAMROW_EXAM` FOREIGN KEY (`EXR_EXA_ID_A`) REFERENCES `exam` (`EXA_ID_A`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examrow`
--

LOCK TABLES `examrow` WRITE;
/*!40000 ALTER TABLE `examrow` DISABLE KEYS */;
INSERT INTO `examrow` VALUES (1,'01.01','6 - 12',NULL,NULL,NULL,NULL,1),(2,'01.01','< 6',NULL,NULL,NULL,NULL,1),(3,'01.01','>=12 (NORMAL)',NULL,NULL,NULL,NULL,1),(4,'01.02','4000 - 7000 (NORMAL)',NULL,NULL,NULL,NULL,1),(5,'01.02','> 7000 (HIGH)',NULL,NULL,NULL,NULL,1),(6,'01.02','< 4000 (LOW)',NULL,NULL,NULL,NULL,1),(7,'01.05','HIGH',NULL,NULL,NULL,NULL,1),(8,'01.05','NORMAL',NULL,NULL,NULL,NULL,1),(9,'01.05','LOW',NULL,NULL,NULL,NULL,1),(10,'01.06','POSITIVE',NULL,NULL,NULL,NULL,1),(11,'01.06','NEGATIVE',NULL,NULL,NULL,NULL,1),(12,'02.01','A RH+',NULL,NULL,NULL,NULL,1),(13,'02.01','A RH-',NULL,NULL,NULL,NULL,1),(14,'02.01','B RH+',NULL,NULL,NULL,NULL,1),(15,'02.01','B RH-',NULL,NULL,NULL,NULL,1),(16,'02.01','AB RH+',NULL,NULL,NULL,NULL,1),(17,'02.01','AB RH-',NULL,NULL,NULL,NULL,1),(18,'02.01','O RH+',NULL,NULL,NULL,NULL,1),(19,'02.01','O RH-',NULL,NULL,NULL,NULL,1),(20,'02.02','NEGATIVE',NULL,NULL,NULL,NULL,1),(21,'02.02','POSITIVE',NULL,NULL,NULL,NULL,1),(22,'03.01','NEGATIVE',NULL,NULL,NULL,NULL,1),(23,'03.01','FEW',NULL,NULL,NULL,NULL,1),(24,'03.01','+',NULL,NULL,NULL,NULL,1),(25,'03.01','++',NULL,NULL,NULL,NULL,1),(26,'03.01','+++',NULL,NULL,NULL,NULL,1),(27,'03.01','++++',NULL,NULL,NULL,NULL,1),(28,'03.02','POSITIVE',NULL,NULL,NULL,NULL,1),(29,'03.02','NEGATIVE',NULL,NULL,NULL,NULL,1),(30,'03.02.1','NEGATIVE',NULL,NULL,NULL,NULL,1),(31,'03.02.1','POSITIVE',NULL,NULL,NULL,NULL,1),(32,'03.02.2','POSITIVE',NULL,NULL,NULL,NULL,1),(33,'03.02.2','NEGATIVE',NULL,NULL,NULL,NULL,1),(34,'03.02.3','NEGATIVE',NULL,NULL,NULL,NULL,1),(35,'03.02.3','POSITIVE',NULL,NULL,NULL,NULL,1),(36,'03.02.4','NEGATIVE',NULL,NULL,NULL,NULL,1),(37,'03.02.4','POSITIVE',NULL,NULL,NULL,NULL,1),(38,'03.03','A..LUMBRICOIDES',NULL,NULL,NULL,NULL,1),(39,'03.03','E.COLI CYSTS',NULL,NULL,NULL,NULL,1),(40,'03.03','E.HISTOLYTICA',NULL,NULL,NULL,NULL,1),(41,'03.03','E.VERMICULARIS',NULL,NULL,NULL,NULL,1),(42,'03.03','G.LAMBLIA',NULL,NULL,NULL,NULL,1),(43,'03.03','T.HOMINIS',NULL,NULL,NULL,NULL,1),(44,'03.03','HOOK WORM',NULL,NULL,NULL,NULL,1),(45,'03.03','S.MANSONI',NULL,NULL,NULL,NULL,1),(46,'03.03','S.STERCORALIS',NULL,NULL,NULL,NULL,1),(47,'03.03','TAENIA SAGINATA',NULL,NULL,NULL,NULL,1),(48,'03.03','TAENIA SOLIUM',NULL,NULL,NULL,NULL,1),(49,'03.03','TRICHURISI TRICHURA',NULL,NULL,NULL,NULL,1),(50,'03.03','HYMENOLEPIS NANA',NULL,NULL,NULL,NULL,1),(51,'03.04','POSITIVE',NULL,NULL,NULL,NULL,1),(52,'03.04','NEGATIVE',NULL,NULL,NULL,NULL,1),(53,'03.05','POSITIVE',NULL,NULL,NULL,NULL,1),(54,'03.05','NEGATIVE',NULL,NULL,NULL,NULL,1),(55,'03.06','POSITIVE',NULL,NULL,NULL,NULL,1),(56,'03.06','NEGATIVE',NULL,NULL,NULL,NULL,1),(57,'04.01','POSITIVE',NULL,NULL,NULL,NULL,1),(58,'04.01','NEGATIVE',NULL,NULL,NULL,NULL,1),(59,'04.02','POSITIVE',NULL,NULL,NULL,NULL,1),(60,'04.02','NEGATIVE',NULL,NULL,NULL,NULL,1),(61,'04.03','POSITIVE',NULL,NULL,NULL,NULL,1),(62,'04.03','NEGATIVE',NULL,NULL,NULL,NULL,1),(63,'04.04','POSITIVE',NULL,NULL,NULL,NULL,1),(64,'04.04','NEGATIVE',NULL,NULL,NULL,NULL,1),(65,'04.05','POSITIVE',NULL,NULL,NULL,NULL,1),(66,'04.05','NEGATIVE',NULL,NULL,NULL,NULL,1),(67,'04.06','NORMAL',NULL,NULL,NULL,NULL,1),(68,'05.01','POSITIVE',NULL,NULL,NULL,NULL,1),(69,'05.01','NEGATIVE',NULL,NULL,NULL,NULL,1),(70,'05.02','NEGATIVE',NULL,NULL,NULL,NULL,1),(71,'05.02','PNEUMOCOCCI',NULL,NULL,NULL,NULL,1),(72,'05.02','MENINGOCOCCI',NULL,NULL,NULL,NULL,1),(73,'05.02','HEMOPHILLUS INFL.',NULL,NULL,NULL,NULL,1),(74,'05.02','CRYPTOCOCCI',NULL,NULL,NULL,NULL,1),(75,'05.02','PLEAMORPHIC BACILLI',NULL,NULL,NULL,NULL,1),(76,'05.02','STAPHYLOCOCCI',NULL,NULL,NULL,NULL,1),(77,'05.03','POSITIVE',NULL,NULL,NULL,NULL,1),(78,'05.03','NEGATIVE',NULL,NULL,NULL,NULL,1),(79,'05.04','POSITIVE',NULL,NULL,NULL,NULL,1),(80,'05.04','NEGATIVE',NULL,NULL,NULL,NULL,1),(81,'05.05','NEGATIVE',NULL,NULL,NULL,NULL,1),(82,'05.05','+',NULL,NULL,NULL,NULL,1),(83,'05.05','++',NULL,NULL,NULL,NULL,1),(84,'05.05','+++',NULL,NULL,NULL,NULL,1),(85,'05.06','POSITIVE',NULL,NULL,NULL,NULL,1),(86,'05.06','NEGATIVE',NULL,NULL,NULL,NULL,1),(87,'05.07','POSITIVE ',NULL,NULL,NULL,NULL,1),(88,'05.07','NEGATIVE',NULL,NULL,NULL,NULL,1),(89,'06.01','POSITIVE',NULL,NULL,NULL,NULL,1),(90,'06.01','NEGATIVE',NULL,NULL,NULL,NULL,1),(91,'06.02','POSITIVE',NULL,NULL,NULL,NULL,1),(92,'06.02','NEGATIVE',NULL,NULL,NULL,NULL,1),(93,'06.03','POSITIVE',NULL,NULL,NULL,NULL,1),(94,'06.03','NEGATIVE',NULL,NULL,NULL,NULL,1),(95,'06.04','POSITIVE',NULL,NULL,NULL,NULL,1),(96,'06.04','NEGATIVE',NULL,NULL,NULL,NULL,1),(97,'06.05','POSITIVE',NULL,NULL,NULL,NULL,1),(98,'06.05','NEGATIVE',NULL,NULL,NULL,NULL,1),(99,'06.06','POSITIVE',NULL,NULL,NULL,NULL,1),(100,'06.06','NEGATIVE',NULL,NULL,NULL,NULL,1),(101,'07.01','POSITIVE',NULL,NULL,NULL,NULL,1),(102,'07.01','NEGATIVE',NULL,NULL,NULL,NULL,1),(103,'07.02','HIGH',NULL,NULL,NULL,NULL,1),(104,'07.02','LOW',NULL,NULL,NULL,NULL,1),(105,'07.02','NORMAL',NULL,NULL,NULL,NULL,1),(106,'07.03','HIGH',NULL,NULL,NULL,NULL,1),(107,'07.03','LOW',NULL,NULL,NULL,NULL,1),(108,'07.03','NORMAL',NULL,NULL,NULL,NULL,1),(109,'07.03.1','<1.2 (NORMAL)',NULL,NULL,NULL,NULL,1),(110,'07.03.1','1.2 - 5',NULL,NULL,NULL,NULL,1),(111,'07.03.1','> 5',NULL,NULL,NULL,NULL,1),(112,'07.03.2','< 1.2 (NORMAL)',NULL,NULL,NULL,NULL,1),(113,'07.03.2','1.2 - 5',NULL,NULL,NULL,NULL,1),(114,'07.03.2','> 5',NULL,NULL,NULL,NULL,1),(115,'07.03.3','<= 50 (NORMAL)',NULL,NULL,NULL,NULL,1),(116,'07.03.3','> 50',NULL,NULL,NULL,NULL,1),(117,'07.03.4','<= 50 (NORMAL)',NULL,NULL,NULL,NULL,1),(118,'07.03.4','> 50',NULL,NULL,NULL,NULL,1),(119,'07.04','HIGH',NULL,NULL,NULL,NULL,1),(120,'07.04','LOW',NULL,NULL,NULL,NULL,1),(121,'07.04','NORMAL',NULL,NULL,NULL,NULL,1),(122,'07.04.1','< 1.4 (NORMAL)',NULL,NULL,NULL,NULL,1),(123,'07.04.1','1.4 - 2.5',NULL,NULL,NULL,NULL,1),(124,'07.04.1','> 2.5',NULL,NULL,NULL,NULL,1),(125,'07.04.2','> 10',NULL,NULL,NULL,NULL,1),(126,'07.04.2','10-55 (NORMAL)',NULL,NULL,NULL,NULL,1),(127,'07.04.2','< 55',NULL,NULL,NULL,NULL,1),(128,'08.01','POSITIVE',NULL,NULL,NULL,NULL,1),(129,'08.01','NEGATIVE',NULL,NULL,NULL,NULL,1),(130,'09.01','SEDIMENTS',NULL,NULL,NULL,NULL,1),(131,'09.01','SUGAR',NULL,NULL,NULL,NULL,1),(132,'09.01','UROBILINOGEN',NULL,NULL,NULL,NULL,1),(133,'09.01','BILIRUBIN',NULL,NULL,NULL,NULL,1),(134,'09.01','PROTEIN',NULL,NULL,NULL,NULL,1),(135,'09.01','HCG',NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `examrow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `examtype`
--

DROP TABLE IF EXISTS `examtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `examtype` (
  `EXC_ID_A` char(2) NOT NULL,
  `EXC_DESC` varchar(50) NOT NULL,
  `EXC_CREATED_BY` varchar(50) DEFAULT NULL,
  `EXC_CREATED_DATE` datetime DEFAULT NULL,
  `EXC_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `EXC_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `EXC_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`EXC_ID_A`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `examtype`
--

LOCK TABLES `examtype` WRITE;
/*!40000 ALTER TABLE `examtype` DISABLE KEYS */;
INSERT INTO `examtype` VALUES ('BA','4.Bacteriology',NULL,NULL,NULL,NULL,1),('BT','2.Blood transfusion',NULL,NULL,NULL,NULL,1),('CH','7.Chemistry',NULL,NULL,NULL,NULL,1),('HB','1.Haematology',NULL,NULL,NULL,NULL,1),('MC','5.Microscopy',NULL,NULL,NULL,NULL,1),('OC','8.Occult Blood',NULL,NULL,NULL,NULL,1),('OT','OTHER',NULL,NULL,NULL,NULL,1),('PA','3.Parasitology',NULL,NULL,NULL,NULL,1),('SE','6.Serology',NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `examtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groupmenu`
--

DROP TABLE IF EXISTS `groupmenu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupmenu` (
  `GM_ID` int(11) NOT NULL AUTO_INCREMENT,
  `GM_UG_ID_A` varchar(50) NOT NULL DEFAULT '',
  `GM_MNI_ID_A` varchar(50) NOT NULL DEFAULT '',
  `GM_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  `GM_CREATED_BY` varchar(50) DEFAULT NULL,
  `GM_CREATED_DATE` datetime DEFAULT NULL,
  `GM_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `GM_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  PRIMARY KEY (`GM_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=139 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groupmenu`
--

LOCK TABLES `groupmenu` WRITE;
/*!40000 ALTER TABLE `groupmenu` DISABLE KEYS */;
INSERT INTO `groupmenu` VALUES (1,'admin','admtype',1,NULL,NULL,NULL,NULL),(2,'admin','disctype',1,NULL,NULL,NULL,NULL),(44,'admin','medicalsward',1,NULL,NULL,NULL,NULL),(4,'admin','admission',1,NULL,NULL,NULL,NULL),(7,'admin','disease',1,NULL,NULL,NULL,NULL),(8,'admin','exams',1,NULL,NULL,NULL,NULL),(9,'admin','exit',1,NULL,NULL,NULL,NULL),(10,'admin','file',1,NULL,NULL,NULL,NULL),(11,'admin','generaldata',1,NULL,NULL,NULL,NULL),(12,'admin','groups',1,NULL,NULL,NULL,NULL),(13,'admin','help',1,NULL,NULL,NULL,NULL),(14,'admin','hospital',1,NULL,NULL,NULL,NULL),(43,'admin','agetype',1,NULL,NULL,NULL,NULL),(16,'admin','laboratory',1,NULL,NULL,NULL,NULL),(17,'admin','medicals',1,NULL,NULL,NULL,NULL),(18,'admin','medicalstock',1,NULL,NULL,NULL,NULL),(19,'admin','operation',1,NULL,NULL,NULL,NULL),(21,'admin','pharmacy',1,NULL,NULL,NULL,NULL),(22,'admin','statistics',1,NULL,NULL,NULL,NULL),(26,'admin','opd',1,NULL,NULL,NULL,NULL),(27,'admin','users',1,NULL,NULL,NULL,NULL),(28,'admin','usersusers',1,NULL,NULL,NULL,NULL),(29,'admin','vaccine',1,NULL,NULL,NULL,NULL),(30,'admin','ward',1,NULL,NULL,NULL,NULL),(31,'admin','types',1,NULL,NULL,NULL,NULL),(32,'admin','pretreatmenttype',1,NULL,NULL,NULL,NULL),(33,'admin','diseasetype',1,NULL,NULL,NULL,NULL),(34,'admin','medstockmovtype',1,NULL,NULL,NULL,NULL),(35,'admin','examtype',1,NULL,NULL,NULL,NULL),(36,'admin','operationtype',1,NULL,NULL,NULL,NULL),(37,'admin','deliverytype',1,NULL,NULL,NULL,NULL),(38,'admin','medicalstype',1,NULL,NULL,NULL,NULL),(39,'admin','delresulttype',1,NULL,NULL,NULL,NULL),(40,'admin','printing',1,NULL,NULL,NULL,NULL),(41,'admin','examlist1',1,NULL,NULL,NULL,NULL),(42,'admin','diseaselist',1,NULL,NULL,NULL,NULL),(45,'admin','priceslists',1,NULL,NULL,NULL,NULL),(46,'admin','otherprices',1,NULL,NULL,NULL,NULL),(47,'admin','accounting',1,NULL,NULL,NULL,NULL),(48,'admin','newbill',1,NULL,NULL,NULL,NULL),(49,'admin','billsmanager',1,NULL,NULL,NULL,NULL),(50,'admin','data',1,NULL,NULL,NULL,NULL),(51,'admin','btnadmdel',1,NULL,NULL,NULL,NULL),(52,'admin','btnadmadm',1,NULL,NULL,NULL,NULL),(53,'admin','btnadmedit',1,NULL,NULL,NULL,NULL),(54,'admin','btnadmnew',1,NULL,NULL,NULL,NULL),(55,'admin','btnadmopd',1,NULL,NULL,NULL,NULL),(56,'admin','btnadmmer',1,NULL,NULL,NULL,NULL),(57,'admin','btnlaboratorydel',1,NULL,NULL,NULL,NULL),(58,'admin','btnlaboratoryedit',1,NULL,NULL,NULL,NULL),(59,'admin','btnlaboratorynew',1,NULL,NULL,NULL,NULL),(60,'admin','btnopdedit',1,NULL,NULL,NULL,NULL),(61,'admin','btnopddel',1,NULL,NULL,NULL,NULL),(62,'admin','btnopdnew',1,NULL,NULL,NULL,NULL),(63,'admin','btndatamalnut',1,NULL,NULL,NULL,NULL),(64,'admin','btndatadel',1,NULL,NULL,NULL,NULL),(65,'admin','btndataedit',1,NULL,NULL,NULL,NULL),(66,'admin','btndataeditpat',1,NULL,NULL,NULL,NULL),(67,'admin','btnpharmaceuticaldel',1,NULL,NULL,NULL,NULL),(68,'admin','btnpharmaceuticaledit',1,NULL,NULL,NULL,NULL),(69,'admin','btnpharmaceuticalnew',1,NULL,NULL,NULL,NULL),(70,'guest','admtype',0,NULL,NULL,NULL,NULL),(71,'guest','disctype',0,NULL,NULL,NULL,NULL),(72,'guest','admission',1,NULL,NULL,NULL,NULL),(73,'guest','disease',0,NULL,NULL,NULL,NULL),(74,'guest','exams',0,NULL,NULL,NULL,NULL),(75,'guest','exit',1,NULL,NULL,NULL,NULL),(76,'guest','file',1,NULL,NULL,NULL,NULL),(77,'guest','generaldata',0,NULL,NULL,NULL,NULL),(78,'guest','groups',0,NULL,NULL,NULL,NULL),(79,'guest','help',0,NULL,NULL,NULL,NULL),(80,'guest','hospital',0,NULL,NULL,NULL,NULL),(81,'guest','laboratory',1,NULL,NULL,NULL,NULL),(82,'guest','medicals',1,NULL,NULL,NULL,NULL),(83,'guest','medicalstock',0,NULL,NULL,NULL,NULL),(84,'guest','operation',0,NULL,NULL,NULL,NULL),(85,'guest','pharmacy',1,NULL,NULL,NULL,NULL),(86,'guest','statistics',1,NULL,NULL,NULL,NULL),(87,'guest','opd',1,NULL,NULL,NULL,NULL),(88,'guest','users',0,NULL,NULL,NULL,NULL),(89,'guest','usersusers',0,NULL,NULL,NULL,NULL),(90,'guest','vaccine',0,NULL,NULL,NULL,NULL),(91,'guest','ward',0,NULL,NULL,NULL,NULL),(92,'guest','types',0,NULL,NULL,NULL,NULL),(93,'guest','pretreatmenttype',0,NULL,NULL,NULL,NULL),(94,'guest','diseasetype',0,NULL,NULL,NULL,NULL),(95,'guest','medstockmovtype',0,NULL,NULL,NULL,NULL),(96,'guest','examtype',0,NULL,NULL,NULL,NULL),(97,'guest','operationtype',0,NULL,NULL,NULL,NULL),(98,'guest','deliverytype',0,NULL,NULL,NULL,NULL),(99,'guest','medicalstype',0,NULL,NULL,NULL,NULL),(100,'guest','delresulttype',0,NULL,NULL,NULL,NULL),(101,'guest','printing',1,NULL,NULL,NULL,NULL),(102,'guest','examlist1',1,NULL,NULL,NULL,NULL),(103,'guest','diseaselist',1,NULL,NULL,NULL,NULL),(104,'admin','btnadmtherapy',1,NULL,NULL,NULL,NULL),(105,'admin','btnbillnew',1,NULL,NULL,NULL,NULL),(106,'admin','btnbilledit',1,NULL,NULL,NULL,NULL),(107,'admin','btnbilldelete',1,NULL,NULL,NULL,NULL),(108,'admin','btnbillreport',1,NULL,NULL,NULL,NULL),(109,'admin','vaccinetype',1,NULL,NULL,NULL,NULL),(110,'admin','patientvaccine',1,NULL,NULL,NULL,NULL),(111,'admin','btnpatientvaccinenew',1,NULL,NULL,NULL,NULL),(112,'admin','btnpatientvaccineedit',1,NULL,NULL,NULL,NULL),(113,'admin','btnpatientvaccinedel',1,NULL,NULL,NULL,NULL),(115,'admin','communication',1,NULL,NULL,NULL,NULL),(116,'guest','communication',1,NULL,NULL,NULL,NULL),(117,'admin','btnadmbill',1,NULL,NULL,NULL,NULL),(118,'admin','btnbillreceipt',1,NULL,NULL,NULL,NULL),(119,'admin','btnadmpatientfolder',1,NULL,NULL,NULL,NULL),(120,'admin','btnopdnewexamination',1,NULL,NULL,NULL,NULL),(121,'admin','btnopdeditexamination',1,NULL,NULL,NULL,NULL),(122,'admin','btnadmadmexamination',1,NULL,NULL,NULL,NULL),(123,'admin','btnadmexamination',1,NULL,NULL,NULL,NULL),(124,'admin','supplier',1,NULL,NULL,NULL,NULL),(125,'admin','btnpatfoldopdrpt',1,NULL,NULL,NULL,NULL),(126,'admin','btnpatfoldadmrpt',1,NULL,NULL,NULL,NULL),(127,'admin','btnpatfoldpatrpt',1,NULL,NULL,NULL,NULL),(128,'admin','btnpatfolddicom',1,NULL,NULL,NULL,NULL),(129,'admin','smsmanager',1,NULL,NULL,NULL,NULL),(130,'admin','btnpharmstockcharge',1,NULL,NULL,NULL,NULL),(131,'admin','btnpharmstockdischarge',1,NULL,NULL,NULL,NULL),(132,'admin','btnmedicalswardreport',1,NULL,NULL,NULL,NULL),(133,'admin','btnmedicalswardexcel',1,NULL,NULL,NULL,NULL),(134,'admin','btnmedicalswardrectify',1,NULL,NULL,NULL,NULL),(135,'admin','dicomtype',1,NULL,NULL,NULL,NULL),(136,'admin','btnopdnewoperation',1,NULL,NULL,NULL,NULL),(137,'admin','btnopdeditoperation',1,NULL,NULL,NULL,NULL),(138,'admin','worksheet',1,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `groupmenu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `help`
--

DROP TABLE IF EXISTS `help`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `help` (
  `HL_ID` int(11) NOT NULL AUTO_INCREMENT,
  `HL_MASK` int(11) NOT NULL,
  `HL_FIELD` int(11) NOT NULL,
  `HL_LANG` char(2) DEFAULT NULL,
  `HL_MSG` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`HL_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `help`
--

LOCK TABLES `help` WRITE;
/*!40000 ALTER TABLE `help` DISABLE KEYS */;
/*!40000 ALTER TABLE `help` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hospital`
--

DROP TABLE IF EXISTS `hospital`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hospital` (
  `HOS_ID_A` varchar(10) NOT NULL,
  `HOS_NAME` varchar(255) NOT NULL,
  `HOS_ADDR` varchar(255) NOT NULL,
  `HOS_CITY` varchar(255) NOT NULL,
  `HOS_TELE` varchar(50) DEFAULT NULL,
  `HOS_FAX` varchar(50) DEFAULT NULL,
  `HOS_EMAIL` varchar(50) DEFAULT NULL,
  `HOS_CURR_COD` varchar(3) DEFAULT NULL,
  `HOS_LOCK` int(11) NOT NULL DEFAULT '0',
  `HOS_CREATED_BY` varchar(50) DEFAULT NULL,
  `HOS_CREATED_DATE` datetime DEFAULT NULL,
  `HOS_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `HOS_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `HOS_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`HOS_ID_A`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hospital`
--

LOCK TABLES `hospital` WRITE;
/*!40000 ALTER TABLE `hospital` DISABLE KEYS */;
INSERT INTO `hospital` VALUES ('STLUKE','St. Luke HOSPITAL - Angal','P.O. BOX 85 - NEBBI','ANGAL','+256 0472621076','+256 0','angal@ucmb.ug.co.',NULL,0,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `hospital` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laboratory`
--

DROP TABLE IF EXISTS `laboratory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `laboratory` (
  `LAB_ID` int(11) NOT NULL AUTO_INCREMENT,
  `LAB_EXA_ID_A` varchar(10) NOT NULL,
  `LAB_DATE` datetime NOT NULL,
  `LAB_RES` varchar(50) NOT NULL,
  `LAB_NOTE` varchar(255) DEFAULT NULL,
  `LAB_PAT_ID` int(11) DEFAULT NULL,
  `LAB_PAT_NAME` varchar(100) DEFAULT NULL,
  `LAB_CROSS1` int(11) DEFAULT NULL,
  `LAB_CROSS2` int(11) DEFAULT NULL,
  `LAB_CROSS3` int(11) DEFAULT NULL,
  `LAB_CROSS4` int(11) DEFAULT NULL,
  `LAB_CROSS5` int(11) DEFAULT NULL,
  `LAB_CROSS6` int(11) DEFAULT NULL,
  `LAB_CROSS7` int(11) DEFAULT NULL,
  `LAB_CROSS8` int(11) DEFAULT NULL,
  `LAB_CROSS9` int(11) DEFAULT NULL,
  `LAB_CROSS10` int(11) DEFAULT NULL,
  `LAB_CROSS11` int(11) DEFAULT NULL,
  `LAB_CROSS12` int(11) DEFAULT NULL,
  `LAB_CROSS13` int(11) DEFAULT NULL,
  `LAB_LOCK` int(11) NOT NULL DEFAULT '0',
  `LAB_AGE` int(11) DEFAULT NULL,
  `LAB_SEX` char(1) DEFAULT NULL,
  `LAB_MATERIAL` varchar(25) DEFAULT NULL,
  `LAB_EXAM_DATE` date DEFAULT NULL,
  `LAB_PAT_INOUT` char(1) DEFAULT NULL,
  `LAB_CREATED_BY` varchar(50) DEFAULT NULL,
  `LAB_CREATED_DATE` datetime DEFAULT NULL,
  `LAB_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `LAB_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `LAB_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`LAB_ID`),
  KEY `FK_LABORATORY_EXAM` (`LAB_EXA_ID_A`),
  KEY `FK_LABORATORY_PATIENT` (`LAB_PAT_ID`),
  CONSTRAINT `FK_LABORATORY_EXAM` FOREIGN KEY (`LAB_EXA_ID_A`) REFERENCES `exam` (`EXA_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_LABORATORY_PATIENT` FOREIGN KEY (`LAB_PAT_ID`) REFERENCES `patient` (`PAT_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratory`
--

LOCK TABLES `laboratory` WRITE;
/*!40000 ALTER TABLE `laboratory` DISABLE KEYS */;
/*!40000 ALTER TABLE `laboratory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laboratoryrow`
--

DROP TABLE IF EXISTS `laboratoryrow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `laboratoryrow` (
  `LABR_ID` int(11) NOT NULL AUTO_INCREMENT,
  `LABR_LAB_ID` int(11) NOT NULL,
  `LABR_DESC` varchar(50) NOT NULL,
  `LABR_CREATED_BY` varchar(50) DEFAULT NULL,
  `LABR_CREATED_DATE` datetime DEFAULT NULL,
  `LABR_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `LABR_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `LABR_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`LABR_ID`),
  KEY `FK_LABORATORYROW_LABORATORY` (`LABR_LAB_ID`),
  CONSTRAINT `FK_LABORATORYROW_LABORATORY` FOREIGN KEY (`LABR_LAB_ID`) REFERENCES `laboratory` (`LAB_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratoryrow`
--

LOCK TABLES `laboratoryrow` WRITE;
/*!40000 ALTER TABLE `laboratoryrow` DISABLE KEYS */;
/*!40000 ALTER TABLE `laboratoryrow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `LOG_ID` int(11) NOT NULL AUTO_INCREMENT,
  `LOG_TYPE` int(11) NOT NULL,
  `LOG_CLASS` varchar(100) DEFAULT NULL,
  `LOG_METHOD` varchar(64) DEFAULT NULL,
  `LOG_TIME` datetime NOT NULL,
  `LOG_MESS` varchar(1024) DEFAULT NULL,
  `LOG_USER` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`LOG_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log`
--

LOCK TABLES `log` WRITE;
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
/*!40000 ALTER TABLE `log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `malnutritioncontrol`
--

DROP TABLE IF EXISTS `malnutritioncontrol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `malnutritioncontrol` (
  `MLN_ID` int(11) NOT NULL AUTO_INCREMENT,
  `MLN_DATE_SUPP` datetime NOT NULL,
  `MNL_DATE_CONF` datetime DEFAULT NULL,
  `MLN_ADM_ID` int(11) NOT NULL,
  `MLN_HEIGHT` float NOT NULL,
  `MLN_WEIGHT` float NOT NULL,
  `MLN_LOCK` int(11) NOT NULL DEFAULT '0',
  `MLN_CREATED_BY` varchar(50) DEFAULT NULL,
  `MLN_CREATED_DATE` datetime DEFAULT NULL,
  `MLN_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `MLN_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `MLN_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`MLN_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `malnutritioncontrol`
--

LOCK TABLES `malnutritioncontrol` WRITE;
/*!40000 ALTER TABLE `malnutritioncontrol` DISABLE KEYS */;
/*!40000 ALTER TABLE `malnutritioncontrol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicaldsr`
--

DROP TABLE IF EXISTS `medicaldsr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicaldsr` (
  `MDSR_ID` int(11) NOT NULL AUTO_INCREMENT,
  `MDSR_MDSRT_ID_A` char(1) NOT NULL,
  `MDSR_CODE` varchar(5) NOT NULL,
  `MDSR_DESC` varchar(100) NOT NULL,
  `MDSR_MIN_STOCK_QTI` float NOT NULL DEFAULT '0',
  `MDSR_INI_STOCK_QTI` float NOT NULL DEFAULT '0',
  `MDSR_PCS_X_PCK` int(11) NOT NULL,
  `MDSR_IN_QTI` float NOT NULL DEFAULT '0',
  `MDSR_OUT_QTI` float NOT NULL DEFAULT '0',
  `MDSR_LOCK` int(11) NOT NULL DEFAULT '0',
  `MDSR_CREATED_BY` varchar(50) DEFAULT NULL,
  `MDSR_CREATED_DATE` datetime DEFAULT NULL,
  `MDSR_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `MDSR_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `MDSR_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`MDSR_ID`),
  UNIQUE KEY `MDSR_MDSRT_ID_A` (`MDSR_MDSRT_ID_A`,`MDSR_DESC`),
  CONSTRAINT `FK_MEDICALDSR_MEDICALDSRTYPE` FOREIGN KEY (`MDSR_MDSRT_ID_A`) REFERENCES `medicaldsrtype` (`MDSRT_ID_A`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=398 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicaldsr`
--

LOCK TABLES `medicaldsr` WRITE;
/*!40000 ALTER TABLE `medicaldsr` DISABLE KEYS */;
INSERT INTO `medicaldsr` VALUES (1,'K','','Glucose Test Strip',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(2,'L','','Acetic Acid Glacial 1 ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(3,'L','','Aceton 99% 1ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(4,'L','','Copper 11 Sulphate 500g',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(5,'L','','EDTA Di- sodium salt 100g',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(6,'L','','Ethanol Absolute 1ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(7,'L','','Formaldehyde solution 35-38% 1ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(8,'L','','Hydrochloric Acid 30-33% 1ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(9,'L','','Iodine Crystal 100g',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(10,'L','','Methanol 99% 1ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(11,'L','','Phenol crystals 1kg',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(12,'L','','Potassium iodide 100g',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(13,'L','','Sodium Carbonate Anhydrous 500g',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(14,'L','','Sodium Citrate 100g',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(15,'L','','Sodium Sulphate 500g',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(16,'L','','Sodium Nitrate 25g',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(17,'L','','Sulphosalicylic Acid 500g',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(18,'L','','Sulphuric Acid Conc 1ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(19,'L','','Xylene 2.5 ltrs',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(20,'L','','Sodium Fluoride',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(21,'L','','Potassium Oxalate',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(22,'L','','Brilliant Cresyl Blue',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(23,'L','','Ammonium Oxalate',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(24,'L','','4 Dimethyl Aminobenzaldelyde',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(25,'L','','Trichloro acetic Acid',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(26,'L','','Non 111 Chloride (Ferric chloride)',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(27,'L','','Sodium Carbonate Anhydrous',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(28,'L','','Trisodium Citrate',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(29,'L','','Crystal Violet',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(30,'K','','GPT (ALT) 200ml ( Does not have NAOH)',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(31,'K','','GOT ( AST) 200ml has no NAOH) AS 101',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(32,'K','','GOT ( AST) 200ml (Calorimetric) AS 147',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(33,'K','','HIV 1/2 Capillus Kit 100Tests',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(34,'K','','HIV Buffer for determine Kit',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(35,'K','','HIV Determine 1/11 (Abbott) 100Tests',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(36,'K','','HIV UNIGOLD 1/11 Test Kits 20 Tests',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(37,'K','','Pregnacy ( HGG Latex) 50 tests',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(38,'K','','RPR 125mm x 75mm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(39,'K','','RPR ( VDRL Carbon ) Antigen 5ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(40,'D','','Adrenaline 1mg/ml 1ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(41,'D','','Aminophylline 25mg/ml,10ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(42,'D','','Amphotericin B 50mg Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(43,'D','','Ampicillin 500mg Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(44,'D','','Atropine 1mg/ml 1ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(45,'D','','Benzathine Penicillin 2.4 MIU Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(46,'D','','Benzyl Penicillin 1 MIU Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(47,'D','','Benzyl Penicillin 5 MIU Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(48,'D','','Chloramphenicol 1g Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(49,'D','','Chloroquine 40mg Base/ml 5ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(50,'D','','Chlorpromazine 25mg/ml/2ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(51,'D','','Cloxacillin 500mg Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(52,'D','','Cyclophosphamide 200mg Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(53,'D','','Cyclophosphamide 500mg Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(54,'D','','Diazepam 5mg / ml 2ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(55,'D','','Diclofenac 25mg/ml 3ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(56,'D','','Digoxin 0.25 mg/ml 2ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(57,'D','','Furosemide 10mg/ml 2ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(58,'D','','Gentamicin 40mg/ml 2ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(59,'D','','Haloperidol 5mg/ml 1ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(60,'D','','Haloperidol Decanoate 50mg/ml 1ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(61,'D','','Hydralazine 20mg Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(62,'D','','Hydrocortisone 100mg Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(63,'D','','Hyoscine Butyl Bromide 20mg/ml/ Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(64,'D','','Insulin Soluble 100IU/ml 10ml Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(65,'D','','Insulin Isophane 100IU/ml 10ml Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(66,'D','','Insulin Mixtard 30/70 100IU/ml 10ml Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(67,'D','','Insulin Mixtard 30/70 100IU/ml 5x3ml catridges',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(68,'D','','Insulin Isophane 40IU/ml 10ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(69,'D','','Iron Dextran 10mg/ml 2ml Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(70,'D','','Ketamine 10mg/ml 20ml Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(71,'D','','Ketamine 10mg/ml 10ml Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(72,'D','','Lignocaine 2% 20ml Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(73,'D','','Lignocaine 2% Adrenaline Dent.cartridges',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(74,'D','','Lignocaine spinal 50mg/ml 2ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(75,'D','','Methylergomeatrine 0.2mg/ml 1ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(76,'D','','Methylergomeatrine 0.5mg/ml 1ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(77,'D','','Metoclopramide 5mg/ml 100ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(78,'D','','Metronidazole 5mg/ml 2ml IV',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(79,'D','','Morphine 15mg/ml 1ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(80,'D','','Oxytocin 10 IU/ml 1ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(81,'D','','Pethidine 100mg/ml 2ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(82,'D','','Pethidine 50mg/ml 1ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(83,'D','','Phenobarbital 100mg/ml 2ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(84,'D','','Phytomenadione 10mg/ml 1ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(85,'D','','Phytomenadione 1mg/ml 1ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(86,'D','','Procaine Penicillin Fortified 4 MIU Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(87,'D','','Promethazine 25mg/ml 2ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(88,'D','','Quinine Di-HCI 300mg/ml 2ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(89,'D','','Ranitidine 25mg/ml 2ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(90,'D','','Streptomycin 1g Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(91,'D','','Suxamethonium 500mg Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(92,'D','','Suxamethonium 500mg/ml 2ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(93,'D','','tetanus Antitoxin 1500 IU 1ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(94,'D','','Thiopental Sodium 500mg Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(95,'D','','Water for Injection 10ml Vial',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(96,'D','','Sodium Chloride 0.9% IV 500ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(97,'D','','Sodium Lactate Compound IV 500ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(98,'D','','Acetazolamide 250mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(99,'D','','Acyclovir 200mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(100,'D','','Aciclovir',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(101,'D','','Aminophylline 100mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(102,'D','','Albendazole 400mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(103,'D','','Albendazole 200mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(104,'D','','Amitriptyline 25mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(105,'D','','Amoxicillin 250mg Caps',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(106,'D','','Amoxicillin /Clavulanate 375mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(107,'D','','Ascorbic Acid 100mg tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(108,'D','','Aspirin 300mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(109,'D','','Atenolol 50mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(110,'D','','Atenolol 100mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(111,'D','','Bendrofluazide 5mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(112,'D','','Benzhexol 2mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(113,'D','','Benzhexol 5mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(114,'D','','Bisacodyl 5mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(115,'D','','Calcium Lactate 300mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(116,'D','','Carbamazepine 200mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(117,'D','','Carbimazole 5mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(118,'D','','Charcoal 250mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(119,'D','','Chloramphenicol 250mg Caps',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(120,'D','','Chloroquine Uncoated 150mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(121,'D','','Chloroquine Coated 150mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(122,'K','','UREA Calorimetric 300 Tests',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(123,'D','','Chlorphenimine 4mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(124,'D','','Chlorpromazine 100mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(125,'D','','Chlorpromazine 25mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(126,'D','','Cimetidine 200mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(127,'D','','Cimetidine 400mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(128,'D','','Ciprofloxacine 500mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(129,'D','','Ciprofloxacine 250mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(130,'D','','Cloxacillin 250mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(131,'D','','Codein Phosphate 30mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(132,'D','','Cotrimoxazole 100/20mg Paed Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(133,'D','','Cotrimoxazole 400/80mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(134,'D','','Darrows Half Strength 500ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(135,'D','','Dexamethasone 4mg/ml 2ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(136,'D','','Dexamethasone 4mg/ml 1ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(137,'D','','Dextrose 5% IV 500ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(138,'D','','Dextrose 30% IV 100ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(139,'D','','Dextrose 50% IV 100ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(140,'D','','Dexamethasone 0.5mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(141,'D','','Diazepam 5mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(142,'D','','Diclofenac 50mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(143,'D','','Diethylcarbamazine 50mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(144,'D','','Digoxin 0.25 mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(145,'D','','Doxycycline 100mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(146,'D','','Ephedrine 30mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(147,'D','','Erythromycin 250mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(148,'D','','Fansidar 500/25mg Tab (50dosesx3)',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(149,'D','','Fansidar 500/25mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(150,'D','','Ferrous Sulphate 200mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(151,'D','','Fluconazole 100mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(152,'D','','Fluconazole 100mg 24 Caps',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(153,'D','','Folic Acid 1mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(154,'D','','Folic Acid 5mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(155,'D','','Folic Acid/Ferrous Sulp 0.5/200mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(156,'D','','Folic Acid 15mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(157,'D','','Frusemide 40mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(158,'D','','Glibenclamide 5mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(159,'D','','Griseofulvin 500mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(160,'D','','Haloperidol 5mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(161,'D','','Haloperidol 5mg',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(162,'D','','Hydralazine 25mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(163,'D','','Hyoscine 10mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(164,'D','','Ibuprofen 200mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(165,'D','','Imipramine 25mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(166,'D','','Indomethacin 25mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(167,'D','','Isoniazid 300mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(168,'D','','Ketoconazole 200mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(169,'D','','Salbutamol 4mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(170,'D','','Spironolactone 25mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(171,'D','','Tolbutamide 500mg tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(172,'D','','Vitamin A 200.000 IU Caps',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(173,'D','','Vitamin B Complex Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(174,'D','','Oral Rehydration Salt (ORS)',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(175,'D','','Paracetamol 120mg/5ml Syrup',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(176,'D','','Paracetamol 120mg/5ml 100ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(177,'D','','Quinine 100mg/5ml Syrup 100ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(178,'D','','Alcohol 95% not denatured 20Ltrs',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(179,'D','','Chlorhexidine/Cetrimide 1.5/15% 1Ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(180,'D','','Chlorhexidine/Cetrimide 1.5/15% 5Ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(181,'D','','Gentian Violet 25g Tin',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(182,'D','','Hydrogen Peroxide 6% 250ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(183,'D','','Iodine Solution 2% 500ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(184,'D','','Sodium Hypochlorite solution 0.75 Ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(185,'D','','liquid detergent 5Ltr Perfumed',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(186,'D','','Soap Blue Bar 550g',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(187,'D','','Liquid detergent 20Ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(188,'D','','Soap Powder Hand wash 5kg',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(189,'D','','Sodium Hypochlorite solution 5Ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(190,'D','','Betamethasone 0.1% eye/ear/nose drops',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(191,'D','','Betamethasone 0.1% Neomycin 0.35 %eye drops 7.5ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(192,'D','','Chloramphenicol 0.5% Eye Drops 10ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(193,'D','','Cloramphenicol 1% Eye Ointment 3.5g',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(194,'D','','Gentamicin 0.3% eye/ear drops 10ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(195,'D','','Hydrocortisone 1% eye drops 5ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(196,'D','','Tetracycline eye ointment 1% 3.5g',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(197,'D','','Beclomethasone 50mcg Inhaler',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(198,'K','','Urine Test Strips 3 Parameters 100 tests',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(199,'D','','Salbutamol solution for inhalation 5ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(200,'D','','Salbutamol Inhaler 10ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(201,'D','','Clotrimazole 500mg Pessaries',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(202,'D','','Clotrimazole 100mg Pessaries',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(203,'D','','Diazepam 2mg/ml 2.5ml Rectal Tube',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(204,'D','','Antihaemorrhoid suppositories',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(205,'D','','Nystatin 100.000 IU Pessaries',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(206,'D','','Dextrose Monohydrate Apyrogen 25Kg',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(207,'D','','Amoxicillin 125mg/5ml Powd. Susp 100ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(208,'D','','Chloramphenicol 125mg/5ml Susp 3Ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(209,'D','','Chloramphenicol 125mg/5ml Susp 100ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(210,'D','','Cotrimoxazole 200+40mg/5ml Susp 3Ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(211,'D','','Cotrimoxazole 200+40mg/5ml Susp 100ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(212,'D','','Nystatin 500.000IU/ Susp/ Drops',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(213,'D','','Pyridoxine 50mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(214,'D','','Quinine 300mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(215,'D','','Ranitidine 150mg Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(216,'D','','Rifampicin/Isoniazid 150/100 Tab',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(217,'D','','Sodium Chloride Apyrogen 50kg',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(218,'K','','Field stain A and B',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(219,'K','','Genitian Violet',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(220,'K','','Neutral Red',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(221,'K','','Eosin Yellowish',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(222,'K','','Giemsa Stain',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(223,'K','','Anti Serum A 10ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(224,'S','','Blood giving set Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(225,'S','','Blood Transfer Bag 300ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(226,'S','','Insulin Syringe 100IU with Needle G26/29',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(227,'S','','IV Cannula G16 with Port',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(228,'S','','IV Cannula G18 with Port',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(229,'S','','IV Cannula G20 with Port',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(230,'S','','IV Cannula G22 with Port',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(231,'S','','IV Cannula G24 without Port',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(232,'S','','IV Cannula G24 with Port',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(233,'S','','IV Giving set Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(234,'S','','Needle container disposable of contaminated',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(235,'S','','Needles Luer G20 Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(236,'S','','Needles Luer G21 Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(237,'S','','Needles Luer G22 Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(238,'S','','Needles Luer G23 Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(239,'S','','Needles Spinal G20x75-120mm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(240,'S','','Needles Spinal G22x75-120mm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(241,'S','','Needles Spinal G25x75-120mm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(242,'S','','Needles Spinal G22x40mm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(243,'S','','Scalp Vein G19 Infusion set',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(244,'S','','Scalp Vein G21 Infusion set',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(245,'S','','Scalp Vein G23 Infusion set',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(246,'S','','Scalp Vein G25 Infusion set',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(247,'S','','Syringe Feeding/Irrigation 50/60ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(248,'S','','Syringe Luer 2ml With Needle Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(249,'S','','Syringe Luer 10ml With Needle Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(250,'S','','Syringe Luer 20ml With Needle Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(251,'S','','Syringe Luer 5ml With Needle Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(252,'S','','Airway Guedel Size 00',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(253,'S','','Airway Guedel Size 0',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(254,'S','','Airway Guedel Size 1',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(255,'S','','Airway Guedel Size 2',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(256,'S','','Airway Guedel Size 3',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(257,'S','','Eye Pad Sterile',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(258,'S','','Adhesive Tape 2.5cm x 5m',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(259,'S','','Adhesive Tape 7.5cm x 5m',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(260,'S','','cotton Wool 500G',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(261,'S','','Cotton Wool 200G',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(262,'S','','Elastic Bandage 10cm x 4.5m',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(263,'S','','Elastic Bandage 7.5cm x 4.5m',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(264,'S','','Gauze Bandage 7.5cm x 3.65-4m',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(265,'S','','Gauze Bandage 10cm x 4m',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(266,'S','','Gauze Pads Non Sterile 10cm x 10cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(267,'S','','Gauze Pads  Sterile 10cm x 10cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(268,'S','','Gauze Hydrophylic 90cm x 91cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(269,'S','','Plaster of Paris 10cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(270,'S','','Plaster of Paris 15cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(271,'S','','Catheter Foley CH20 3 Way Balloon',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(272,'S','','Catheter Foley CH8 3 Way Balloon',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(273,'S','','Catheter Foley CH10 3 Way Balloon',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(274,'S','','Catheter Foley CH12 3 Way Balloon',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(275,'S','','Catheter Foley CH14 3 Way Balloon',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(276,'S','','Catheter Foley CH16 3 Way Balloon',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(277,'S','','Catheter Foley CH18 3 Way Balloon',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(278,'S','','Catheter Stopper for All sizes',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(279,'S','','Nasogastric Tube G5 (Children)',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(280,'S','','Nasogastric Tube G8 (Children)',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(281,'S','','Nasogastric Tube G6 (Children)',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(282,'S','','Nasogastric Tube G10 (Children)',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(283,'S','','Nasogastric Tube G14 (Children)',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(284,'S','','Nasogastric Tube G16 (Children)',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(285,'S','','Rectal Tube CH24',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(286,'S','','Rectal Tube CH26',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(287,'S','','Suction Catheter Size 6 Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(288,'S','','Suction Catheter Size 8 Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(289,'S','','Suction Catheter Size 16 Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(290,'S','','Suction Catheter Size 12 Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(291,'S','','Suction Catheter Size 14 Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(292,'S','','Suction Catheter Size 10 Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(293,'S','','Gloves Domestic',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(294,'S','','Gloves High risk non sterile Medium',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(295,'S','','Gloves Gynaecological 7.5-8',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(296,'S','','Gloves Non Sterile Medium Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(297,'S','','Gloves Non Sterile Large Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(298,'S','','Gloves Surgical Sterile 6',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(299,'S','','Gloves Surgical Sterile 6.5',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(300,'S','','Gloves Surgical Sterile 7',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(301,'S','','Gloves Surgical Sterile 7.5',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(302,'S','','Gloves Surgical Sterile 8',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(303,'S','','Gloves Surgical Sterile 8.5',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(304,'S','','Tongue depressor Disposable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(305,'S','','Bedpan Plastic Autoclavable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(306,'S','','Bedpan Stainless Steel',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(307,'S','','Body Bag 70 x 215cm  (Adult)',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(308,'S','','Bowl Without Lid 7 x 12cm stainless steel',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(309,'S','','Bowl Without Lid 8 x 16cm stainless steel',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(310,'S','','Bowl Without Lid 10 x 24cm stainless steel',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(311,'S','','Air ring set 43x15cm, rubber with pump',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(312,'S','','Colostomy Bag closed 30mm size 2',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(313,'S','','Colostomy Bag closed 30mm size 3',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(314,'S','','Colostomy Bag open re-usable 35mm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(315,'S','','Ear syringe rubber 60ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(316,'S','','First Aid kit',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(317,'S','','Gallipot stainless steel 300ml/15cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(318,'S','','Gallipot stainless steel 200ml/10cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(319,'S','','Hot water Bottle 2Ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(320,'S','','Instrument Box With Lid 20x10x5cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(321,'S','','Instrument Tray 30 x 20 x 2cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(322,'S','','Irrigation can with accessories',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(323,'S','','Kidney Dish stainless Steel 24cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(324,'S','','Kidney Dish stainless Steel 20cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(325,'S','','Kidney Dish Polypropylene 24cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(326,'S','','Mackintosh Plastic (Apron) per 1m',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(327,'S','','Mackintosh Rubber Brown (sheeting) per 1m',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(328,'S','','Measuring Cup Graduated 25ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(329,'S','','Neck Support Small',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(330,'S','','Neck Support Medium',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(331,'S','','Neck Support Large',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(332,'S','','Spoon Medicine 5ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(333,'S','','Apron Plastic Re-usable',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(334,'S','','Apron Plastic Re-usable local',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(335,'S','','Apron Polythene Disp Non Sterile',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(336,'S','','Razor Blades Disposable 5pc',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(337,'S','','Stethoscope Foetal Metal',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(338,'S','','Stethoscope Foetal Wood',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(339,'S','','Surgical Brush (Scrubbing)',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(340,'S','','Surgical Mop 12 x 15',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(341,'S','','Tablet Counting Tray',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(342,'S','','Toilet Paper Rolls',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(343,'S','','Traction Kit Children',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(344,'S','','Traction Kit Adult',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(345,'S','','Thermometer Clinical Flat Type',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(346,'S','','Thermometer Clinical Prismatic Type',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(347,'S','','Umbilical Cord Tie non sterile 100m',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(348,'S','','Umbilical Cord Tie sterile 22m',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(349,'S','','Urinal 1Ltr / 2Ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(350,'S','','Urine Collecting Bag sterile 2Ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(351,'S','','Insectcide Spray 400g',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(352,'S','','Mosquito Net Impregnated Medium',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(353,'S','','Mosquito Net Impregnated Large',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(354,'S','','Mosquito Net Non Impregnated Medium',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(355,'S','','Mosquito Net Non Impregnated Large',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(356,'S','','Mosquito Net Impregnation Tablet',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(357,'S','','Mosquito Net Impregnation Liquid 500ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(358,'S','','Mosquito Wall spray Powder 80g',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(359,'S','','Handle for surgical blade No 3',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(360,'S','','Handle for surgical blade No 4',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(361,'S','','Surgical Blades No 20',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(362,'S','','Surgical Blades No 21',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(363,'S','','Surgical Blades No 22',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(364,'S','','Surgical Blades No 23',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(365,'S','','Needle suture No 5 round',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(366,'S','','Needle suture No 5 cutting',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(367,'S','','Needle suture No 6 Round',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(368,'S','','Suture Cutgut Chromic (0)',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(369,'S','','Suture Cutgut Chromic (2) RN22240TH',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(370,'S','','Suture Cutgut Chromic (2/0) RN22230TH',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(371,'S','','Suture Cutgut Chromic (3/0) RN2325TF',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(372,'S','','Suture Cutgut Plain (2/0) RN1230TF',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(373,'S','','Suture Silk (1) S595',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(374,'S','','Suture Silk (2/0) RN5230TF',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(375,'S','','Suture PGA (3/0) RN3330TF',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(376,'S','','Lead Apron 100cmx60cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(377,'S','','X-Ray Developer 2.6kg for 22.5Ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(378,'S','','X-Ray Film 18x24cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(379,'S','','X-Ray Film 20x40cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(380,'S','','X-Ray Film 24x30cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(381,'S','','X-Ray Film 30x40cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(382,'S','','X-Ray Film 35x35cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(383,'S','','X-Ray Film 43x35cm',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(384,'S','','X-Ray Film Cassette  18x24cm with screen',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(385,'S','','X-Ray Film Cassette  24x30cm with screen',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(386,'S','','X-Ray Film Cassette  30x40cm with screen',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(387,'S','','X-Ray Film Cassette  35x35cm with screen',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(388,'S','','X-Ray Film Cassette  35x43cm with screen',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(389,'S','','X-Ray Fixer 3.3kg for 22.5 Ltr',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(390,'S','','Barium Sulphate for X-Ray 1kg',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(391,'S','','Diatrizoate Meglumin Sod 76% 20ml Amp',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(392,'K','','Anti Serum B 10ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(393,'K','','Anti Serum AB 10ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(394,'K','','Anti Serum D 10ml',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(395,'K','','Creatinine 200ml (Calorimetric)',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(396,'K','','Glucose GOD PAD  6 x 100ml (Colorimetric)',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1),(397,'K','','Glucose Test Strips (Hyloguard)',0,0,0,0,0,0,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `medicaldsr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicaldsrlot`
--

DROP TABLE IF EXISTS `medicaldsrlot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicaldsrlot` (
  `LT_ID_A` varchar(50) NOT NULL,
  `LT_MDSR_ID` int(11) NOT NULL,
  `LT_PREP_DATE` datetime NOT NULL,
  `LT_DUE_DATE` datetime NOT NULL,
  `LT_COST` double DEFAULT NULL,
  `LT_LOCK` int(11) NOT NULL DEFAULT '0',
  `LT_CREATED_BY` varchar(50) DEFAULT NULL,
  `LT_CREATED_DATE` datetime DEFAULT NULL,
  `LT_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `LT_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `LT_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`LT_ID_A`),
  KEY `FK_MEDICALDSRLOT_MEDICALDSR_idx` (`LT_MDSR_ID`),
  CONSTRAINT `FK_MEDICALDSRLOT_MEDICALDSR` FOREIGN KEY (`LT_MDSR_ID`) REFERENCES `medicaldsr` (`MDSR_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicaldsrlot`
--

LOCK TABLES `medicaldsrlot` WRITE;
/*!40000 ALTER TABLE `medicaldsrlot` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicaldsrlot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicaldsrstockmov`
--

DROP TABLE IF EXISTS `medicaldsrstockmov`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicaldsrstockmov` (
  `MMV_ID` int(11) NOT NULL AUTO_INCREMENT,
  `MMV_MDSR_ID` int(11) NOT NULL,
  `MMV_WRD_ID_A` char(1) DEFAULT NULL,
  `MMV_MMVT_ID_A` varchar(10) NOT NULL,
  `MMV_LT_ID_A` varchar(50) DEFAULT NULL,
  `MMV_DATE` datetime NOT NULL,
  `MMV_QTY` float NOT NULL DEFAULT '0',
  `MMV_FROM` int(11) DEFAULT NULL,
  `MMV_LOCK` int(11) NOT NULL DEFAULT '0',
  `MMV_REFNO` varchar(50) NOT NULL DEFAULT '',
  `MMV_CREATED_BY` varchar(50) DEFAULT NULL,
  `MMV_CREATED_DATE` datetime DEFAULT NULL,
  `MMV_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `MMV_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `MMV_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`MMV_ID`),
  KEY `FK_MEDICALDSRSTOCKMOV_MEDICALDSR` (`MMV_MDSR_ID`),
  KEY `FK_MEDICALDSRSTOCKMOV_MEDICALDSRSTOCKMOVTYPE` (`MMV_MMVT_ID_A`),
  KEY `FK_MEDICALDSRSTOCKMOV_WARD` (`MMV_WRD_ID_A`),
  CONSTRAINT `FK_MEDICALDSRSTOCKMOV_MEDICALDSR` FOREIGN KEY (`MMV_MDSR_ID`) REFERENCES `medicaldsr` (`MDSR_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_MEDICALDSRSTOCKMOV_MEDICALDSRSTOCKMOVTYPE` FOREIGN KEY (`MMV_MMVT_ID_A`) REFERENCES `medicaldsrstockmovtype` (`MMVT_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_MEDICALDSRSTOCKMOV_WARD` FOREIGN KEY (`MMV_WRD_ID_A`) REFERENCES `ward` (`WRD_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicaldsrstockmov`
--

LOCK TABLES `medicaldsrstockmov` WRITE;
/*!40000 ALTER TABLE `medicaldsrstockmov` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicaldsrstockmov` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicaldsrstockmovtype`
--

DROP TABLE IF EXISTS `medicaldsrstockmovtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicaldsrstockmovtype` (
  `MMVT_ID_A` varchar(10) NOT NULL,
  `MMVT_DESC` varchar(50) NOT NULL,
  `MMVT_TYPE` char(2) NOT NULL,
  `MMVT_CREATED_BY` varchar(50) DEFAULT NULL,
  `MMVT_CREATED_DATE` datetime DEFAULT NULL,
  `MMVT_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `MMVT_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `MMVT_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`MMVT_ID_A`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicaldsrstockmovtype`
--

LOCK TABLES `medicaldsrstockmovtype` WRITE;
/*!40000 ALTER TABLE `medicaldsrstockmovtype` DISABLE KEYS */;
INSERT INTO `medicaldsrstockmovtype` VALUES ('charge','Charge','+',NULL,NULL,NULL,NULL,1),('discharge','Discharge','-',NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `medicaldsrstockmovtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicaldsrstockmovward`
--

DROP TABLE IF EXISTS `medicaldsrstockmovward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicaldsrstockmovward` (
  `MMVN_ID` int(10) NOT NULL AUTO_INCREMENT,
  `MMVN_WRD_ID_A` char(1) NOT NULL,
  `MMVN_DATE` datetime NOT NULL,
  `MMVN_IS_PATIENT` tinyint(1) NOT NULL,
  `MMVN_PAT_ID` int(11) DEFAULT NULL,
  `MMVN_PAT_AGE` smallint(6) DEFAULT NULL,
  `MMVN_PAT_WEIGHT` float DEFAULT NULL,
  `MMVN_DESC` varchar(100) NOT NULL,
  `MMVN_MDSR_ID` varchar(100) NOT NULL,
  `MMVN_MDSR_QTY` float NOT NULL,
  `MMVN_MDSR_UNITS` varchar(10) NOT NULL,
  `MMVN_CREATED_BY` varchar(50) DEFAULT NULL,
  `MMVN_WRD_ID_A_FROM` varchar(1) DEFAULT NULL,
  `MMVN_WRD_ID_A_TO` varchar(1) DEFAULT NULL,
  `MMVN_LT_ID` varchar(50) DEFAULT NULL,
  `MMVN_CREATED_DATE` datetime DEFAULT NULL,
  `MMVN_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `MMVN_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `MMVN_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`MMVN_ID`) USING BTREE,
  KEY `FK_MEDICALDSRSTOCKMOVWARD_WARD_idx` (`MMVN_WRD_ID_A`),
  KEY `FK_MEDICALDSRSTOCKMOVWARD_PATIENT_idx` (`MMVN_PAT_ID`),
  KEY `FK_MEDICALDSRSTOCKMOVWARD_LOT_idx` (`MMVN_LT_ID`),
  CONSTRAINT `FK_MEDICALDSRSTOCKMOVWARD_LOT` FOREIGN KEY (`MMVN_LT_ID`) REFERENCES `medicaldsrlot` (`LT_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_MEDICALDSRSTOCKMOVWARD_PATIENT` FOREIGN KEY (`MMVN_PAT_ID`) REFERENCES `patient` (`PAT_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_MEDICALDSRSTOCKMOVWARD_WARD` FOREIGN KEY (`MMVN_WRD_ID_A`) REFERENCES `ward` (`WRD_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicaldsrstockmovward`
--

LOCK TABLES `medicaldsrstockmovward` WRITE;
/*!40000 ALTER TABLE `medicaldsrstockmovward` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicaldsrstockmovward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicaldsrtype`
--

DROP TABLE IF EXISTS `medicaldsrtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicaldsrtype` (
  `MDSRT_ID_A` char(1) NOT NULL,
  `MDSRT_DESC` varchar(30) DEFAULT NULL,
  `MDSRT_CREATED_BY` varchar(50) DEFAULT NULL,
  `MDSRT_CREATED_DATE` datetime DEFAULT NULL,
  `MDSRT_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `MDSRT_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `MDSRT_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`MDSRT_ID_A`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicaldsrtype`
--

LOCK TABLES `medicaldsrtype` WRITE;
/*!40000 ALTER TABLE `medicaldsrtype` DISABLE KEYS */;
INSERT INTO `medicaldsrtype` VALUES ('D','Drugs',NULL,NULL,NULL,NULL,1),('K','Chemical',NULL,NULL,NULL,NULL,1),('L','Laboratory',NULL,NULL,NULL,NULL,1),('S','Surgery',NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `medicaldsrtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medicaldsrward`
--

DROP TABLE IF EXISTS `medicaldsrward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medicaldsrward` (
  `MDSRWRD_WRD_ID_A` char(1) NOT NULL,
  `MDSRWRD_MDSR_ID` int(11) NOT NULL,
  `MDSRWRD_IN_QTI` float DEFAULT '0',
  `MDSRWRD_OUT_QTI` float DEFAULT '0',
  `MDSRWRD_LT_ID_A` varchar(50) NOT NULL,
  `MDSRWRD_CREATED_BY` varchar(50) DEFAULT NULL,
  `MDSRWRD_CREATED_DATE` datetime DEFAULT NULL,
  `MDSRWRD_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `MDSRWRD_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `MDSRWRD_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`MDSRWRD_WRD_ID_A`,`MDSRWRD_MDSR_ID`,`MDSRWRD_LT_ID_A`),
  KEY `FK_MEDICALDSRWARD_WARD_idx` (`MDSRWRD_WRD_ID_A`),
  KEY `FK_MEDICALDSRWARD_MEDICALDSR_idx` (`MDSRWRD_MDSR_ID`),
  KEY `FK_MEDICALDSRWARD_MEDICALDSRLOT_idx` (`MDSRWRD_LT_ID_A`),
  CONSTRAINT `FK_MEDICALDSRWARD_MEDICALDSR` FOREIGN KEY (`MDSRWRD_MDSR_ID`) REFERENCES `medicaldsr` (`MDSR_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_MEDICALDSRWARD_MEDICALDSRLOT` FOREIGN KEY (`MDSRWRD_LT_ID_A`) REFERENCES `medicaldsrlot` (`LT_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_MEDICALDSRWARD_WARD` FOREIGN KEY (`MDSRWRD_WRD_ID_A`) REFERENCES `ward` (`WRD_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medicaldsrward`
--

LOCK TABLES `medicaldsrward` WRITE;
/*!40000 ALTER TABLE `medicaldsrward` DISABLE KEYS */;
/*!40000 ALTER TABLE `medicaldsrward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menuitem`
--

DROP TABLE IF EXISTS `menuitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `menuitem` (
  `MNI_ID_A` varchar(50) NOT NULL DEFAULT '',
  `MNI_BTN_LABEL` varchar(50) NOT NULL DEFAULT '',
  `MNI_LABEL` varchar(50) NOT NULL DEFAULT '',
  `MNI_TOOLTIP` varchar(100) DEFAULT NULL,
  `MNI_SHORTCUT` char(1) DEFAULT NULL,
  `MNI_SUBMENU` varchar(50) NOT NULL DEFAULT '',
  `MNI_CLASS` varchar(100) NOT NULL DEFAULT '',
  `MNI_IS_SUBMENU` char(1) NOT NULL DEFAULT 'N',
  `MNI_POSITION` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`MNI_ID_A`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menuitem`
--

LOCK TABLES `menuitem` WRITE;
/*!40000 ALTER TABLE `menuitem` DISABLE KEYS */;
INSERT INTO `menuitem` VALUES ('admission','angal.menu.btn.admission','angal.menu.admission','x','A','main','org.isf.admission.gui.AdmittedPatientBrowser','N',5),('admtype','angal.menu.btn.admtype','angal.menu.admtype','x','A','types','org.isf.admtype.gui.AdmissionTypeBrowser','N',0),('deliverytype','angal.menu.btn.deliverytype','angal.menu.deliverytype','x','T','types','org.isf.dlvrtype.gui.DeliveryTypeBrowser','N',2),('delresulttype','angal.menu.btn.delresulttype','angal.menu.delresulttype','x','R','types','org.isf.dlvrrestype.gui.DeliveryResultTypeBrowser','N',3),('disctype','angal.menu.btn.disctype','angal.menu.disctype','x','D','types','org.isf.disctype.gui.DischargeTypeBrowser','N',1),('disease','angal.menu.btn.disease','angal.menu.disease','x','D','generaldata','org.isf.disease.gui.DiseaseBrowser','N',3),('diseaselist','angal.menu.btn.diseaselist','angal.menu.diseaselist','x','D','printing','org.isf.stat.gui.DiseasesListLauncher','N',2),('diseasetype','angal.menu.btn.diseasetype','angal.menu.diseasetype','x','D','types','org.isf.distype.gui.DiseaseTypeBrowser','N',4),('examlist1','angal.menu.btn.examlist1','angal.menu.examlist1','x','E','printing','org.isf.stat.gui.ExamsList1Launcher','N',1),('exams','angal.menu.btn.exams','angal.menu.exams','x','E','generaldata','org.isf.exa.gui.ExamBrowser','N',4),('examtype','angal.menu.btn.examtype','angal.menu.examtype','x','E','types','org.isf.exatype.gui.ExamTypeBrowser','N',5),('exit','angal.menu.btn.exit','angal.menu.exit','x','E','file','none','N',0),('file','angal.menu.btn.file','angal.menu.file','x','F','main','none','Y',0),('generaldata','angal.menu.btn.generaldata','angal.menu.generaldata','x','G','main','none','Y',1),('groups','angal.menu.btn.groups','angal.menu.groups','x','G','users','org.isf.menu.gui.UserGroupBrowsing','N',1),('help','angal.menu.btn.help','angal.menu.help','x','H','main','org.isf.help.HelpViewer','N',11),('hospital','angal.menu.btn.hospital','angal.menu.hospital','x','H','generaldata','org.isf.hospital.gui.HospitalBrowser','N',1),('laboratory','angal.menu.btn.laboratory','angal.menu.laboratory','x','L','main','org.isf.lab.gui.LabBrowser','N',4),('medicals','angal.menu.btn.medicals','angal.menu.medicals','x','P','pharmacy','org.isf.medicals.gui.MedicalBrowser','N',0),('medicalstock','angal.menu.btn.medicalstock','angal.menu.medicalstock','x','S','pharmacy','org.isf.medicalstock.gui.MovStockBrowser','N',1),('medicalstype','angal.menu.btn.medicalstype','angal.menu.medicalstype','x','M','types','org.isf.medtype.gui.MedicalTypeBrowser','N',7),('medstockmovtype','angal.menu.btn.medstockmovtype','angal.menu.medstockmovtype','x','S','types','org.isf.medstockmovtype.gui.MedicaldsrstockmovTypeBrowser','N',6),('opd','angal.menu.btn.opd','angal.menu.opd','x','O','main','org.isf.opd.gui.OpdBrowser','N',2),('operation','angal.menu.btn.operation','angal.menu.operation','x','O','generaldata','org.isf.operation.gui.OperationBrowser','N',5),('operationtype','angal.menu.btn.operationtype','angal.menu.operationtype','x','O','types','org.isf.opetype.gui.OperationTypeBrowser','N',8),('pharmacy','angal.menu.btn.pharmacy','angal.menu.pharmacy','x','P','main','none','Y',3),('pretreatmenttype','angal.menu.btn.pretreatmenttype','angal.menu.pretreatmenttype','x','P','types','org.isf.pregtreattype.gui.PregnantTreatmentTypeBrowser','N',9),('printing','angal.menu.btn.printing','angal.menu.printing','x','R','main','none','Y',9),('statistics','angal.menu.btn.statistics','angal.menu.statistics','x','T','main','org.isf.stat.reportlauncher.gui.ReportLauncher','N',6),('types','angal.menu.btn.types','angal.menu.types','x','T','generaldata','none','Y',0),('users','angal.menu.btn.users','angal.menu.users','x','U','file','none','Y',1),('usersusers','angal.menu.btn.usersusers','angal.menu.usersusers','x','U','users','org.isf.menu.gui.UserBrowsing','N',0),('vaccine','angal.menu.btn.vaccine','angal.menu.vaccine','x','V','generaldata','org.isf.vaccine.gui.VaccineBrowser','N',6),('ward','angal.menu.btn.ward','angal.menu.ward','x','W','generaldata','org.isf.ward.gui.WardBrowser','N',2),('medicalsward','angal.menu.btn.medicalsward','angal.menu.medicalsward','x','W','pharmacy','org.isf.medicalstockward.gui.WardPharmacy','N',2),('agetype','angal.menu.btn.agetype','angal.menu.agetype','x','G','types','org.isf.agetype.gui.AgeTypeBrowser','N',11),('priceslists','angal.menu.btn.priceslists','angal.menu.priceslists','x','P','generaldata','org.isf.priceslist.gui.PricesBrowser','N',7),('otherprices','angal.menu.btn.otherprices','angal.menu.otherprices','x','H','types','org.isf.pricesothers.gui.PricesOthersBrowser','N',10),('accounting','angal.menu.btn.accounting','angal.menu.accounting','x','C','main','none','Y',6),('newbill','angal.menu.btn.newbill','angal.menu.newbill','x','N','accounting','org.isf.accounting.gui.PatientBillEdit','N',0),('billsmanager','angal.menu.btn.billsmanager','angal.menu.billsmanager','x','M','accounting','org.isf.accounting.gui.BillBrowser','N',1),('data','angal.admission.data','angal.admission.data','x','D','admission','none','N',3),('btnadmnew','angal.admission.newpatient','angal.admission.newpatient','x','N','admission','none','N',0),('btnadmedit','angal.admission.editpatient','angal.admission.editpatient','x','E','admission','none','N',1),('btnadmopd','angal.admission.opd','angal.admission.admission','x','O','admission','none','N',5),('btnadmadm','angal.admission.admission','angal.admission.admission','x','A','admission','none','N',4),('btnadmdel','angal.admission.deletepatient','angal.admission.deletepatient','x','L','admission','none','N',2),('btnadmmer','angal.admission.merge','angal.admission.merge','x','L','admission','none','N',2),('btndataeditpat','angal.admission.editpatient','angal.admission.editpatient','x','P','data','none','N',0),('btndatamalnut','angal.admission.malnutritioncontrol','angal.admission.malnutritioncontrol','x','M','data','none','N',3),('btndatadel','angal.common.deletem','angal.common.deletem','x','D','data','none','N',2),('btndataedit','angal.common.editm','angal.common.editm','x','E','data','none','N',1),('btnopddel','angal.common.delete','angal.common.delete','x','D','opd','none','N',2),('btnopdedit','angal.common.edit','angal.common.edit','x','E','opd','none','N',1),('btnopdnew','angal.common.new','angal.common.new','x','N','opd','none','N',0),('btnpharmaceuticaldel','angal.common.delete','angal.common.delete','x','D','medicals','none','N',2),('btnpharmaceuticaledit','angal.common.edit','angal.common.edit','x','E','medicals','none','N',1),('btnpharmaceuticalnew','angal.common.new','angal.common.new','x','N','medicals','none','N',0),('btnlaboratorydel','angal.common.delete','angal.common.delete','x','D','laboratory','none','N',2),('btnlaboratoryedit','angal.common.edit','angal.common.edit','x','E','laboratory','none','N',1),('btnlaboratorynew','angal.common.new','angal.common.new','x','N','laboratory','none','N',0),('btnadmtherapy','angal.admission.therapy','angal.admission.therapy','x','T','admission','none','N',6),('btnbillnew','angal.billbrowser.newbill','angal.billbrowser.newbill','x','N','billsmanager','none','N',0),('btnbilledit','angal.billbrowser.editbill','angal.billbrowser.editbill','x','N','billsmanager','none','N',1),('btnbilldelete','angal.billbrowser.deletebill','angal.billbrowser.deletebill','x','N','billsmanager','none','N',2),('btnbillreport','angal.billbrowser.report','angal.billbrowser.report','x','N','billsmanager','none','N',3),('vaccinetype','angal.menu.btn.vaccinetype','angal.menu.vaccinetype','x','V','types','org.isf.vactype.gui.VaccineTypeBrowser','N',12),('patientvaccine','angal.menu.btn.patientvaccine','angal.menu.patientvaccine','x','V','main','org.isf.patvac.gui.PatVacBrowser','N',7),('btnpatientvaccinenew','angal.common.new','angal.common.new','x','N','patientvaccine','none','N',0),('btnpatientvaccineedit','angal.common.edit','angal.common.edit','x','E','patientvaccine','none','N',1),('btnpatientvaccinedel','angal.common.delete','angal.common.delete','x','D','patientvaccine','none','N',2),('communication','angal.menu.btn.chat','angal.menu.chat','x','M','main','org.isf.xmpp.gui.CommunicationFrame','N',10),('btnadmbill','angal.menu.btn.btnadmbill','angal.menu.btnadmbill','x','R','admission','none','N',4),('btnbillreceipt','angal.menu.btn.btnbillreceipt','angal.menu.btnbillreceipt','x','R','billsmanager','none','N',4),('btnadmpatientfolder','angal.admission.patientfolder','angal.admission.patientfolder','x','P','admission','none','Y',6),('btnopdnewexamination','angal.opd.examination','angal.opd.examination','x','A','btnopdnew','none','N',1),('btnopdeditexamination','angal.opd.examination','angal.opd.examination','x','A','btnopdedit','none','N',1),('btnadmadmexamination','angal.admission.examination','angal.admission.examination','x','A','btnadmadm','none','N',1),('btnadmexamination','angal.admission.examination','angal.admission.examination','x','A','admission','none','N',1),('supplier','angal.menu.btn.supplier','angal.menu.supplier','x','S','generaldata','org.isf.supplier.gui.SupplierBrowser','N',8),('btnpatfoldopdrpt','angal.menu.btn.opdchart','angal.menu.opdchart','x','O','btnadmpatientfolder','none','N',1),('btnpatfoldadmrpt','angal.menu.btn.admchart','angal.menu.admchart','x','A','btnadmpatientfolder','none','N',2),('btnpatfoldpatrpt','angal.menu.btn.patreport','angal.menu.patreport','x','R','btnadmpatientfolder','none','N',3),('btnpatfolddicom','angal.menu.btn.dicom','angal.menu.dicom','x','D','btnadmpatientfolder','none','N',4),('smsmanager','angal.menu.btn.smsmanager','angal.menu.smsmanager','x','M','generaldata','org.isf.sms.gui.SmsBrowser','N',9),('btnpharmstockcharge','angal.menu.btn.btnpharmstockcharge','angal.menu.btnpharmstockcharge','x','C','medicalstock','none','N',1),('btnpharmstockdischarge','angal.menu.btn.btnpharmstockdischarge','angal.menu.btnpharmstockdischarge','x','D','medicalstock','none','N',2),('btnmedicalswardreport','angal.menu.btn.btnmedicalswardreport','angal.menu.btnmedicalswardreport','x','P','medicalsward','none','N',2),('btnmedicalswardexcel','angal.menu.btn.btnmedicalswardexcel','angal.menu.btnmedicalswardexcel','x','E','medicalsward','none','N',3),('btnmedicalswardrectify','angal.menu.btn.btnmedicalswardrectify','angal.menu.btnmedicalswardrectify','x','R','medicalsward','none','N',1),('dicomtype','angal.menu.btn.dicomtype','angal.menu.dicomtype','x','X','types','org.isf.dicomtype.gui.DicomTypeBrowser','N',13),('btnopdnewoperation','angal.opd.operation','angal.opd.operation','x','A','btnopdnew','none','N',2),('btnopdeditoperation','angal.opd.operation','angal.opd.operation','x','A','btnopdedit','none','N',2),('worksheet','angal.menu.btn.worksheet','angal.menu.worksheet','x','W','main','org.isf.visits.gui.VisitView','N',8);
/*!40000 ALTER TABLE `menuitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `opd`
--

DROP TABLE IF EXISTS `opd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `opd` (
  `OPD_ID` int(11) NOT NULL AUTO_INCREMENT,
  `OPD_DATE` datetime NOT NULL,
  `OPD_NEW_PAT` char(1) NOT NULL DEFAULT 'N',
  `OPD_DATE_VIS` date NOT NULL,
  `OPD_PROG_YEAR` int(11) NOT NULL,
  `OPD_SEX` char(1) NOT NULL,
  `OPD_AGE` int(11) NOT NULL DEFAULT '0',
  `OPD_DIS_ID_A` varchar(10) DEFAULT NULL,
  `OPD_DIS_ID_A_2` varchar(10) DEFAULT NULL,
  `OPD_DIS_ID_A_3` varchar(10) DEFAULT NULL,
  `OPD_REFERRAL_FROM` varchar(1) DEFAULT NULL,
  `OPD_REFERRAL_TO` varchar(1) DEFAULT NULL,
  `OPD_NOTE` text NOT NULL,
  `OPD_PAT_ID` int(11) DEFAULT NULL,
  `OPD_USR_ID_A` varchar(50) NOT NULL DEFAULT 'admin',
  `OPD_LOCK` int(11) NOT NULL DEFAULT '0',
  `OPD_CREATED_BY` varchar(50) DEFAULT NULL,
  `OPD_DATE_NEXT_VIS` datetime DEFAULT NULL,
  `OPD_CREATED_DATE` datetime DEFAULT NULL,
  `OPD_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `OPD_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `OPD_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`OPD_ID`),
  KEY `FK_OPD_DISEASE` (`OPD_DIS_ID_A`),
  KEY `FK_OPD_DISEASE_2` (`OPD_DIS_ID_A_2`),
  KEY `FK_OPD_DISEASE_3` (`OPD_DIS_ID_A_3`),
  KEY `FK_OPD_PATIENT` (`OPD_PAT_ID`),
  CONSTRAINT `FK_OPD_DISEASE` FOREIGN KEY (`OPD_DIS_ID_A`) REFERENCES `disease` (`DIS_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OPD_DISEASE_2` FOREIGN KEY (`OPD_DIS_ID_A_2`) REFERENCES `disease` (`DIS_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OPD_DISEASE_3` FOREIGN KEY (`OPD_DIS_ID_A_3`) REFERENCES `disease` (`DIS_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_OPD_PATIENT` FOREIGN KEY (`OPD_PAT_ID`) REFERENCES `patient` (`PAT_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `opd`
--

LOCK TABLES `opd` WRITE;
/*!40000 ALTER TABLE `opd` DISABLE KEYS */;
/*!40000 ALTER TABLE `opd` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operation`
--

DROP TABLE IF EXISTS `operation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operation` (
  `OPE_ID_A` varchar(10) NOT NULL,
  `OPE_OCL_ID_A` char(2) NOT NULL,
  `OPE_DESC` varchar(50) NOT NULL,
  `OPE_STAT` int(11) NOT NULL DEFAULT '0',
  `OPE_FOR` char(1) DEFAULT '1' COMMENT '''1'' = OPD/IPD, ''2'' = IPD only, ''3'' = OPD only',
  `OPE_LOCK` int(11) NOT NULL DEFAULT '0',
  `OPE_CREATED_BY` varchar(50) DEFAULT NULL,
  `OPE_CREATED_DATE` datetime DEFAULT NULL,
  `OPE_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `OPE_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `OPE_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`OPE_ID_A`),
  KEY `FK_OPERATION_OPERATIONTYPE` (`OPE_OCL_ID_A`),
  CONSTRAINT `FK_OPERATION_OPERATIONTYPE` FOREIGN KEY (`OPE_OCL_ID_A`) REFERENCES `operationtype` (`OCL_ID_A`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operation`
--

LOCK TABLES `operation` WRITE;
/*!40000 ALTER TABLE `operation` DISABLE KEYS */;
INSERT INTO `operation` VALUES ('1','OB','Caesarian section',1,'1',0,NULL,NULL,NULL,NULL,1),('10','GY','Acute abdomen',1,'1',0,NULL,NULL,NULL,NULL,1),('11','GY','Ectopic pregnancy',1,'1',0,NULL,NULL,NULL,NULL,1),('12','GY','Peritonitis',1,'1',0,NULL,NULL,NULL,NULL,1),('13','GY','Pelvic abscess',1,'1',0,NULL,NULL,NULL,NULL,1),('14','GY','Uterine fibroids',1,'1',0,NULL,NULL,NULL,NULL,1),('15','GY','Ovarian tumours',1,'1',0,NULL,NULL,NULL,NULL,1),('16','GY','Uterine prolapse',1,'1',0,NULL,NULL,NULL,NULL,1),('17','GY','Cystocele',1,'1',0,NULL,NULL,NULL,NULL,1),('18','MG','Circumcision',1,'1',0,NULL,NULL,NULL,NULL,1),('19','MG','Phimosis',1,'1',0,NULL,NULL,NULL,NULL,1),('2','OB','Hysterectomy',1,'1',0,NULL,NULL,NULL,NULL,1),('20','MG','Paraphimosis',1,'1',0,NULL,NULL,NULL,NULL,1),('21','MG','Dorsal slit-paraphimosis',1,'1',0,NULL,NULL,NULL,NULL,1),('22','MG','Uretheral stricture-bougienage',1,'1',0,NULL,NULL,NULL,NULL,1),('23','MG','Hydrocelectomy',1,'1',0,NULL,NULL,NULL,NULL,1),('24','MG','Testicular tumours',1,'1',0,NULL,NULL,NULL,NULL,1),('25','MG','Prostatectomy',1,'1',0,NULL,NULL,NULL,NULL,1),('26','MG','Prostate biopsy',1,'1',0,NULL,NULL,NULL,NULL,1),('27','MG','Bladder biopsy',1,'1',0,NULL,NULL,NULL,NULL,1),('28','AG','Hernia (inguinal & femoral)',1,'1',0,NULL,NULL,NULL,NULL,1),('29','AG','Strangulated',1,'1',0,NULL,NULL,NULL,NULL,1),('3','OB','Ruptured uterus',1,'1',0,NULL,NULL,NULL,NULL,1),('30','AG','Non strangulated',1,'1',0,NULL,NULL,NULL,NULL,1),('31','AG','Epigastrical Hernia',1,'1',0,NULL,NULL,NULL,NULL,1),('32','AG','Intestinal obstruction',1,'1',0,NULL,NULL,NULL,NULL,1),('33','AG','Mechanical',1,'1',0,NULL,NULL,NULL,NULL,1),('34','AG','Volvulus',1,'1',0,NULL,NULL,NULL,NULL,1),('35','AG','Laparotomy',1,'1',0,NULL,NULL,NULL,NULL,1),('36','AG','Penetrating abdominal injuries',1,'1',0,NULL,NULL,NULL,NULL,1),('37','AG','Peritonitis',1,'1',0,NULL,NULL,NULL,NULL,1),('38','AG','Appendicitis',1,'1',0,NULL,NULL,NULL,NULL,1),('39','AG','Cholecystitis',1,'1',0,NULL,NULL,NULL,NULL,1),('4','OB','Injured uterus',1,'1',0,NULL,NULL,NULL,NULL,1),('40','AG','Abdominal Tumours',1,'1',0,NULL,NULL,NULL,NULL,1),('41','OR','Reduction of fractures',1,'1',0,NULL,NULL,NULL,NULL,1),('42','OR','Upper limb',1,'1',0,NULL,NULL,NULL,NULL,1),('43','OR','Lower limb',1,'1',0,NULL,NULL,NULL,NULL,1),('44','OR','Osteomyelitis - sequestrectomy',1,'1',0,NULL,NULL,NULL,NULL,1),('45','OS','Incision & Drainage',1,'1',0,NULL,NULL,NULL,NULL,1),('46','OS','Debridement',1,'1',0,NULL,NULL,NULL,NULL,1),('47','OS','Mise -a- plat',1,'1',0,NULL,NULL,NULL,NULL,1),('48','OS','Surgical toilet  & suture',1,'1',0,NULL,NULL,NULL,NULL,1),('5','OB','Evacuations',1,'1',0,NULL,NULL,NULL,NULL,1),('6','OB','Incomplete abortion',1,'1',0,NULL,NULL,NULL,NULL,1),('7','OB','Septic abortion',1,'1',0,NULL,NULL,NULL,NULL,1),('8','OB','Dilatation and curettage',1,'1',0,NULL,NULL,NULL,NULL,1),('9','OB','Repair of vesico-vaginal fistula (vvf)',1,'1',0,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `operation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operationrow`
--

DROP TABLE IF EXISTS `operationrow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operationrow` (
  `OPER_ID_A` int(11) NOT NULL AUTO_INCREMENT,
  `OPER_ID` varchar(11) NOT NULL,
  `OPER_PRESCRIBER` varchar(150) NOT NULL,
  `OPER_RESULT` varchar(250) NOT NULL,
  `OPER_OPDATE` datetime NOT NULL,
  `OPER_REMARKS` varchar(250) NOT NULL,
  `OPER_ADMISSION_ID` int(11) DEFAULT '0',
  `OPER_OPD_ID` int(11) DEFAULT '0',
  `OPER_BILL_ID` int(11) DEFAULT '0',
  `OPER_TRANS_UNIT` float DEFAULT '0',
  `OPER_CREATED_BY` varchar(50) DEFAULT NULL,
  `OPER_CREATED_DATE` datetime DEFAULT NULL,
  `OPER_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `OPER_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `OPER_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`OPER_ID_A`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operationrow`
--

LOCK TABLES `operationrow` WRITE;
/*!40000 ALTER TABLE `operationrow` DISABLE KEYS */;
/*!40000 ALTER TABLE `operationrow` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operationtype`
--

DROP TABLE IF EXISTS `operationtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operationtype` (
  `OCL_ID_A` char(2) NOT NULL,
  `OCL_DESC` varchar(50) NOT NULL,
  `OCL_TYPE` varchar(20) NOT NULL DEFAULT 'MAJOR',
  `OCL_CREATED_BY` varchar(50) DEFAULT NULL,
  `OCL_CREATED_DATE` datetime DEFAULT NULL,
  `OCL_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `OCL_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `OCL_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`OCL_ID_A`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operationtype`
--

LOCK TABLES `operationtype` WRITE;
/*!40000 ALTER TABLE `operationtype` DISABLE KEYS */;
INSERT INTO `operationtype` VALUES ('AG','ABDOMINAL GENERAL SURGERY','MAJOR',NULL,NULL,NULL,NULL,1),('GY','GYNECOLOGICAL','MAJOR',NULL,NULL,NULL,NULL,1),('MG','MALE GENITOURINARY SYSTEM','MAJOR',NULL,NULL,NULL,NULL,1),('OB','OBSTETRICAL','MAJOR',NULL,NULL,NULL,NULL,1),('OR','ORTHOPEDICAL','MAJOR',NULL,NULL,NULL,NULL,1),('OS','OTHERS: SKIN AND SUBCUTANEOUS','MAJOR',NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `operationtype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `PAT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PAT_FNAME` varchar(50) NOT NULL,
  `PAT_SNAME` varchar(50) NOT NULL,
  `PAT_NAME` varchar(100) DEFAULT NULL,
  `PAT_BDATE` date DEFAULT NULL,
  `PAT_AGE` int(11) NOT NULL DEFAULT '0',
  `PAT_AGETYPE` varchar(50) NOT NULL DEFAULT '',
  `PAT_SEX` char(1) NOT NULL,
  `PAT_ADDR` varchar(50) DEFAULT NULL,
  `PAT_CITY` varchar(50) NOT NULL,
  `PAT_NEXT_KIN` varchar(50) DEFAULT NULL,
  `PAT_TELE` varchar(50) DEFAULT NULL,
  `PAT_MOTH_NAME` varchar(50) NOT NULL DEFAULT '',
  `PAT_MOTH` char(1) DEFAULT NULL,
  `PAT_FATH_NAME` varchar(50) NOT NULL DEFAULT '',
  `PAT_FATH` char(1) DEFAULT NULL,
  `PAT_LEDU` char(1) DEFAULT NULL,
  `PAT_ESTA` char(1) DEFAULT NULL,
  `PAT_PTOGE` char(1) DEFAULT NULL,
  `PAT_NOTE` text,
  `PAT_DELETED` char(1) NOT NULL DEFAULT 'N',
  `PAT_LOCK` int(11) NOT NULL DEFAULT '0',
  `PAT_BTYPE` varchar(15) NOT NULL DEFAULT 'Unknown',
  `PAT_TAXCODE` varchar(30) DEFAULT '',
  `PAT_TIMESTAMP` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `PAT_CREATED_BY` varchar(50) DEFAULT NULL,
  `PAT_CREATED_DATE` datetime DEFAULT NULL,
  `PAT_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `PAT_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `PAT_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  `PAT_PROFESSION` varchar(50) NOT NULL DEFAULT 'unknown',
  `PAT_MAR_STAT` varchar(50) NOT NULL DEFAULT 'unknown',
  `PROFILE_PHOTO_ID` int(11) DEFAULT NULL,
  PRIMARY KEY (`PAT_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (0,'Patient','Null','Null Patient',NULL,0,'-','U','-','-','-','-','-','U','-','U',NULL,'U','U','-','Y',0,'-','-','2020-11-13 00:32:48',NULL,NULL,NULL,NULL,1,'unknown','unknown',NULL);
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_profile_photo`
--

DROP TABLE IF EXISTS `patient_profile_photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_profile_photo` (
  `PAT_PROFILE_PHOTO_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PAT_PHOTO` blob,
  PRIMARY KEY (`PAT_PROFILE_PHOTO_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_profile_photo`
--

LOCK TABLES `patient_profile_photo` WRITE;
/*!40000 ALTER TABLE `patient_profile_photo` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_profile_photo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patientexamination`
--

DROP TABLE IF EXISTS `patientexamination`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patientexamination` (
  `PEX_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PEX_DATE` datetime NOT NULL,
  `PEX_PAT_ID` int(11) NOT NULL,
  `PEX_HEIGHT` int(11) DEFAULT NULL COMMENT 'Height in cm',
  `PEX_WEIGHT` double DEFAULT NULL COMMENT 'Weight in Kg',
  `PEX_AP_MIN` int(11) DEFAULT NULL COMMENT 'Blood Pressure MIN in mmHg',
  `PEX_AP_MAX` int(11) DEFAULT NULL COMMENT 'Blood Pressure MAX in mmHg',
  `PEX_HR` int(11) DEFAULT NULL COMMENT 'Heart Rate in APm',
  `PEX_TEMP` double DEFAULT NULL COMMENT 'Temperature in °C',
  `PEX_SAT` double DEFAULT NULL COMMENT 'Saturation in %',
  `PEX_HGT` int(3) DEFAULT NULL COMMENT 'Hemo Glucose Test',
  `PEX_DIURESIS` int(11) DEFAULT NULL COMMENT 'Daily Urine Volume in ml',
  `PEX_DIURESIS_DESC` varchar(45) DEFAULT NULL COMMENT 'Diuresis: physiological, oliguria, anuria, fequent, nocturia, stranguria, hematuria, pyuria',
  `PEX_BOWEL_DESC` varchar(45) DEFAULT NULL COMMENT 'Bowel Function: regular, irregular, constipation, diarrheal',
  `PEX_RR` int(11) DEFAULT NULL COMMENT 'Respiratory rate in bpm',
  `PEX_AUSC` varchar(50) DEFAULT NULL COMMENT 'Auscultation: normal, wheezes, rhonchi, crackles, stridor, bronchial',
  `PEX_NOTE` varchar(300) DEFAULT NULL,
  `PEX_CREATED_BY` varchar(50) DEFAULT NULL,
  `PEX_CREATED_DATE` datetime DEFAULT NULL,
  `PEX_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `PEX_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `PEX_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`PEX_ID`),
  KEY `PEX_PAT_ID` (`PEX_PAT_ID`),
  CONSTRAINT `FK_PATIENTEXAMINATION_PATIENT` FOREIGN KEY (`PEX_PAT_ID`) REFERENCES `patient` (`PAT_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patientexamination`
--

LOCK TABLES `patientexamination` WRITE;
/*!40000 ALTER TABLE `patientexamination` DISABLE KEYS */;
/*!40000 ALTER TABLE `patientexamination` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patientvaccine`
--

DROP TABLE IF EXISTS `patientvaccine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patientvaccine` (
  `PAV_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PAV_YPROG` int(11) NOT NULL,
  `PAV_DATE` datetime NOT NULL,
  `PAV_PAT_ID` int(11) NOT NULL,
  `PAV_VAC_ID_A` varchar(10) NOT NULL,
  `PAV_LOCK` int(11) NOT NULL DEFAULT '0',
  `PAV_CREATED_BY` varchar(50) DEFAULT NULL,
  `PAV_CREATED_DATE` datetime DEFAULT NULL,
  `PAV_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `PAV_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `PAV_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`PAV_ID`),
  KEY `FK_PATIENTVACCINE_PATIENT` (`PAV_PAT_ID`),
  KEY `FK_PATIENTVACCINE_VACCINE` (`PAV_VAC_ID_A`),
  CONSTRAINT `FK_PATIENTVACCINE_PATIENT` FOREIGN KEY (`PAV_PAT_ID`) REFERENCES `patient` (`PAT_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_PATIENTVACCINE_VACCINE` FOREIGN KEY (`PAV_VAC_ID_A`) REFERENCES `vaccine` (`VAC_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patientvaccine`
--

LOCK TABLES `patientvaccine` WRITE;
/*!40000 ALTER TABLE `patientvaccine` DISABLE KEYS */;
/*!40000 ALTER TABLE `patientvaccine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pregnanttreatmenttype`
--

DROP TABLE IF EXISTS `pregnanttreatmenttype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pregnanttreatmenttype` (
  `PTT_ID_A` varchar(10) NOT NULL,
  `PTT_DESC` varchar(50) NOT NULL,
  `PTT_CREATED_BY` varchar(50) DEFAULT NULL,
  `PTT_CREATED_DATE` datetime DEFAULT NULL,
  `PTT_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `PTT_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `PTT_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`PTT_ID_A`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pregnanttreatmenttype`
--

LOCK TABLES `pregnanttreatmenttype` WRITE;
/*!40000 ALTER TABLE `pregnanttreatmenttype` DISABLE KEYS */;
INSERT INTO `pregnanttreatmenttype` VALUES ('A','ANC RE-ATTENDANCE',NULL,NULL,NULL,NULL,1),('I1','IMMUNISATION 1',NULL,NULL,NULL,NULL,1),('I2','IMMUNISATION 2',NULL,NULL,NULL,NULL,1),('I3','IMMUNISATION 3',NULL,NULL,NULL,NULL,1),('N','NEW ANC ATTENDANCE',NULL,NULL,NULL,NULL,1),('S1','FIRST DOSE WITH SP',NULL,NULL,NULL,NULL,1),('S2','SECOND DOSE WITH SP',NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `pregnanttreatmenttype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pricelists`
--

DROP TABLE IF EXISTS `pricelists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pricelists` (
  `LST_ID` int(11) NOT NULL AUTO_INCREMENT,
  `LST_CODE` varchar(7) NOT NULL,
  `LST_NAME` varchar(50) NOT NULL,
  `LST_DESC` varchar(100) NOT NULL,
  `LST_CURRENCY` varchar(10) NOT NULL,
  `LST_CREATED_BY` varchar(50) DEFAULT NULL,
  `LST_CREATED_DATE` datetime DEFAULT NULL,
  `LST_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `LST_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `LST_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`LST_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pricelists`
--

LOCK TABLES `pricelists` WRITE;
/*!40000 ALTER TABLE `pricelists` DISABLE KEYS */;
INSERT INTO `pricelists` VALUES (1,'LIST001','Basic','Basic price list','',NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `pricelists` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices`
--

DROP TABLE IF EXISTS `prices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prices` (
  `PRC_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PRC_LST_ID` int(11) NOT NULL,
  `PRC_GRP` char(3) NOT NULL,
  `PRC_ITEM` varchar(10) NOT NULL,
  `PRC_DESC` varchar(100) NOT NULL,
  `PRC_PRICE` double NOT NULL,
  `PRC_CREATED_BY` varchar(50) DEFAULT NULL,
  `PRC_CREATED_DATE` datetime DEFAULT NULL,
  `PRC_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `PRC_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `PRC_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`PRC_ID`),
  KEY `FK_PRICES_PRICELISTS` (`PRC_LST_ID`),
  CONSTRAINT `FK_PRICES_PRICELISTS` FOREIGN KEY (`PRC_LST_ID`) REFERENCES `pricelists` (`LST_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=497 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices`
--

LOCK TABLES `prices` WRITE;
/*!40000 ALTER TABLE `prices` DISABLE KEYS */;
INSERT INTO `prices` VALUES (1,1,'EXA','01.01','1.1 HB',0,NULL,NULL,NULL,NULL,1),(2,1,'EXA','01.01.01','1.1 HB (Procedure 3)',0,NULL,NULL,NULL,NULL,1),(3,1,'EXA','01.02','1.2 WBC Count',0,NULL,NULL,NULL,NULL,1),(4,1,'EXA','01.03','1.3 Differential ',0,NULL,NULL,NULL,NULL,1),(5,1,'EXA','01.04','1.4 Film Comment',0,NULL,NULL,NULL,NULL,1),(6,1,'EXA','01.05','1.5 ESR',0,NULL,NULL,NULL,NULL,1),(7,1,'EXA','01.06','1.6 Sickling Test',0,NULL,NULL,NULL,NULL,1),(8,1,'EXA','02.01','2.1 Grouping',0,NULL,NULL,NULL,NULL,1),(9,1,'EXA','02.02','2.2 Comb\'s Test',0,NULL,NULL,NULL,NULL,1),(10,1,'EXA','03.01','3.1 Blood Slide (Malaria)',0,NULL,NULL,NULL,NULL,1),(11,1,'EXA','03.02','3.2 Blood Slide (OTHERS, E.G. TRIUPHANOSOMIAS, MICRIFILARIA, LEISHMANIA, BORRELIA)',0,NULL,NULL,NULL,NULL,1),(12,1,'EXA','03.02.1','3.21 Trypanosomiasis',0,NULL,NULL,NULL,NULL,1),(13,1,'EXA','03.02.2','3.22 MICROFILARIA',0,NULL,NULL,NULL,NULL,1),(14,1,'EXA','03.02.3','3.23 LEISHMANIA',0,NULL,NULL,NULL,NULL,1),(15,1,'EXA','03.02.4','3.24 BORRELIA',0,NULL,NULL,NULL,NULL,1),(16,1,'EXA','03.03','3.3 STOOL MICROSCOPY',0,NULL,NULL,NULL,NULL,1),(17,1,'EXA','03.04','3.4 URINE MICROSCOPY',0,NULL,NULL,NULL,NULL,1),(18,1,'EXA','03.05','3.5 TISSUE MICROSCOPY',0,NULL,NULL,NULL,NULL,1),(19,1,'EXA','03.06','3.6 CSF WET PREP',0,NULL,NULL,NULL,NULL,1),(20,1,'EXA','04.01','4.1 CULTURE AND SENSITIVITY (C&S) FOR HAEMOPHILUS INFUENZA TYPE B',0,NULL,NULL,NULL,NULL,1),(21,1,'EXA','04.02','4.2 C&S FOR SALMONELA TYPHI',0,NULL,NULL,NULL,NULL,1),(22,1,'EXA','04.03','4.3 C&S FOR VIBRO CHOLERA',0,NULL,NULL,NULL,NULL,1),(23,1,'EXA','04.04','4.4 C&S FOR SHIGELLA DYSENTERIAE',0,NULL,NULL,NULL,NULL,1),(24,1,'EXA','04.05','4.5 C&S FOR NEISSERIA MENINGITIDES',0,NULL,NULL,NULL,NULL,1),(25,1,'EXA','04.06','4.6 OTHER C&S ',0,NULL,NULL,NULL,NULL,1),(26,1,'EXA','05.01','5.1 WET PREP',0,NULL,NULL,NULL,NULL,1),(27,1,'EXA','05.02','5.2 GRAM STAIN',0,NULL,NULL,NULL,NULL,1),(28,1,'EXA','05.03','5.3 INDIA INK',0,NULL,NULL,NULL,NULL,1),(29,1,'EXA','05.04','5.4 LEISMANIA',0,NULL,NULL,NULL,NULL,1),(30,1,'EXA','05.05','5.5 ZN',0,NULL,NULL,NULL,NULL,1),(31,1,'EXA','05.06','5.6 WAYSON',0,NULL,NULL,NULL,NULL,1),(32,1,'EXA','05.07','5.7 PAP SMEAR',0,NULL,NULL,NULL,NULL,1),(33,1,'EXA','06.01','6.1 VDRL/RPR',0,NULL,NULL,NULL,NULL,1),(34,1,'EXA','06.02','6.2 TPHA',0,NULL,NULL,NULL,NULL,1),(35,1,'EXA','06.03','6.3 HIV',0,NULL,NULL,NULL,NULL,1),(36,1,'EXA','06.04','6.4 HEPATITIS',0,NULL,NULL,NULL,NULL,1),(37,1,'EXA','06.05','6.5 OTHERS E.G BRUCELLA, RHEUMATOID FACTOR, WEIL FELIX',0,NULL,NULL,NULL,NULL,1),(38,1,'EXA','06.06','6.6 PREGANCY TEST',0,NULL,NULL,NULL,NULL,1),(39,1,'EXA','07.01','7.1 PROTEIN',0,NULL,NULL,NULL,NULL,1),(40,1,'EXA','07.02','7.2 SUGAR',0,NULL,NULL,NULL,NULL,1),(41,1,'EXA','07.03','7.3 LFTS',0,NULL,NULL,NULL,NULL,1),(42,1,'EXA','07.03.1','7.3.1 BILIRUBIN TOTAL',0,NULL,NULL,NULL,NULL,1),(43,1,'EXA','07.03.2','7.3.2 BILIRUBIN DIRECT',0,NULL,NULL,NULL,NULL,1),(44,1,'EXA','07.03.3','7.3.3 GOT',0,NULL,NULL,NULL,NULL,1),(45,1,'EXA','07.03.4','7.3.4 ALT/GPT',0,NULL,NULL,NULL,NULL,1),(46,1,'EXA','07.04','7.4 RFTS',0,NULL,NULL,NULL,NULL,1),(47,1,'EXA','07.04.1','7.4.1 CREATININA',0,NULL,NULL,NULL,NULL,1),(48,1,'EXA','07.04.2','7.4.2 UREA',0,NULL,NULL,NULL,NULL,1),(49,1,'EXA','08.01','8.1 OCCULT BLOOD',0,NULL,NULL,NULL,NULL,1),(50,1,'EXA','09.01','9.1 URINALYSIS',0,NULL,NULL,NULL,NULL,1),(51,1,'OPE','40','Abdominal Tumours',0,NULL,NULL,NULL,NULL,1),(52,1,'OPE','10','Acute abdomen',0,NULL,NULL,NULL,NULL,1),(53,1,'OPE','38','Appendicitis',0,NULL,NULL,NULL,NULL,1),(54,1,'OPE','27','Bladder biopsy',0,NULL,NULL,NULL,NULL,1),(55,1,'OPE','1','Caesarian section',0,NULL,NULL,NULL,NULL,1),(56,1,'OPE','39','Cholecystitis',0,NULL,NULL,NULL,NULL,1),(57,1,'OPE','18','Circumcision',0,NULL,NULL,NULL,NULL,1),(58,1,'OPE','17','Cystocele',0,NULL,NULL,NULL,NULL,1),(59,1,'OPE','46','Debridement',0,NULL,NULL,NULL,NULL,1),(60,1,'OPE','8','Dilatation and curettage',0,NULL,NULL,NULL,NULL,1),(61,1,'OPE','21','Dorsal slit-paraphimosis',0,NULL,NULL,NULL,NULL,1),(62,1,'OPE','11','Ectopic pregnancy',0,NULL,NULL,NULL,NULL,1),(63,1,'OPE','31','Epigastrical Hernia',0,NULL,NULL,NULL,NULL,1),(64,1,'OPE','5','Evacuations',0,NULL,NULL,NULL,NULL,1),(65,1,'OPE','28','Hernia (inguinal & femoral)',0,NULL,NULL,NULL,NULL,1),(66,1,'OPE','23','Hydrocelectomy',0,NULL,NULL,NULL,NULL,1),(67,1,'OPE','2','Hysterectomy',0,NULL,NULL,NULL,NULL,1),(68,1,'OPE','45','Incision & Drainage',0,NULL,NULL,NULL,NULL,1),(69,1,'OPE','6','Incomplete abortion',0,NULL,NULL,NULL,NULL,1),(70,1,'OPE','4','Injured uterus',0,NULL,NULL,NULL,NULL,1),(71,1,'OPE','32','Intestinal obstruction',0,NULL,NULL,NULL,NULL,1),(72,1,'OPE','35','Laparotomy',0,NULL,NULL,NULL,NULL,1),(73,1,'OPE','43','Lower limb',0,NULL,NULL,NULL,NULL,1),(74,1,'OPE','33','Mechanical',0,NULL,NULL,NULL,NULL,1),(75,1,'OPE','47','Mise -a- plat',0,NULL,NULL,NULL,NULL,1),(76,1,'OPE','30','Non strangulated',0,NULL,NULL,NULL,NULL,1),(77,1,'OPE','44','Osteomyelitis - sequestrectomy',0,NULL,NULL,NULL,NULL,1),(78,1,'OPE','15','Ovarian tumours',0,NULL,NULL,NULL,NULL,1),(79,1,'OPE','20','Paraphimosis',0,NULL,NULL,NULL,NULL,1),(80,1,'OPE','13','Pelvic abscess',0,NULL,NULL,NULL,NULL,1),(81,1,'OPE','36','Penetrating abdominal injuries',0,NULL,NULL,NULL,NULL,1),(82,1,'OPE','12','Peritonitis',0,NULL,NULL,NULL,NULL,1),(83,1,'OPE','37','Peritonitis',0,NULL,NULL,NULL,NULL,1),(84,1,'OPE','19','Phimosis',0,NULL,NULL,NULL,NULL,1),(85,1,'OPE','26','Prostate biopsy',0,NULL,NULL,NULL,NULL,1),(86,1,'OPE','25','Prostatectomy',0,NULL,NULL,NULL,NULL,1),(87,1,'OPE','41','Reduction of fractures',0,NULL,NULL,NULL,NULL,1),(88,1,'OPE','9','Repair of vesico-vaginal fistula (vvf)',0,NULL,NULL,NULL,NULL,1),(89,1,'OPE','3','Ruptured uterus',0,NULL,NULL,NULL,NULL,1),(90,1,'OPE','7','Septic abortion',0,NULL,NULL,NULL,NULL,1),(91,1,'OPE','29','Strangulated',0,NULL,NULL,NULL,NULL,1),(92,1,'OPE','48','Surgical toilet  & suture',0,NULL,NULL,NULL,NULL,1),(93,1,'OPE','24','Testicular tumours',0,NULL,NULL,NULL,NULL,1),(94,1,'OPE','42','Upper limb',0,NULL,NULL,NULL,NULL,1),(95,1,'OPE','22','Uretheral stricture-bougienage',0,NULL,NULL,NULL,NULL,1),(96,1,'OPE','14','Uterine fibroids',0,NULL,NULL,NULL,NULL,1),(97,1,'OPE','16','Uterine prolapse',0,NULL,NULL,NULL,NULL,1),(98,1,'OPE','34','Volvulus',0,NULL,NULL,NULL,NULL,1),(99,1,'MED','24','4 Dimethyl Aminobenzaldelyde',0,NULL,NULL,NULL,NULL,1),(100,1,'MED','98','Acetazolamide 250mg Tab',0,NULL,NULL,NULL,NULL,1),(101,1,'MED','2','Acetic Acid Glacial 1 ltr',0,NULL,NULL,NULL,NULL,1),(102,1,'MED','3','Aceton 99% 1ltr',0,NULL,NULL,NULL,NULL,1),(103,1,'MED','100','Aciclovir',0,NULL,NULL,NULL,NULL,1),(104,1,'MED','99','Acyclovir 200mg Tab',0,NULL,NULL,NULL,NULL,1),(105,1,'MED','258','Adhesive Tape 2.5cm x 5m',0,NULL,NULL,NULL,NULL,1),(106,1,'MED','259','Adhesive Tape 7.5cm x 5m',0,NULL,NULL,NULL,NULL,1),(107,1,'MED','40','Adrenaline 1mg/ml 1ml Amp',0,NULL,NULL,NULL,NULL,1),(108,1,'MED','311','Air ring set 43x15cm, rubber with pump',0,NULL,NULL,NULL,NULL,1),(109,1,'MED','253','Airway Guedel Size 0',0,NULL,NULL,NULL,NULL,1),(110,1,'MED','252','Airway Guedel Size 00',0,NULL,NULL,NULL,NULL,1),(111,1,'MED','254','Airway Guedel Size 1',0,NULL,NULL,NULL,NULL,1),(112,1,'MED','255','Airway Guedel Size 2',0,NULL,NULL,NULL,NULL,1),(113,1,'MED','256','Airway Guedel Size 3',0,NULL,NULL,NULL,NULL,1),(114,1,'MED','103','Albendazole 200mg Tab',0,NULL,NULL,NULL,NULL,1),(115,1,'MED','102','Albendazole 400mg Tab',0,NULL,NULL,NULL,NULL,1),(116,1,'MED','178','Alcohol 95% not denatured 20Ltrs',0,NULL,NULL,NULL,NULL,1),(117,1,'MED','101','Aminophylline 100mg Tab',0,NULL,NULL,NULL,NULL,1),(118,1,'MED','41','Aminophylline 25mg/ml,10ml Amp',0,NULL,NULL,NULL,NULL,1),(119,1,'MED','104','Amitriptyline 25mg Tab',0,NULL,NULL,NULL,NULL,1),(120,1,'MED','23','Ammonium Oxalate',0,NULL,NULL,NULL,NULL,1),(121,1,'MED','106','Amoxicillin /Clavulanate 375mg Tab',0,NULL,NULL,NULL,NULL,1),(122,1,'MED','207','Amoxicillin 125mg/5ml Powd. Susp 100ml',0,NULL,NULL,NULL,NULL,1),(123,1,'MED','105','Amoxicillin 250mg Caps',0,NULL,NULL,NULL,NULL,1),(124,1,'MED','42','Amphotericin B 50mg Vial',0,NULL,NULL,NULL,NULL,1),(125,1,'MED','43','Ampicillin 500mg Vial',0,NULL,NULL,NULL,NULL,1),(126,1,'MED','223','Anti Serum A 10ml',0,NULL,NULL,NULL,NULL,1),(127,1,'MED','393','Anti Serum AB 10ml',0,NULL,NULL,NULL,NULL,1),(128,1,'MED','392','Anti Serum B 10ml',0,NULL,NULL,NULL,NULL,1),(129,1,'MED','394','Anti Serum D 10ml',0,NULL,NULL,NULL,NULL,1),(130,1,'MED','204','Antihaemorrhoid suppositories',0,NULL,NULL,NULL,NULL,1),(131,1,'MED','333','Apron Plastic Re-usable',0,NULL,NULL,NULL,NULL,1),(132,1,'MED','334','Apron Plastic Re-usable local',0,NULL,NULL,NULL,NULL,1),(133,1,'MED','335','Apron Polythene Disp Non Sterile',0,NULL,NULL,NULL,NULL,1),(134,1,'MED','107','Ascorbic Acid 100mg tab',0,NULL,NULL,NULL,NULL,1),(135,1,'MED','108','Aspirin 300mg Tab',0,NULL,NULL,NULL,NULL,1),(136,1,'MED','110','Atenolol 100mg Tab',0,NULL,NULL,NULL,NULL,1),(137,1,'MED','109','Atenolol 50mg Tab',0,NULL,NULL,NULL,NULL,1),(138,1,'MED','44','Atropine 1mg/ml 1ml Amp',0,NULL,NULL,NULL,NULL,1),(139,1,'MED','390','Barium Sulphate for X-Ray 1kg',0,NULL,NULL,NULL,NULL,1),(140,1,'MED','197','Beclomethasone 50mcg Inhaler',0,NULL,NULL,NULL,NULL,1),(141,1,'MED','305','Bedpan Plastic Autoclavable',0,NULL,NULL,NULL,NULL,1),(142,1,'MED','306','Bedpan Stainless Steel',0,NULL,NULL,NULL,NULL,1),(143,1,'MED','111','Bendrofluazide 5mg Tab',0,NULL,NULL,NULL,NULL,1),(144,1,'MED','45','Benzathine Penicillin 2.4 MIU Vial',0,NULL,NULL,NULL,NULL,1),(145,1,'MED','112','Benzhexol 2mg Tab',0,NULL,NULL,NULL,NULL,1),(146,1,'MED','113','Benzhexol 5mg Tab',0,NULL,NULL,NULL,NULL,1),(147,1,'MED','46','Benzyl Penicillin 1 MIU Vial',0,NULL,NULL,NULL,NULL,1),(148,1,'MED','47','Benzyl Penicillin 5 MIU Vial',0,NULL,NULL,NULL,NULL,1),(149,1,'MED','190','Betamethasone 0.1% eye/ear/nose drops',0,NULL,NULL,NULL,NULL,1),(150,1,'MED','191','Betamethasone 0.1% Neomycin 0.35 %eye drops 7.5ml',0,NULL,NULL,NULL,NULL,1),(151,1,'MED','114','Bisacodyl 5mg Tab',0,NULL,NULL,NULL,NULL,1),(152,1,'MED','224','Blood giving set Disposable',0,NULL,NULL,NULL,NULL,1),(153,1,'MED','225','Blood Transfer Bag 300ml',0,NULL,NULL,NULL,NULL,1),(154,1,'MED','307','Body Bag 70 x 215cm  (Adult)',0,NULL,NULL,NULL,NULL,1),(155,1,'MED','310','Bowl Without Lid 10 x 24cm stainless steel',0,NULL,NULL,NULL,NULL,1),(156,1,'MED','308','Bowl Without Lid 7 x 12cm stainless steel',0,NULL,NULL,NULL,NULL,1),(157,1,'MED','309','Bowl Without Lid 8 x 16cm stainless steel',0,NULL,NULL,NULL,NULL,1),(158,1,'MED','22','Brilliant Cresyl Blue',0,NULL,NULL,NULL,NULL,1),(159,1,'MED','115','Calcium Lactate 300mg Tab',0,NULL,NULL,NULL,NULL,1),(160,1,'MED','116','Carbamazepine 200mg Tab',0,NULL,NULL,NULL,NULL,1),(161,1,'MED','117','Carbimazole 5mg Tab',0,NULL,NULL,NULL,NULL,1),(162,1,'MED','273','Catheter Foley CH10 3 Way Balloon',0,NULL,NULL,NULL,NULL,1),(163,1,'MED','274','Catheter Foley CH12 3 Way Balloon',0,NULL,NULL,NULL,NULL,1),(164,1,'MED','275','Catheter Foley CH14 3 Way Balloon',0,NULL,NULL,NULL,NULL,1),(165,1,'MED','276','Catheter Foley CH16 3 Way Balloon',0,NULL,NULL,NULL,NULL,1),(166,1,'MED','277','Catheter Foley CH18 3 Way Balloon',0,NULL,NULL,NULL,NULL,1),(167,1,'MED','271','Catheter Foley CH20 3 Way Balloon',0,NULL,NULL,NULL,NULL,1),(168,1,'MED','272','Catheter Foley CH8 3 Way Balloon',0,NULL,NULL,NULL,NULL,1),(169,1,'MED','278','Catheter Stopper for All sizes',0,NULL,NULL,NULL,NULL,1),(170,1,'MED','118','Charcoal 250mg Tab',0,NULL,NULL,NULL,NULL,1),(171,1,'MED','192','Chloramphenicol 0.5% Eye Drops 10ml',0,NULL,NULL,NULL,NULL,1),(172,1,'MED','209','Chloramphenicol 125mg/5ml Susp 100ml',0,NULL,NULL,NULL,NULL,1),(173,1,'MED','208','Chloramphenicol 125mg/5ml Susp 3Ltr',0,NULL,NULL,NULL,NULL,1),(174,1,'MED','48','Chloramphenicol 1g Vial',0,NULL,NULL,NULL,NULL,1),(175,1,'MED','119','Chloramphenicol 250mg Caps',0,NULL,NULL,NULL,NULL,1),(176,1,'MED','179','Chlorhexidine/Cetrimide 1.5/15% 1Ltr',0,NULL,NULL,NULL,NULL,1),(177,1,'MED','180','Chlorhexidine/Cetrimide 1.5/15% 5Ltr',0,NULL,NULL,NULL,NULL,1),(178,1,'MED','49','Chloroquine 40mg Base/ml 5ml Amp',0,NULL,NULL,NULL,NULL,1),(179,1,'MED','121','Chloroquine Coated 150mg Tab',0,NULL,NULL,NULL,NULL,1),(180,1,'MED','120','Chloroquine Uncoated 150mg Tab',0,NULL,NULL,NULL,NULL,1),(181,1,'MED','123','Chlorphenimine 4mg Tab',0,NULL,NULL,NULL,NULL,1),(182,1,'MED','124','Chlorpromazine 100mg Tab',0,NULL,NULL,NULL,NULL,1),(183,1,'MED','125','Chlorpromazine 25mg Tab',0,NULL,NULL,NULL,NULL,1),(184,1,'MED','50','Chlorpromazine 25mg/ml/2ml Amp',0,NULL,NULL,NULL,NULL,1),(185,1,'MED','126','Cimetidine 200mg Tab',0,NULL,NULL,NULL,NULL,1),(186,1,'MED','127','Cimetidine 400mg Tab',0,NULL,NULL,NULL,NULL,1),(187,1,'MED','129','Ciprofloxacine 250mg Tab',0,NULL,NULL,NULL,NULL,1),(188,1,'MED','128','Ciprofloxacine 500mg Tab',0,NULL,NULL,NULL,NULL,1),(189,1,'MED','193','Cloramphenicol 1% Eye Ointment 3.5g',0,NULL,NULL,NULL,NULL,1),(190,1,'MED','202','Clotrimazole 100mg Pessaries',0,NULL,NULL,NULL,NULL,1),(191,1,'MED','201','Clotrimazole 500mg Pessaries',0,NULL,NULL,NULL,NULL,1),(192,1,'MED','130','Cloxacillin 250mg Tab',0,NULL,NULL,NULL,NULL,1),(193,1,'MED','51','Cloxacillin 500mg Vial',0,NULL,NULL,NULL,NULL,1),(194,1,'MED','131','Codein Phosphate 30mg Tab',0,NULL,NULL,NULL,NULL,1),(195,1,'MED','312','Colostomy Bag closed 30mm size 2',0,NULL,NULL,NULL,NULL,1),(196,1,'MED','313','Colostomy Bag closed 30mm size 3',0,NULL,NULL,NULL,NULL,1),(197,1,'MED','314','Colostomy Bag open re-usable 35mm',0,NULL,NULL,NULL,NULL,1),(198,1,'MED','4','Copper 11 Sulphate 500g',0,NULL,NULL,NULL,NULL,1),(199,1,'MED','132','Cotrimoxazole 100/20mg Paed Tab',0,NULL,NULL,NULL,NULL,1),(200,1,'MED','211','Cotrimoxazole 200+40mg/5ml Susp 100ml',0,NULL,NULL,NULL,NULL,1),(201,1,'MED','210','Cotrimoxazole 200+40mg/5ml Susp 3Ltr',0,NULL,NULL,NULL,NULL,1),(202,1,'MED','133','Cotrimoxazole 400/80mg Tab',0,NULL,NULL,NULL,NULL,1),(203,1,'MED','261','Cotton Wool 200G',0,NULL,NULL,NULL,NULL,1),(204,1,'MED','260','cotton Wool 500G',0,NULL,NULL,NULL,NULL,1),(205,1,'MED','395','Creatinine 200ml (Calorimetric)',0,NULL,NULL,NULL,NULL,1),(206,1,'MED','29','Crystal Violet',0,NULL,NULL,NULL,NULL,1),(207,1,'MED','52','Cyclophosphamide 200mg Vial',0,NULL,NULL,NULL,NULL,1),(208,1,'MED','53','Cyclophosphamide 500mg Vial',0,NULL,NULL,NULL,NULL,1),(209,1,'MED','134','Darrows Half Strength 500ml',0,NULL,NULL,NULL,NULL,1),(210,1,'MED','140','Dexamethasone 0.5mg Tab',0,NULL,NULL,NULL,NULL,1),(211,1,'MED','136','Dexamethasone 4mg/ml 1ml Amp',0,NULL,NULL,NULL,NULL,1),(212,1,'MED','135','Dexamethasone 4mg/ml 2ml Amp',0,NULL,NULL,NULL,NULL,1),(213,1,'MED','138','Dextrose 30% IV 100ml',0,NULL,NULL,NULL,NULL,1),(214,1,'MED','137','Dextrose 5% IV 500ml',0,NULL,NULL,NULL,NULL,1),(215,1,'MED','139','Dextrose 50% IV 100ml',0,NULL,NULL,NULL,NULL,1),(216,1,'MED','206','Dextrose Monohydrate Apyrogen 25Kg',0,NULL,NULL,NULL,NULL,1),(217,1,'MED','391','Diatrizoate Meglumin Sod 76% 20ml Amp',0,NULL,NULL,NULL,NULL,1),(218,1,'MED','203','Diazepam 2mg/ml 2.5ml Rectal Tube',0,NULL,NULL,NULL,NULL,1),(219,1,'MED','54','Diazepam 5mg / ml 2ml Amp',0,NULL,NULL,NULL,NULL,1),(220,1,'MED','141','Diazepam 5mg Tab',0,NULL,NULL,NULL,NULL,1),(221,1,'MED','55','Diclofenac 25mg/ml 3ml Amp',0,NULL,NULL,NULL,NULL,1),(222,1,'MED','142','Diclofenac 50mg Tab',0,NULL,NULL,NULL,NULL,1),(223,1,'MED','143','Diethylcarbamazine 50mg Tab',0,NULL,NULL,NULL,NULL,1),(224,1,'MED','144','Digoxin 0.25 mg Tab',0,NULL,NULL,NULL,NULL,1),(225,1,'MED','56','Digoxin 0.25 mg/ml 2ml Amp',0,NULL,NULL,NULL,NULL,1),(226,1,'MED','145','Doxycycline 100mg Tab',0,NULL,NULL,NULL,NULL,1),(227,1,'MED','315','Ear syringe rubber 60ml',0,NULL,NULL,NULL,NULL,1),(228,1,'MED','5','EDTA Di- sodium salt 100g',0,NULL,NULL,NULL,NULL,1),(229,1,'MED','262','Elastic Bandage 10cm x 4.5m',0,NULL,NULL,NULL,NULL,1),(230,1,'MED','263','Elastic Bandage 7.5cm x 4.5m',0,NULL,NULL,NULL,NULL,1),(231,1,'MED','221','Eosin Yellowish',0,NULL,NULL,NULL,NULL,1),(232,1,'MED','146','Ephedrine 30mg Tab',0,NULL,NULL,NULL,NULL,1),(233,1,'MED','147','Erythromycin 250mg Tab',0,NULL,NULL,NULL,NULL,1),(234,1,'MED','6','Ethanol Absolute 1ltr',0,NULL,NULL,NULL,NULL,1),(235,1,'MED','257','Eye Pad Sterile',0,NULL,NULL,NULL,NULL,1),(236,1,'MED','149','Fansidar 500/25mg Tab',0,NULL,NULL,NULL,NULL,1),(237,1,'MED','148','Fansidar 500/25mg Tab (50dosesx3)',0,NULL,NULL,NULL,NULL,1),(238,1,'MED','150','Ferrous Sulphate 200mg Tab',0,NULL,NULL,NULL,NULL,1),(239,1,'MED','218','Field stain A and B',0,NULL,NULL,NULL,NULL,1),(240,1,'MED','316','First Aid kit',0,NULL,NULL,NULL,NULL,1),(241,1,'MED','152','Fluconazole 100mg 24 Caps',0,NULL,NULL,NULL,NULL,1),(242,1,'MED','151','Fluconazole 100mg Tab',0,NULL,NULL,NULL,NULL,1),(243,1,'MED','156','Folic Acid 15mg Tab',0,NULL,NULL,NULL,NULL,1),(244,1,'MED','153','Folic Acid 1mg Tab',0,NULL,NULL,NULL,NULL,1),(245,1,'MED','154','Folic Acid 5mg Tab',0,NULL,NULL,NULL,NULL,1),(246,1,'MED','155','Folic Acid/Ferrous Sulp 0.5/200mg Tab',0,NULL,NULL,NULL,NULL,1),(247,1,'MED','7','Formaldehyde solution 35-38% 1ltr',0,NULL,NULL,NULL,NULL,1),(248,1,'MED','157','Frusemide 40mg Tab',0,NULL,NULL,NULL,NULL,1),(249,1,'MED','57','Furosemide 10mg/ml 2ml Amp',0,NULL,NULL,NULL,NULL,1),(250,1,'MED','318','Gallipot stainless steel 200ml/10cm',0,NULL,NULL,NULL,NULL,1),(251,1,'MED','317','Gallipot stainless steel 300ml/15cm',0,NULL,NULL,NULL,NULL,1),(252,1,'MED','265','Gauze Bandage 10cm x 4m',0,NULL,NULL,NULL,NULL,1),(253,1,'MED','264','Gauze Bandage 7.5cm x 3.65-4m',0,NULL,NULL,NULL,NULL,1),(254,1,'MED','268','Gauze Hydrophylic 90cm x 91cm',0,NULL,NULL,NULL,NULL,1),(255,1,'MED','267','Gauze Pads  Sterile 10cm x 10cm',0,NULL,NULL,NULL,NULL,1),(256,1,'MED','266','Gauze Pads Non Sterile 10cm x 10cm',0,NULL,NULL,NULL,NULL,1),(257,1,'MED','219','Genitian Violet',0,NULL,NULL,NULL,NULL,1),(258,1,'MED','194','Gentamicin 0.3% eye/ear drops 10ml',0,NULL,NULL,NULL,NULL,1),(259,1,'MED','58','Gentamicin 40mg/ml 2ml',0,NULL,NULL,NULL,NULL,1),(260,1,'MED','181','Gentian Violet 25g Tin',0,NULL,NULL,NULL,NULL,1),(261,1,'MED','222','Giemsa Stain',0,NULL,NULL,NULL,NULL,1),(262,1,'MED','158','Glibenclamide 5mg Tab',0,NULL,NULL,NULL,NULL,1),(263,1,'MED','293','Gloves Domestic',0,NULL,NULL,NULL,NULL,1),(264,1,'MED','295','Gloves Gynaecological 7.5-8',0,NULL,NULL,NULL,NULL,1),(265,1,'MED','294','Gloves High risk non sterile Medium',0,NULL,NULL,NULL,NULL,1),(266,1,'MED','297','Gloves Non Sterile Large Disposable',0,NULL,NULL,NULL,NULL,1),(267,1,'MED','296','Gloves Non Sterile Medium Disposable',0,NULL,NULL,NULL,NULL,1),(268,1,'MED','298','Gloves Surgical Sterile 6',0,NULL,NULL,NULL,NULL,1),(269,1,'MED','299','Gloves Surgical Sterile 6.5',0,NULL,NULL,NULL,NULL,1),(270,1,'MED','300','Gloves Surgical Sterile 7',0,NULL,NULL,NULL,NULL,1),(271,1,'MED','301','Gloves Surgical Sterile 7.5',0,NULL,NULL,NULL,NULL,1),(272,1,'MED','302','Gloves Surgical Sterile 8',0,NULL,NULL,NULL,NULL,1),(273,1,'MED','303','Gloves Surgical Sterile 8.5',0,NULL,NULL,NULL,NULL,1),(274,1,'MED','396','Glucose GOD PAD  6 x 100ml (Colorimetric)',0,NULL,NULL,NULL,NULL,1),(275,1,'MED','1','Glucose Test Strip',0,NULL,NULL,NULL,NULL,1),(276,1,'MED','397','Glucose Test Strips (Hyloguard)',0,NULL,NULL,NULL,NULL,1),(277,1,'MED','32','GOT ( AST) 200ml (Calorimetric) AS 147',0,NULL,NULL,NULL,NULL,1),(278,1,'MED','31','GOT ( AST) 200ml has no NAOH) AS 101',0,NULL,NULL,NULL,NULL,1),(279,1,'MED','30','GPT (ALT) 200ml ( Does not have NAOH)',0,NULL,NULL,NULL,NULL,1),(280,1,'MED','159','Griseofulvin 500mg Tab',0,NULL,NULL,NULL,NULL,1),(281,1,'MED','161','Haloperidol 5mg',0,NULL,NULL,NULL,NULL,1),(282,1,'MED','160','Haloperidol 5mg Tab',0,NULL,NULL,NULL,NULL,1),(283,1,'MED','59','Haloperidol 5mg/ml 1ml Amp',0,NULL,NULL,NULL,NULL,1),(284,1,'MED','60','Haloperidol Decanoate 50mg/ml 1ml Amp',0,NULL,NULL,NULL,NULL,1),(285,1,'MED','359','Handle for surgical blade No 3',0,NULL,NULL,NULL,NULL,1),(286,1,'MED','360','Handle for surgical blade No 4',0,NULL,NULL,NULL,NULL,1),(287,1,'MED','33','HIV 1/2 Capillus Kit 100Tests',0,NULL,NULL,NULL,NULL,1),(288,1,'MED','34','HIV Buffer for determine Kit',0,NULL,NULL,NULL,NULL,1),(289,1,'MED','35','HIV Determine 1/11 (Abbott) 100Tests',0,NULL,NULL,NULL,NULL,1),(290,1,'MED','36','HIV UNIGOLD 1/11 Test Kits 20 Tests',0,NULL,NULL,NULL,NULL,1),(291,1,'MED','319','Hot water Bottle 2Ltr',0,NULL,NULL,NULL,NULL,1),(292,1,'MED','61','Hydralazine 20mg Vial',0,NULL,NULL,NULL,NULL,1),(293,1,'MED','162','Hydralazine 25mg Tab',0,NULL,NULL,NULL,NULL,1),(294,1,'MED','8','Hydrochloric Acid 30-33% 1ltr',0,NULL,NULL,NULL,NULL,1),(295,1,'MED','195','Hydrocortisone 1% eye drops 5ml',0,NULL,NULL,NULL,NULL,1),(296,1,'MED','62','Hydrocortisone 100mg Vial',0,NULL,NULL,NULL,NULL,1),(297,1,'MED','182','Hydrogen Peroxide 6% 250ml',0,NULL,NULL,NULL,NULL,1),(298,1,'MED','163','Hyoscine 10mg Tab',0,NULL,NULL,NULL,NULL,1),(299,1,'MED','63','Hyoscine Butyl Bromide 20mg/ml/ Amp',0,NULL,NULL,NULL,NULL,1),(300,1,'MED','164','Ibuprofen 200mg Tab',0,NULL,NULL,NULL,NULL,1),(301,1,'MED','165','Imipramine 25mg Tab',0,NULL,NULL,NULL,NULL,1),(302,1,'MED','166','Indomethacin 25mg Tab',0,NULL,NULL,NULL,NULL,1),(303,1,'MED','351','Insectcide Spray 400g',0,NULL,NULL,NULL,NULL,1),(304,1,'MED','320','Instrument Box With Lid 20x10x5cm',0,NULL,NULL,NULL,NULL,1),(305,1,'MED','321','Instrument Tray 30 x 20 x 2cm',0,NULL,NULL,NULL,NULL,1),(306,1,'MED','65','Insulin Isophane 100IU/ml 10ml Vial',0,NULL,NULL,NULL,NULL,1),(307,1,'MED','68','Insulin Isophane 40IU/ml 10ml',0,NULL,NULL,NULL,NULL,1),(308,1,'MED','66','Insulin Mixtard 30/70 100IU/ml 10ml Vial',0,NULL,NULL,NULL,NULL,1),(309,1,'MED','67','Insulin Mixtard 30/70 100IU/ml 5x3ml catridges',0,NULL,NULL,NULL,NULL,1),(310,1,'MED','64','Insulin Soluble 100IU/ml 10ml Vial',0,NULL,NULL,NULL,NULL,1),(311,1,'MED','226','Insulin Syringe 100IU with Needle G26/29',0,NULL,NULL,NULL,NULL,1),(312,1,'MED','9','Iodine Crystal 100g',0,NULL,NULL,NULL,NULL,1),(313,1,'MED','183','Iodine Solution 2% 500ml',0,NULL,NULL,NULL,NULL,1),(314,1,'MED','69','Iron Dextran 10mg/ml 2ml Vial',0,NULL,NULL,NULL,NULL,1),(315,1,'MED','322','Irrigation can with accessories',0,NULL,NULL,NULL,NULL,1),(316,1,'MED','167','Isoniazid 300mg Tab',0,NULL,NULL,NULL,NULL,1),(317,1,'MED','227','IV Cannula G16 with Port',0,NULL,NULL,NULL,NULL,1),(318,1,'MED','228','IV Cannula G18 with Port',0,NULL,NULL,NULL,NULL,1),(319,1,'MED','229','IV Cannula G20 with Port',0,NULL,NULL,NULL,NULL,1),(320,1,'MED','230','IV Cannula G22 with Port',0,NULL,NULL,NULL,NULL,1),(321,1,'MED','232','IV Cannula G24 with Port',0,NULL,NULL,NULL,NULL,1),(322,1,'MED','231','IV Cannula G24 without Port',0,NULL,NULL,NULL,NULL,1),(323,1,'MED','233','IV Giving set Disposable',0,NULL,NULL,NULL,NULL,1),(324,1,'MED','71','Ketamine 10mg/ml 10ml Vial',0,NULL,NULL,NULL,NULL,1),(325,1,'MED','70','Ketamine 10mg/ml 20ml Vial',0,NULL,NULL,NULL,NULL,1),(326,1,'MED','168','Ketoconazole 200mg Tab',0,NULL,NULL,NULL,NULL,1),(327,1,'MED','325','Kidney Dish Polypropylene 24cm',0,NULL,NULL,NULL,NULL,1),(328,1,'MED','324','Kidney Dish stainless Steel 20cm',0,NULL,NULL,NULL,NULL,1),(329,1,'MED','323','Kidney Dish stainless Steel 24cm',0,NULL,NULL,NULL,NULL,1),(330,1,'MED','376','Lead Apron 100cmx60cm',0,NULL,NULL,NULL,NULL,1),(331,1,'MED','72','Lignocaine 2% 20ml Vial',0,NULL,NULL,NULL,NULL,1),(332,1,'MED','73','Lignocaine 2% Adrenaline Dent.cartridges',0,NULL,NULL,NULL,NULL,1),(333,1,'MED','74','Lignocaine spinal 50mg/ml 2ml Amp',0,NULL,NULL,NULL,NULL,1),(334,1,'MED','187','Liquid detergent 20Ltr',0,NULL,NULL,NULL,NULL,1),(335,1,'MED','185','liquid detergent 5Ltr Perfumed',0,NULL,NULL,NULL,NULL,1),(336,1,'MED','326','Mackintosh Plastic (Apron) per 1m',0,NULL,NULL,NULL,NULL,1),(337,1,'MED','327','Mackintosh Rubber Brown (sheeting) per 1m',0,NULL,NULL,NULL,NULL,1),(338,1,'MED','328','Measuring Cup Graduated 25ml',0,NULL,NULL,NULL,NULL,1),(339,1,'MED','10','Methanol 99% 1ltr',0,NULL,NULL,NULL,NULL,1),(340,1,'MED','75','Methylergomeatrine 0.2mg/ml 1ml Amp',0,NULL,NULL,NULL,NULL,1),(341,1,'MED','76','Methylergomeatrine 0.5mg/ml 1ml Amp',0,NULL,NULL,NULL,NULL,1),(342,1,'MED','77','Metoclopramide 5mg/ml 100ml Amp',0,NULL,NULL,NULL,NULL,1),(343,1,'MED','78','Metronidazole 5mg/ml 2ml IV',0,NULL,NULL,NULL,NULL,1),(344,1,'MED','79','Morphine 15mg/ml 1ml Amp',0,NULL,NULL,NULL,NULL,1),(345,1,'MED','353','Mosquito Net Impregnated Large',0,NULL,NULL,NULL,NULL,1),(346,1,'MED','352','Mosquito Net Impregnated Medium',0,NULL,NULL,NULL,NULL,1),(347,1,'MED','357','Mosquito Net Impregnation Liquid 500ml',0,NULL,NULL,NULL,NULL,1),(348,1,'MED','356','Mosquito Net Impregnation Tablet',0,NULL,NULL,NULL,NULL,1),(349,1,'MED','355','Mosquito Net Non Impregnated Large',0,NULL,NULL,NULL,NULL,1),(350,1,'MED','354','Mosquito Net Non Impregnated Medium',0,NULL,NULL,NULL,NULL,1),(351,1,'MED','358','Mosquito Wall spray Powder 80g',0,NULL,NULL,NULL,NULL,1),(352,1,'MED','282','Nasogastric Tube G10 (Children)',0,NULL,NULL,NULL,NULL,1),(353,1,'MED','283','Nasogastric Tube G14 (Children)',0,NULL,NULL,NULL,NULL,1),(354,1,'MED','284','Nasogastric Tube G16 (Children)',0,NULL,NULL,NULL,NULL,1),(355,1,'MED','279','Nasogastric Tube G5 (Children)',0,NULL,NULL,NULL,NULL,1),(356,1,'MED','281','Nasogastric Tube G6 (Children)',0,NULL,NULL,NULL,NULL,1),(357,1,'MED','280','Nasogastric Tube G8 (Children)',0,NULL,NULL,NULL,NULL,1),(358,1,'MED','331','Neck Support Large',0,NULL,NULL,NULL,NULL,1),(359,1,'MED','330','Neck Support Medium',0,NULL,NULL,NULL,NULL,1),(360,1,'MED','329','Neck Support Small',0,NULL,NULL,NULL,NULL,1),(361,1,'MED','234','Needle container disposable of contaminated',0,NULL,NULL,NULL,NULL,1),(362,1,'MED','366','Needle suture No 5 cutting',0,NULL,NULL,NULL,NULL,1),(363,1,'MED','365','Needle suture No 5 round',0,NULL,NULL,NULL,NULL,1),(364,1,'MED','367','Needle suture No 6 Round',0,NULL,NULL,NULL,NULL,1),(365,1,'MED','235','Needles Luer G20 Disposable',0,NULL,NULL,NULL,NULL,1),(366,1,'MED','236','Needles Luer G21 Disposable',0,NULL,NULL,NULL,NULL,1),(367,1,'MED','237','Needles Luer G22 Disposable',0,NULL,NULL,NULL,NULL,1),(368,1,'MED','238','Needles Luer G23 Disposable',0,NULL,NULL,NULL,NULL,1),(369,1,'MED','239','Needles Spinal G20x75-120mm',0,NULL,NULL,NULL,NULL,1),(370,1,'MED','242','Needles Spinal G22x40mm',0,NULL,NULL,NULL,NULL,1),(371,1,'MED','240','Needles Spinal G22x75-120mm',0,NULL,NULL,NULL,NULL,1),(372,1,'MED','241','Needles Spinal G25x75-120mm',0,NULL,NULL,NULL,NULL,1),(373,1,'MED','220','Neutral Red',0,NULL,NULL,NULL,NULL,1),(374,1,'MED','26','Non 111 Chloride (Ferric chloride)',0,NULL,NULL,NULL,NULL,1),(375,1,'MED','205','Nystatin 100.000 IU Pessaries',0,NULL,NULL,NULL,NULL,1),(376,1,'MED','212','Nystatin 500.000IU/ Susp/ Drops',0,NULL,NULL,NULL,NULL,1),(377,1,'MED','174','Oral Rehydration Salt (ORS)',0,NULL,NULL,NULL,NULL,1),(378,1,'MED','80','Oxytocin 10 IU/ml 1ml Amp',0,NULL,NULL,NULL,NULL,1),(379,1,'MED','176','Paracetamol 120mg/5ml 100ml',0,NULL,NULL,NULL,NULL,1),(380,1,'MED','175','Paracetamol 120mg/5ml Syrup',0,NULL,NULL,NULL,NULL,1),(381,1,'MED','81','Pethidine 100mg/ml 2ml Amp',0,NULL,NULL,NULL,NULL,1),(382,1,'MED','82','Pethidine 50mg/ml 1ml Amp',0,NULL,NULL,NULL,NULL,1),(383,1,'MED','83','Phenobarbital 100mg/ml 2ml Amp',0,NULL,NULL,NULL,NULL,1),(384,1,'MED','11','Phenol crystals 1kg',0,NULL,NULL,NULL,NULL,1),(385,1,'MED','84','Phytomenadione 10mg/ml 1ml Amp',0,NULL,NULL,NULL,NULL,1),(386,1,'MED','85','Phytomenadione 1mg/ml 1ml Amp',0,NULL,NULL,NULL,NULL,1),(387,1,'MED','269','Plaster of Paris 10cm',0,NULL,NULL,NULL,NULL,1),(388,1,'MED','270','Plaster of Paris 15cm',0,NULL,NULL,NULL,NULL,1),(389,1,'MED','12','Potassium iodide 100g',0,NULL,NULL,NULL,NULL,1),(390,1,'MED','21','Potassium Oxalate',0,NULL,NULL,NULL,NULL,1),(391,1,'MED','37','Pregnacy ( HGG Latex) 50 tests',0,NULL,NULL,NULL,NULL,1),(392,1,'MED','86','Procaine Penicillin Fortified 4 MIU Vial',0,NULL,NULL,NULL,NULL,1),(393,1,'MED','87','Promethazine 25mg/ml 2ml Amp',0,NULL,NULL,NULL,NULL,1),(394,1,'MED','213','Pyridoxine 50mg Tab',0,NULL,NULL,NULL,NULL,1),(395,1,'MED','177','Quinine 100mg/5ml Syrup 100ml',0,NULL,NULL,NULL,NULL,1),(396,1,'MED','214','Quinine 300mg Tab',0,NULL,NULL,NULL,NULL,1),(397,1,'MED','88','Quinine Di-HCI 300mg/ml 2ml Amp',0,NULL,NULL,NULL,NULL,1),(398,1,'MED','215','Ranitidine 150mg Tab',0,NULL,NULL,NULL,NULL,1),(399,1,'MED','89','Ranitidine 25mg/ml 2ml Amp',0,NULL,NULL,NULL,NULL,1),(400,1,'MED','336','Razor Blades Disposable 5pc',0,NULL,NULL,NULL,NULL,1),(401,1,'MED','285','Rectal Tube CH24',0,NULL,NULL,NULL,NULL,1),(402,1,'MED','286','Rectal Tube CH26',0,NULL,NULL,NULL,NULL,1),(403,1,'MED','216','Rifampicin/Isoniazid 150/100 Tab',0,NULL,NULL,NULL,NULL,1),(404,1,'MED','39','RPR ( VDRL Carbon ) Antigen 5ml',0,NULL,NULL,NULL,NULL,1),(405,1,'MED','38','RPR 125mm x 75mm',0,NULL,NULL,NULL,NULL,1),(406,1,'MED','169','Salbutamol 4mg Tab',0,NULL,NULL,NULL,NULL,1),(407,1,'MED','200','Salbutamol Inhaler 10ml',0,NULL,NULL,NULL,NULL,1),(408,1,'MED','199','Salbutamol solution for inhalation 5ml',0,NULL,NULL,NULL,NULL,1),(409,1,'MED','243','Scalp Vein G19 Infusion set',0,NULL,NULL,NULL,NULL,1),(410,1,'MED','244','Scalp Vein G21 Infusion set',0,NULL,NULL,NULL,NULL,1),(411,1,'MED','245','Scalp Vein G23 Infusion set',0,NULL,NULL,NULL,NULL,1),(412,1,'MED','246','Scalp Vein G25 Infusion set',0,NULL,NULL,NULL,NULL,1),(413,1,'MED','186','Soap Blue Bar 550g',0,NULL,NULL,NULL,NULL,1),(414,1,'MED','188','Soap Powder Hand wash 5kg',0,NULL,NULL,NULL,NULL,1),(415,1,'MED','27','Sodium Carbonate Anhydrous',0,NULL,NULL,NULL,NULL,1),(416,1,'MED','13','Sodium Carbonate Anhydrous 500g',0,NULL,NULL,NULL,NULL,1),(417,1,'MED','96','Sodium Chloride 0.9% IV 500ml',0,NULL,NULL,NULL,NULL,1),(418,1,'MED','217','Sodium Chloride Apyrogen 50kg',0,NULL,NULL,NULL,NULL,1),(419,1,'MED','14','Sodium Citrate 100g',0,NULL,NULL,NULL,NULL,1),(420,1,'MED','20','Sodium Fluoride',0,NULL,NULL,NULL,NULL,1),(421,1,'MED','184','Sodium Hypochlorite solution 0.75 Ltr',0,NULL,NULL,NULL,NULL,1),(422,1,'MED','189','Sodium Hypochlorite solution 5Ltr',0,NULL,NULL,NULL,NULL,1),(423,1,'MED','97','Sodium Lactate Compound IV 500ml',0,NULL,NULL,NULL,NULL,1),(424,1,'MED','16','Sodium Nitrate 25g',0,NULL,NULL,NULL,NULL,1),(425,1,'MED','15','Sodium Sulphate 500g',0,NULL,NULL,NULL,NULL,1),(426,1,'MED','170','Spironolactone 25mg Tab',0,NULL,NULL,NULL,NULL,1),(427,1,'MED','332','Spoon Medicine 5ml',0,NULL,NULL,NULL,NULL,1),(428,1,'MED','337','Stethoscope Foetal Metal',0,NULL,NULL,NULL,NULL,1),(429,1,'MED','338','Stethoscope Foetal Wood',0,NULL,NULL,NULL,NULL,1),(430,1,'MED','90','Streptomycin 1g Vial',0,NULL,NULL,NULL,NULL,1),(431,1,'MED','292','Suction Catheter Size 10 Disposable',0,NULL,NULL,NULL,NULL,1),(432,1,'MED','290','Suction Catheter Size 12 Disposable',0,NULL,NULL,NULL,NULL,1),(433,1,'MED','291','Suction Catheter Size 14 Disposable',0,NULL,NULL,NULL,NULL,1),(434,1,'MED','289','Suction Catheter Size 16 Disposable',0,NULL,NULL,NULL,NULL,1),(435,1,'MED','287','Suction Catheter Size 6 Disposable',0,NULL,NULL,NULL,NULL,1),(436,1,'MED','288','Suction Catheter Size 8 Disposable',0,NULL,NULL,NULL,NULL,1),(437,1,'MED','17','Sulphosalicylic Acid 500g',0,NULL,NULL,NULL,NULL,1),(438,1,'MED','18','Sulphuric Acid Conc 1ltr',0,NULL,NULL,NULL,NULL,1),(439,1,'MED','361','Surgical Blades No 20',0,NULL,NULL,NULL,NULL,1),(440,1,'MED','362','Surgical Blades No 21',0,NULL,NULL,NULL,NULL,1),(441,1,'MED','363','Surgical Blades No 22',0,NULL,NULL,NULL,NULL,1),(442,1,'MED','364','Surgical Blades No 23',0,NULL,NULL,NULL,NULL,1),(443,1,'MED','339','Surgical Brush (Scrubbing)',0,NULL,NULL,NULL,NULL,1),(444,1,'MED','340','Surgical Mop 12 x 15',0,NULL,NULL,NULL,NULL,1),(445,1,'MED','368','Suture Cutgut Chromic (0)',0,NULL,NULL,NULL,NULL,1),(446,1,'MED','369','Suture Cutgut Chromic (2) RN22240TH',0,NULL,NULL,NULL,NULL,1),(447,1,'MED','370','Suture Cutgut Chromic (2/0) RN22230TH',0,NULL,NULL,NULL,NULL,1),(448,1,'MED','371','Suture Cutgut Chromic (3/0) RN2325TF',0,NULL,NULL,NULL,NULL,1),(449,1,'MED','372','Suture Cutgut Plain (2/0) RN1230TF',0,NULL,NULL,NULL,NULL,1),(450,1,'MED','375','Suture PGA (3/0) RN3330TF',0,NULL,NULL,NULL,NULL,1),(451,1,'MED','373','Suture Silk (1) S595',0,NULL,NULL,NULL,NULL,1),(452,1,'MED','374','Suture Silk (2/0) RN5230TF',0,NULL,NULL,NULL,NULL,1),(453,1,'MED','91','Suxamethonium 500mg Vial',0,NULL,NULL,NULL,NULL,1),(454,1,'MED','92','Suxamethonium 500mg/ml 2ml Amp',0,NULL,NULL,NULL,NULL,1),(455,1,'MED','247','Syringe Feeding/Irrigation 50/60ml',0,NULL,NULL,NULL,NULL,1),(456,1,'MED','249','Syringe Luer 10ml With Needle Disposable',0,NULL,NULL,NULL,NULL,1),(457,1,'MED','250','Syringe Luer 20ml With Needle Disposable',0,NULL,NULL,NULL,NULL,1),(458,1,'MED','248','Syringe Luer 2ml With Needle Disposable',0,NULL,NULL,NULL,NULL,1),(459,1,'MED','251','Syringe Luer 5ml With Needle Disposable',0,NULL,NULL,NULL,NULL,1),(460,1,'MED','341','Tablet Counting Tray',0,NULL,NULL,NULL,NULL,1),(461,1,'MED','93','tetanus Antitoxin 1500 IU 1ml Amp',0,NULL,NULL,NULL,NULL,1),(462,1,'MED','196','Tetracycline eye ointment 1% 3.5g',0,NULL,NULL,NULL,NULL,1),(463,1,'MED','345','Thermometer Clinical Flat Type',0,NULL,NULL,NULL,NULL,1),(464,1,'MED','346','Thermometer Clinical Prismatic Type',0,NULL,NULL,NULL,NULL,1),(465,1,'MED','94','Thiopental Sodium 500mg Vial',0,NULL,NULL,NULL,NULL,1),(466,1,'MED','342','Toilet Paper Rolls',0,NULL,NULL,NULL,NULL,1),(467,1,'MED','171','Tolbutamide 500mg tab',0,NULL,NULL,NULL,NULL,1),(468,1,'MED','304','Tongue depressor Disposable',0,NULL,NULL,NULL,NULL,1),(469,1,'MED','344','Traction Kit Adult',0,NULL,NULL,NULL,NULL,1),(470,1,'MED','343','Traction Kit Children',0,NULL,NULL,NULL,NULL,1),(471,1,'MED','25','Trichloro acetic Acid',0,NULL,NULL,NULL,NULL,1),(472,1,'MED','28','Trisodium Citrate',0,NULL,NULL,NULL,NULL,1),(473,1,'MED','347','Umbilical Cord Tie non sterile 100m',0,NULL,NULL,NULL,NULL,1),(474,1,'MED','348','Umbilical Cord Tie sterile 22m',0,NULL,NULL,NULL,NULL,1),(475,1,'MED','122','UREA Calorimetric 300 Tests',0,NULL,NULL,NULL,NULL,1),(476,1,'MED','349','Urinal 1Ltr / 2Ltr',0,NULL,NULL,NULL,NULL,1),(477,1,'MED','350','Urine Collecting Bag sterile 2Ltr',0,NULL,NULL,NULL,NULL,1),(478,1,'MED','198','Urine Test Strips 3 Parameters 100 tests',0,NULL,NULL,NULL,NULL,1),(479,1,'MED','172','Vitamin A 200.000 IU Caps',0,NULL,NULL,NULL,NULL,1),(480,1,'MED','173','Vitamin B Complex Tab',0,NULL,NULL,NULL,NULL,1),(481,1,'MED','95','Water for Injection 10ml Vial',0,NULL,NULL,NULL,NULL,1),(482,1,'MED','377','X-Ray Developer 2.6kg for 22.5Ltr',0,NULL,NULL,NULL,NULL,1),(483,1,'MED','378','X-Ray Film 18x24cm',0,NULL,NULL,NULL,NULL,1),(484,1,'MED','379','X-Ray Film 20x40cm',0,NULL,NULL,NULL,NULL,1),(485,1,'MED','380','X-Ray Film 24x30cm',0,NULL,NULL,NULL,NULL,1),(486,1,'MED','381','X-Ray Film 30x40cm',0,NULL,NULL,NULL,NULL,1),(487,1,'MED','382','X-Ray Film 35x35cm',0,NULL,NULL,NULL,NULL,1),(488,1,'MED','383','X-Ray Film 43x35cm',0,NULL,NULL,NULL,NULL,1),(489,1,'MED','384','X-Ray Film Cassette  18x24cm with screen',0,NULL,NULL,NULL,NULL,1),(490,1,'MED','385','X-Ray Film Cassette  24x30cm with screen',0,NULL,NULL,NULL,NULL,1),(491,1,'MED','386','X-Ray Film Cassette  30x40cm with screen',0,NULL,NULL,NULL,NULL,1),(492,1,'MED','387','X-Ray Film Cassette  35x35cm with screen',0,NULL,NULL,NULL,NULL,1),(493,1,'MED','388','X-Ray Film Cassette  35x43cm with screen',0,NULL,NULL,NULL,NULL,1),(494,1,'MED','389','X-Ray Fixer 3.3kg for 22.5 Ltr',0,NULL,NULL,NULL,NULL,1),(495,1,'MED','19','Xylene 2.5 ltrs',0,NULL,NULL,NULL,NULL,1),(496,1,'OTH','1','Amount per day',0,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `prices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pricesothers`
--

DROP TABLE IF EXISTS `pricesothers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pricesothers` (
  `OTH_ID` int(11) NOT NULL AUTO_INCREMENT,
  `OTH_CODE` varchar(10) NOT NULL,
  `OTH_DESC` varchar(100) NOT NULL,
  `OTH_OPD_INCLUDE` int(11) NOT NULL DEFAULT '0',
  `OTH_IPD_INCLUDE` int(11) NOT NULL DEFAULT '0',
  `OTH_DAILY` int(11) NOT NULL DEFAULT '0',
  `OTH_DISCHARGE` int(11) DEFAULT '0',
  `OTH_UNDEFINED` int(11) DEFAULT '0',
  `OTH_CREATED_BY` varchar(50) DEFAULT NULL,
  `OTH_CREATED_DATE` datetime DEFAULT NULL,
  `OTH_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `OTH_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `OTH_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`OTH_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pricesothers`
--

LOCK TABLES `pricesothers` WRITE;
/*!40000 ALTER TABLE `pricesothers` DISABLE KEYS */;
INSERT INTO `pricesothers` VALUES (1,'OTH001','Amount per day',0,1,1,0,0,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `pricesothers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sms`
--

DROP TABLE IF EXISTS `sms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sms` (
  `SMS_ID` int(11) NOT NULL AUTO_INCREMENT,
  `SMS_DATE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `SMS_DATE_SCHED` datetime NOT NULL,
  `SMS_NUMBER` varchar(45) NOT NULL,
  `SMS_TEXT` varchar(160) NOT NULL,
  `SMS_DATE_SENT` datetime DEFAULT NULL,
  `SMS_USER` varchar(50) NOT NULL DEFAULT 'admin',
  `SMS_MOD` varchar(45) NOT NULL DEFAULT 'smsmanager',
  `SMS_MOD_ID` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`SMS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sms`
--

LOCK TABLES `sms` WRITE;
/*!40000 ALTER TABLE `sms` DISABLE KEYS */;
/*!40000 ALTER TABLE `sms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `supplier` (
  `SUP_ID` int(11) NOT NULL AUTO_INCREMENT,
  `SUP_NAME` varchar(100) NOT NULL,
  `SUP_ADDRESS` varchar(150) DEFAULT NULL,
  `SUP_TAXCODE` varchar(50) DEFAULT NULL,
  `SUP_PHONE` varchar(20) DEFAULT NULL,
  `SUP_FAX` varchar(20) DEFAULT NULL,
  `SUP_EMAIL` varchar(100) DEFAULT NULL,
  `SUP_NOTE` varchar(200) DEFAULT NULL,
  `SUP_DELETED` char(1) DEFAULT 'N',
  `SUP_CREATED_BY` varchar(50) DEFAULT NULL,
  `SUP_CREATED_DATE` datetime DEFAULT NULL,
  `SUP_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `SUP_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `SUP_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`SUP_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `supplier`
--

LOCK TABLES `supplier` WRITE;
/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `therapies`
--

DROP TABLE IF EXISTS `therapies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `therapies` (
  `THR_ID` int(11) NOT NULL AUTO_INCREMENT,
  `THR_PAT_ID` int(11) NOT NULL,
  `THR_STARTDATE` datetime NOT NULL,
  `THR_ENDDATE` datetime NOT NULL,
  `THR_MDSR_ID` int(11) NOT NULL,
  `THR_QTY` double NOT NULL,
  `THR_UNT_ID` int(11) NOT NULL,
  `THR_FREQINDAY` int(11) NOT NULL,
  `THR_FREQINPRD` int(11) NOT NULL,
  `THR_NOTE` text,
  `THR_NOTIFY` tinyint(1) NOT NULL DEFAULT '0',
  `THR_SMS` tinyint(1) NOT NULL DEFAULT '0',
  `THR_CREATED_BY` varchar(50) DEFAULT NULL,
  `THR_CREATED_DATE` datetime DEFAULT NULL,
  `THR_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `THR_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `THR_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`THR_ID`),
  KEY `FK_THERAPIES_PATIENT` (`THR_PAT_ID`),
  KEY `FK_THERAPIES_MDSR` (`THR_MDSR_ID`),
  CONSTRAINT `FK_THERAPIES_MDSR` FOREIGN KEY (`THR_MDSR_ID`) REFERENCES `medicaldsr` (`MDSR_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_THERAPIES_PATIENT` FOREIGN KEY (`THR_PAT_ID`) REFERENCES `patient` (`PAT_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `therapies`
--

LOCK TABLES `therapies` WRITE;
/*!40000 ALTER TABLE `therapies` DISABLE KEYS */;
/*!40000 ALTER TABLE `therapies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `US_ID_A` varchar(50) NOT NULL DEFAULT '',
  `US_UG_ID_A` varchar(50) NOT NULL DEFAULT '',
  `US_PASSWD` varchar(60) NOT NULL DEFAULT '',
  `US_DESC` varchar(128) DEFAULT NULL,
  `US_CREATED_BY` varchar(50) DEFAULT NULL,
  `US_CREATED_DATE` datetime DEFAULT NULL,
  `US_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `US_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `US_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`US_ID_A`),
  KEY `FK_USER_USERGROUP` (`US_UG_ID_A`),
  CONSTRAINT `FK_USER_USERGROUP` FOREIGN KEY (`US_UG_ID_A`) REFERENCES `usergroup` (`UG_ID_A`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('admin','admin','$2a$10$FI/PMO0oSHHosF2PX8l3QuB0DJepVfnynbLZ9Zm2711bF2ch8db2S','administrator',NULL,NULL,NULL,NULL,1),('guest','guest','$2a$10$b0WlANdaNV7Ukn/klFGt3.euZ7PaHuJI6TtBSM2vdxkavvkUDbpo2','guest',NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usergroup`
--

DROP TABLE IF EXISTS `usergroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usergroup` (
  `UG_ID_A` varchar(50) NOT NULL DEFAULT '',
  `UG_DESC` varchar(128) DEFAULT NULL,
  `UG_CREATED_BY` varchar(50) DEFAULT NULL,
  `UG_CREATED_DATE` datetime DEFAULT NULL,
  `UG_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `UG_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `UG_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`UG_ID_A`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usergroup`
--

LOCK TABLES `usergroup` WRITE;
/*!40000 ALTER TABLE `usergroup` DISABLE KEYS */;
INSERT INTO `usergroup` VALUES ('admin','User with all the privileges',NULL,NULL,NULL,NULL,1),('guest','Read Only Users',NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `usergroup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccine`
--

DROP TABLE IF EXISTS `vaccine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vaccine` (
  `VAC_ID_A` varchar(10) NOT NULL,
  `VAC_DESC` varchar(50) NOT NULL,
  `VAC_VACT_ID_A` char(1) NOT NULL,
  `VAC_LOCK` int(11) NOT NULL DEFAULT '0',
  `VAC_CREATED_BY` varchar(50) DEFAULT NULL,
  `VAC_CREATED_DATE` datetime DEFAULT NULL,
  `VAC_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `VAC_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `VAC_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`VAC_ID_A`),
  KEY `FK_VACCINE_VACCINETYPE` (`VAC_VACT_ID_A`),
  CONSTRAINT `FK_VACCINE_VACCINETYPE` FOREIGN KEY (`VAC_VACT_ID_A`) REFERENCES `vaccinetype` (`VACT_ID_A`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccine`
--

LOCK TABLES `vaccine` WRITE;
/*!40000 ALTER TABLE `vaccine` DISABLE KEYS */;
INSERT INTO `vaccine` VALUES ('1','BCG','C',0,NULL,NULL,NULL,NULL,0),('10','TT VACCINE DOSE 1','P',0,NULL,NULL,NULL,NULL,0),('11','TT VACCINE DOSE 2','P',0,NULL,NULL,NULL,NULL,0),('12','TT VACCINE DOSE 3','P',0,NULL,NULL,NULL,NULL,0),('13','TT VACCINE DOSE 4','P',0,NULL,NULL,NULL,NULL,0),('14','TT VACCINE DOSE 5','P',0,NULL,NULL,NULL,NULL,0),('15','TT VACCINE DOSE 2','N',0,NULL,NULL,NULL,NULL,0),('16','TT VACCINE DOSE 3','N',0,NULL,NULL,NULL,NULL,0),('17','TT VACCINE DOSE 4','N',0,NULL,NULL,NULL,NULL,0),('18','TT VACCINE DOSE 5','N',0,NULL,NULL,NULL,NULL,0),('2','POLIO 0 C','C',0,NULL,NULL,NULL,NULL,0),('3','POLIO 1 C','C',0,NULL,NULL,NULL,NULL,0),('4','POLIO 2 C','C',0,NULL,NULL,NULL,NULL,0),('5','POLIO 3 C','C',0,NULL,NULL,NULL,NULL,0),('6','DPT 1 - HepB + Hib 1','C',0,NULL,NULL,NULL,NULL,0),('7','DPT 2 - HepB + Hib 1','C',0,NULL,NULL,NULL,NULL,0),('8','DPT 3 - HepB + Hib 1','C',0,NULL,NULL,NULL,NULL,0),('9','MEASLES','C',0,NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `vaccine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccinetype`
--

DROP TABLE IF EXISTS `vaccinetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vaccinetype` (
  `VACT_ID_A` char(1) NOT NULL,
  `VACT_DESC` varchar(50) NOT NULL,
  `VACT_CREATED_BY` varchar(50) DEFAULT NULL,
  `VACT_CREATED_DATE` datetime DEFAULT NULL,
  `VACT_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `VACT_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `VACT_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`VACT_ID_A`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccinetype`
--

LOCK TABLES `vaccinetype` WRITE;
/*!40000 ALTER TABLE `vaccinetype` DISABLE KEYS */;
INSERT INTO `vaccinetype` VALUES ('C','Child',NULL,NULL,NULL,NULL,0),('N','No pregnant',NULL,NULL,NULL,NULL,0),('P','Pregnant',NULL,NULL,NULL,NULL,0);
/*!40000 ALTER TABLE `vaccinetype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `version`
--

DROP TABLE IF EXISTS `version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `version` (
  `VER_MAJOR` int(11) NOT NULL,
  `VER_MINOR` int(11) NOT NULL,
  `VER_SOURCE` longblob,
  `VER_DATE` datetime NOT NULL,
  `VER_CURRENT` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`VER_MAJOR`,`VER_MINOR`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `version`
--

LOCK TABLES `version` WRITE;
/*!40000 ALTER TABLE `version` DISABLE KEYS */;
/*!40000 ALTER TABLE `version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visits`
--

DROP TABLE IF EXISTS `visits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visits` (
  `VST_ID` int(11) NOT NULL AUTO_INCREMENT,
  `VST_PAT_ID` int(11) NOT NULL,
  `VST_DATE` datetime NOT NULL,
  `VST_NOTE` text,
  `VST_SMS` tinyint(1) DEFAULT '0',
  `VST_CREATED_BY` varchar(50) DEFAULT NULL,
  `VST_CREATED_DATE` datetime DEFAULT NULL,
  `VST_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `VST_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `VST_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  `VST_WRD_ID_A` char(1) DEFAULT NULL,
  `VST_DURATION` int(11) DEFAULT NULL,
  `VST_SERVICE` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`VST_ID`),
  KEY `FK_VISITS_PATIENT` (`VST_PAT_ID`),
  KEY `FK_VISITS_WARD` (`VST_WRD_ID_A`),
  CONSTRAINT `FK_VISITS_PATIENT` FOREIGN KEY (`VST_PAT_ID`) REFERENCES `patient` (`PAT_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_VISITS_WARD` FOREIGN KEY (`VST_WRD_ID_A`) REFERENCES `ward` (`WRD_ID_A`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visits`
--

LOCK TABLES `visits` WRITE;
/*!40000 ALTER TABLE `visits` DISABLE KEYS */;
/*!40000 ALTER TABLE `visits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ward`
--

DROP TABLE IF EXISTS `ward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ward` (
  `WRD_ID_A` char(1) NOT NULL,
  `WRD_NAME` varchar(50) NOT NULL,
  `WRD_TELE` varchar(50) DEFAULT NULL,
  `WRD_FAX` varchar(50) DEFAULT NULL,
  `WRD_EMAIL` varchar(50) DEFAULT NULL,
  `WRD_NBEDS` int(11) NOT NULL,
  `WRD_NQUA_NURS` int(11) NOT NULL,
  `WRD_NDOC` int(11) NOT NULL,
  `WRD_IS_PHARMACY` tinyint(1) NOT NULL DEFAULT '1',
  `WRD_IS_MALE` tinyint(1) NOT NULL DEFAULT '1',
  `WRD_IS_FEMALE` tinyint(1) NOT NULL DEFAULT '1',
  `WRD_LOCK` int(11) NOT NULL DEFAULT '0',
  `WRD_CREATED_BY` varchar(50) DEFAULT NULL,
  `WRD_CREATED_DATE` datetime DEFAULT NULL,
  `WRD_LAST_MODIFIED_BY` varchar(50) DEFAULT NULL,
  `WRD_LAST_MODIFIED_DATE` datetime DEFAULT NULL,
  `WRD_ACTIVE` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`WRD_ID_A`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ward`
--

LOCK TABLES `ward` WRITE;
/*!40000 ALTER TABLE `ward` DISABLE KEYS */;
INSERT INTO `ward` VALUES ('I','INTERNAL MEDICINE','234/52544','54324/5424','internal.medicine@stluke.org',20,3,2,1,1,1,1,NULL,NULL,NULL,NULL,1),('M','MATERNITY','234/52544','54324/5424','maternity@stluke.org',20,3,2,1,0,1,1,NULL,NULL,NULL,NULL,1),('N','NURSERY','234/52544','54324/5424','nursery@stluke.org',20,3,2,1,1,1,1,NULL,NULL,NULL,NULL,1),('S','SURGERY','234/52544','54324/5424','surgery@stluke.org',20,3,2,1,1,1,1,NULL,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `ward` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-11-13  1:35:23
