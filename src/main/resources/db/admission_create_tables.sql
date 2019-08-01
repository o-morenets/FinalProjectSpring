-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema admission
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `admission` ;

-- -----------------------------------------------------
-- Schema admission
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `admission` DEFAULT CHARACTER SET utf8 ;
USE `admission` ;

-- -----------------------------------------------------
-- Table `persistent_logins`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `persistent_logins` ;

CREATE TABLE IF NOT EXISTS `persistent_logins` (
  `username` VARCHAR(64) NOT NULL,
  `series` VARCHAR(64) NOT NULL,
  `token` VARCHAR(64) NOT NULL,
  `last_used` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`series`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `speciality`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `speciality` ;

CREATE TABLE IF NOT EXISTS `speciality` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `subject` ;

CREATE TABLE IF NOT EXISTS `subject` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


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
    REFERENCES `speciality` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `usr`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `usr` ;

CREATE TABLE IF NOT EXISTS `usr` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `account_non_expired` BIT(1) NOT NULL,
  `account_non_locked` BIT(1) NOT NULL,
  `credentials_non_expired` BIT(1) NOT NULL,
  `email` VARCHAR(255) NULL DEFAULT NULL,
  `enabled` BIT(1) NOT NULL,
  `first_name` VARCHAR(255) NULL DEFAULT NULL,
  `last_name` VARCHAR(255) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  `username` VARCHAR(255) NULL DEFAULT NULL,
  `speciality_id` BIGINT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `UKdfui7gxngrgwn9ewee3ogtgym` (`username` ASC),
  INDEX `FKpxxdan81grbl691clwm0i4ux7` (`speciality_id` ASC),
  CONSTRAINT `FKpxxdan81grbl691clwm0i4ux7`
    FOREIGN KEY (`speciality_id`)
    REFERENCES `speciality` (`id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;


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
    REFERENCES `usr` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `user_role`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_role` ;

CREATE TABLE IF NOT EXISTS `user_role` (
  `user_id` BIGINT(20) NOT NULL,
  `role_name` VARCHAR(255) NULL DEFAULT NULL,
  INDEX `FKfpm8swft53ulq2hl11yplpr5` (`user_id` ASC),
  CONSTRAINT `FKfpm8swft53ulq2hl11yplpr5`
    FOREIGN KEY (`user_id`)
    REFERENCES `usr` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `speciality`
-- -----------------------------------------------------
START TRANSACTION;
USE `admission`;
INSERT INTO `speciality` (`id`, `name`) VALUES (1, 'Хімік');
INSERT INTO `speciality` (`id`, `name`) VALUES (2, 'Археолог');
INSERT INTO `speciality` (`id`, `name`) VALUES (3, 'Слюсар');
INSERT INTO `speciality` (`id`, `name`) VALUES (4, 'Ботанік');
INSERT INTO `speciality` (`id`, `name`) VALUES (5, 'Філософ');

COMMIT;


-- -----------------------------------------------------
-- Data for table `subject`
-- -----------------------------------------------------
START TRANSACTION;
USE `admission`;
INSERT INTO `subject` (`id`, `name`) VALUES (1, 'Математика');
INSERT INTO `subject` (`id`, `name`) VALUES (2, 'Українська мова');
INSERT INTO `subject` (`id`, `name`) VALUES (3, 'Біологія');
INSERT INTO `subject` (`id`, `name`) VALUES (4, 'Хімія');
INSERT INTO `subject` (`id`, `name`) VALUES (5, 'Образотворче мистецтво');
INSERT INTO `subject` (`id`, `name`) VALUES (6, 'Географія');
INSERT INTO `subject` (`id`, `name`) VALUES (7, 'Фізика');
INSERT INTO `subject` (`id`, `name`) VALUES (8, 'Технології');
INSERT INTO `subject` (`id`, `name`) VALUES (9, 'Інформатика');
INSERT INTO `subject` (`id`, `name`) VALUES (10, 'Графіка');

COMMIT;


-- -----------------------------------------------------
-- Data for table `speciality_subject`
-- -----------------------------------------------------
START TRANSACTION;
USE `admission`;
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (1, 1);
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (1, 4);
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (1, 7);
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (2, 2);
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (2, 3);
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (2, 4);
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (2, 10);
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (3, 1);
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (3, 3);
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (3, 5);
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (4, 6);
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (4, 10);
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (4, 4);
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (4, 1);
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (5, 8);
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (5, 7);
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (5, 3);
INSERT INTO `speciality_subject` (`speciality_id`, `subject_id`) VALUES (5, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `usr`
-- -----------------------------------------------------
START TRANSACTION;
USE `admission`;
INSERT INTO `usr` (`id`, `account_non_expired`, `account_non_locked`, `credentials_non_expired`, `email`, `enabled`, `first_name`, `last_name`, `password`, `username`, `speciality_id`) VALUES (1, true, true, true, 'serhii.bobkov@ua', true, 'Сергій', 'Бобков', '$2a$10$ajxcWhSO9U.9gLYLe4LtleEQTsGglVKWWEf4VXTTQBoN4q2gF6Ir.', 'a', NULL);
INSERT INTO `usr` (`id`, `account_non_expired`, `account_non_locked`, `credentials_non_expired`, `email`, `enabled`, `first_name`, `last_name`, `password`, `username`, `speciality_id`) VALUES (2, true, true, true, 'iryna.zaychenko@ua', true, 'Ірина', 'Зайченко', '$2a$10$sUbptpNWjkgAA4aPx1BvP.ASfSgcw7YogHUUH/40VSGk/Er6UGxE.', 'z', 2);
INSERT INTO `usr` (`id`, `account_non_expired`, `account_non_locked`, `credentials_non_expired`, `email`, `enabled`, `first_name`, `last_name`, `password`, `username`, `speciality_id`) VALUES (3, true, true, true, 'kateryna.osadcha@ua', true, 'Катерина', 'Осадча', '$2a$10$eb0DPeaKRHBok/mzpqlws.tLRNp7L6abDLVY/uzczHs1JqyoH8Aa6', 'x', 3);
INSERT INTO `usr` (`id`, `account_non_expired`, `account_non_locked`, `credentials_non_expired`, `email`, `enabled`, `first_name`, `last_name`, `password`, `username`, `speciality_id`) VALUES (4, true, true, true, 'alla.shurova@ua', true, 'Алла', 'Шурова', '$2a$10$Fy1DgLO32O/lns/TTwWTTeNd5Xk.moqjrLnvFIwMoOkYTkhnXmLP2', 'q', 1);
INSERT INTO `usr` (`id`, `account_non_expired`, `account_non_locked`, `credentials_non_expired`, `email`, `enabled`, `first_name`, `last_name`, `password`, `username`, `speciality_id`) VALUES (5, true, true, true, 'nataliya.tarasova@ua', true, 'Наталія', 'Тарасова', '$2a$10$S/urAoe6GhQvep9NtHksGOkTE91zByRQQSKkrTfcU4NP.2pbzjBCe', 's', NULL);
INSERT INTO `usr` (`id`, `account_non_expired`, `account_non_locked`, `credentials_non_expired`, `email`, `enabled`, `first_name`, `last_name`, `password`, `username`, `speciality_id`) VALUES (6, true, true, true, 'serhii.zhdanov@ua', true, 'Сергій', 'Жданов', '$2a$10$M59G5hkXHBKbUBqTs0pzDO8VPV9k3pndgf0jwuLnbuVDI/725EXay', 'w', 4);
INSERT INTO `usr` (`id`, `account_non_expired`, `account_non_locked`, `credentials_non_expired`, `email`, `enabled`, `first_name`, `last_name`, `password`, `username`, `speciality_id`) VALUES (7, true, true, true, 'oleksii.morenets@cmail.com', true, 'Олексій', 'Моренець', '$2a$10$llwghixwtyuVUEJk2Hy/xe7Hdm2EkJ8zBbccvnCQCHgRqWFMWtJP.', 'admin', NULL);
INSERT INTO `usr` (`id`, `account_non_expired`, `account_non_locked`, `credentials_non_expired`, `email`, `enabled`, `first_name`, `last_name`, `password`, `username`, `speciality_id`) VALUES (8, true, true, true, 'dmytro.gordiychuk@ua', true, 'Дмитро', 'Гордійчук', '$2a$10$fcKxpgxwtsYOQ97H1G0OhOWIecQ6pCqHZUk4zEpq4/lAllYvrHQhW', 'user', NULL);
INSERT INTO `usr` (`id`, `account_non_expired`, `account_non_locked`, `credentials_non_expired`, `email`, `enabled`, `first_name`, `last_name`, `password`, `username`, `speciality_id`) VALUES (9, true, true, true, 'pavlo.polyakov@ua', true, 'Павло', 'Поляков', '$2a$10$cZjX/8jHXUbPNqjpT6N7DOcXln3N0tLa.14jp.SU.FUzxgt6NEtDS', 'student', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `subject_grade`
-- -----------------------------------------------------
START TRANSACTION;
USE `admission`;
INSERT INTO `subject_grade` (`grade`, `subject_id`, `user_id`) VALUES (70, 2, 2);
INSERT INTO `subject_grade` (`grade`, `subject_id`, `user_id`) VALUES (85, 3, 2);
INSERT INTO `subject_grade` (`grade`, `subject_id`, `user_id`) VALUES (90, 10, 2);
INSERT INTO `subject_grade` (`grade`, `subject_id`, `user_id`) VALUES (100, 1, 3);
INSERT INTO `subject_grade` (`grade`, `subject_id`, `user_id`) VALUES (65, 5, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_role`
-- -----------------------------------------------------
START TRANSACTION;
USE `admission`;
INSERT INTO `user_role` (`user_id`, `role_name`) VALUES (1, 'ADMIN');
INSERT INTO `user_role` (`user_id`, `role_name`) VALUES (2, 'USER');
INSERT INTO `user_role` (`user_id`, `role_name`) VALUES (3, 'USER');
INSERT INTO `user_role` (`user_id`, `role_name`) VALUES (4, 'USER');
INSERT INTO `user_role` (`user_id`, `role_name`) VALUES (5, 'USER');
INSERT INTO `user_role` (`user_id`, `role_name`) VALUES (6, 'USER');
INSERT INTO `user_role` (`user_id`, `role_name`) VALUES (7, 'ADMIN');
INSERT INTO `user_role` (`user_id`, `role_name`) VALUES (8, 'USER');
INSERT INTO `user_role` (`user_id`, `role_name`) VALUES (9, 'USER');

COMMIT;

