CREATE DATABASE  IF NOT EXISTS `PetHospital` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `PetHospital`;
DROP TABLE IF EXISTS `event`;
DROP TABLE IF EXISTS `pet`;
DROP TABLE IF EXISTS `owner`;
CREATE TABLE `owner` (
  `id` int(11) NOT NULL,
  `first_name` varchar(45) NOT NULL COMMENT '	',
  `last_name` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO `owner` VALUES (1,'Jens','Andersen','Mimersgade 143'),(2,'Arne','Hansen','Strandvejen 12'),(3,'Hanne','Jensen','Oluf Palmes Allé 98 1. th');

CREATE TABLE `pet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `birth` date NOT NULL,
  `species` varchar(45) NOT NULL,
  `death` date DEFAULT NULL,
  `owner_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_idx` (`owner_id`),
  CONSTRAINT `owner` FOREIGN KEY (`owner_id`) REFERENCES `owner` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
INSERT INTO `pet` VALUES (1,'Fiddo','2015-02-01','Dog',NULL,1),(2,'Hannibal','2013-05-10','Dog',NULL,1),(3,'Elvis','2010-08-08','Cat',NULL,3),(4,'Sam','2012-01-05','Rabbit','2015-07-07',2);



CREATE TABLE `event` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pet_id` int(11) NOT NULL,
  `event` varchar(45) NOT NULL,
  `remark` varchar(45) DEFAULT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pet_idx` (`pet_id`),
  CONSTRAINT `pet` FOREIGN KEY (`pet_id`) REFERENCES `pet` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
INSERT INTO `event` VALUES (1,4,'Death','Died of age','2015-07-07'),(2,2,'Broken bone','Ribbs broken','2015-02-08'),(3,3,'Medicine','Antibiotics for wound on back leg','2015-03-10');

