-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema HoyoSim
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema HoyoSim

-- -----------------------------------------------------
-- Table `inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `item` INT(11) NOT NULL,
  `player` BIGINT(20) UNSIGNED NOT NULL,
  `name_suffix` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 112
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `items` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `pack` VARCHAR(45) NOT NULL,
  `image` VARCHAR(255) NOT NULL,
  `game` VARCHAR(45) NOT NULL,
  `canShiny` TINYINT(4) NULL DEFAULT 0,
  `rank` INT(11) NULL DEFAULT NULL,
  `event_only` TINYINT(4) NOT NULL DEFAULT 0,
  `event_boosted` TINYINT(4) NOT NULL DEFAULT 0,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `players`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `players` (
  `id` BIGINT(20) UNSIGNED NOT NULL,
  `stellar_gems` INT(11) NOT NULL DEFAULT 0,
  `last_reward` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

-- -----------------------------------------------------
-- procedure GetPlayerInventory
-- -----------------------------------------------------

DELIMITER $$

CREATE PROCEDURE `GetPlayerInventory`(IN p_player_id BIGINT)
BEGIN
    SELECT 
        CONCAT(items.name, inventory.name_suffix) AS full_item_name,
        COUNT(*) AS item_count
    FROM 
        inventory
    INNER JOIN 
        items ON items.id = inventory.item
    WHERE 
        inventory.player = p_player_id
    GROUP BY 
        full_item_name
    ORDER BY 
        item_count DESC;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdatePlayerGems
-- -----------------------------------------------------

DELIMITER $$

CREATE PROCEDURE `UpdatePlayerGems`(IN p_player BIGINT, IN p_reward INT)
BEGIN
    DECLARE v_now DATETIME;
    DECLARE v_last_reward DATETIME;
    DECLARE v_gems INT;

    SET v_now = NOW();

    -- Check if player exists and retrieve last_reward and gems
    SELECT last_reward, stellar_gems INTO v_last_reward, v_gems 
    FROM players 
    WHERE id = p_player;

    -- If player does not exist, create it
    IF v_last_reward IS NULL THEN
        INSERT INTO players (id, stellar_gems, last_reward) VALUES (p_player, p_reward, v_now);
    ELSE
        -- If last reward was more than 10 minutes ago, update gems
        IF TIMESTAMPDIFF(MINUTE, v_last_reward, v_now) > 10 THEN
            UPDATE players 
            SET stellar_gems = v_gems + p_reward, last_reward = v_now 
            WHERE id = p_player;
        END IF;
    END IF;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure UpdatePlayerInventory
-- -----------------------------------------------------

DELIMITER $$

CREATE PROCEDURE `UpdatePlayerInventory`(
    IN p_player BIGINT,
    IN p_cost INT,
    IN p_items_json VARCHAR(1000)
)
BEGIN
    DECLARE v_json TEXT;
    DECLARE v_item_id INT;
    DECLARE v_player_id BIGINT;
    DECLARE v_name_suffix VARCHAR(255);
    DECLARE v_json_len INT;
    DECLARE v_index INT DEFAULT 0;
    DECLARE v_json_item JSON;

    -- Deduct cost from stellar_gems
    UPDATE players
    SET stellar_gems = stellar_gems - p_cost
    WHERE id = p_player;

    -- Get the length of the JSON array
    SET v_json_len = JSON_LENGTH(p_items_json);

    -- Loop through each item in the JSON array
    WHILE v_index < v_json_len DO
        -- Extract JSON object at current index
        SET v_json_item = JSON_EXTRACT(p_items_json, CONCAT('$[', v_index, ']'));
        
        -- Extract values from JSON object
        SET v_item_id = JSON_UNQUOTE(JSON_EXTRACT(v_json_item, '$.item'));
        SET v_player_id = JSON_UNQUOTE(JSON_EXTRACT(v_json_item, '$.player'));
        SET v_name_suffix = JSON_UNQUOTE(JSON_EXTRACT(v_json_item, '$.name_suffix'));

        -- Insert item into inventory table
        INSERT INTO inventory (item, player, name_suffix)
        VALUES (v_item_id, v_player_id, v_name_suffix);

        -- Increment index
        SET v_index = v_index + 1;
    END WHILE;
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
