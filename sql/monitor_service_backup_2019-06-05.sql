# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.10)
# Database: monitor_service
# Generation Time: 2019-06-08 04:16:48 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table ActivityType
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ActivityType`;

CREATE TABLE `ActivityType` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `ActivityType` WRITE;
/*!40000 ALTER TABLE `ActivityType` DISABLE KEYS */;

INSERT INTO `ActivityType` (`id`, `type`)
VALUES
	(1,'ACTIVITY'),
	(2,'BENCHMARK'),
	(3,'ERROR');

/*!40000 ALTER TABLE `ActivityType` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table AuditLog
# ------------------------------------------------------------

DROP TABLE IF EXISTS `AuditLog`;

CREATE TABLE `AuditLog` (
  `poi_log_id` int(11) NOT NULL,
  `current_value` varchar(500) DEFAULT NULL,
  `old_value` varchar(500) DEFAULT NULL,
  `entity_name` varchar(45) NOT NULL,
  `entity_id` int(11) DEFAULT NULL,
  `notes` longtext,
  `action` varchar(100) NOT NULL,
  PRIMARY KEY (`poi_log_id`),
  CONSTRAINT `fk_AuditLog_PoiLog1` FOREIGN KEY (`poi_log_id`) REFERENCES `PoiLog` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `AuditLog` WRITE;
/*!40000 ALTER TABLE `AuditLog` DISABLE KEYS */;

INSERT INTO `AuditLog` (`poi_log_id`, `current_value`, `old_value`, `entity_name`, `entity_id`, `notes`, `action`)
VALUES
	(3,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(4,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(6,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(7,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(8,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(9,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(10,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(11,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(12,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(13,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(14,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(15,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(16,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(17,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(18,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(19,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(20,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(21,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(22,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'\\/api\\/job\\/batch'),
	(23,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/job/batch'),
	(24,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(25,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(26,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(27,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(28,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(29,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(30,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(31,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(32,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(33,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(34,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(35,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(36,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(37,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(38,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(39,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(40,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(41,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(42,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(43,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(44,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(45,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(46,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(47,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(48,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(49,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(50,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(51,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(52,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(53,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(54,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(55,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(56,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(57,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(58,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(59,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(60,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(61,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(62,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(63,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(64,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(65,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(66,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(67,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(68,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(69,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login'),
	(70,'{\"jobs\": \"11, 12\"}',NULL,'Job',NULL,NULL,'/api/login');

/*!40000 ALTER TABLE `AuditLog` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table Client
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Client`;

CREATE TABLE `Client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `user_agent` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `Client` WRITE;
/*!40000 ALTER TABLE `Client` DISABLE KEYS */;

INSERT INTO `Client` (`id`, `username`, `user_agent`)
VALUES
	(4,'bla@test.com','PostmanRuntime\\/7.6.1'),
	(5,'bla@test.com','PostmanRuntime/7.6.1');

/*!40000 ALTER TABLE `Client` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table ErrorLog
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ErrorLog`;

