-- MySQL dump 10.13  Distrib 5.7.9, for osx10.9 (x86_64)
--
-- Host: 127.0.0.1    Database: glucometer
-- ------------------------------------------------------
-- Server version	5.7.11

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
-- Table structure for table `remarks_table`
--

DROP TABLE IF EXISTS `remarks_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remarks_table` (
  `remarkID` bigint(20) NOT NULL AUTO_INCREMENT,
  `isCreatedOn` varchar(255) DEFAULT NULL,
  `remarkString` varchar(255) DEFAULT NULL,
  `remarkTitle` varchar(255) DEFAULT NULL,
  `assignedDoctor_personID` bigint(20) DEFAULT NULL,
  `assignedPatient_personId` bigint(20) DEFAULT NULL,
  `additionalCommentsFromUser` varchar(255) DEFAULT NULL,
  `isAvaliable` bit(1) DEFAULT NULL,
  `doctorUsername` varchar(255) DEFAULT NULL,
  `patientUsername` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`remarkID`),
  KEY `FK_j2k84i63o5ybk5mn5wq8j1ij6` (`assignedDoctor_personID`),
  KEY `FK_lscn9bm8weqfql348hx8f2wnh` (`assignedPatient_personId`),
  CONSTRAINT `FK_j2k84i63o5ybk5mn5wq8j1ij6` FOREIGN KEY (`assignedDoctor_personID`) REFERENCES `doctor_table` (`personID`),
  CONSTRAINT `FK_lscn9bm8weqfql348hx8f2wnh` FOREIGN KEY (`assignedPatient_personId`) REFERENCES `user_table` (`personId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remarks_table`
--

LOCK TABLES `remarks_table` WRITE;
/*!40000 ALTER TABLE `remarks_table` DISABLE KEYS */;
INSERT INTO `remarks_table` VALUES (2,NULL,'The Glucose Levels are looking fine','Everything is fine',NULL,NULL,NULL,'','mike','aapeshave'),(3,NULL,'The Glucose Levels are looking fine','Keep Up!',NULL,NULL,NULL,'','mike','aapeshave');
/*!40000 ALTER TABLE `remarks_table` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-30 10:36:00
