CREATE DATABASE IF NOT EXISTS cdpforge
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_general_ci;

USE cdpforge;

CREATE TABLE `clients` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);

CREATE TABLE `instances` (
  `id` INT NOT NULL,
  `client` INT NOT NULL,
  `description` VARCHAR(100) DEFAULT NULL,
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `fk_instances_clients_idx` (`client`),
  CONSTRAINT `fk_instances_clients`
    FOREIGN KEY (`client`)
    REFERENCES `clients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE `plugins` (
  `id` BIGINT AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `type` VARCHAR(20) NOT NULL,
  `priority` INT NOT NULL,
  `input_topic` VARCHAR(100) NOT NULL,
  `output_topic` VARCHAR(100) DEFAULT NULL,
  `createdAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT `plugins_pk` PRIMARY KEY (`id`),
  CONSTRAINT `plugins_unique` UNIQUE (`name`)
);
