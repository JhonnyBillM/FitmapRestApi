# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.17)
# Database: fitmap
# Generation Time: 2017-01-23 18:32:51 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table HISTORY
# ------------------------------------------------------------

DROP TABLE IF EXISTS `HISTORY`;

CREATE TABLE `HISTORY` (
  `idhistory` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `idroute` int(11) unsigned NOT NULL,
  `iduser` int(11) unsigned NOT NULL,
  `date` datetime NOT NULL,
  `time` bigint(255) NOT NULL,
  PRIMARY KEY (`idhistory`),
  KEY `HISTORYROUTE` (`idroute`),
  KEY `HISTORYUSER` (`iduser`),
  CONSTRAINT `HISTORYROUTE` FOREIGN KEY (`idroute`) REFERENCES `ROUTE` (`idroute`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `HISTORYUSER` FOREIGN KEY (`iduser`) REFERENCES `USER` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table POINTS
# ------------------------------------------------------------

DROP TABLE IF EXISTS `POINTS`;

CREATE TABLE `POINTS` (
  `idpoint` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `idroute` int(11) unsigned NOT NULL,
  `longitude` double NOT NULL,
  `latitude` double NOT NULL,
  PRIMARY KEY (`idpoint`),
  KEY `ROUTEPOINT` (`idroute`),
  CONSTRAINT `ROUTEPOINT` FOREIGN KEY (`idroute`) REFERENCES `ROUTE` (`idroute`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `POINTS` WRITE;
/*!40000 ALTER TABLE `POINTS` DISABLE KEYS */;

INSERT INTO `POINTS` (`idpoint`, `idroute`, `longitude`, `latitude`)
VALUES
	(83,44,-122.29907018,37.48050104),
	(84,44,-122.29901151,37.48081016),
	(85,44,-122.29896314,37.48112252),
	(86,45,-122.33350505,37.50401014),
	(87,45,-122.33381577,37.50420426),
	(88,46,-122.40094584,37.57613294),
	(89,46,-122.40106956,37.57643435),
	(90,46,-122.40144256,37.57731483),
	(91,46,-122.40131859,37.57701769),
	(92,46,-122.40119688,37.57672629),
	(93,46,-122.40156585,37.57760761),
	(94,46,-122.40167993,37.57788895),
	(95,47,-122.42624687,37.62110118),
	(96,47,-122.42696981,37.62223282),
	(97,47,-122.42661417,37.62166536),
	(98,47,-122.42643085,37.62138398),
	(99,47,-122.42715597,37.62251265),
	(100,47,-122.4267834,37.62194662);

/*!40000 ALTER TABLE `POINTS` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table REVIEW
# ------------------------------------------------------------

DROP TABLE IF EXISTS `REVIEW`;

CREATE TABLE `REVIEW` (
  `iduser` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `idroute` int(11) unsigned NOT NULL,
  `comment` varchar(300) NOT NULL DEFAULT '',
  `rating` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `time` bigint(255) NOT NULL,
  PRIMARY KEY (`iduser`),
  KEY `REVIEWROUTE` (`idroute`),
  CONSTRAINT `REVIEWROUTE` FOREIGN KEY (`idroute`) REFERENCES `ROUTE` (`idroute`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `REVIEWUSER` FOREIGN KEY (`iduser`) REFERENCES `USER` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table ROUTE
# ------------------------------------------------------------

DROP TABLE IF EXISTS `ROUTE`;

CREATE TABLE `ROUTE` (
  `idroute` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `iduser` int(11) unsigned NOT NULL,
  `name` varchar(25) NOT NULL DEFAULT '',
  `time` bigint(255) NOT NULL,
  `rating` int(1) NOT NULL,
  `comment` varchar(300) NOT NULL DEFAULT '',
  `discipline` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`idroute`),
  KEY `ROUTEUSER` (`iduser`),
  CONSTRAINT `ROUTEUSER` FOREIGN KEY (`iduser`) REFERENCES `USER` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `ROUTE` WRITE;
/*!40000 ALTER TABLE `ROUTE` DISABLE KEYS */;

INSERT INTO `ROUTE` (`idroute`, `iduser`, `name`, `time`, `rating`, `comment`, `discipline`)
VALUES
	(44,58,'asd',2921406097,2,'asd',''),
	(45,58,'a',1262049524,2,'a',''),
	(46,58,'DAS',6686920685,2,'asd',''),
	(47,58,'sadasdsa',5517880760,2,'asd','');

/*!40000 ALTER TABLE `ROUTE` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table USER
# ------------------------------------------------------------

DROP TABLE IF EXISTS `USER`;

CREATE TABLE `USER` (
  `iduser` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL DEFAULT '',
  `lastname` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `USER` WRITE;
/*!40000 ALTER TABLE `USER` DISABLE KEYS */;

INSERT INTO `USER` (`iduser`, `name`, `lastname`)
VALUES
	(58,'Rafael','Suazo'),
	(59,'Rafael','Suazo'),
	(60,'Rafael','Suazo'),
	(61,'Rafael','Suazo');

/*!40000 ALTER TABLE `USER` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
