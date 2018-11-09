-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `Wharehouse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Wharehouse` ;

CREATE TABLE IF NOT EXISTS `Wharehouse` (
  `wharehouseNumber` INT NOT NULL,
  `wharehouseName` VARCHAR(45) NOT NULL,
  `streetNumber` VARCHAR(45) NULL,
  `streetName` VARCHAR(45) NULL,
  `city` ENUM('Sydney', 'Brisbane', 'Melbourne'),
  `suburb` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `postcode` VARCHAR(45) NULL,
  `wharehouseHeadName` VARCHAR(45) NULL,
  `numberEmployees` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`wharehouseNumber`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Publisher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Publisher` ;

CREATE TABLE IF NOT EXISTS `Publisher` (
  `publisherCode` INT NOT NULL,
  `publisherName` VARCHAR(45) NOT NULL,
  `publisherCity` VARCHAR(45) NULL,
  `publisherState` VARCHAR(45) NULL,
  `publisherEmail` VARCHAR(45) NULL,
  PRIMARY KEY (`publisherCode`, `publisherName`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Author` ;

CREATE TABLE IF NOT EXISTS `Author` (
  `authorNumber` INT NOT NULL,
  `authorName` VARCHAR(45) NOT NULL,
  `authorEmail` VARCHAR(45) NULL,
  PRIMARY KEY (`authorNumber`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Item` ;

CREATE TABLE IF NOT EXISTS `Item` (
  `itemCode` VARCHAR(12) NOT NULL,
  `itemTitle` VARCHAR(45) NOT NULL,
  `publisherCode` INT NOT NULL,
  `itemType` ENUM('paperback', 'eBook', 'other'),
  `stockPrice` DOUBLE NULL,
  `ISBN` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`itemCode`, `ISBN`, `itemTitle`, `publisherCode`),
  INDEX `fk_Item_1_idx` (`publisherCode` ASC),
  CONSTRAINT `fk_Item_1`
    FOREIGN KEY (`publisherCode`)
    REFERENCES `Publisher` (`publisherCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ItemWriters`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ItemWriters` ;

CREATE TABLE IF NOT EXISTS `ItemWriters` (
  `itemCode` VARCHAR(12) NOT NULL,
  `authorNumber` INT NOT NULL,
  `writerSequenceNumber` INT NULL,
  PRIMARY KEY (`itemCode`),
  INDEX `fk_ItemWriters_1_idx` (`authorNumber` ASC),
  CONSTRAINT `fk_ItemWriters_1`
    FOREIGN KEY (`authorNumber`)
    REFERENCES `Author` (`authorNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ItemWriters_2`
    FOREIGN KEY (`itemCode`)
    REFERENCES `Item` (`itemCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Inventory` ;

CREATE TABLE IF NOT EXISTS `Inventory` (
  `itemCode` VARCHAR(12) NOT NULL,
  `wharehouseNumber` INT NOT NULL,
  `unitsOnHand` INT NOT NULL,
  PRIMARY KEY (`itemCode`),
  INDEX `fk_Inventory_2_idx` (`wharehouseNumber` ASC),
  CONSTRAINT `fk_Inventory_1`
    FOREIGN KEY (`itemCode`)
    REFERENCES `Item` (`itemCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Inventory_2`
    FOREIGN KEY (`wharehouseNumber`)
    REFERENCES `Wharehouse` (`wharehouseNumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
