CREATE DATABASE IF NOT EXISTS cdpforge;

USE cdpforge;

CREATE TABLE `clients` (
  `id` BIGINT AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT NOW(),
  `updated_at` DATETIME NOT NULL DEFAULT NOW(),
  PRIMARY KEY (`id`)
);

CREATE TABLE `instances` (
  `id` BIGINT AUTO_INCREMENT NOT NULL,
  `client` INT NOT NULL,
  `description` VARCHAR(100) DEFAULT NULL,
  `active` TINYINT NOT NULL DEFAULT 1,  
  `created_at` DATETIME NOT NULL DEFAULT NOW(),
  `updated_at` DATETIME NOT NULL DEFAULT NOW(),
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
  `created_at` DATETIME NOT NULL DEFAULT NOW(),
  `updated_at` DATETIME NOT NULL DEFAULT NOW(),
  CONSTRAINT `plugins_pk` PRIMARY KEY (`id`),
  CONSTRAINT `plugins_unique` UNIQUE (`name`)
);
