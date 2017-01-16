# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 0.0.0.0 (MySQL 5.7.17)
# Database: fitmap
# Generation Time: 2017-01-16 02:45:53 +0000
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
  CONSTRAINT `ROUTEUSER` FOREIGN KEY (`iduser`) REFERENCES `USUARIO` (`iduser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table USER
# ------------------------------------------------------------

DROP TABLE IF EXISTS `USER`;

CREATE TABLE `USER` (
  `iduser` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(25) NOT NULL DEFAULT '',
  `lastname` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`iduser`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
