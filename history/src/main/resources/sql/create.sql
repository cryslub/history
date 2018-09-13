delimiter $$
CREATE DATABASE `test` /*!40100 DEFAULT CHARACTER SET latin1 */$$
delimiter $$

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1$$

INSERT INTO `category` VALUES (1,'Apparel');