CREATE TABLE `ErrorLog` (
  `poi_log_id` int(11) NOT NULL,
  `severity` varchar(45) NOT NULL,
  `message` varchar(500) NOT NULL,
  `code` int(11) NOT NULL,
  `trace_message` longtext NOT NULL,
  `meta_data` longtext,
  PRIMARY KEY (`poi_log_id`),
  CONSTRAINT `fk_ErrorLog_PoiLog1` FOREIGN KEY (`poi_log_id`) REFERENCES `PoiLog` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `ErrorLog` WRITE;
/*!40000 ALTER TABLE `ErrorLog` DISABLE KEYS */;

INSERT INTO `ErrorLog` (`poi_log_id`, `severity`, `message`, `code`, `trace_message`, `meta_data`)
VALUES
	(5,'high','Unexpected Exception. Try again later',500,'cURL error 7: Failed to connect to localhost port 8004: Connection refused (see http:\\/\\/curl.haxx.se\\/libcurl\\/c\\/libcurl-errors.html)',NULL);

/*!40000 ALTER TABLE `ErrorLog` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table Log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Log`;

CREATE TABLE `Log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(45) NOT NULL,
  `service` varchar(45) NOT NULL,
  `log` longtext NOT NULL,
  `logged_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table MetricsLog
# ------------------------------------------------------------

DROP TABLE IF EXISTS `MetricsLog`;

CREATE TABLE `MetricsLog` (
  `cpu_usage` decimal(10,3) DEFAULT NULL,
  `response_time_ms` decimal(10,3) DEFAULT NULL,
  `poi_log_id` int(11) NOT NULL,
  `requested_at` datetime DEFAULT NULL,
  `response_at` datetime DEFAULT NULL,
  `resource` varchar(45) NOT NULL,
  `method` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`poi_log_id`),
  KEY `fk_MetricsLog_PoiLog1_idx` (`poi_log_id`),
  CONSTRAINT `fk_MetricsLog_PoiLog1` FOREIGN KEY (`poi_log_id`) REFERENCES `PoiLog` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `MetricsLog` WRITE;
/*!40000 ALTER TABLE `MetricsLog` DISABLE KEYS */;

INSERT INTO `MetricsLog` (`cpu_usage`, `response_time_ms`, `poi_log_id`, `requested_at`, `response_at`, `resource`, `method`)
VALUES
	(NULL,12.866,3,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/job/batch','PATCH'),
	(NULL,12.866,4,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/job/batch','PATCH'),
	(NULL,12.866,6,'2019-05-12 16:39:27','2019-05-12 16:39:27','\\/api\\/job\\/batch','PATCH'),
	(NULL,12.866,7,'2019-05-12 16:39:27','2019-05-12 16:39:27','\\/api\\/job\\/batch','PATCH'),
	(NULL,12.866,8,'2019-05-12 16:39:27','2019-05-12 16:39:27','\\/api\\/job\\/batch','PATCH'),
	(NULL,12.866,9,'2019-05-12 16:39:27','2019-05-12 16:39:27','\\/api\\/job\\/batch','PATCH'),
	(NULL,12.866,10,'2019-05-12 16:39:27','2019-05-12 16:39:27','\\/api\\/job\\/batch','PATCH'),
	(NULL,12.866,11,'2019-05-12 16:39:27','2019-05-12 16:39:27','\\/api\\/job\\/batch','PATCH'),
	(NULL,12.866,12,'2019-05-12 16:39:27','2019-05-12 16:39:27','\\/api\\/job\\/batch','PATCH'),
	(NULL,12.866,13,'2019-05-12 16:39:27','2019-05-12 16:39:27','\\/api\\/job\\/batch','PATCH'),
	(NULL,12.866,14,'2019-05-12 16:39:27','2019-05-12 16:39:27','\\/api\\/job\\/batch','PATCH'),
	(NULL,12.866,15,'2019-05-12 16:39:27','2019-05-12 16:39:27','\\/api\\/job\\/batch','PATCH'),
	(NULL,12.866,16,'2019-05-12 16:39:27','2019-05-12 16:39:27','\\/api\\/job\\/batch','PATCH'),
	(NULL,12.866,17,'2019-05-12 16:39:27','2019-05-12 16:39:27','\\/api\\/job\\/batch','PATCH'),
	(NULL,12.866,18,'2019-05-12 16:39:27','2019-05-12 16:39:27','\\/api\\/job\\/batch','PATCH'),
	(NULL,12.866,19,'2019-05-12 16:39:27','2019-05-12 16:39:27','\\/api\\/job\\/batch','PATCH'),
	(NULL,12.866,20,'2019-05-12 16:39:27','2019-05-12 16:39:27','\\/api\\/job\\/batch','PATCH'),
	(NULL,12.866,21,'2019-05-12 16:39:27','2019-05-12 16:39:27','\\/api\\/job\\/batch','PATCH'),
	(NULL,12.866,22,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/job/batch','PATCH'),
	(NULL,12.866,23,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/job/batch','PATCH'),
	(NULL,12.866,24,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,25,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,26,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,27,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,28,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,29,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,30,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,31,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,32,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,33,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,34,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,35,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,36,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,37,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,38,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,39,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,40,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,41,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,42,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,43,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,44,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,45,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,46,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,47,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,48,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,49,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,50,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,51,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,52,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,53,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,54,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,55,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,56,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,57,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,58,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,59,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,60,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,61,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,62,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,63,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,64,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,65,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,66,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,67,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,68,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,69,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH'),
	(NULL,12.866,70,'2019-05-12 16:39:27','2019-05-12 16:39:27','/api/login','PATCH');

/*!40000 ALTER TABLE `MetricsLog` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table PoiLog
# ------------------------------------------------------------

DROP TABLE IF EXISTS `PoiLog`;

CREATE TABLE `PoiLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created_at` datetime NOT NULL,
  `activity_type_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `ip` varchar(45) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  PRIMARY KEY (`id`,`activity_type_id`,`client_id`),
  KEY `fk_PoiLog_ActivityType1_idx` (`activity_type_id`),
  KEY `fk_PoiLog_Client1_idx` (`client_id`),
  CONSTRAINT `fk_PoiLog_ActivityType1` FOREIGN KEY (`activity_type_id`) REFERENCES `ActivityType` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PoiLog_Client1` FOREIGN KEY (`client_id`) REFERENCES `Client` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `PoiLog` WRITE;
/*!40000 ALTER TABLE `PoiLog` DISABLE KEYS */;

INSERT INTO `PoiLog` (`id`, `created_at`, `activity_type_id`, `user_id`, `ip`, `client_id`)
VALUES
	(3,'2019-06-03 21:00:29',1,200,'127.0.0.1',4),
	(4,'2019-06-03 21:01:03',1,200,'127.0.0.1',4),
	(5,'2019-06-03 22:24:46',3,200,'127.0.0.1',4),
	(6,'2019-06-04 00:13:11',1,200,'127.0.0.1',4),
	(7,'2019-06-04 00:13:38',1,200,'127.0.0.1',4),
	(8,'2019-06-04 00:14:12',1,200,'127.0.0.1',4),
	(9,'2019-06-04 00:16:41',1,200,'127.0.0.1',4),
	(10,'2019-06-04 00:17:11',1,200,'127.0.0.1',4),
	(11,'2019-06-04 00:17:59',1,200,'127.0.0.1',4),
	(12,'2019-06-04 00:22:44',1,200,'127.0.0.1',4),
	(13,'2019-06-04 00:23:35',1,200,'127.0.0.1',4),
	(14,'2019-06-04 18:47:39',1,200,'127.0.0.1',4),
	(15,'2019-06-04 18:54:33',1,200,'127.0.0.1',4),
	(16,'2019-06-04 18:55:32',1,200,'127.0.0.1',4),
	(17,'2019-06-04 18:56:33',1,200,'127.0.0.1',4),
	(18,'2019-06-04 19:05:09',1,200,'127.0.0.1',4),
	(19,'2019-06-04 19:05:27',1,200,'127.0.0.1',4),
	(20,'2019-06-04 19:06:31',1,200,'127.0.0.1',4),
	(21,'2019-06-04 19:07:09',1,200,'127.0.0.1',4),
	(22,'2019-06-04 19:08:30',1,200,'127.0.0.1',4),
	(23,'2019-06-04 20:09:31',1,200,'127.0.0.1',5),
	(24,'2019-06-04 20:10:13',1,200,'127.0.0.1',5),
	(25,'2019-06-04 21:00:39',1,200,'127.0.0.1',5),
	(26,'2019-06-04 21:06:18',1,200,'127.0.0.1',5),
	(27,'2019-06-04 21:09:01',1,200,'127.0.0.1',5),
	(28,'2019-06-04 21:09:31',1,200,'127.0.0.1',5),
	(29,'2019-06-04 21:14:41',1,200,'127.0.0.1',5),
	(30,'2019-06-04 21:17:01',1,200,'127.0.0.1',5),
	(31,'2019-06-04 21:17:08',1,200,'127.0.0.1',5),
	(32,'2019-06-04 21:17:09',1,200,'127.0.0.1',5),
	(33,'2019-06-04 21:17:10',1,200,'127.0.0.1',5),
	(34,'2019-06-04 21:17:13',1,200,'127.0.0.1',5),
	(35,'2019-06-04 21:17:15',1,200,'127.0.0.1',5),
	(36,'2019-06-04 21:17:16',1,200,'127.0.0.1',5),
	(37,'2019-06-04 21:17:17',1,200,'127.0.0.1',5),
	(38,'2019-06-04 21:17:19',1,200,'127.0.0.1',5),
	(39,'2019-06-04 21:19:07',1,200,'127.0.0.1',5),
	(40,'2019-06-04 21:19:08',1,200,'127.0.0.1',5),
	(41,'2019-06-04 21:19:09',1,200,'127.0.0.1',5),
	(42,'2019-06-04 21:35:33',1,200,'127.0.0.1',5),
	(43,'2019-06-04 21:35:34',1,200,'127.0.0.1',5),
	(44,'2019-06-04 21:35:35',1,200,'127.0.0.1',5),
	(45,'2019-06-04 21:35:36',1,200,'127.0.0.1',5),
	(46,'2019-06-04 21:35:37',1,200,'127.0.0.1',5),
	(47,'2019-06-04 21:35:38',1,200,'127.0.0.1',5),
	(48,'2019-06-05 19:17:39',1,200,'127.0.0.1',5),
	(49,'2019-06-05 19:17:40',1,200,'127.0.0.1',5),
	(50,'2019-06-05 19:17:43',1,200,'127.0.0.1',5),
	(51,'2019-06-05 19:17:47',1,200,'127.0.0.1',5),
	(52,'2019-06-05 19:17:49',1,200,'127.0.0.1',5),
	(53,'2019-06-05 19:19:51',1,200,'127.0.0.1',5),
	(54,'2019-06-05 19:19:52',1,200,'127.0.0.1',5),
	(55,'2019-06-05 19:19:53',1,200,'127.0.0.1',5),
	(56,'2019-06-05 19:19:54',1,200,'127.0.0.1',5),
	(57,'2019-06-05 19:57:50',1,200,'127.0.0.1',5),
	(58,'2019-06-05 19:57:51',1,200,'127.0.0.1',5),
	(59,'2019-06-05 19:57:52',1,200,'127.0.0.1',5),
	(60,'2019-06-05 19:57:53',1,200,'127.0.0.1',5),
	(61,'2019-06-05 19:57:55',1,200,'127.0.0.1',5),
	(62,'2019-06-05 19:57:56',1,200,'127.0.0.1',5),
	(63,'2019-06-05 19:57:57',1,200,'127.0.0.1',5),
	(64,'2019-06-05 20:02:30',1,200,'127.0.0.1',5),
	(65,'2019-06-05 20:06:31',1,200,'127.0.0.1',5),
	(66,'2019-06-05 20:06:32',1,200,'127.0.0.1',5),
	(67,'2019-06-05 20:06:33',1,200,'127.0.0.1',5),
	(68,'2019-06-05 20:06:34',1,200,'127.0.0.1',5),
	(69,'2019-06-05 20:06:36',1,200,'127.0.0.1',5),
	(70,'2019-06-05 20:06:38',1,200,'127.0.0.1',5);

/*!40000 ALTER TABLE `PoiLog` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
