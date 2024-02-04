-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema inventory_management_system
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema inventory_management_system
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `inventory_management_system2` DEFAULT CHARACTER SET latin1 ;
USE `inventory_management_system2` ;

-- -----------------------------------------------------
-- Table `inventory_management_system`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_management_system2`.`customer` (
  `customer_ID` INT(11) NOT NULL,
  `customer_Name` VARCHAR(100) NULL DEFAULT NULL,
  `customer_Add` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `inventory_management_system`.`delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_management_system2`.`delivery` (
  `Delivery_ID` INT(11) NOT NULL,
  `sales_Date` DATE NULL DEFAULT NULL,
  `customer_customer_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Delivery_ID`, `customer_customer_ID`),
  INDEX `fk_delivery_customer1_idx` (`customer_customer_ID` ASC),
  CONSTRAINT `fk_delivery_customer1`
    FOREIGN KEY (`customer_customer_ID`)
    REFERENCES `inventory_management_system`.`customer` (`customer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `inventory_management_system`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_management_system2`.`location` (
  `Location_ID` INT(11) NOT NULL,
  `Location_Name` VARCHAR(100) NULL DEFAULT NULL,
  `Location_address` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`Location_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `inventory_management_system`.`ware_house`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_management_system2`.`ware_house` (
  `warehouse_ID` INT(11) NOT NULL,
  `warehouse_Name` VARCHAR(100) NULL DEFAULT NULL,
  `Is_Refrigerated` TINYINT(1) NULL DEFAULT NULL,
  `location_Location_ID` INT(11) NOT NULL,
  PRIMARY KEY (`warehouse_ID`, `location_Location_ID`),
  INDEX `fk_ware_house_location1_idx` (`location_Location_ID` ASC),
  CONSTRAINT `fk_ware_house_location1`
    FOREIGN KEY (`location_Location_ID`)
    REFERENCES `inventory_management_system`.`location` (`Location_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `inventory_management_system`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_management_system2`.`product` (
  `ProductID` INT(11) NOT NULL,
  `ProductCode` VARCHAR(100) NULL DEFAULT NULL,
  `Barcode` VARCHAR(100) NULL DEFAULT NULL,
  `Product_Name` VARCHAR(100) NULL DEFAULT NULL,
  `Product_Description` VARCHAR(2000) NULL DEFAULT NULL,
  `Product_Category` VARCHAR(100) NULL DEFAULT NULL,
  `Reorder_Quantity` INT(11) NULL DEFAULT NULL,
  `Packed_Weight` FLOAT(10,2) NULL DEFAULT NULL,
  `Packed_Height` FLOAT(10,2) NULL DEFAULT NULL,
  `Packed_Width` FLOAT(10,2) NULL DEFAULT NULL,
  `Packed_Depth` FLOAT(10,2) NULL DEFAULT NULL,
  `Refrigerated` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`ProductID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `inventory_management_system`.`delivery_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_management_system2`.`delivery_details` (
  `delivery_detail_ID` INT(11) NULL DEFAULT NULL,
  `delivery_quantity` INT(11) NULL DEFAULT NULL,
  `Expected_Date` DATE NULL DEFAULT NULL,
  `Actual_Date` DATE NULL DEFAULT NULL,
  `ware_house_warehouse_ID` INT(11) NOT NULL,
  `ware_house_location_Location_ID` INT(11) NOT NULL,
  `product_ProductID` INT(11) NOT NULL,
  `delivery_Delivery_ID` INT(11) NOT NULL,
  `delivery_customer_customer_ID` INT(11) NOT NULL,
  PRIMARY KEY (`ware_house_warehouse_ID`, `ware_house_location_Location_ID`, `product_ProductID`, `delivery_Delivery_ID`, `delivery_customer_customer_ID`),
  INDEX `fk_delivery_details_product1_idx` (`product_ProductID` ASC) ,
  INDEX `fk_delivery_details_delivery1_idx` (`delivery_Delivery_ID` ASC, `delivery_customer_customer_ID` ASC) ,
  CONSTRAINT `fk_delivery_details_ware_house1`
    FOREIGN KEY (`ware_house_warehouse_ID` , `ware_house_location_Location_ID`)
    REFERENCES `inventory_management_system2`.`ware_house` (`warehouse_ID` , `location_Location_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_delivery_details_product1`
    FOREIGN KEY (`product_ProductID`)
    REFERENCES `inventory_management_system2`.`product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_delivery_details_delivery1`
    FOREIGN KEY (`delivery_Delivery_ID` , `delivery_customer_customer_ID`)
    REFERENCES `inventory_management_system2`.`delivery` (`Delivery_ID` , `customer_customer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `inventory_management_system`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_management_system2`.`inventory` (
  `Inventory_ID` INT(11) NOT NULL,
  `Quantity_available` INT(11) NULL DEFAULT NULL,
  `Min_Stock_Level` INT(11) NULL DEFAULT NULL,
  `Max_Stock_level` INT(11) NULL DEFAULT NULL,
  `Reorder_Point` INT(11) NULL DEFAULT NULL,
  `product_ProductID` INT(11) NOT NULL,
  `ware_house_warehouse_ID` INT(11) NOT NULL,
  `ware_house_location_Location_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Inventory_ID`, `product_ProductID`, `ware_house_warehouse_ID`, `ware_house_location_Location_ID`),
  INDEX `fk_inventory_product1_idx` (`product_ProductID` ASC) ,
  INDEX `fk_inventory_ware_house1_idx` (`ware_house_warehouse_ID` ASC, `ware_house_location_Location_ID` ASC) ,
  CONSTRAINT `fk_inventory_product1`
    FOREIGN KEY (`product_ProductID`)
    REFERENCES `inventory_management_system2`.`product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_ware_house1`
    FOREIGN KEY (`ware_house_warehouse_ID` , `ware_house_location_Location_ID`)
    REFERENCES `inventory_management_system2`.`ware_house` (`warehouse_ID` , `location_Location_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `inventory_management_system`.`provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_management_system2`.`provider` (
  `Provider_ID` INT(11) NOT NULL,
  `Provider_Name` VARCHAR(100) NULL DEFAULT NULL,
  `Provider_Add` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`Provider_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `inventory_management_system`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_management_system2`.`orders` (
  `Order_ID` INT(11) NOT NULL,
  `Order_Date` DATE NULL DEFAULT NULL,
  `provider_Provider_ID` INT(11) NOT NULL,
  PRIMARY KEY (`Order_ID`, `provider_Provider_ID`),
  INDEX `fk_orders_provider_idx` (`provider_Provider_ID` ASC) ,
  CONSTRAINT `fk_orders_provider`
    FOREIGN KEY (`provider_Provider_ID`)
    REFERENCES `inventory_management_system2`.`provider` (`Provider_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `inventory_management_system`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_management_system2`.`order_details` (
  `order_detail_ID` INT(11) NOT NULL,
  `order_quantity` INT(11) NULL DEFAULT NULL,
  `Expected_Date` DATE NULL DEFAULT NULL,
  `Actual_Date` DATE NULL DEFAULT NULL,
  `orders_Order_ID` INT(11) NOT NULL,
  `orders_provider_Provider_ID` INT(11) NOT NULL,
  `product_ProductID` INT(11) NOT NULL,
  `ware_house_warehouse_ID` INT(11) NOT NULL,
  PRIMARY KEY (`order_detail_ID`, `orders_Order_ID`, `orders_provider_Provider_ID`, `product_ProductID`, `ware_house_warehouse_ID`),
  INDEX `fk_order_details_orders1_idx` (`orders_Order_ID` ASC, `orders_provider_Provider_ID` ASC) ,
  INDEX `fk_order_details_product1_idx` (`product_ProductID` ASC) ,
  INDEX `fk_order_details_ware_house1_idx` (`ware_house_warehouse_ID` ASC) ,
  CONSTRAINT `fk_order_details_orders1`
    FOREIGN KEY (`orders_Order_ID` , `orders_provider_Provider_ID`)
    REFERENCES `inventory_management_system2`.`orders` (`Order_ID` , `provider_Provider_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_details_product1`
    FOREIGN KEY (`product_ProductID`)
    REFERENCES `inventory_management_system2`.`product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_details_ware_house1`
    FOREIGN KEY (`ware_house_warehouse_ID`)
    REFERENCES `inventory_management_system2`.`ware_house` (`warehouse_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `inventory_management_system`.`transfer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_management_system2`.`transfer` (
  `Transfer_ID` INT(11) NOT NULL,
  `Transfer_Quantity` INT(11) NULL DEFAULT NULL,
  `sent_date` DATE NULL DEFAULT NULL,
  `received_date` DATE NULL DEFAULT NULL,
  `product_ProductID` INT(11) NOT NULL,
  PRIMARY KEY (`Transfer_ID`, `product_ProductID`),
  INDEX `fk_transfer_product1_idx` (`product_ProductID` ASC),
  CONSTRAINT `fk_transfer_product1`
    FOREIGN KEY (`product_ProductID`)
    REFERENCES `inventory_management_system2`.`product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
