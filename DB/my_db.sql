-- MySQL Script generated by MySQL Workbench
-- Fri Jan 12 02:01:32 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`performance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`performance` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` TEXT NOT NULL,
  `duration` INT NOT NULL,
  `genre` TEXT NOT NULL,
  `cast` TEXT NOT NULL,
  `price` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`theatre hall`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`theatre hall` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `performance_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_theatre hall_performance1_idx` (`performance_id` ASC),
  CONSTRAINT `fk_theatre hall_performance1`
    FOREIGN KEY (`performance_id`)
    REFERENCES `mydb`.`performance` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`group` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `row` INT NOT NULL,
  `seatNum` INT NOT NULL,
  `theatre hall_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_group_theatre hall1_idx` (`theatre hall_id` ASC),
  CONSTRAINT `fk_group_theatre hall1`
    FOREIGN KEY (`theatre hall_id`)
    REFERENCES `mydb`.`theatre hall` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`seat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`seat` (
  `idSedista` INT NOT NULL,
  `row` INT NOT NULL,
  `number` INT NOT NULL,
  `group_id` INT NOT NULL,
  PRIMARY KEY (`idSedista`),
  INDEX `fk_seat_group_idx` (`group_id` ASC),
  CONSTRAINT `fk_seat_group`
    FOREIGN KEY (`group_id`)
    REFERENCES `mydb`.`group` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(12) NOT NULL,
  `password` VARCHAR(12) NOT NULL,
  `name` TEXT NOT NULL,
  `surname` TEXT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `userid` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ticket` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `performanceName` TEXT NOT NULL,
  `seat_idSedista` INT NOT NULL,
  `ticketcol` VARCHAR(45) NULL,
  `performance_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ticket_seat1_idx` (`seat_idSedista` ASC),
  INDEX `fk_ticket_performance1_idx` (`performance_id` ASC),
  INDEX `fk_ticket_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_ticket_seat1`
    FOREIGN KEY (`seat_idSedista`)
    REFERENCES `mydb`.`seat` (`idSedista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_performance1`
    FOREIGN KEY (`performance_id`)
    REFERENCES `mydb`.`performance` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ticket_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
