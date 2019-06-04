-- MySQL Script generated by MySQL Workbench
-- Mon Jun  3 19:53:30 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema monitor_service
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `monitor_service` ;

-- -----------------------------------------------------
-- Schema monitor_service
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `monitor_service` DEFAULT CHARACTER SET utf8 ;
USE `monitor_service` ;

-- -----------------------------------------------------
-- Table `monitor_service`.`ActivityType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `monitor_service`.`ActivityType` ;

CREATE TABLE IF NOT EXISTS `monitor_service`.`ActivityType` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitor_service`.`Client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `monitor_service`.`Client` ;

CREATE TABLE IF NOT EXISTS `monitor_service`.`Client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `user_agent` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitor_service`.`PoiLog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `monitor_service`.`PoiLog` ;

CREATE TABLE IF NOT EXISTS `monitor_service`.`PoiLog` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL,
  `activity_type_id` INT NOT NULL,
  `user_id` INT NULL,
  `ip` VARCHAR(45) NULL,
  `client_id` INT NOT NULL,
  PRIMARY KEY (`id`, `activity_type_id`, `client_id`),
  INDEX `fk_PoiLog_ActivityType1_idx` (`activity_type_id` ASC),
  INDEX `fk_PoiLog_Client1_idx` (`client_id` ASC),
  CONSTRAINT `fk_PoiLog_ActivityType1`
    FOREIGN KEY (`activity_type_id`)
    REFERENCES `monitor_service`.`ActivityType` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PoiLog_Client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `monitor_service`.`Client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitor_service`.`MetricsLog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `monitor_service`.`MetricsLog` ;

CREATE TABLE IF NOT EXISTS `monitor_service`.`MetricsLog` (
  `cpu_usage` DECIMAL(10,3) NULL,
  `response_time_ms` DECIMAL(10,3) NULL,
  `poi_log_id` INT NOT NULL,
  `requested_at` DATETIME NULL,
  `response_at` DATETIME NULL,
  `resource` VARCHAR(45) NOT NULL,
  `method` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`poi_log_id`),
  INDEX `fk_MetricsLog_PoiLog1_idx` (`poi_log_id` ASC),
  CONSTRAINT `fk_MetricsLog_PoiLog1`
    FOREIGN KEY (`poi_log_id`)
    REFERENCES `monitor_service`.`PoiLog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitor_service`.`AuditLog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `monitor_service`.`AuditLog` ;

CREATE TABLE IF NOT EXISTS `monitor_service`.`AuditLog` (
  `poi_log_id` INT NOT NULL,
  `current_value` VARCHAR(500) NULL,
  `old_value` VARCHAR(500) NULL,
  `entity_name` VARCHAR(45) NOT NULL,
  `entity_id` INT NULL,
  `notes` LONGTEXT NULL,
  `action` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`poi_log_id`),
  CONSTRAINT `fk_AuditLog_PoiLog1`
    FOREIGN KEY (`poi_log_id`)
    REFERENCES `monitor_service`.`PoiLog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitor_service`.`ErrorLog`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `monitor_service`.`ErrorLog` ;

CREATE TABLE IF NOT EXISTS `monitor_service`.`ErrorLog` (
  `poi_log_id` INT NOT NULL,
  `severity` VARCHAR(45) NOT NULL,
  `message` VARCHAR(500) NOT NULL,
  `code` INT NOT NULL,
  `trace_message` LONGTEXT NOT NULL,
  `meta_data` LONGTEXT NULL,
  PRIMARY KEY (`poi_log_id`),
  CONSTRAINT `fk_ErrorLog_PoiLog1`
    FOREIGN KEY (`poi_log_id`)
    REFERENCES `monitor_service`.`PoiLog` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `monitor_service`.`Log`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `monitor_service`.`Log` ;

CREATE TABLE IF NOT EXISTS `monitor_service`.`Log` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  `service` VARCHAR(45) NOT NULL,
  `log` LONGTEXT NOT NULL,
  `logged_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
