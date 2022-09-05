-- MySQL dump 10.13  Distrib 8.0.29, for Win64 (x86_64)
--
-- Host: localhost    Database: shooter
-- ------------------------------------------------------
-- Server version	8.0.29

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
-- Table structure for table `bans`
--

DROP TABLE IF EXISTS `bans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bans` (
  `BanID` int NOT NULL AUTO_INCREMENT,
  `BanTimeStamp` timestamp NOT NULL,
  `PlayerBannedID` int NOT NULL,
  `ReportCategoryID` int NOT NULL,
  `BanDetails` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`BanID`),
  KEY `PlayerBannedID` (`PlayerBannedID`),
  KEY `ReportCategoryID` (`ReportCategoryID`),
  CONSTRAINT `bans_ibfk_1` FOREIGN KEY (`PlayerBannedID`) REFERENCES `playerlogin` (`PlayerID`),
  CONSTRAINT `bans_ibfk_2` FOREIGN KEY (`ReportCategoryID`) REFERENCES `reportsystem` (`ReportCategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bans`
--

LOCK TABLES `bans` WRITE;
/*!40000 ALTER TABLE `bans` DISABLE KEYS */;
INSERT INTO `bans` VALUES (1,'2022-08-20 23:18:05',4,5,NULL),(2,'2022-08-20 23:18:05',6,2,NULL),(3,'2022-08-20 23:18:05',7,2,NULL),(4,'2022-08-20 23:18:05',8,3,NULL),(5,'2022-08-20 23:18:05',10,1,NULL),(6,'2022-08-21 17:45:01',6,2,'INSTABAN'),(7,'2022-08-21 17:52:59',6,2,'INSTABAN'),(8,'2022-08-21 18:03:15',10,2,NULL),(9,'2022-08-21 18:07:02',6,2,'InstaBan'),(10,'2022-08-21 18:07:17',10,2,'InstaBan'),(12,'2022-08-21 18:08:35',10,1,'InstaBan'),(13,'2022-08-22 23:23:44',10,1,'InstaBan');
/*!40000 ALTER TABLE `bans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playerdetails`
--

DROP TABLE IF EXISTS `playerdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playerdetails` (
  `PlayerID` int NOT NULL,
  `Age` int NOT NULL,
  `Gender` varchar(64) NOT NULL,
  `Country` varchar(64) NOT NULL,
  KEY `PlayerID` (`PlayerID`),
  CONSTRAINT `playerdetails_ibfk_1` FOREIGN KEY (`PlayerID`) REFERENCES `playerlogin` (`PlayerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playerdetails`
--

LOCK TABLES `playerdetails` WRITE;
/*!40000 ALTER TABLE `playerdetails` DISABLE KEYS */;
INSERT INTO `playerdetails` VALUES (1,26,'Male','Turkey'),(2,21,'Male','USA'),(3,24,'Male','Ukraine'),(4,21,'Male','USA'),(5,23,'Male','Russia'),(6,27,'Male','UK'),(7,14,'Male','Spain'),(8,17,'Male','Japan'),(9,16,'Male','Russia'),(10,21,'Female','UK'),(11,19,'Male','USA'),(12,27,'Male','USA'),(13,23,'Female','Canada'),(14,26,'Female','USA'),(15,14,'Female','Canada'),(16,16,'Female','Brazil'),(17,18,'Female','Mexico'),(18,21,'Female','UK'),(19,17,'Male','Indonesia'),(20,27,'Male','Japan');
/*!40000 ALTER TABLE `playerdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playerlogin`
--

DROP TABLE IF EXISTS `playerlogin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playerlogin` (
  `PlayerID` int NOT NULL AUTO_INCREMENT,
  `Username` varchar(64) NOT NULL,
  `Password` varchar(64) NOT NULL,
  `Email` varchar(128) NOT NULL,
  PRIMARY KEY (`PlayerID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playerlogin`
--

LOCK TABLES `playerlogin` WRITE;
/*!40000 ALTER TABLE `playerlogin` DISABLE KEYS */;
INSERT INTO `playerlogin` VALUES (1,'tarik','nF454$kM','tarik@loaded.gg'),(2,'shiro','mA390^','shirorzbusiness@gmail.com'),(3,'s1mple','71Ru5*','s1mplekostyliev@gmail.com'),(4,'prod','#48eL8','prodvalorantb@gmail.com'),(5,'cory','*I44y4','CoryxKenshinYT@hotmail.com'),(6,'w1ldc4t','329Cn#','business@iamwildcat.net'),(7,'avila','ZvJ5s_8R','julianavila@gmail.com'),(8,'kento','Bxh%h:+9','	kentobento@gmail.com'),(9,'m0nesy','HK8F]m*~','m0nesy@loaded.gg'),(10,'skyer','nCC4+.UL','dearskyer@gmail.com'),(11,'grim','3EuKiJgu','grim@afkcreators.com'),(12,'shroud','nTe11UfC','shroud@loaded.gg'),(13,'ploo','egofnz72','ploo@nani.gg'),(14,'t1na','Tc81Vm12','wenisprinklesbusiness@gmail.com'),(15,'florescent','n4AodgLi','florescent@loaded.gg'),(16,'mimi','1nQmtfx5','mimi@levelupagency.eu'),(17,'jazzyk1ns','hUs7ru6C','jazzyk1ns@seg.gg'),(18,'MeL','QfY9L0YF','meL@seg.gg'),(19,'f0rsakeN','iExoNs69','forsaken@pprx.team'),(20,'stewie','72NvzwWF','teamstewie2k@unitedtalent.com');
/*!40000 ALTER TABLE `playerlogin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `playerperformance`
--

DROP TABLE IF EXISTS `playerperformance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `playerperformance` (
  `PlayerID` int NOT NULL,
  `RankID` int DEFAULT NULL,
  `MatchesPlayed` int DEFAULT NULL,
  `KDRatio` decimal(10,2) DEFAULT NULL,
  `Accuracy` decimal(5,2) DEFAULT NULL,
  `Winrate` decimal(5,2) DEFAULT NULL,
  KEY `PlayerID` (`PlayerID`),
  KEY `RankID` (`RankID`),
  CONSTRAINT `playerperformance_ibfk_1` FOREIGN KEY (`PlayerID`) REFERENCES `playerlogin` (`PlayerID`),
  CONSTRAINT `playerperformance_ibfk_2` FOREIGN KEY (`RankID`) REFERENCES `ranksystem` (`RankID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `playerperformance`
--

LOCK TABLES `playerperformance` WRITE;
/*!40000 ALTER TABLE `playerperformance` DISABLE KEYS */;
INSERT INTO `playerperformance` VALUES (11,8,380,0.99,68.10,51.80),(12,7,865,1.11,54.00,52.10),(13,6,268,0.83,67.00,48.50),(14,1,2,42.00,16.10,50.00),(15,5,115,0.99,34.50,45.30),(16,4,67,0.67,27.40,32.10),(17,2,23,0.12,18.70,43.90),(18,8,75,1.12,45.60,56.00),(19,9,234,1.30,56.80,59.80),(20,9,717,1.01,70.20,56.90),(11,8,380,0.99,68.10,51.80),(12,7,865,1.11,54.00,52.10),(13,6,268,0.83,67.00,48.50),(14,1,2,42.00,16.10,50.00),(15,5,115,0.99,34.50,45.30),(16,4,67,0.67,27.40,32.10),(17,2,23,0.12,18.70,43.90),(18,8,75,1.12,45.60,56.00),(19,9,234,1.30,56.80,59.80),(20,9,717,1.01,70.20,56.90),(1,9,390,1.24,66.00,57.70),(2,6,428,0.96,69.40,53.00),(3,8,79,1.34,60.00,60.00),(4,2,307,1.02,45.00,52.40),(5,3,34,1.10,39.20,48.70),(6,7,15,11.10,68.90,64.00),(7,1,25,14.90,78.30,89.00),(8,4,7,1.90,57.70,75.00),(9,9,21,2.30,61.60,70.00),(10,5,9,1.74,76.00,44.40);
/*!40000 ALTER TABLE `playerperformance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `playersregion`
--

DROP TABLE IF EXISTS `playersregion`;
/*!50001 DROP VIEW IF EXISTS `playersregion`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `playersregion` AS SELECT 
 1 AS `PlayerCount`,
 1 AS `Country`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `ranksystem`
--

DROP TABLE IF EXISTS `ranksystem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ranksystem` (
  `RankID` int NOT NULL AUTO_INCREMENT,
  `RankName` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`RankID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ranksystem`
--

LOCK TABLES `ranksystem` WRITE;
/*!40000 ALTER TABLE `ranksystem` DISABLE KEYS */;
INSERT INTO `ranksystem` VALUES (1,'iron'),(2,'bronze'),(3,'silver'),(4,'gold'),(5,'platinum'),(6,'diamond'),(7,'ascendant'),(8,'immortal'),(9,'radiant');
/*!40000 ALTER TABLE `ranksystem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `ReportID` int NOT NULL AUTO_INCREMENT,
  `ReportTimeStamp` timestamp NOT NULL,
  `PlayerReportedID` int NOT NULL,
  `PlayerReportingID` int NOT NULL,
  `ReportCategoryID` int NOT NULL,
  `ReportDetails` varchar(240) DEFAULT NULL,
  PRIMARY KEY (`ReportID`),
  KEY `PlayerReportedID` (`PlayerReportedID`),
  KEY `PlayerReportingID` (`PlayerReportingID`),
  KEY `ReportCategoryID` (`ReportCategoryID`),
  CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`PlayerReportedID`) REFERENCES `playerlogin` (`PlayerID`),
  CONSTRAINT `reports_ibfk_2` FOREIGN KEY (`PlayerReportingID`) REFERENCES `playerlogin` (`PlayerID`),
  CONSTRAINT `reports_ibfk_3` FOREIGN KEY (`ReportCategoryID`) REFERENCES `reportsystem` (`ReportCategoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
INSERT INTO `reports` VALUES (1,'2022-08-21 23:07:50',4,13,1,'toxic'),(2,'2022-08-20 23:07:50',9,14,2,'100% esp'),(3,'2022-08-19 23:07:50',19,8,2,' '),(4,'2022-08-21 13:07:50',20,5,6,' '),(5,'2022-08-14 23:07:50',14,4,3,'afk at spawn'),(6,'2022-08-07 23:07:50',16,3,3,'afk at spawn'),(7,'2022-08-18 23:07:50',6,2,2,'aimbot'),(8,'2022-08-17 23:07:50',7,2,2,' '),(9,'2022-08-20 23:07:50',9,4,4,'calling me names'),(10,'2022-08-14 23:07:50',7,4,5,'ruining team morale');
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reportsystem`
--

DROP TABLE IF EXISTS `reportsystem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reportsystem` (
  `ReportCategoryID` int NOT NULL,
  `ReportCategory` varchar(240) NOT NULL,
  PRIMARY KEY (`ReportCategoryID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reportsystem`
--

LOCK TABLES `reportsystem` WRITE;
/*!40000 ALTER TABLE `reportsystem` DISABLE KEYS */;
INSERT INTO `reportsystem` VALUES (1,'verbal abuse'),(2,'cheating'),(3,'sabotaging the team'),(4,'inappropriate name'),(5,'disrespectful behaviour'),(6,'threats');
/*!40000 ALTER TABLE `reportsystem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `viewbanranks`
--

DROP TABLE IF EXISTS `viewbanranks`;
/*!50001 DROP VIEW IF EXISTS `viewbanranks`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `viewbanranks` AS SELECT 
 1 AS `PlayerID`,
 1 AS `Username`,
 1 AS `RankName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `viewhighrankregion`
--

DROP TABLE IF EXISTS `viewhighrankregion`;
/*!50001 DROP VIEW IF EXISTS `viewhighrankregion`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `viewhighrankregion` AS SELECT 
 1 AS `PlayerCount`,
 1 AS `Country`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `viewplayersregion`
--

DROP TABLE IF EXISTS `viewplayersregion`;
/*!50001 DROP VIEW IF EXISTS `viewplayersregion`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `viewplayersregion` AS SELECT 
 1 AS `PlayerCount`,
 1 AS `Country`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `playersregion`
--

/*!50001 DROP VIEW IF EXISTS `playersregion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `playersregion` AS select count(0) AS `PlayerCount`,`pd`.`Country` AS `Country` from `playerdetails` `pd` group by `pd`.`Country` order by count(0) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `viewbanranks`
--

/*!50001 DROP VIEW IF EXISTS `viewbanranks`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `viewbanranks` AS select `bans`.`PlayerBannedID` AS `PlayerID`,`playerlogin`.`Username` AS `Username`,`ranksystem`.`RankName` AS `RankName` from (((`bans` join `playerperformance`) join `ranksystem`) join `playerlogin` on(((`bans`.`PlayerBannedID` = `playerperformance`.`PlayerID`) and (`playerperformance`.`PlayerID` = `playerlogin`.`PlayerID`) and (`playerperformance`.`RankID` = `ranksystem`.`RankID`)))) where `bans`.`ReportCategoryID` in (select `reportsystem`.`ReportCategoryID` from `reportsystem` where (`reportsystem`.`ReportCategory` = 'cheating')) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `viewhighrankregion`
--

/*!50001 DROP VIEW IF EXISTS `viewhighrankregion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `viewhighrankregion` AS select count(0) AS `PlayerCount`,`pd`.`Country` AS `Country` from `playerdetails` `pd` where `pd`.`PlayerID` in (select `pp`.`PlayerID` from `playerperformance` `pp` where (`pp`.`RankID` > 6)) group by `pd`.`Country` order by count(0) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `viewplayersregion`
--

/*!50001 DROP VIEW IF EXISTS `viewplayersregion`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `viewplayersregion` AS select count(0) AS `PlayerCount`,`pd`.`Country` AS `Country` from `playerdetails` `pd` group by `pd`.`Country` order by count(0) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-08-23 13:24:53
