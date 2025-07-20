CREATE TABLE `settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `client` int NOT NULL,
  `field` varchar(12) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `client` (`client`),
  KEY `field` (`field`),
  CONSTRAINT `settings_ibfk_1` FOREIGN KEY (`client`) REFERENCES `clients` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3
