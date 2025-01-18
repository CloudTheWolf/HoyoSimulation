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

--
-- Table structure for table `app_config`
--

CREATE TABLE `app_config` (
  `id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `sValue` varchar(255) DEFAULT NULL,
  `iValue` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `guilds`
--

CREATE TABLE `guilds` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `id` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `player` bigint(20) UNSIGNED NOT NULL,
  `name_suffix` varchar(255) DEFAULT NULL,
  `dateadded` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `pack` varchar(45) NOT NULL,
  `image` varchar(255) NOT NULL,
  `game` varchar(45) NOT NULL,
  `canShiny` tinyint(4) DEFAULT 0,
  `rank` int(11) DEFAULT NULL,
  `event_only` tinyint(4) NOT NULL DEFAULT 0,
  `event_boosted` tinyint(4) NOT NULL DEFAULT 0,
  `type` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Truncate table before insert `items`
--

TRUNCATE TABLE `items`;
--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `name`, `pack`, `image`, `game`, `canShiny`, `rank`, `event_only`, `event_boosted`, `type`) VALUES
(1, 'Stelle (Harmony)', '2.1', 'https://static.wikia.nocookie.net/houkai-star-rail/images/0/0a/Character_Trailblazer_%28F%29_Harmony_Splash_Art.png', 'hsr', 1, 5, 0, 0, 'character'),
(2, 'Caelus (Harmony)', '2.1', 'https://static.wikia.nocookie.net/houkai-star-rail/images/f/f5/Character_Trailblazer_%28M%29_Harmony_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240508064008', 'hsr', 1, 5, 0, 0, 'character'),
(3, 'Stelle (Preservation)', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/1/17/Character_Trailblazer_%28F%29_Preservation_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230501005729', 'hsr', 1, 5, 0, 0, 'character'),
(4, 'Caelus (Preservation)', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/6/63/Character_Trailblazer_%28M%29_Preservation_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230501005737', 'hsr', 1, 5, 0, 0, 'character'),
(5, 'Stelle (Destruction)', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/6/6f/Character_Trailblazer_%28F%29_Destruction_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230501005741', 'hsr', 1, 5, 0, 0, 'character'),
(6, 'Caelus (Destruction)', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/1/12/Character_Trailblazer_%28M%29_Destruction_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230501005733', 'hsr', 1, 5, 0, 0, 'character'),
(7, 'Acheron', '2.1', 'https://static.wikia.nocookie.net/houkai-star-rail/images/7/78/Character_Acheron_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240327021325', 'hsr', 1, 5, 0, 0, 'character'),
(8, 'Argenti', '1.5', 'https://static.wikia.nocookie.net/houkai-star-rail/images/9/90/Character_Argenti_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20231206232011', 'hsr', 1, 5, 0, 0, 'character'),
(9, 'Arlan', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/5/5b/Character_Arlan_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230216231038', 'hsr', 1, 4, 0, 0, 'character'),
(10, 'Asta', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/b/bd/Character_Asta_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230216231122', 'hsr', 1, 4, 0, 0, 'character'),
(11, 'Aventurine', '2.1', 'https://static.wikia.nocookie.net/houkai-star-rail/images/a/a9/Character_Aventurine_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240327104723', 'hsr', 1, 5, 0, 0, 'character'),
(12, 'Bailu', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/e/e9/Character_Bailu_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230210120736', 'hsr', 1, 5, 0, 0, 'character'),
(13, 'Black Swan', '2.0', ' https://static.wikia.nocookie.net/houkai-star-rail/images/f/fd/Character_Black_Swan_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240220023547', 'hsr', 1, 5, 0, 0, 'character'),
(14, 'Blade', '1.2', 'https://static.wikia.nocookie.net/houkai-star-rail/images/1/16/Character_Blade_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230501004859', 'hsr', 1, 5, 0, 0, 'character'),
(15, 'Boothill', '2.2', 'https://static.wikia.nocookie.net/houkai-star-rail/images/b/bb/Character_Boothill_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240624231026', 'hsr', 1, 5, 0, 0, 'character'),
(16, 'Bronya', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/7/7c/Character_Bronya_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240121130128', 'hsr', 1, 5, 0, 0, 'character'),
(17, 'Clara', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/c/c2/Character_Clara_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230216231958', 'hsr', 1, 5, 0, 0, 'character'),
(18, 'Dan Heng', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/e/e5/Character_Dan_Heng_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230525090149', 'hsr', 1, 4, 0, 0, 'character'),
(19, 'Dan Heng • Imbibitor Lunae', '1.3', 'https://static.wikia.nocookie.net/houkai-star-rail/images/2/2c/Character_Dan_Heng_%E2%80%A2_Imbibitor_Lunae_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230818234313', 'hsr', 1, 5, 0, 0, 'character'),
(20, 'Dr Ratio', '1.6', 'https://static.wikia.nocookie.net/houkai-star-rail/images/5/56/Character_Dr._Ratio_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20231227132629', 'hsr', 1, 5, 0, 0, 'character'),
(21, 'Firefly', '2.3', 'https://static.wikia.nocookie.net/houkai-star-rail/images/3/38/Character_Firefly_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240619022729', 'hsr', 1, 5, 0, 0, 'character'),
(22, 'Gallagher', '2.1', 'https://static.wikia.nocookie.net/houkai-star-rail/images/2/2d/Character_Gallagher_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240327022011', 'hsr', 1, 4, 0, 0, 'character'),
(23, 'Gepard', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/9/96/Character_Gepard_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230216232354', 'hsr', 1, 5, 0, 0, 'character'),
(24, 'Guinaifen', '1.4', 'https://static.wikia.nocookie.net/houkai-star-rail/images/3/33/Character_Guinaifen_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20231030040741', 'hsr', 1, 4, 0, 0, 'character'),
(25, 'Hanya', '1.5', 'https://static.wikia.nocookie.net/houkai-star-rail/images/e/e8/Character_Hanya_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20231206232120', 'hsr', 1, 4, 0, 0, 'character'),
(26, 'Herta', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/8/8c/Character_Herta_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230216231220', 'hsr', 1, 4, 0, 0, 'character'),
(27, 'Himeko', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/8/8e/Character_Himeko_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230525090036', 'hsr', 1, 5, 0, 0, 'character'),
(28, 'Hook', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/e/ec/Character_Hook_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230525090126', 'hsr', 1, 4, 0, 0, 'character'),
(29, 'Huohuo', '1.5', 'https://static.wikia.nocookie.net/houkai-star-rail/images/8/82/Character_Huohuo_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20231115031700', 'hsr', 1, 5, 0, 0, 'character'),
(30, 'Jing Yuan', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/4/48/Character_Jing_Yuan_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230210115809', 'hsr', 1, 5, 0, 0, 'character'),
(31, 'Jingliu', '1.4', 'https://static.wikia.nocookie.net/houkai-star-rail/images/9/97/Character_Jingliu_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240525000314', 'hsr', 1, 5, 0, 0, 'character'),
(32, 'Kafka', '1.2', ' https://static.wikia.nocookie.net/houkai-star-rail/images/9/95/Character_Kafka_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230809042240', 'hsr', 1, 5, 0, 0, 'character'),
(33, 'Luka', '1.2', 'https://static.wikia.nocookie.net/houkai-star-rail/images/5/51/Character_Luka_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230809042157', 'hsr', 1, 4, 0, 0, 'character'),
(34, 'Luocha', '1.1', 'https://static.wikia.nocookie.net/houkai-star-rail/images/a/a5/Character_Luocha_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230628091054', 'hsr', 1, 5, 0, 0, 'character'),
(35, 'Lynx', '1.3', 'https://static.wikia.nocookie.net/houkai-star-rail/images/3/3c/Character_Lynx_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230719101506', 'hsr', 1, 4, 0, 0, 'character'),
(36, 'March 7th (Preservation)', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/1/18/Character_March_7th_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230525090156', 'hsr', 1, 4, 0, 0, 'character'),
(37, 'Misha', '2.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/5/5c/Character_Misha_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240206022717', 'hsr', 1, 4, 0, 0, 'character'),
(38, 'Natasha', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/7/7e/Character_Natasha_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240525042421', 'hsr', 1, 4, 0, 0, 'character'),
(39, 'Pela', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/c/c9/Character_Pela_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230525090100', 'hsr', 1, 4, 0, 0, 'character'),
(40, 'Qingque', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/d/d1/Character_Qingque_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230210115335', 'hsr', 1, 4, 0, 0, 'character'),
(41, 'Robon', '2.2', 'https://static.wikia.nocookie.net/houkai-star-rail/images/9/92/Character_Robin_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240508021256', 'hsr', 1, 5, 0, 0, 'character'),
(42, 'Ruan Mei', '1.6', 'https://static.wikia.nocookie.net/houkai-star-rail/images/d/d5/Character_Ruan_Mei_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20231227021137', 'hsr', 1, 5, 0, 0, 'character'),
(43, 'Sampo', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/6/65/Character_Sampo_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230525090046', 'hsr', 1, 4, 0, 0, 'character'),
(44, 'Seele', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/5/58/Character_Seele_Splash_Art.png/revision/latest?cb=20240121123334', 'hsr', 1, 5, 0, 0, 'character'),
(45, 'Serval', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/8/8a/Character_Serval_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230525090108', 'hsr', 1, 4, 0, 0, 'character'),
(46, 'Silver Wolf', '1.1', 'https://static.wikia.nocookie.net/houkai-star-rail/images/6/60/Character_Silver_Wolf_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230216230911', 'hsr', 1, 5, 0, 0, 'character'),
(47, 'Sparkle', '2.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/9/99/Character_Sparkle_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240327022635', 'hsr', 0, 5, 0, 0, 'character'),
(48, 'Sushang', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/7/72/Character_Sushang_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230210115023', 'hsr', 1, 4, 0, 0, 'character'),
(49, 'Tingyun', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/5/5b/Character_Tingyun_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230210115502', 'hsr', 1, 4, 0, 0, 'character'),
(50, 'Topaz and Numby', '1.4', 'https://static.wikia.nocookie.net/houkai-star-rail/images/9/9d/Character_Topaz_and_Numby_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20231030040101', 'hsr', 1, 5, 0, 0, 'character'),
(51, 'Welt', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/1/11/Character_Welt_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230525090017', 'hsr', 1, 5, 0, 0, 'character'),
(52, 'Xueyi', '1.6', 'https://static.wikia.nocookie.net/houkai-star-rail/images/b/bc/Character_Xueyi_Splash_Art.png/revision/latest?cb=20231227045314', 'hsr', 1, 4, 0, 0, 'character'),
(53, 'Yanqing', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/6/6d/Character_Yanqing_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230210121516', 'hsr', 1, 5, 0, 0, 'character'),
(54, 'Yukong', '1.1', 'https://static.wikia.nocookie.net/houkai-star-rail/images/0/04/Character_Yukong_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230628090836', 'hsr', 1, 5, 0, 0, 'character'),
(55, 'Jade', '2.3', 'https://static.wikia.nocookie.net/houkai-star-rail/images/6/6d/Character_Jade_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240607085744', 'hsr', 1, 5, 0, 0, 'character'),
(56, 'Jiaoqiu', '2.4', 'https://static.wikia.nocookie.net/houkai-star-rail/images/b/be/Character_Jiaoqiu_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240607080618', 'hsr', 1, 5, 0, 0, 'character'),
(57, 'March 7th (The Hunt)', '2.4', ' https://static.wikia.nocookie.net/houkai-star-rail/images/b/b9/Character_March_7th_%28The_Hunt%29_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240609082221', 'hsr', 1, 5, 0, 0, 'character'),
(58, 'Yunli', '2.4', 'https://static.wikia.nocookie.net/houkai-star-rail/images/7/72/Character_Yunli_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240607080210', 'hsr', 1, 5, 0, 0, 'character'),
(61, 'A Secret Vow', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/a/a2/Light_Cone_A_Secret_Vow.png/revision/latest?cb=20230719025735', 'hsr', 0, 4, 0, 0, 'weapon'),
(62, 'Adversarial', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/f/f7/Light_Cone_Adversarial.png/revision/latest?cb=20230719025231', 'hsr', 0, 3, 0, 0, 'weapon'),
(63, 'Along the Passing Shore', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/0/08/Light_Cone_Along_the_Passing_Shore.png/revision/latest?cb=20240327025150', 'hsr', 0, 5, 0, 0, 'weapon'),
(64, 'Amber', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/4/42/Light_Cone_Amber.png/revision/latest?cb=20230719024934', 'hsr', 0, 3, 0, 0, 'weapon'),
(65, 'An Instant Before A Gaze', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/2/24/Light_Cone_An_Instant_Before_A_Gaze.png/revision/latest?cb=20231206040430', 'hsr', 0, 5, 0, 0, 'weapon'),
(66, 'Arrows', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/7/79/Light_Cone_Arrows.png/revision/latest?cb=20230719024846', 'hsr', 0, 3, 0, 0, 'weapon'),
(67, 'Baptism of Pure Thought', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/5/5a/Light_Cone_Baptism_of_Pure_Thought.png/revision/latest?cb=20240117041243', 'hsr', 0, 5, 0, 0, 'weapon'),
(68, 'Before Dawn', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/2/26/Light_Cone_Before_Dawn.png/revision/latest?cb=20230719030610', 'hsr', 0, 5, 0, 0, 'weapon'),
(69, 'Before the Tutorial Mission Starts', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/7/76/Light_Cone_Before_the_Tutorial_Mission_Starts.png/revision/latest?cb=20230719030345', 'hsr', 0, 4, 0, 0, 'weapon'),
(70, 'Boundless Choreo', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/6/60/Light_Cone_Boundless_Choreo.png/revision/latest?cb=20240508030705', 'hsr', 0, 4, 0, 0, 'weapon'),
(71, 'Brighter Than the Sun', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/d/d0/Light_Cone_Brighter_Than_the_Sun.png/revision/latest?cb=20230830022603', 'hsr', 0, 5, 0, 0, 'weapon'),
(72, 'But the Battle Isn\'t Over', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/2/29/Light_Cone_But_the_Battle_Isn%27t_Over.png/revision/latest?cb=20230719030450', 'hsr', 0, 5, 0, 0, 'weapon'),
(73, 'Carve the Moon, Weave the Clouds', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/1/1f/Light_Cone_Carve_the_Moon%2C_Weave_the_Clouds.png/revision/latest?cb=20230719030257', 'hsr', 0, 4, 0, 0, 'weapon'),
(74, 'Chorus', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/e/e2/Light_Cone_Chorus.png/revision/latest?cb=20230719025007', 'hsr', 0, 3, 0, 0, 'weapon'),
(75, 'Collapsing Sky', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/d/d0/Light_Cone_Collapsing_Sky.png/revision/latest?cb=20230719024918', 'hsr', 0, 3, 0, 0, 'weapon'),
(76, 'Concert for Two', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/3/35/Light_Cone_Concert_for_Two.png/revision/latest?cb=20240417060149', 'hsr', 0, 4, 0, 0, 'weapon'),
(77, 'Cornucopia', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/4/46/Light_Cone_Cornucopia.png/revision/latest?cb=20230719024902', 'hsr', 0, 3, 0, 0, 'weapon'),
(78, 'Cruising in the Stellar Sea', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/2/2a/Light_Cone_Cruising_in_the_Stellar_Sea.png/revision/latest?cb=20230719030715', 'hsr', 0, 5, 0, 0, 'weapon'),
(79, 'Dance! Dance! Dance!', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/6/64/Light_Cone_Dance%21_Dance%21_Dance%21.png/revision/latest?cb=20230719025912', 'hsr', 0, 4, 0, 0, 'weapon'),
(80, 'Darting Arrow', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/5/51/Light_Cone_Darting_Arrow.png/revision/latest?cb=20230719025039', 'hsr', 0, 3, 0, 0, 'weapon'),
(81, 'Data Bank', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/a/ac/Light_Cone_Data_Bank.png/revision/latest?cb=20230719025023', 'hsr', 0, 3, 0, 0, 'weapon'),
(82, 'Day One of My New Life', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/6/61/Light_Cone_Day_One_of_My_New_Life.png/revision/latest?cb=20230719025454', 'hsr', 0, 4, 0, 0, 'weapon'),
(83, 'Defense', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/9/96/Light_Cone_Defense.png/revision/latest?cb=20230719025127', 'hsr', 0, 3, 0, 0, 'weapon'),
(84, 'Destiny’s Threads Forewoven', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/b/ba/Light_Cone_Destiny%27s_Threads_Forewoven.png/revision/latest?cb=20240206022449', 'hsr', 0, 4, 0, 0, 'weapon'),
(85, 'Dreamville Adventure', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/7/73/Light_Cone_Dreamville_Adventure.png/revision/latest?cb=20240206022506', 'hsr', 0, 4, 0, 0, 'weapon'),
(86, 'Earthly Escapade', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/5/5b/Light_Cone_Earthly_Escapade.png/revision/latest?cb=20240206022523', 'hsr', 0, 5, 0, 0, 'weapon'),
(87, 'Echoes of the Coffin', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/c/c0/Light_Cone_Echoes_of_the_Coffin.png/revision/latest?cb=20230719030554', 'hsr', 0, 5, 0, 0, 'weapon'),
(88, 'Eternal Calculus', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/d/de/Light_Cone_Eternal_Calculus.png/revision/latest?cb=20240607171009', 'hsr', 0, 5, 0, 0, 'weapon'),
(89, 'Eyes of the Prey', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/8/87/Light_Cone_Eyes_of_the_Prey.png/revision/latest?cb=20230719025631', 'hsr', 0, 4, 0, 0, 'weapon'),
(90, 'Fermata', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/1/1b/Light_Cone_Fermata.png/revision/latest?cb=20230719030016', 'hsr', 0, 4, 0, 0, 'weapon'),
(91, 'Final Victor', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/5/5a/Light_Cone_Final_Victor.png/revision/latest?cb=20240206022542', 'hsr', 0, 4, 0, 0, 'weapon'),
(92, 'Fine Fruit', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/7/70/Light_Cone_Fine_Fruit.png/revision/latest?cb=20230719025055', 'hsr', 0, 3, 0, 0, 'weapon'),
(93, 'Flames Afar', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/4/46/Light_Cone_Flames_Afar.png/revision/latest?cb=20240206022259', 'hsr', 0, 4, 0, 0, 'weapon'),
(94, 'Flowing Nightglow', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/f/f2/Light_Cone_Flowing_Nightglow.png/revision/latest?cb=20240508030636', 'hsr', 0, 5, 0, 0, 'weapon'),
(95, 'For Tomorrow\'s Journey', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/a/aa/Light_Cone_For_Tomorrow%27s_Journey.png/revision/latest?cb=20240508033226', 'hsr', 0, 4, 0, 0, 'weapon'),
(96, 'Geniuses\' Repose', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/b/b9/Light_Cone_Geniuses%27_Repose.png/revision/latest?cb=20230719025944', 'hsr', 0, 4, 0, 0, 'weapon'),
(97, 'Good Night and Sleep Well', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/e/ef/Light_Cone_Good_Night_and_Sleep_Well.png/revision/latest?cb=20230719025438', 'hsr', 0, 4, 0, 0, 'weapon'),
(98, 'Hey, Over Here', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/4/45/Light_Cone_Hey%2C_Over_Here.png/revision/latest?cb=20231115024207', 'hsr', 0, 4, 0, 0, 'weapon'),
(99, 'Hidden Shadow', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/1/19/Light_Cone_Hidden_Shadow.png/revision/latest?cb=20230719025335', 'hsr', 0, 3, 0, 0, 'weapon'),
(100, 'I Shall Be My Own Sword', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/c/c7/Light_Cone_I_Shall_Be_My_Own_Sword.png/revision/latest?cb=20231011030715', 'hsr', 0, 5, 0, 0, 'weapon'),
(101, 'In the Name of the World', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/b/b7/Light_Cone_In_the_Name_of_the_World.png/revision/latest?cb=20230719030506', 'hsr', 0, 5, 0, 0, 'weapon'),
(102, 'In the Night', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/7/78/Light_Cone_In_the_Night.png/revision/latest?cb=20230719030418', 'hsr', 0, 5, 0, 0, 'weapon'),
(103, 'Incessant Rain', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/0/0b/Light_Cone_Incessant_Rain.png/revision/latest?cb=20230719030538', 'hsr', 0, 5, 0, 0, 'weapon'),
(104, 'Indelible Promise', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/7/73/Light_Cone_Indelible_Promise.png/revision/latest?cb=20240206022314', 'hsr', 0, 4, 0, 0, 'weapon'),
(105, 'Inherently Unjust Destiny', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/f/f9/Light_Cone_Inherently_Unjust_Destiny.png/revision/latest?cb=20240417060129', 'hsr', 0, 5, 0, 0, 'weapon'),
(106, 'It’s Showtime', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/f/f3/Light_Cone_It%27s_Showtime.png/revision/latest?cb=20240206022334', 'hsr', 0, 4, 0, 0, 'weapon'),
(107, 'Landau\'s Choice', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/b/b7/Light_Cone_Landau%27s_Choice.png/revision/latest?cb=20230719025647', 'hsr', 0, 4, 0, 0, 'weapon'),
(108, 'Loop', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/d/d8/Light_Cone_Loop.png/revision/latest?cb=20230719025143', 'hsr', 0, 3, 0, 0, 'weapon'),
(109, 'Make the World Clamor', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/0/0b/Light_Cone_Make_the_World_Clamor.png/revision/latest?cb=20230719025751', 'hsr', 0, 4, 0, 0, 'weapon'),
(110, 'Mediation', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/2/28/Light_Cone_Mediation.png/revision/latest?cb=20230719025351', 'hsr', 0, 3, 0, 0, 'weapon'),
(111, 'Memories of the Past', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/1/15/Light_Cone_Memories_of_the_Past.png/revision/latest?cb=20230719025527', 'hsr', 0, 4, 0, 0, 'weapon'),
(112, 'Meshing Cogs', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/8/89/Light_Cone_Meshing_Cogs.png/revision/latest?cb=20230719025159', 'hsr', 0, 3, 0, 0, 'weapon'),
(113, 'Moment of Victory', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/a/a1/Light_Cone_Moment_of_Victory.png/revision/latest?cb=20230719030522', 'hsr', 0, 5, 0, 0, 'weapon'),
(114, 'Multiplication', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/7/70/Light_Cone_Multiplication.png/revision/latest?cb=20230719025247', 'hsr', 0, 3, 0, 0, 'weapon'),
(115, 'Mutual Demise', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/a/a0/Light_Cone_Mutual_Demise.png/revision/latest?cb=20230719025303', 'hsr', 0, 3, 0, 0, 'weapon'),
(116, 'Night of Fright', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/d/df/Light_Cone_Night_of_Fright.png/revision/latest?cb=20231115024040', 'hsr', 0, 5, 0, 0, 'weapon'),
(117, 'Night on the Milky Way', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/d/d4/Light_Cone_Night_on_the_Milky_Way.png/revision/latest?cb=20230719030401', 'hsr', 0, 5, 0, 0, 'weapon'),
(118, 'Nowhere to Run', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/4/42/Light_Cone_Nowhere_to_Run.png/revision/latest?cb=20230719030313', 'hsr', 0, 4, 0, 0, 'weapon'),
(119, 'On the Fall of an Aeon', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/9/99/Light_Cone_On_the_Fall_of_an_Aeon.png/revision/latest?cb=20230719030658', 'hsr', 0, 5, 0, 0, 'weapon'),
(120, 'Only Silence Remains', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/e/e2/Light_Cone_Only_Silence_Remains.png/revision/latest?cb=20230719025510', 'hsr', 0, 4, 0, 0, 'weapon'),
(121, 'Passkey', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/a/a4/Light_Cone_Passkey.png/revision/latest?cb=20230719025215', 'hsr', 0, 3, 0, 0, 'weapon'),
(122, 'Past and Future', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/b/b0/Light_Cone_Past_and_Future.png/revision/latest?cb=20230719030105', 'hsr', 0, 4, 0, 0, 'weapon'),
(123, 'Past Self in Mirror', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/a/a4/Light_Cone_Past_Self_in_Mirror.png/revision/latest?cb=20231227021316', 'hsr', 0, 5, 0, 0, 'weapon'),
(124, 'Patience Is All You Need', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/8/87/Light_Cone_Patience_Is_All_You_Need.png/revision/latest?cb=20230809041852', 'hsr', 0, 5, 0, 0, 'weapon'),
(125, 'Perfect Timing', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/7/77/Light_Cone_Perfect_Timing.png/revision/latest?cb=20230719025807', 'hsr', 0, 4, 0, 0, 'weapon'),
(126, 'Pioneering', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/f/fa/Light_Cone_Pioneering.png/revision/latest?cb=20230719025320', 'hsr', 0, 3, 0, 0, 'weapon'),
(127, 'Planetary Rendezvous', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/b/b0/Light_Cone_Planetary_Rendezvous.png/revision/latest?cb=20230719025719', 'hsr', 0, 4, 0, 0, 'weapon'),
(128, 'Post-Op Conversation', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/0/03/Light_Cone_Post-Op_Conversation.png/revision/latest?cb=20230719025422', 'hsr', 0, 4, 0, 0, 'weapon'),
(129, 'Quid Pro Quo', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/7/71/Light_Cone_Quid_Pro_Quo.png/revision/latest?cb=20230719030000', 'hsr', 0, 4, 0, 0, 'weapon'),
(130, 'Reforged Remembrance', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/f/f7/Light_Cone_Reforged_Remembrance.png/revision/latest?cb=20240206022354', 'hsr', 0, 5, 0, 0, 'weapon'),
(131, 'Resolution Shines As Pearls of Sweat', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/7/72/Light_Cone_Resolution_Shines_As_Pearls_of_Sweat.png/revision/latest?cb=20230719025824', 'hsr', 0, 4, 0, 0, 'weapon'),
(132, 'Return to Darkness', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/e/e0/Light_Cone_Return_to_Darkness.png/revision/latest?cb=20230719030241', 'hsr', 0, 4, 0, 0, 'weapon'),
(133, 'River Flows in Spring', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/b/b3/Light_Cone_River_Flows_in_Spring.png/revision/latest?cb=20230719030048', 'hsr', 0, 4, 0, 0, 'weapon'),
(134, 'Sagacity', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/7/70/Light_Cone_Sagacity.png/revision/latest?cb=20230719025407', 'hsr', 0, 3, 0, 0, 'weapon'),
(135, 'Sailing Towards A Second Life', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/e/eb/Light_Cone_Sailing_Towards_a_Second_Life.png/revision/latest?cb=20240603054042', 'hsr', 0, 5, 0, 0, 'weapon'),
(136, 'Shared Feeling', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/3/35/Light_Cone_Shared_Feeling.png/revision/latest?cb=20230719025615', 'hsr', 0, 4, 0, 0, 'weapon'),
(137, 'Shattered Home', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/6/62/Light_Cone_Shattered_Home.png/revision/latest?cb=20230719025111', 'hsr', 0, 3, 0, 0, 'weapon'),
(138, 'She Already Shut Her Eyes', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/0/0a/Light_Cone_She_Already_Shut_Her_Eyes.png/revision/latest?cb=20230920055423', 'hsr', 0, 5, 0, 0, 'weapon'),
(139, 'Sleep Like the Dead', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/2/2d/Light_Cone_Sleep_Like_the_Dead.png/revision/latest?cb=20230719030626', 'hsr', 0, 5, 0, 0, 'weapon'),
(140, 'Solitary Healing', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/9/90/Light_Cone_Solitary_Healing.png/revision/latest?cb=20230830022551', 'hsr', 0, 5, 0, 0, 'weapon'),
(141, 'Something Irreplaceable', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/7/7a/Light_Cone_Something_Irreplaceable.png/revision/latest?cb=20230719030434', 'hsr', 0, 5, 0, 0, 'weapon'),
(142, 'Subscribe for More!', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/5/57/Light_Cone_Subscribe_for_More%21.png/revision/latest?cb=20230719025856', 'hsr', 0, 4, 0, 0, 'weapon'),
(143, 'Swordplay', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/b/b9/Light_Cone_Swordplay.png/revision/latest?cb=20230719025703', 'hsr', 0, 4, 0, 0, 'weapon'),
(144, 'Texture of Memories', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/1/1e/Light_Cone_Texture_of_Memories.png/revision/latest?cb=20230719024830', 'hsr', 0, 5, 0, 0, 'weapon'),
(145, 'The Birth of the Self', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/f/f1/Light_Cone_The_Birth_of_the_Self.png/revision/latest?cb=20230719025559', 'hsr', 0, 4, 0, 0, 'weapon'),
(146, 'The Day The Cosmos Fell', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/f/fe/Light_Cone_The_Day_The_Cosmos_Fell.png/revision/latest?cb=20240206022414', 'hsr', 0, 4, 0, 0, 'weapon'),
(147, 'The Moles Welcome You', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/5/5a/Light_Cone_The_Moles_Welcome_You.png/revision/latest?cb=20230719025543', 'hsr', 0, 4, 0, 0, 'weapon'),
(148, 'The Seriousness of Breakfast', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/d/d6/Light_Cone_The_Seriousness_of_Breakfast.png/revision/latest?cb=20230719030137', 'hsr', 0, 4, 0, 0, 'weapon'),
(149, 'The Unreachable Side', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/b/b7/Light_Cone_The_Unreachable_Side.png/revision/latest?cb=20230719023309', 'hsr', 0, 5, 0, 0, 'weapon'),
(150, 'This Is Me!', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/c/cb/Light_Cone_This_Is_Me%21.png/revision/latest?cb=20230719030225', 'hsr', 0, 4, 0, 0, 'weapon'),
(151, 'Time Waits for No One', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/b/b1/Light_Cone_Time_Waits_for_No_One.png/revision/latest?cb=20230719030642', 'hsr', 0, 5, 0, 0, 'weapon'),
(152, 'Today Is Another Peaceful Day', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/c/c3/Light_Cone_Today_Is_Another_Peaceful_Day.png/revision/latest?cb=20230719030329', 'hsr', 0, 4, 0, 0, 'weapon'),
(153, 'Trend of the Universal Market', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/8/8a/Light_Cone_Trend_of_the_Universal_Market.png/revision/latest?cb=20230719025840', 'hsr', 0, 4, 0, 0, 'weapon'),
(154, 'Under the Blue Sky', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/0/01/Light_Cone_Under_the_Blue_Sky.png/revision/latest?cb=20230719025928', 'hsr', 0, 4, 0, 0, 'weapon'),
(155, 'Void', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/3/37/Light_Cone_Void.png/revision/latest?cb=20230719024951', 'hsr', 0, 3, 0, 0, 'weapon'),
(156, 'Warmth Shortens Cold Nights', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/a/a2/Light_Cone_Warmth_Shortens_Cold_Nights.png/revision/latest?cb=20230719030153', 'hsr', 0, 4, 0, 0, 'weapon'),
(157, 'We Are Wildfire', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/c/c2/Light_Cone_We_Are_Wildfire.png/revision/latest?cb=20230719030032', 'hsr', 0, 4, 0, 0, 'weapon'),
(158, 'We Will Meet Again', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/c/c1/Light_Cone_We_Will_Meet_Again.png/revision/latest?cb=20230719030209', 'hsr', 0, 4, 0, 0, 'weapon'),
(159, 'What Is Real', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/0/0c/Light_Cone_What_Is_Real.png/revision/latest?cb=20240206022433', 'hsr', 0, 4, 0, 0, 'weapon'),
(160, 'Whereabouts Should Dreams Rest', '2.3', 'https://static.wikia.nocookie.net/houkai-star-rail/images/0/0e/Light_Cone_Whereabouts_Should_Dreams_Rest.png/revision/latest?cb=20240607171003', 'hsr', 0, 5, 0, 0, 'weapon'),
(161, 'Woof! Walk Time!', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/f/f2/Light_Cone_Woof%21_Walk_Time%21.png/revision/latest?cb=20230719030121', 'hsr', 0, 4, 0, 0, 'weapon'),
(162, 'Worrisome, Blissful', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/3/37/Light_Cone_Worrisome%2C_Blissful.png/revision/latest?cb=20231029050253', 'hsr', 0, 5, 0, 0, 'weapon'),
(163, 'After the Charmony Fall', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/5/50/Light_Cone_After_the_Charmony_Fall.png/revision/latest?cb=20240607171011', 'hsr', 0, 4, 0, 0, 'weapon'),
(164, 'Yet Hope Is Priceless', '2.3', 'https://static.wikia.nocookie.net/houkai-star-rail/images/5/52/Light_Cone_Yet_Hope_Is_Priceless.png/revision/latest?cb=20240607171006', 'hsr', 0, 5, 0, 0, 'weapon'),
(165, 'Fu Xuan', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/3/3e/Character_Fu_Xuan_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20230928224921', 'hsr', 1, 5, 0, 0, 'character'),
(166, 'Dance at Sunset', '2.4', 'https://static.wikia.nocookie.net/houkai-star-rail/images/2/23/Light_Cone_Dance_at_Sunset_Artwork.png/revision/latest?cb=20240730175611', 'hsr', 0, 5, 0, 0, 'weapon'),
(167, 'Those Many Springs', '2.4', 'https://static.wikia.nocookie.net/houkai-star-rail/images/4/40/Light_Cone_Those_Many_Springs.png/revision/latest?cb=20240821090652', 'hsr', 0, 5, 0, 0, 'weapon'),
(168, 'Poised to Bloom', '2.4', 'https://static.wikia.nocookie.net/houkai-star-rail/images/1/19/Light_Cone_Poised_to_Bloom.png/revision/latest?cb=20240821090957', 'hsr', 0, 4, 0, 0, 'weapon'),
(169, 'Feixiao', '2.5', 'https://static.wikia.nocookie.net/houkai-star-rail/images/6/61/Character_Feixiao_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240910181856', 'hsr', 1, 5, 0, 0, 'character'),
(170, 'Moze', '2.5', 'https://static.wikia.nocookie.net/houkai-star-rail/images/8/81/Character_Moze_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240910181952', 'hsr', 1, 4, 0, 0, 'character'),
(171, 'I Venture Forth to Hunt', '2.5', 'https://static.wikia.nocookie.net/houkai-star-rail/images/1/13/Light_Cone_I_Venture_Forth_to_Hunt.png/revision/latest?cb=20240910183947', 'hsr', 0, 5, 0, 0, 'weapon'),
(172, 'Lingsha', '2.5', 'https://static.wikia.nocookie.net/houkai-star-rail/images/c/c1/Character_Lingsha_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20240901044210', 'hsr', 1, 5, 0, 0, 'character'),
(173, 'Scent Alone Stays True', '2.5', 'https://static.wikia.nocookie.net/houkai-star-rail/images/e/eb/Light_Cone_Scent_Alone_Stays_True.png/revision/latest?cb=20241002192322', 'hsr', 0, 5, 0, 0, 'weapon'),
(174, 'Rappa', '2.6', 'https://static.wikia.nocookie.net/houkai-star-rail/images/1/1c/Character_Rappa_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20241011175436', 'hsr', 1, 5, 0, 0, 'character'),
(175, 'Ninjutsu Inscription: Dazzling Evilbreaker', '2.6', 'https://static.wikia.nocookie.net/houkai-star-rail/images/a/ac/Light_Cone_Ninjutsu_Inscription_Dazzling_Evilbreaker.png/revision/latest?cb=20241011171910', 'hsr', 0, 5, 0, 0, 'weapon'),
(176, 'Sunday', '2.7', 'https://static.wikia.nocookie.net/houkai-star-rail/images/2/21/Character_Sunday_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20241122125803', 'hsr', 1, 5, 0, 0, 'character'),
(177, 'Fugue', '2.7', 'https://static.wikia.nocookie.net/houkai-star-rail/images/4/4c/Character_Fugue_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20241122125941', 'hsr', 1, 5, 0, 0, 'character'),
(178, 'A Grounded Ascent', '2.7', 'https://static.wikia.nocookie.net/houkai-star-rail/images/2/27/Light_Cone_A_Grounded_Ascent.png/revision/latest?cb=20241205031402', 'hsr', 0, 5, 0, 0, 'weapon'),
(179, 'Long Road Leads Home', '2.7', 'https://static.wikia.nocookie.net/houkai-star-rail/images/b/b1/Light_Cone_Long_Road_Leads_Home.png/revision/latest?cb=20241122205850', 'hsr', 0, 5, 0, 0, 'weapon'),
(180, 'The Herta', '3.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/4/42/Character_The_Herta_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20250108051304', 'hsr', 1, 5, 0, 1, 'character'),
(181, 'Aglaea', '0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/8/81/Character_Aglaea_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20250117063425', 'hsr', 1, 5, 0, 0, 'character'),
(182, 'Stelle (Remembrance)', '3.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/1/15/Character_Trailblazer_%28F%29_Remembrance_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20250117063309', 'hsr', 1, 5, 0, 0, 'chatacter'),
(183, 'Caelis (Remembrance)', '3.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/5/57/Character_Trailblazer_%28M%29_Remembrance_Splash_Art.png/revision/latest/scale-to-width-down/1000?cb=20250117063325', 'hsr', 1, 5, 0, 0, 'character'),
(184, 'Into the Unreachable Veil', '3.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/a/aa/Light_Cone_Into_the_Unreachable_Veil.png/revision/latest?cb=20250116180930', 'hsr', 0, 5, 0, 1, 'weapon'),
(185, 'Time Woven Into Gold', '0', 'TO BE FILLED', 'hsr', 0, 5, 0, 0, 'weapon'),
(186, 'Geniusesz\' Greetings', '0', 'TO BE FILLED', 'hsr', 0, 4, 0, 0, 'weapon'),
(187, 'Victory In a Blink', '3.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/5/54/Light_Cone_Victory_In_a_Blink.png/revision/latest?cb=20250116181430', 'hsr', 0, 4, 0, 0, 'weapon'),
(188, 'Sweat Now, Cry Less', '3.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/b/ba/Light_Cone_Sweat_Now%2C_Cry_Less.png/revision/latest?cb=20250116181112', 'hsr', 0, 4, 0, 0, 'weapon'),
(189, 'Duke Inferno', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/6/6f/HoYoLAB_Article_Annihilation_Gang_6.png/revision/latest?cb=20240119053510', 'hsr', 1, 6, 0, 0, 'character'),
(190, 'Akash', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/8/86/HoYoLAB_Article_Annihilation_Gang_2.png/revision/latest?cb=20240801030101', 'hsr', 1, 6, 0, 0, 'character'),
(191, 'Dubra', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/e/e7/HoYoLAB_Article_Annihilation_Gang_3.png/revision/latest?cb=20240119053426', 'hsr', 1, 6, 0, 0, 'character'),
(192, 'Caterina', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/1/1a/HoYoLAB_Article_Annihilation_Gang_4.png/revision/latest?cb=20240119053425', 'hsr', 1, 6, 0, 0, 'character'),
(193, 'Constance', '1.0', 'https://static.wikia.nocookie.net/houkai-star-rail/images/2/2f/HoYoLAB_Article_Annihilation_Gang_5.png/revision/latest?cb=20240119053426', 'hsr', 1, 6, 0, 0, 'character');

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `stellar_gems` int(11) NOT NULL DEFAULT 0,
  `last_reward` timestamp NULL DEFAULT NULL,
  `warps_since_five_star` int(11) DEFAULT 0,
  `warps_since_event_character` int(11) DEFAULT 0,
  `warps_since_event_weapon` int(11) DEFAULT 0,
  `name` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `app_config`
--
ALTER TABLE `app_config`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `guilds`
--
ALTER TABLE `guilds`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `app_config`
--
ALTER TABLE `app_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=194;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
