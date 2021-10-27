
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for microservicedb
DROP DATABASE IF EXISTS `microservicedb`;
CREATE DATABASE IF NOT EXISTS `microservicedb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `microservicedb`;

-- Dumping structure for procedure microservicedb.get_referror_fee_summary
DROP PROCEDURE IF EXISTS `get_referror_fee_summary`;
DELIMITER //
CREATE PROCEDURE `get_referror_fee_summary`()
BEGIN
	SELECT 
		  rf.id
		, rf.create_date AS createDate
		, rf.last_modified_date AS lastModifiedDate 
		, rf.user_id as userId
		, rf.amount	
		, u.create_date AS userCreateDate
		, u.last_modified_date AS userLastModifiedDate
		, u.user_type AS userType
		, u.display_name AS displayName
		, u.avatar_big AS avatarBig
		, u.avatar_small AS avatarSmall
		, u.firstname
		, u.lastname
		, u.phone_number AS phoneNumber
		, u.referred_by_id AS referredById
		, p.value + TIMESTAMPDIFF(HOUR, NOW(), u.create_date) > 0 AS active
	FROM users u
	INNER JOIN referror_fees rf ON (u.id = rf.user_id)
	INNER JOIN parameters p ON (p.name = 'Referral hours');
END//
DELIMITER ;

-- Dumping structure for procedure microservicedb.insert_referror_fee
DROP PROCEDURE IF EXISTS `insert_referror_fee`;
DELIMITER //
CREATE PROCEDURE `insert_referror_fee`(IN userID INT,	IN referredByID INT,	IN amount INT)
    MODIFIES SQL DATA
BEGIN
	INSERT INTO referror_fees (create_date, last_modified_date, user_id, referred_by_id, amount, is_processed) VALUES (CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), userID, referredByID, amount, 0);
END//
DELIMITER ;

-- Dumping structure for table microservicedb.parameters
DROP TABLE IF EXISTS `parameters`;
CREATE TABLE IF NOT EXISTS `parameters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `create_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_modified_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `name` varchar(100) NOT NULL,
  `value` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- Dumping data for table microservicedb.parameters: ~4 rows (approximately)
/*!40000 ALTER TABLE `parameters` DISABLE KEYS */;
INSERT INTO `parameters` (`id`, `create_date`, `last_modified_date`, `name`, `value`) VALUES
	(1, '2021-07-07 21:30:07', '2021-07-07 21:30:07', 'Offer', 'Web 3.0'),
	(2, '2021-07-07 21:30:07', '2021-07-07 21:30:07', 'Protection Split', '0.5'),
	(3, '2021-07-07 21:30:07', '2021-07-07 21:30:07', 'Pot Money', '0.9'),
	(4, '2021-07-07 21:30:07', '2021-07-07 21:30:07', 'Referral hours', '72');
/*!40000 ALTER TABLE `parameters` ENABLE KEYS */;

-- Dumping structure for table microservicedb.referror_fees
DROP TABLE IF EXISTS `referror_fees`;
CREATE TABLE IF NOT EXISTS `referror_fees` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `create_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_modified_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user_id` int(10) unsigned NOT NULL,
  `referred_by_id` int(10) unsigned NOT NULL,
  `amount` int(10) unsigned NOT NULL,
  `is_processed` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `referror_fees_user_id_fkey` (`user_id`),
  KEY `referror_fees_referred_by_id_fkey` (`referred_by_id`),
  CONSTRAINT `referror_fees_referred_by_id_fkey` FOREIGN KEY (`referred_by_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `referror_fees_user_id_fkey` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;

