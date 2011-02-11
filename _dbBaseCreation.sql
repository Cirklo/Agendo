-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 07, 2011 at 10:19 
-- Server version: 5.1.41
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `dbtest`
--

-- --------------------------------------------------------

--
-- Table structure for table `access`
--

DROP TABLE IF EXISTS `access`;
CREATE TABLE IF NOT EXISTS `access` (
  `access_id` int(11) NOT NULL,
  `access_permission` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`access_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `access`
--

INSERT INTO `access` (`access_id`, `access_permission`) VALUES
(0, 'View'),
(1, 'Update'),
(2, 'Delete'),
(3, 'Update, Delete'),
(4, 'Add'),
(5, 'Add, Update'),
(6, 'Add, Delete'),
(7, 'Add, Update, Delete');

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
CREATE TABLE IF NOT EXISTS `admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_user` int(11) NOT NULL,
  `admin_table` varchar(20) NOT NULL COMMENT 'Available tables<br /><br />admin<br />board<br />department<br />entry<br />equip<br />institute<br />parameter<br />permissions<br />resource<br />type<br />user',
  `admin_permission` int(11) NOT NULL COMMENT '0 - View<br />1 - Update<br />2 - Delete<br/>3 - Update, Delete<br />4 - Add<br />5 - Add, Update<br />6 - Add, Delete<br />7 - Add, Update, Delete',
  PRIMARY KEY (`admin_id`),
  KEY `admin_user` (`admin_user`),
  KEY `admin_permission` (`admin_permission`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=35 ;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `admin_user`, `admin_table`, `admin_permission`) VALUES
(1, 1, 'resource', 7),
(2, 1, 'permissions', 7),
(3, 1, 'type', 7),
(4, 1, 'department', 7),
(5, 1, 'user', 7),
(6, 1, 'entry', 7),
(7, 1, 'admin', 7),
(8, 1, 'cirklo', 7);

-- --------------------------------------------------------

--
-- Table structure for table `announcement`
--

DROP TABLE IF EXISTS `announcement`;
CREATE TABLE IF NOT EXISTS `announcement` (
  `announcement_id` int(11) NOT NULL AUTO_INCREMENT,
  `announcement_title` varchar(100) COLLATE utf8_bin NOT NULL,
  `announcement_message` varchar(200) COLLATE utf8_bin DEFAULT NULL,
  `announcement_object` int(11) NOT NULL COMMENT 'Main object of the announcement.',
  `announcement_date` date NOT NULL COMMENT 'Announcement date.',
  `announcement_end_date` date DEFAULT NULL COMMENT 'The announcement will no longer be available after the end date.',
  PRIMARY KEY (`announcement_id`),
  KEY `announcement_object` (`announcement_object`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

--
-- Dumping data for table `announcement`
--


-- --------------------------------------------------------

--
-- Table structure for table `board`
--

DROP TABLE IF EXISTS `board`;
CREATE TABLE IF NOT EXISTS `board` (
  `board_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Table used with monitoring system only',
  `board_address` varchar(20) COLLATE utf8_bin NOT NULL,
  `board_type` varchar(20) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`board_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

--
-- Dumping data for table `board`
--


-- --------------------------------------------------------

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
CREATE TABLE IF NOT EXISTS `country` (
  `country_id` int(11) NOT NULL AUTO_INCREMENT,
  `country_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `country_tel_id` char(3) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=240 ;

--
-- Dumping data for table `country`
--

INSERT INTO `country` (`country_id`, `country_name`, `country_tel_id`) VALUES
(1, 'Not Specified', '0'),
(2, 'Albania', '355'),
(3, 'Algeria', '213'),
(4, 'American Samoa', '684'),
(5, 'Andorra', '376'),
(6, 'Angola', '244'),
(7, 'Anguilla', '264'),
(8, 'Antarctica', '672'),
(9, 'Antigua', '268'),
(10, 'Argentina', '54'),
(11, 'Armenia', '374'),
(12, 'Aruba', '297'),
(13, 'Ascension Island', '247'),
(14, 'Australia', '61'),
(15, 'Austria', '43'),
(16, 'Austria', '43'),
(17, 'Azberbaijan', '994'),
(18, 'Bahamas', '242'),
(19, 'Bahrain', '973'),
(20, 'Bangladesh', '880'),
(21, 'Barbados', '246'),
(22, 'Barbuda', '268'),
(23, 'Belarus', '375'),
(24, 'Belgium', '32'),
(25, 'Belize', '501'),
(26, 'Benin', '229'),
(27, 'Bermuda', '441'),
(28, 'Bhutan', '975'),
(29, 'Bolivia', '591'),
(30, 'Bosnia', '387'),
(31, 'Botswana', '267'),
(32, 'Brazil', '55'),
(33, 'British Virgin Islands', '284'),
(34, 'Brunei', '673'),
(35, 'Bulgaria', '359'),
(36, 'Burkina Faso', '226'),
(37, 'Burma (Myanmar)', '95'),
(38, 'Burundi', '257'),
(39, 'Cambodia', '855'),
(40, 'Cameroon', '237'),
(41, 'Canada', '1'),
(42, 'Cape Verde Islands', '238'),
(43, 'Cayman Islands', '345'),
(44, 'Central African Rep.', '236'),
(45, 'Chad', '235'),
(46, 'Chile', '56'),
(47, 'China', '86'),
(48, 'Christmas Island', '61'),
(49, 'Cocos Islands', '61'),
(50, 'Colombia', '57'),
(51, 'Comoros', '269'),
(52, 'Congo', '242'),
(53, 'Congo (Dem.Rep.)', '243'),
(54, 'Cook Islands', '682'),
(55, 'Costa Rica', '506'),
(56, 'Croatia', '385'),
(57, 'Cuba', '53'),
(58, 'Cyprus', '357'),
(59, 'Czech Republic', '420'),
(60, 'Denmark', '45'),
(61, 'Diego Garcia', '246'),
(62, 'Djibouti', '253'),
(63, 'Dominica', '767'),
(64, 'Dominican Rep.', '809'),
(65, 'Ecuador', '593'),
(66, 'Egypt', '20'),
(67, 'El Salvador', '503'),
(68, 'Equatorial Guinea', '240'),
(69, 'Eritrea', '291'),
(70, 'Estonia', '372'),
(71, 'Ethiopia', '251'),
(72, 'Faeroe Islands', '298'),
(73, 'Falkland Islands', '500'),
(74, 'Fiji Islands', '679'),
(75, 'Finland', '358'),
(76, 'France', '33'),
(77, 'French Antilles', '596'),
(78, 'French Guiana', '594'),
(79, 'French Polynesia', '689'),
(80, 'Gabon', '241'),
(81, 'Gambia', '220'),
(82, 'Georgia', '995'),
(83, 'Germany', '49'),
(84, 'Ghana', '233'),
(85, 'Gibraltar', '350'),
(86, 'Greece', '30'),
(87, 'Greenland', '299'),
(88, 'Grenada', '473'),
(89, 'Guadeloupe', '590'),
(90, 'Guam', '671'),
(91, 'Guantanamo Bay', '539'),
(92, 'Guatemala', '502'),
(93, 'Guinea', '224'),
(94, 'Guinea Bissau', '245'),
(95, 'Guyana', '592'),
(96, 'Haiti', '509'),
(97, 'Honduras', '504'),
(98, 'Hong Kong', '852'),
(99, 'Hungary', '36'),
(100, 'Iceland', '354'),
(101, 'India', '91'),
(102, 'Indonesia', '62'),
(103, 'Iran', '98'),
(104, 'Iraq', '964'),
(105, 'Ireland', '353'),
(106, 'Israel', '972'),
(107, 'Italy', '39'),
(108, 'Ivory Coast', '225'),
(109, 'Jamaica', '876'),
(110, 'Japan', '81'),
(111, 'Jordan', '962'),
(112, 'Kazakhstan', '7'),
(113, 'Kenya', '254'),
(114, 'Kiribati', '686'),
(115, 'Korea (North)', '850'),
(116, 'Korea (South)', '82'),
(117, 'Kuwait', '965'),
(118, 'Kyrgyzstan', '996'),
(119, 'Laos', '856'),
(120, 'Latvia', '371'),
(121, 'Lebanon', '961'),
(122, 'Lesotho', '266'),
(123, 'Liberia', '231'),
(124, 'Libya', '218'),
(125, 'Liechtenstein', '423'),
(126, 'Lithuania', '370'),
(127, 'Luxembourg', '352'),
(128, 'Macau', '853'),
(129, 'Macedonia', '389'),
(130, 'Madagascar', '261'),
(131, 'Malawi', '265'),
(132, 'Malaysia', '60'),
(133, 'Maldives', '960'),
(134, 'Mali', '223'),
(135, 'Malta', '356'),
(136, 'Mariana Islands', '670'),
(137, 'Marshall Islands', '692'),
(138, 'Martinique', '596'),
(139, 'Mauritania', '222'),
(140, 'Mauritius', '230'),
(141, 'Mayotte Islands', '269'),
(142, 'Mexico', '52'),
(143, 'Micronesia', '691'),
(144, 'Midway Island', '808'),
(145, 'Moldova', '373'),
(146, 'Monaco', '377'),
(147, 'Mongolia', '976'),
(148, 'Montserrat', '664'),
(149, 'Morocco', '212'),
(150, 'Mozambique', '258'),
(151, 'Myanmar (Burma)', '95'),
(152, 'Namibia', '264'),
(153, 'Nauru', '674'),
(154, 'Nepal', '977'),
(155, 'Netherlands', '31'),
(156, 'Netherlands Antilles', '599'),
(157, 'Nevis', '869'),
(158, 'New Caledonia', '687'),
(159, 'New Zealand', '64'),
(160, 'Nicaragua', '505'),
(161, 'Niger', '227'),
(162, 'Nigeria', '234'),
(163, 'Niue', '683'),
(164, 'Norfolk Island', '672'),
(165, 'Norway', '47'),
(166, 'Oman', '968'),
(167, 'Pakistan', '92'),
(168, 'Palau', '680'),
(169, 'Palestine', '970'),
(170, 'Panama', '507'),
(171, 'Papua New Guinea', '675'),
(172, 'Paraguay', '595'),
(173, 'Peru', '51'),
(174, 'Philippines', '63'),
(175, 'Poland', '48'),
(176, 'Portugal', '351'),
(177, 'Puerto Rico', '787'),
(178, 'Qatar', '974'),
(179, 'Reunion Island', '262'),
(180, 'Romania', '40'),
(181, 'Russia', '7'),
(182, 'Rwanda', '250'),
(183, 'San Marino', '378'),
(184, 'Sao Tome & Principe', '239'),
(185, 'Saudi Arabia', '966'),
(186, 'Senegal', '221'),
(187, 'Serbia', '381'),
(188, 'Seychelles', '248'),
(189, 'Sierra Leone', '232'),
(190, 'Singapore', '65'),
(191, 'Slovakia', '421'),
(192, 'Slovenia', '386'),
(193, 'Solomon Islands', '677'),
(194, 'Somalia', '252'),
(195, 'South Africa', '27'),
(196, 'Spain', '34'),
(197, 'Sri Lanka', '94'),
(198, 'St. Helena', '290'),
(199, 'St. Kitts', '869'),
(200, 'St. Lucia', '758'),
(201, 'St. Perre & Miquelon', '508'),
(202, 'St. Vincent', '784'),
(203, 'Sudan', '249'),
(204, 'Suriname', '597'),
(205, 'Swaziland', '268'),
(206, 'Sweden', '46'),
(207, 'Switzerland', '41'),
(208, 'Syria', '963'),
(209, 'Taiwan', '886'),
(210, 'Tajikistan', '992'),
(211, 'Tanzania', '255'),
(212, 'Thailand', '66'),
(213, 'Togo', '228'),
(214, 'Tonga', '676'),
(215, 'Trinidad & Tobago', '868'),
(216, 'Tunisia', '216'),
(217, 'Turkey', '90'),
(218, 'Turkmenistan', '993'),
(219, 'Turks & Caicos', '649'),
(220, 'Tuvalu', '688'),
(221, 'Uganda', '256'),
(222, 'Ukraine', '380'),
(223, 'United Arab Emirates', '971'),
(224, 'United Kingdom (UK)', '44'),
(225, 'United States (USA)', '1'),
(226, 'Uruguay', '598'),
(227, 'US Virgin Islands', '1'),
(228, 'Uzbekistan', '998'),
(229, 'Vanuatu', '678'),
(230, 'Vatican City', '39'),
(231, 'Venezuela', '58'),
(232, 'Vietnam', '84'),
(233, 'Wake Island', '808'),
(234, 'Wallis & Futuna', '681'),
(235, 'Western Samoa', '685'),
(236, 'Yemen', '967'),
(237, 'Yugoslavia', '381'),
(238, 'Zambia', '260'),
(239, 'Zimbabwe', '263');

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
CREATE TABLE IF NOT EXISTS `department` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `department_inst` smallint(6) NOT NULL,
  PRIMARY KEY (`department_id`),
  KEY `department_inst` (`department_inst`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`department_id`, `department_name`, `department_inst`) VALUES
(1, 'Cirklo', 1);

-- --------------------------------------------------------

--
-- Table structure for table `entry`
--

DROP TABLE IF EXISTS `entry`;
CREATE TABLE IF NOT EXISTS `entry` (
  `entry_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `entry_user` int(11) NOT NULL,
  `entry_datetime` datetime NOT NULL,
  `entry_slots` smallint(6) NOT NULL,
  `entry_assistance` tinyint(4) NOT NULL DEFAULT '0',
  `entry_repeat` int(11) NOT NULL,
  `entry_status` tinyint(4) NOT NULL,
  `entry_resource` int(11) NOT NULL,
  `entry_action` datetime NOT NULL,
  `entry_comments` tinytext COLLATE utf8_bin,
  PRIMARY KEY (`entry_id`),
  KEY `entry_user` (`entry_user`),
  KEY `entry_resource` (`entry_resource`),
  KEY `entry_repeat` (`entry_repeat`),
  KEY `entry_status` (`entry_status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=578 ;

--
-- Dumping data for table `entry`
--


-- --------------------------------------------------------

--
-- Table structure for table `equip`
--

DROP TABLE IF EXISTS `equip`;
CREATE TABLE IF NOT EXISTS `equip` (
  `equip_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Table used with monitoring system only',
  `equip_resourceid` int(11) NOT NULL,
  `equip_boardID` int(11) NOT NULL,
  `equip_para` int(11) NOT NULL,
  `equip_min` int(11) NOT NULL,
  `equip_max` int(11) NOT NULL,
  `equip_user` int(11) NOT NULL,
  `equip_desc` varchar(32) COLLATE utf8_bin NOT NULL,
  `equip_alarm_period` int(4) NOT NULL COMMENT 'minute',
  `equip_calibration` varchar(300) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`equip_id`),
  KEY `equip_boardID` (`equip_boardID`),
  KEY `equip_para` (`equip_para`),
  KEY `equip_resourceid` (`equip_resourceid`),
  KEY `equip_user` (`equip_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='monitored equipment' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `equip`
--


-- --------------------------------------------------------

--
-- Table structure for table `institute`
--

DROP TABLE IF EXISTS `institute`;
CREATE TABLE IF NOT EXISTS `institute` (
  `institute_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `institute_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `institute_address` varchar(64) COLLATE utf8_bin NOT NULL,
  `institute_phone` int(11) NOT NULL,
  `institute_country` int(11) NOT NULL,
  `institute_vat` int(11) NOT NULL,
  PRIMARY KEY (`institute_id`),
  KEY `institute_country` (`institute_country`),
  KEY `institute_country_2` (`institute_country`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

--
-- Dumping data for table `institute`
--

INSERT INTO `institute` (`institute_id`, `institute_name`, `institute_address`, `institute_phone`, `institute_country`, `institute_vat`) VALUES
(1, 'IGC', 'Rua da Quinta Grande', 12345678, 34, 323232323);

-- --------------------------------------------------------

--
-- Table structure for table `mainconfig`
--

DROP TABLE IF EXISTS `mainconfig`;
CREATE TABLE IF NOT EXISTS `mainconfig` (
  `mainconfig_id` int(11) NOT NULL AUTO_INCREMENT,
  `mainconfig_institute` varchar(100) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL,
  `mainconfig_shortname` varchar(10) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL,
  `mainconfig_url` varchar(50) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL,
  `mainconfig_email` varchar(50) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL,
  `mainconfig_password` varchar(50) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL,
  `mainconfig_host` varchar(50) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL,
  `mainconfig_port` int(11) NOT NULL,
  `mainconfig_SMTPSecure` varchar(10) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL,
  `mainconfig_SMTPAuth` tinyint(4) NOT NULL,
  PRIMARY KEY (`mainconfig_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=18446744073709551615 ;

--
-- Dumping data for table `mainconfig`
--

INSERT INTO `mainconfig` (`mainconfig_id`, `mainconfig_institute`, `mainconfig_shortname`, `mainconfig_url`, `mainconfig_email`, `mainconfig_password`, `mainconfig_host`, `mainconfig_port`, `mainconfig_SMTPSecure`, `mainconfig_SMTPAuth`) VALUES
(1, 'IGC', 'IGC', 'www.igc.gulbenkian.pt', 'mail@mail.com', 'pass', 'host', 25, 'stmp', 0);

-- --------------------------------------------------------

--
-- Table structure for table `measure`
--

DROP TABLE IF EXISTS `measure`;
CREATE TABLE IF NOT EXISTS `measure` (
  `measure_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Table used with monitoring system only',
  `measure_equip` int(11) NOT NULL,
  `measure_value` int(11) NOT NULL,
  `measure_date` datetime NOT NULL,
  PRIMARY KEY (`measure_id`),
  KEY `measure_equip` (`measure_equip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

--
-- Dumping data for table `measure`
--


-- --------------------------------------------------------

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
CREATE TABLE IF NOT EXISTS `media` (
  `media_id` int(11) NOT NULL AUTO_INCREMENT,
  `media_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `media_description` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `media_link` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`media_id`),
  UNIQUE KEY `media_name` (`media_name`,`media_description`,`media_link`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `media`
--

INSERT INTO `media` (`media_id`, `media_name`, `media_description`, `media_link`) VALUES
(1, 'Recover Password', 'Shows how to recover a user''s password', 'videos/recoverpwd.swf'),
(2, 'New User', 'Shows how to create users', 'videos/askfor.swf'),
(3, 'Entry Confirmation', 'Shows how to confirm entries', 'videos/confirm.swf'),
(4, 'New Permission', 'Shows how to give a user permission for a certain resource', 'videos/newperm.swf'),
(5, 'Waiting Lists', 'Shows how waiting lists work', 'videos/waitlist.swf');

-- --------------------------------------------------------

--
-- Table structure for table `param`
--

DROP TABLE IF EXISTS `param`;
CREATE TABLE IF NOT EXISTS `param` (
  `param_id` int(11) NOT NULL AUTO_INCREMENT,
  `param_proc` varchar(50) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL,
  `param_name` varchar(50) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL,
  `param_type` varchar(50) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL,
  `param_size` int(11) NOT NULL,
  PRIMARY KEY (`param_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `parameter`
--

DROP TABLE IF EXISTS `parameter`;
CREATE TABLE IF NOT EXISTS `parameter` (
  `parameter_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Table used with monitoring system only',
  `parameter_type` varchar(10) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`parameter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

--
-- Dumping data for table `parameter`
--


-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `permissions_id` int(11) NOT NULL AUTO_INCREMENT,
  `permissions_user` int(11) NOT NULL,
  `permissions_resource` int(11) NOT NULL,
  `permissions_level` tinyint(4) NOT NULL,
  PRIMARY KEY (`permissions_id`),
  KEY `permissions_user` (`permissions_user`),
  KEY `permissions_resource` (`permissions_resource`),
  KEY `permissions_level` (`permissions_level`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`permissions_id`, `permissions_user`, `permissions_resource`, `permissions_level`) VALUES
(1, 1, 1, 7),
(2, 1, 2, 7),
(3, 1, 3, 7),
(4, 1, 4, 7),
(5, 1, 5, 7),
(6, 1, 6, 7),
(7, 1, 7, 7);

-- --------------------------------------------------------

--
-- Table structure for table `permlevel`
--

DROP TABLE IF EXISTS `permlevel`;
CREATE TABLE IF NOT EXISTS `permlevel` (
  `permlevel_id` tinyint(4) NOT NULL,
  `permlevel_desc` varchar(128) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`permlevel_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `permlevel`
--

INSERT INTO `permlevel` (`permlevel_id`, `permlevel_desc`) VALUES
(0, 'No permission'),
(1, 'Regular reservation'),
(3, 'Add ahead'),
(5, 'Add Back'),
(7, 'Add Back+Ahead'),
(9, 'Extra reservation');

-- --------------------------------------------------------

--
-- Table structure for table `proc`
--

DROP TABLE IF EXISTS `proc`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dbtest`.`proc` AS select `mysql`.`proc`.`name` AS `name`,`mysql`.`proc`.`param_list` AS `param_list` from `mysql`.`proc` where ((`mysql`.`proc`.`db` = _utf8'dbtest') and (left(`mysql`.`proc`.`name`,5) = _utf8'view_'));

--
-- Dumping data for table `proc`
--


-- --------------------------------------------------------

--
-- Table structure for table `repetition`
--

DROP TABLE IF EXISTS `repetition`;
CREATE TABLE IF NOT EXISTS `repetition` (
  `repetition_id` int(11) NOT NULL AUTO_INCREMENT,
  `repetition_code` varchar(20) COLLATE utf8_bin NOT NULL,
  KEY `repetition_id` (`repetition_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3265 ;

-- --------------------------------------------------------

--
-- Table structure for table `resaccess`
--

DROP TABLE IF EXISTS `resaccess`;
CREATE TABLE IF NOT EXISTS `resaccess` (
  `resaccess_id` int(11) NOT NULL AUTO_INCREMENT,
  `resaccess_user` int(11) NOT NULL,
  `resaccess_table` varchar(30) COLLATE utf8_bin NOT NULL,
  `resaccess_column` varchar(30) COLLATE utf8_bin NOT NULL,
  `resaccess_value` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`resaccess_id`),
  KEY `resaccess_user` (`resaccess_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Allow users only to view specific content' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `resaccess`
--


-- --------------------------------------------------------

--
-- Table structure for table `resource`
--

DROP TABLE IF EXISTS `resource`;
CREATE TABLE IF NOT EXISTS `resource` (
  `resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_name` varchar(32) COLLATE utf8_bin NOT NULL,
  `resource_type` smallint(6) NOT NULL,
  `resource_status` tinyint(4) NOT NULL,
  `resource_maxdays` smallint(6) NOT NULL COMMENT 'In days, sets the maximum number of days a user can reserve ahead.',
  `resource_starttime` smallint(6) NOT NULL COMMENT 'Hour, Starting time of day for reservations.',
  `resource_stoptime` smallint(6) NOT NULL COMMENT 'Hour, Above this time reservations are no longer available.',
  `resource_resp` int(11) NOT NULL,
  `resource_wikilink` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `resource_price` smallint(6) NOT NULL,
  `resource_resolution` smallint(6) NOT NULL COMMENT 'In minutes, sets the time duration in minutes of  each slot.',
  `resource_maxslots` tinyint(4) NOT NULL COMMENT 'In slots, Maximum time of usage per user per day.',
  `resource_confIP` varchar(15) COLLATE utf8_bin NOT NULL DEFAULT '0.0.0.0' COMMENT 'IP address of computer to be used to confirm reservation.',
  `resource_confirmtol` smallint(6) NOT NULL COMMENT 'In slots, Number of time slots of tolerance allowed before and after reservation time to confirm presence or equipment usage.',
  `resource_delhour` int(11) NOT NULL COMMENT 'In hours, minimum time before an entry starts.to delete it.',
  PRIMARY KEY (`resource_id`),
  KEY `resource_type` (`resource_type`),
  KEY `resource_status` (`resource_status`),
  KEY `resource_id` (`resource_id`),
  KEY `resource_resp` (`resource_resp`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=5 ;

--
-- Dumping data for table `resource`
--

INSERT INTO `resource` (`resource_id`, `resource_name`, `resource_type`, `resource_status`, `resource_maxdays`, `resource_starttime`, `resource_stoptime`, `resource_resp`, `resource_wikilink`, `resource_price`, `resource_resolution`, `resource_maxslots`, `resource_confIP`, `resource_confirmtol`, `resource_delhour`) VALUES
(1, 'Demo Resource', 1, 1, 7, 7, 22, 1, '', 1, 30, 8, '0.0.0.0', 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `resourcebyuser`
--

DROP TABLE IF EXISTS `resourcebyuser`;
CREATE TABLE IF NOT EXISTS `resourcebyuser` (
  `resourcebyuser_id` int(11) NOT NULL AUTO_INCREMENT,
  `resourcebyuser_user` int(11) DEFAULT NULL,
  `resourcebyuser_resource` int(11) DEFAULT NULL,
  `resourcebyuser_hours` double DEFAULT NULL,
  `resourcebyuser_userid` int(3) DEFAULT NULL,
  PRIMARY KEY (`resourcebyuser_id`),
  KEY `resourcebyuser_user` (`resourcebyuser_user`),
  KEY `resourcebyuser_resource` (`resourcebyuser_resource`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

--
-- Dumping data for table `resourcebyuser`
--


-- --------------------------------------------------------

--
-- Table structure for table `resourceusage`
--

DROP TABLE IF EXISTS `resourceusage`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `dbtest`.`resourceusage` AS select `dbtest`.`resource`.`resource_id` AS `resourceusage_id`,`dbtest`.`resource`.`resource_name` AS `resourceusage_name`,(sum(`dbtest`.`entry`.`entry_slots`) * `dbtest`.`resource`.`resource_resolution`) AS `resourceusage_minutes` from (`dbtest`.`entry` join `dbtest`.`resource`) where ((`dbtest`.`entry`.`entry_resource` = `dbtest`.`resource`.`resource_id`) and (`dbtest`.`entry`.`entry_status` = 1)) group by `dbtest`.`resource`.`resource_name`;

--
-- Dumping data for table `resourceusage`
--

INSERT INTO `resourceusage` (`resourceusage_id`, `resourceusage_name`, `resourceusage_minutes`) VALUES
(1, 'Demo Resource', '11040');

-- --------------------------------------------------------

--
-- Table structure for table `resstatus`
--

DROP TABLE IF EXISTS `resstatus`;
CREATE TABLE IF NOT EXISTS `resstatus` (
  `resstatus_id` tinyint(4) NOT NULL,
  `resstatus_name` varchar(40) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`resstatus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `resstatus`
--

INSERT INTO `resstatus` (`resstatus_id`, `resstatus_name`) VALUES
(0, 'Inactive'),
(1, 'Regular reservation'),
(2, 'Invisible'),
(3, 'Pre-reservation with user confirmation'),
(4, 'Pre-reservation with admin confirmation');

-- --------------------------------------------------------

--
-- Table structure for table `resxfields`
--

DROP TABLE IF EXISTS `resxfields`;
CREATE TABLE IF NOT EXISTS `resxfields` (
  `resxfields_id` int(11) NOT NULL,
  `resxfields_field` tinyint(4) NOT NULL,
  `resxfields_resource` int(11) NOT NULL,
  KEY `resxfields_id` (`resxfields_field`),
  KEY `resxfields_resource` (`resxfields_resource`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `resxfields`
--


-- --------------------------------------------------------

--
-- Table structure for table `search`
--

DROP TABLE IF EXISTS `search`;
CREATE TABLE IF NOT EXISTS `search` (
  `search_id` int(11) NOT NULL AUTO_INCREMENT,
  `search_table` varchar(20) COLLATE utf8_bin NOT NULL,
  `search_query` varchar(1000) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`search_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

--
-- Dumping data for table `search`
--


-- --------------------------------------------------------

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
CREATE TABLE IF NOT EXISTS `status` (
  `status_id` tinyint(4) NOT NULL,
  `status_name` varchar(16) NOT NULL,
  PRIMARY KEY (`status_id`),
  KEY `status_id` (`status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`status_id`, `status_name`) VALUES
(1, 'Regular'),
(2, 'Pre-reserve'),
(3, 'Deleted'),
(4, 'Monitor');

-- --------------------------------------------------------

--
-- Table structure for table `type`
--

DROP TABLE IF EXISTS `type`;
CREATE TABLE IF NOT EXISTS `type` (
  `type_id` smallint(6) NOT NULL,
  `type_name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `type`
--

INSERT INTO `type` (`type_id`, `type_name`) VALUES
(1, 'Microscopes - Optical Sectioning'),
(2, 'Microscopes - Wide fields'),
(3, 'Flow Cytometry - Cell sorters'),
(4, 'Real Time PCRs'),
(5, 'Flow Cytometry - Analyzers'),
(6, 'Phys-Chem Measurements'),
(7, 'Stereoscopes'),
(8, 'Histology'),
(9, 'Computers'),
(10, 'Environment Control');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_login` varchar(32) COLLATE utf8_bin NOT NULL,
  `user_passwd` varchar(64) COLLATE utf8_bin NOT NULL COMMENT 'pwd',
  `user_firstname` varchar(16) COLLATE utf8_bin NOT NULL,
  `user_lastname` varchar(16) COLLATE utf8_bin NOT NULL,
  `user_dep` int(11) NOT NULL,
  `user_phone` varchar(32) COLLATE utf8_bin NOT NULL,
  `user_phonext` varchar(8) COLLATE utf8_bin DEFAULT NULL,
  `user_mobile` varchar(16) COLLATE utf8_bin DEFAULT NULL,
  `user_email` varchar(64) COLLATE utf8_bin NOT NULL,
  `user_alert` int(11) NOT NULL COMMENT '1 - Alert by email<br />2 - Alert by SMS',
  PRIMARY KEY (`user_id`),
  KEY `user_dep` (`user_dep`),
  KEY `user_alert` (`user_alert`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=10 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_login`, `user_passwd`, `user_firstname`, `user_lastname`, `user_dep`, `user_phone`, `user_phonext`, `user_mobile`, `user_email`, `user_alert`) VALUES
(1, 'admin', '*A4B6157319038724E3560894F7F932C8886EBFCF', 'admin', 'admin', 1, '123456789', '123', '987654321', 'adminmail@mail.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `xfields`
--

DROP TABLE IF EXISTS `xfields`;
CREATE TABLE IF NOT EXISTS `xfields` (
  `xfields_id` tinyint(4) NOT NULL,
  `xfields_name` varchar(8) COLLATE utf8_bin NOT NULL,
  `xfields_label` varchar(32) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`xfields_id`),
  UNIQUE KEY `xfields_name` (`xfields_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `xfields`
--


-- --------------------------------------------------------

--
-- Table structure for table `xfieldsval`
--

DROP TABLE IF EXISTS `xfieldsval`;
CREATE TABLE IF NOT EXISTS `xfieldsval` (
  `xfieldsval_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `xfieldsval_entry` bigint(20) NOT NULL,
  `xfieldsval_field` tinyint(4) NOT NULL,
  `xfieldsval_value` varchar(32) NOT NULL,
  PRIMARY KEY (`xfieldsval_id`),
  KEY `xfieldval_entry` (`xfieldsval_entry`,`xfieldsval_field`,`xfieldsval_value`),
  KEY `xfieldval_fieldid` (`xfieldsval_field`),
  KEY `xfieldsval_id` (`xfieldsval_id`),
  KEY `xfieldsval_id_2` (`xfieldsval_id`),
  KEY `xfieldsval_entry` (`xfieldsval_entry`),
  KEY `xfieldvals_field` (`xfieldsval_field`),
  KEY `xfieldsval_field` (`xfieldsval_field`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `xfieldsval`
--


--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin`
--
ALTER TABLE `admin`
  ADD CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`admin_user`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `admin_ibfk_2` FOREIGN KEY (`admin_permission`) REFERENCES `access` (`access_id`);

--
-- Constraints for table `announcement`
--
ALTER TABLE `announcement`
  ADD CONSTRAINT `announcement_ibfk_1` FOREIGN KEY (`announcement_object`) REFERENCES `resource` (`resource_id`);

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `department_ibfk_1` FOREIGN KEY (`department_inst`) REFERENCES `institute` (`institute_id`);

--
-- Constraints for table `entry`
--
ALTER TABLE `entry`
  ADD CONSTRAINT `entry_ibfk_1` FOREIGN KEY (`entry_user`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `entry_ibfk_2` FOREIGN KEY (`entry_resource`) REFERENCES `resource` (`resource_id`),
  ADD CONSTRAINT `entry_ibfk_4` FOREIGN KEY (`entry_status`) REFERENCES `status` (`status_id`),
  ADD CONSTRAINT `entry_ibfk_5` FOREIGN KEY (`entry_repeat`) REFERENCES `repetition` (`repetition_id`) ON DELETE CASCADE;

--
-- Constraints for table `equip`
--
ALTER TABLE `equip`
  ADD CONSTRAINT `equip_ibfk_14` FOREIGN KEY (`equip_resourceid`) REFERENCES `resource` (`resource_id`),
  ADD CONSTRAINT `equip_ibfk_15` FOREIGN KEY (`equip_boardID`) REFERENCES `board` (`board_id`),
  ADD CONSTRAINT `equip_ibfk_16` FOREIGN KEY (`equip_para`) REFERENCES `parameter` (`parameter_id`),
  ADD CONSTRAINT `equip_ibfk_17` FOREIGN KEY (`equip_user`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `institute`
--
ALTER TABLE `institute`
  ADD CONSTRAINT `institute_ibfk_1` FOREIGN KEY (`institute_country`) REFERENCES `country` (`country_id`);

--
-- Constraints for table `measure`
--
ALTER TABLE `measure`
  ADD CONSTRAINT `measure_ibfk_1` FOREIGN KEY (`measure_equip`) REFERENCES `equip` (`equip_id`);

--
-- Constraints for table `permissions`
--
ALTER TABLE `permissions`
  ADD CONSTRAINT `permissions_ibfk_4` FOREIGN KEY (`permissions_user`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permissions_ibfk_5` FOREIGN KEY (`permissions_resource`) REFERENCES `resource` (`resource_id`),
  ADD CONSTRAINT `permissions_ibfk_6` FOREIGN KEY (`permissions_level`) REFERENCES `permlevel` (`permlevel_id`);

--
-- Constraints for table `resaccess`
--
ALTER TABLE `resaccess`
  ADD CONSTRAINT `resaccess_ibfk_1` FOREIGN KEY (`resaccess_user`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `resource`
--
ALTER TABLE `resource`
  ADD CONSTRAINT `resource_ibfk_1` FOREIGN KEY (`resource_type`) REFERENCES `type` (`type_id`),
  ADD CONSTRAINT `resource_ibfk_3` FOREIGN KEY (`resource_resp`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `resource_ibfk_4` FOREIGN KEY (`resource_status`) REFERENCES `resstatus` (`resstatus_id`);

--
-- Constraints for table `resourcebyuser`
--
ALTER TABLE `resourcebyuser`
  ADD CONSTRAINT `resourcebyuser_ibfk_1` FOREIGN KEY (`resourcebyuser_user`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `resourcebyuser_ibfk_2` FOREIGN KEY (`resourcebyuser_resource`) REFERENCES `resource` (`resource_id`);

--
-- Constraints for table `resxfields`
--
ALTER TABLE `resxfields`
  ADD CONSTRAINT `resxfields_ibfk_2` FOREIGN KEY (`resxfields_resource`) REFERENCES `resource` (`resource_id`),
  ADD CONSTRAINT `resxfields_ibfk_3` FOREIGN KEY (`resxfields_field`) REFERENCES `xfields` (`xfields_id`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`user_dep`) REFERENCES `department` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `usercheck`
--
ALTER TABLE `usercheck`
  ADD CONSTRAINT `usercheck_ibfk_1` FOREIGN KEY (`usercheck_user`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `usercheck_ibfk_2` FOREIGN KEY (`usercheck_resource`) REFERENCES `resource` (`resource_id`);

--
-- Constraints for table `xfieldsval`
--
ALTER TABLE `xfieldsval`
  ADD CONSTRAINT `xfieldsval_ibfk_2` FOREIGN KEY (`xfieldsval_field`) REFERENCES `xfields` (`xfields_id`),
  ADD CONSTRAINT `xfieldsval_ibfk_3` FOREIGN KEY (`xfieldsval_entry`) REFERENCES `entry` (`entry_id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
