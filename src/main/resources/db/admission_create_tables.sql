-- -----------------------------------------------------
-- Schema admission
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `admission` ;

-- -----------------------------------------------------
-- Schema admission
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `admission` ;
USE `admission` ;


-- -----------------------------------------------------
-- Table `speciality`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `speciality` ;

CREATE TABLE IF NOT EXISTS `speciality` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `subject` ;

CREATE TABLE IF NOT EXISTS `subject` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `speciality_subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `speciality_subject` ;

CREATE TABLE IF NOT EXISTS `speciality_subject` (
  `speciality_id` BIGINT(20) NOT NULL,
  `subject_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`speciality_id`, `subject_id`),
  INDEX `FKbvlrspwe5cj3t0fde37px7lyu` (`subject_id` ASC),
  CONSTRAINT `FKbvlrspwe5cj3t0fde37px7lyu`
    FOREIGN KEY (`subject_id`)
    REFERENCES `subject` (`id`),
  CONSTRAINT `FKi1h4260k9cra32fo5a8u3shpf`
    FOREIGN KEY (`speciality_id`)
    REFERENCES `speciality` (`id`));


-- -----------------------------------------------------
-- Table `usr`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `usr` ;

CREATE TABLE IF NOT EXISTS `usr` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `speciality_id` BIGINT(20) NULL DEFAULT NULL,
  `account_non_expired` BOOLEAN,
  `account_non_locked` BOOLEAN,
  `credentials_non_expired` BOOLEAN,
  `enabled` BOOLEAN,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UKdfui7gxngrgwn9ewee3ogtgym` (`username` ASC),
  INDEX `FKpxxdan81grbl691clwm0i4ux7` (`speciality_id` ASC),
  CONSTRAINT `FKpxxdan81grbl691clwm0i4ux7`
    FOREIGN KEY (`speciality_id`)
    REFERENCES `speciality` (`id`)
    ON DELETE CASCADE);


-- -----------------------------------------------------
-- Table `admission`.`message`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `message` (
  `average_grade` DOUBLE NOT NULL,
  `message_read` BIT(1) NULL,
  `user_id` BIGINT(20) NOT NULL,
  `entered` BIT(1) NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `FK70bv6o4exfe3fbrho7nuotopf`
    FOREIGN KEY (`user_id`)
    REFERENCES `usr` (`id`));


-- -----------------------------------------------------
-- Table `subject_grade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `subject_grade` ;

CREATE TABLE IF NOT EXISTS `subject_grade` (
  `grade` INT(11) NOT NULL,
  `subject_id` BIGINT(20) NOT NULL,
  `user_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`subject_id`, `user_id`),
  INDEX `FK947k4ym625vhlb4afylpuul8i` (`user_id` ASC),
  CONSTRAINT `FK7ndcktiy0re9epm98or2yu0f9`
    FOREIGN KEY (`subject_id`)
    REFERENCES `subject` (`id`),
  CONSTRAINT `FK947k4ym625vhlb4afylpuul8i`
    FOREIGN KEY (`user_id`)
    REFERENCES `usr` (`id`));


-- -----------------------------------------------------
-- Table `user_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_role` ;

CREATE TABLE IF NOT EXISTS `user_role` (
  `user_id` BIGINT(20) NOT NULL,
  `role_name` VARCHAR(255) NOT NULL,
  INDEX `FKfpm8swft53ulq2hl11yplpr5` (`user_id` ASC),
  CONSTRAINT `FKfpm8swft53ulq2hl11yplpr5`
    FOREIGN KEY (`user_id`)
    REFERENCES `usr` (`id`));