-- Dumping data for table microservicedb.referror_fees: ~26 rows (approximately)
/*!40000 ALTER TABLE `referror_fees` DISABLE KEYS */;
INSERT INTO `referror_fees` (`id`, `create_date`, `last_modified_date`, `user_id`, `referred_by_id`, `amount`, `is_processed`) VALUES
	(28, '2021-07-09 11:41:51', '2021-07-27 21:24:52', 15, 1, 10, 0),
	(29, '2021-07-09 11:42:48', '2021-07-27 21:24:52', 15, 1, 10, 0),
	(30, '2021-07-12 21:50:59', '2021-07-27 21:24:52', 15, 1, 10, 0),
	(31, '2021-07-12 21:51:18', '2021-07-27 21:24:52', 15, 1, 10, 0),
	(32, '2021-07-12 21:51:32', '2021-07-27 21:24:52', 15, 1, 10, 0),
	(33, '2021-07-12 21:51:40', '2021-07-27 21:24:52', 15, 1, 10, 0),
	(34, '2021-07-12 21:56:28', '2021-07-27 21:24:52', 15, 1, 10, 0),
	(35, '2021-07-12 21:56:33', '2021-07-27 21:24:52', 15, 1, 10, 0),
	(36, '2021-07-12 23:35:52', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(37, '2021-07-12 23:38:23', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(38, '2021-07-12 23:39:12', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(39, '2021-07-18 09:27:48', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(40, '2021-07-18 09:31:51', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(41, '2021-07-18 09:33:07', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(42, '2021-07-18 10:47:34', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(43, '2021-07-18 10:47:34', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(44, '2021-07-18 10:47:35', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(45, '2021-07-18 10:47:35', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(46, '2021-07-18 10:47:35', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(47, '2021-07-18 10:47:36', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(48, '2021-07-18 10:47:36', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(49, '2021-07-18 10:49:56', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(50, '2021-07-18 10:50:07', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(51, '2021-07-18 10:50:18', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(52, '2021-07-18 10:50:29', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(53, '2021-07-18 10:50:32', '2021-07-27 21:25:20', 1, 1, 10, 0),
	(54, '2021-08-03 12:40:18', '2021-08-03 12:40:18', 1, 1, 15, 0);
/*!40000 ALTER TABLE `referror_fees` ENABLE KEYS */;

-- Dumping structure for table microservicedb.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `old_id` binary(16) DEFAULT NULL,
  `create_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_modified_date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_type` smallint(6) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `avatar_big` varchar(1000) DEFAULT NULL,
  `avatar_small` varchar(1000) DEFAULT NULL,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `api_key` varchar(50) NOT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `referred_by_id` int(10) unsigned DEFAULT NULL,
  `socket_id` varchar(50) DEFAULT NULL,
  `online_status` smallint(6) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_display_name_key` (`display_name`),
  KEY `users_referred_by_id_fkey` (`referred_by_id`),
  KEY `idx_users_old_id` (`old_id`),
  KEY `idx_users_display_name` (`display_name`),
  KEY `idx_users_online_status` (`online_status`),
  KEY `idx_users_phone_number` (`phone_number`),
  KEY `idx_users_socket_id` (`socket_id`),
  CONSTRAINT `users_referred_by_id_fkey` FOREIGN KEY (`referred_by_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

-- Dumping data for table microservicedb.users: ~22 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `old_id`, `create_date`, `last_modified_date`, `user_type`, `display_name`, `avatar_big`, `avatar_small`, `is_deleted`, `api_key`, `firstname`, `lastname`, `phone_number`, `referred_by_id`, `socket_id`, `online_status`) VALUES
	(1, _binary 0x11ea725e92d3ae6089b20242ac110008, '2021-07-27 20:15:10', '2020-11-21 09:58:08', 0, 'Zoren8', '', '', 0, 'KgbJBRPxj5IvwYUy898DW4FUcmyrPatR', 'James', 'Cruz', '639171234567', NULL, '2ISuHAKPrDl94je1AAK9', 0),
	(2, _binary 0x11e6650eab580a00a4d10242ac110005, '2021-07-27 20:15:10', '2020-11-21 09:58:08', 1, 'Bengga', '', '', 0, 'rxeXkeiohOPFOhG3hAjBWtxy9BTNdNXg', 'James', 'Cruz', '639177654321', NULL, NULL, 0),
	(3, _binary 0x11ea7266d58252e089b20242ac110008, '2021-07-27 20:15:10', '2020-04-02 04:28:48', 0, 'mikiliuson', '', '', 0, 'eXgNZpNIXr12VyQMBIW0t2J8OsbWXvTp', 'Dominique', 'Liuson', '+639988620284', NULL, NULL, 0),
	(4, _binary 0x11ea7266d81818f089b20242ac110008, '2021-07-27 20:15:10', '2020-04-02 07:13:19', 0, 'shan', '', '', 0, '84fxvYXybtwO6Y8nC8Vtc9FpRjEzHIBr', 'Shan', 'Clemente', '+639199112700', NULL, NULL, 0),
	(5, _binary 0x11ea7266f6d4e70089b20242ac110008, '2021-07-27 20:15:10', '2020-04-02 07:07:50', 0, 'Albert', '', '', 0, 'xAa04UvJrlqsfRSoP7gsWlkcHfI0XDVb', 'Albert', 'Nicomedez', '+63099985317640', NULL, NULL, 0),
	(6, _binary 0x11ea7267124485e089b20242ac110008, '2021-07-27 20:15:10', '2020-04-02 07:13:19', 0, 'jan', '', '', 0, 'k4FHMKFGNlJvfP104iuigftbARL6GqEE', 'Jan', 'Maceda', '+639055137634', NULL, NULL, 0),
	(7, _binary 0x11ea72672b5489e089b20242ac110008, '2021-07-27 20:15:10', '2020-04-02 07:13:19', 0, 'seanjersen', '', '', 0, 'rMjdKkIl5YnPfDfyjJRgePCSbBnL30Dm', 'Sean', 'Tan', '+639178514643', NULL, NULL, 0),
	(8, _binary 0x11ea72679afc37c089b20242ac110008, '2021-07-27 20:15:10', '2020-03-30 09:19:49', 0, 'sophiamay', '', '', 0, 'AwmrkPbbekKq99DUT6Oz4ZexedyOPi1M', 'Sophia', 'Bulalacao', '+639178887516', NULL, NULL, 0),
	(9, _binary 0x11ea72681814c10089b20242ac110008, '2021-07-27 20:15:10', '2020-04-02 07:05:06', 0, 'sambrite', '', '', 0, 'ejNqFiuCL3UiYFJByaF9iCdoL1uUa4zA', 'Samantha', 'Maliuanag', '+639178287266', NULL, NULL, 0),
	(10, _binary 0x11ea72681a538d7089b20242ac110008, '2020-03-30 09:23:23', '2020-03-30 09:23:23', 0, 'ALLYANA', '', '', 0, 'DJVDuAj67gX1nNibmhsjY1W7Ja7KM1uq', 'Allyana', 'Dee', '+639178989324', NULL, NULL, 0),
	(11, _binary 0x11ea7268438f200089b20242ac110008, '2020-03-30 09:24:32', '2020-04-02 04:28:48', 0, 'mendez.m', '', '', 0, 'iYMFvNzE5jXaSKRXihW0OkOMp9zPXNlg', 'Maggie', 'Mendez', '+639178502022', NULL, NULL, 0),
	(12, _binary 0x11ea72684a53267089b20242ac110008, '2020-03-30 09:24:43', '2020-04-02 04:28:48', 0, 'reinaloons', '', '', 0, 'UsHY0vvmsSqlfTRfJTN6vG0er9WaCnMH', 'Reina', 'Luna', '+639178147190', NULL, NULL, 0),
	(13, _binary 0x11ea7268518afd5089b20242ac110008, '2020-03-30 09:24:55', '2020-04-02 04:28:48', 0, 'Ghia', '', '', 0, 'Bq3dgoc6ugMp7Z7mJvyuhoNhNsOzhy4z', 'Ghia', 'Chupungco', '+639285054618', NULL, NULL, 0),
	(14, _binary 0x11ea72685ecf236089b20242ac110008, '2020-03-30 09:25:18', '2020-04-02 04:28:48', 0, 'FriedEgg', '', '', 0, 'p6gVqn8oVHFb30QBWFFph1KFxnTJlgDf', 'Enzo', 'Jover', '+639293399882', NULL, NULL, 0),
	(15, _binary 0x11ea726872c379c089b20242ac110008, '2020-03-30 09:25:51', '2020-04-02 04:28:48', 0, 'audreya', '', '', 0, 'asmES4AQWXhJLJpWKseiUCYqYTZBqAkV', 'Audrey', 'Adarme', '+639178310238', NULL, NULL, 0),
	(16, _binary 0x11ea72687458bfc089b20242ac110008, '2020-03-30 09:25:54', '2020-04-02 04:28:48', 0, 'gabbeep', '', '', 0, 'JXJBFBLm6fi4T8btgwV8A76AjUm4jTTt', 'Gabbee', 'Pinga', '+639178833697', NULL, NULL, 0),
	(17, _binary 0x11ea7268891e6fe089b20242ac110008, '2020-03-30 09:26:29', '2020-03-30 09:26:29', 0, 'kay', '', '', 0, '6x9aDxy8I50oyCFa1ViolAjwUkzHbqba', 'Kay', 'D', '+639209001024', NULL, NULL, 0),
	(18, _binary 0x11ea7268d414ce4089b20242ac110008, '2020-03-30 09:28:34', '2020-03-30 09:28:34', 0, 'sophiaa12', '', '', 0, 'TzbVt3RDrDKzBEMdNOeveEFK76udIIzg', 'Sophia', 'Arellano', '+639175110353', NULL, NULL, 0),
	(19, _binary 0x11ea7268eabf1ce089b20242ac110008, '2020-03-30 09:29:12', '2020-04-02 04:28:48', 0, 'robyndg', '', '', 0, 'cL2JsEDjggSZnQ9ZNTF14gOYf2WilBQ1', 'Robyn', 'DeGuzman', '+6309989642019', NULL, NULL, 0),
	(20, _binary 0x11ea7268eedbd11089b20242ac110008, '2020-03-30 09:29:19', '2020-04-02 07:13:19', 0, 'jar', '', '', 0, 'X7Yby3Ekh4nuqyqeh6Ytx9vKuwfRornX', 'Joshua', 'Escaño', '+639175980503', NULL, NULL, 0),
	(21, _binary 0x11ea7269027b9ed089b20242ac110008, '2020-03-30 09:29:52', '2020-04-02 07:13:19', 0, 'tyleroyek', '', '', 0, 'YLSLP07l8FedAOa07WFWwM6eUMEpTVJi', 'BenedictTyler', 'O’yek', '+639065615280', NULL, NULL, 0),
	(22, _binary 0x11ea7269028a6be089b20242ac110008, '2020-03-30 09:29:52', '2020-04-02 04:28:48', 0, 'gian817', '', '', 0, 'OLzjiIhpIC3maS95GViNEz95Hcj23qPE', 'Gian', 'Fausto', '+639178400920', NULL, NULL, 0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for function microservicedb.uuid_to_bin
DROP FUNCTION IF EXISTS `uuid_to_bin`;
DELIMITER //
CREATE FUNCTION `uuid_to_bin`(_uuid BINARY(36)) RETURNS binary(16)
    DETERMINISTIC
    SQL SECURITY INVOKER
RETURN
        UNHEX(CONCAT(
            SUBSTR(_uuid, 15, 4),
            SUBSTR(_uuid, 10, 4),
            SUBSTR(_uuid,  1, 8),
            SUBSTR(_uuid, 20, 4),
            SUBSTR(_uuid, 25) ))//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
