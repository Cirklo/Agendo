-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 01, 2011 at 02:14 
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

CREATE TABLE IF NOT EXISTS `admin` (
  `admin_id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_user` int(11) NOT NULL,
  `admin_table` varchar(20) NOT NULL COMMENT 'Available tables<br /><br />admin<br />board<br />department<br />entry<br />equip<br />institute<br />parameter<br />permissions<br />resource<br />type<br />user',
  `admin_permission` int(11) NOT NULL COMMENT '0 - View<br />1 - Update<br />2 - Delete<br/>3 - Update, Delete<br />4 - Add<br />5 - Add, Update<br />6 - Add, Delete<br />7 - Add, Update, Delete',
  PRIMARY KEY (`admin_id`),
  KEY `admin_user` (`admin_user`),
  KEY `admin_permission` (`admin_permission`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=40 ;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `admin_user`, `admin_table`, `admin_permission`) VALUES
(22, 1, 'resource', 5),
(24, 1, 'permissions', 5),
(25, 1, 'type', 7),
(26, 1, 'department', 7),
(27, 1, 'user', 7),
(28, 1, 'entry', 7),
(34, 1, 'admin', 7),
(35, 1, 'help', 7),
(36, 1, 'treeview', 5),
(37, 1, 'restree', 7),
(38, 1, 'plugin', 7),
(39, 1, 'menu', 7);

-- --------------------------------------------------------

--
-- Table structure for table `announcement`
--

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
-- Table structure for table `bool`
--

CREATE TABLE IF NOT EXISTS `bool` (
  `bool_id` int(11) NOT NULL,
  `bool_type` varchar(6) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`bool_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `bool`
--

INSERT INTO `bool` (`bool_id`, `bool_type`) VALUES
(0, 'FALSE'),
(1, 'TRUE');

-- --------------------------------------------------------

--
-- Table structure for table `color`
--

CREATE TABLE IF NOT EXISTS `color` (
  `color_id` int(11) NOT NULL,
  `color_name` varchar(50) COLLATE utf8_bin NOT NULL,
  `color_code` varchar(6) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`color_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `color`
--

INSERT INTO `color` (`color_id`, `color_name`, `color_code`) VALUES
(0, 'indian red', 'B0171F'),
(1, 'crimson', 'DC143C'),
(2, 'lightpink', 'FFB6C1'),
(3, 'lightpink 1', 'FFAEB9'),
(4, 'lightpink 2', 'EEA2AD'),
(5, 'lightpink 3', 'CD8C95'),
(6, 'lightpink 4', '8B5F65'),
(7, 'pink', 'FFC0CB'),
(8, 'pink 1', 'FFB5C5'),
(9, 'pink 2', 'EEA9B8'),
(10, 'pink 3', 'CD919E'),
(11, 'pink 4', '8B636C'),
(12, 'palevioletred', 'DB7093'),
(13, 'palevioletred 1', 'FF82AB'),
(14, 'palevioletred 2', 'EE799F'),
(15, 'palevioletred 3', 'CD6889'),
(16, 'palevioletred 4', '8B475D'),
(17, 'lavenderblush 1 (lavenderblush)', 'FFF0F5'),
(18, 'lavenderblush 2', 'EEE0E5'),
(19, 'lavenderblush 3', 'CDC1C5'),
(20, 'lavenderblush 4', '8B8386'),
(21, 'violetred 1', 'FF3E96'),
(22, 'violetred 2', 'EE3A8C'),
(23, 'violetred 3', 'CD3278'),
(24, 'violetred 4', '8B2252'),
(25, 'hotpink', 'FF69B4'),
(26, 'hotpink 1', 'FF6EB4'),
(27, 'hotpink 2', 'EE6AA7'),
(28, 'hotpink 3', 'CD6090'),
(29, 'hotpink 4', '8B3A62'),
(30, 'raspberry', '872657'),
(31, 'deeppink 1 (deeppink)', 'FF1493'),
(32, 'deeppink 2', 'EE1289'),
(33, 'deeppink 3', 'CD1076'),
(34, 'deeppink 4', '8B0A50'),
(35, 'maroon 1', 'FF34B3'),
(36, 'maroon 2', 'EE30A7'),
(37, 'maroon 3', 'CD2990'),
(38, 'maroon 4', '8B1C62'),
(39, 'mediumvioletred', 'C71585'),
(40, 'violetred', 'D02090'),
(41, 'orchid', 'DA70D6'),
(42, 'orchid 1', 'FF83FA'),
(43, 'orchid 2', 'EE7AE9'),
(44, 'orchid 3', 'CD69C9'),
(45, 'orchid 4', '8B4789'),
(46, 'thistle', 'D8BFD8'),
(47, 'thistle 1', 'FFE1FF'),
(48, 'thistle 2', 'EED2EE'),
(49, 'thistle 3', 'CDB5CD'),
(50, 'thistle 4', '8B7B8B'),
(51, 'plum 1', 'FFBBFF'),
(52, 'plum 2', 'EEAEEE'),
(53, 'plum 3', 'CD96CD'),
(54, 'plum 4', '8B668B'),
(55, 'plum', 'DDA0DD'),
(56, 'violet', 'EE82EE'),
(57, 'magenta (fuchsia*)', 'FF00FF'),
(58, 'magenta 2', 'EE00EE'),
(59, 'magenta 3', 'CD00CD'),
(60, 'magenta 4 (darkmagenta)', '8B008B'),
(61, 'purple*', '800080'),
(62, 'mediumorchid', 'BA55D3'),
(63, 'mediumorchid 1', 'E066FF'),
(64, 'mediumorchid 2', 'D15FEE'),
(65, 'mediumorchid 3', 'B452CD'),
(66, 'mediumorchid 4', '7A378B'),
(67, 'darkviolet', '9400D3'),
(68, 'darkorchid', '9932CC'),
(69, 'darkorchid 1', 'BF3EFF'),
(70, 'darkorchid 2', 'B23AEE'),
(71, 'darkorchid 3', '9A32CD'),
(72, 'darkorchid 4', '68228B'),
(73, 'indigo', '4B0082'),
(74, 'blueviolet', '8A2BE2'),
(75, 'purple 1', '9B30FF'),
(76, 'purple 2', '912CEE'),
(77, 'purple 3', '7D26CD'),
(78, 'purple 4', '551A8B'),
(79, 'mediumpurple', '9370DB'),
(80, 'mediumpurple 1', 'AB82FF'),
(81, 'mediumpurple 2', '9F79EE'),
(82, 'mediumpurple 3', '8968CD'),
(83, 'mediumpurple 4', '5D478B'),
(84, 'darkslateblue', '483D8B'),
(85, 'lightslateblue', '8470FF'),
(86, 'mediumslateblue', '7B68EE'),
(87, 'slateblue', '6A5ACD'),
(88, 'slateblue 1', '836FFF'),
(89, 'slateblue 2', '7A67EE'),
(90, 'slateblue 3', '6959CD'),
(91, 'slateblue 4', '473C8B'),
(92, 'ghostwhite', 'F8F8FF'),
(93, 'lavender', 'E6E6FA'),
(94, 'blue*', '0000FF'),
(95, 'blue 2', '0000EE'),
(96, 'blue 3 (mediumblue)', '0000CD'),
(97, 'blue 4 (darkblue)', '00008B'),
(98, 'navy*', '80'),
(99, 'midnightblue', '191970'),
(100, 'cobalt', '3D59AB'),
(101, 'royalblue', '41690'),
(102, 'royalblue 1', '4876FF'),
(103, 'royalblue 2', '436EEE'),
(104, 'royalblue 3', '3A5FCD'),
(105, 'royalblue 4', '27408B'),
(106, 'cornflowerblue', '6495ED'),
(107, 'lightsteelblue', 'B0C4DE'),
(108, 'lightsteelblue 1', 'CAE1FF'),
(109, 'lightsteelblue 2', 'BCD2EE'),
(110, 'lightsteelblue 3', 'A2B5CD'),
(111, 'lightsteelblue 4', '6E7B8B'),
(112, 'lightslategray', '778899'),
(113, 'slategray', '708090'),
(114, 'slategray 1', 'C6E2FF'),
(115, 'slategray 2', 'B9D3EE'),
(116, 'slategray 3', '9FB6CD'),
(117, 'slategray 4', '6C7B8B'),
(118, 'dodgerblue 1 (dodgerblue)', '1E90FF'),
(119, 'dodgerblue 2', '1C86EE'),
(120, 'dodgerblue 3', '1874CD'),
(121, 'dodgerblue 4', '104E8B'),
(122, 'aliceblue', 'F0F8FF'),
(123, 'steelblue', '4682B4'),
(124, 'steelblue 1', '63B8FF'),
(125, 'steelblue 2', '5CACEE'),
(126, 'steelblue 3', '4F94CD'),
(127, 'steelblue 4', '36648B'),
(128, 'lightskyblue', '87CEFA'),
(129, 'lightskyblue 1', 'B0E2FF'),
(130, 'lightskyblue 2', 'A4D3EE'),
(131, 'lightskyblue 3', '8DB6CD'),
(132, 'lightskyblue 4', '607B8B'),
(133, 'skyblue 1', '87CEFF'),
(134, 'skyblue 2', '7EC0EE'),
(135, 'skyblue 3', '6CA6CD'),
(136, 'skyblue 4', '4A708B'),
(137, 'skyblue', '87CEEB'),
(138, 'deepskyblue 1 (deepskyblue)', '00BFFF'),
(139, 'deepskyblue 2', '00B2EE'),
(140, 'deepskyblue 3', '009ACD'),
(141, 'deepskyblue 4', '00688B'),
(142, 'peacock', '33A1C9'),
(143, 'lightblue', 'ADD8E6'),
(144, 'lightblue 1', 'BFEFFF'),
(145, 'lightblue 2', 'B2DFEE'),
(146, 'lightblue 3', '9AC0CD'),
(147, 'lightblue 4', '68838B'),
(148, 'powderblue', 'B0E0E6'),
(149, 'cadetblue 1', '98F5FF'),
(150, 'cadetblue 2', '8EE5EE'),
(151, 'cadetblue 3', '7AC5CD'),
(152, 'cadetblue 4', '53868B'),
(153, 'turquoise 1', '00F5FF'),
(154, 'turquoise 2', '00E5EE'),
(155, 'turquoise 3', '00C5CD'),
(156, 'turquoise 4', '00868B'),
(157, 'cadetblue', '5F9EA0'),
(158, 'darkturquoise', '00CED1'),
(159, 'azure 1 (azure)', 'F0FFFF'),
(160, 'azure 2', 'E0EEEE'),
(161, 'azure 3', 'C1CDCD'),
(162, 'azure 4', '838B8B'),
(163, 'lightcyan 1 (lightcyan)', 'E0FFFF'),
(164, 'lightcyan 2', 'D1EEEE'),
(165, 'lightcyan 3', 'B4CDCD'),
(166, 'lightcyan 4', '7A8B8B'),
(167, 'paleturquoise 1', 'BBFFFF'),
(168, 'paleturquoise 2 (paleturquoise)', 'AEEEEE'),
(169, 'paleturquoise 3', '96CDCD'),
(170, 'paleturquoise 4', '668B8B'),
(171, 'darkslategray', '2F4F4F'),
(172, 'darkslategray 1', '97FFFF'),
(173, 'darkslategray 2', '8DEEEE'),
(174, 'darkslategray 3', '79CDCD'),
(175, 'darkslategray 4', '528B8B'),
(176, 'cyan / aqua*', '00FFFF'),
(177, 'cyan 2', '00EEEE'),
(178, 'cyan 3', '00CDCD'),
(179, 'cyan 4 (darkcyan)', '008B8B'),
(180, 'teal*', '8080'),
(181, 'mediumturquoise', '48D1CC'),
(182, 'lightseagreen', '20B2AA'),
(183, 'manganeseblue', '03A89E'),
(184, 'turquoise', '40E0D0'),
(185, 'coldgrey', '808A87'),
(186, 'turquoiseblue', '00C78C'),
(187, 'aquamarine 1 (aquamarine)', '7FFFD4'),
(188, 'aquamarine 2', '76EEC6'),
(189, 'aquamarine 3 (mediumaquamarine)', '66CDAA'),
(190, 'aquamarine 4', '458B74'),
(191, 'mediumspringgreen', '00FA9A'),
(192, 'mintcream', 'F5FFFA'),
(193, 'springgreen', '00FF7F'),
(194, 'springgreen 1', '00EE76'),
(195, 'springgreen 2', '00CD66'),
(196, 'springgreen 3', '008B45'),
(197, 'mediumseagreen', '3CB371'),
(198, 'seagreen 1', '54FF9F'),
(199, 'seagreen 2', '4EEE94'),
(200, 'seagreen 3', '43CD80'),
(201, 'seagreen 4 (seagreen)', '2E8B57'),
(202, 'emeraldgreen', '00C957'),
(203, 'mint', 'BDFCC9'),
(204, 'cobaltgreen', '3D9140'),
(205, 'honeydew 1 (honeydew)', 'F0FFF0'),
(206, 'honeydew 2', 'E0EEE0'),
(207, 'honeydew 3', 'C1CDC1'),
(208, 'honeydew 4', '838B83'),
(209, 'darkseagreen', '8FBC8F'),
(210, 'darkseagreen 1', 'C1FFC1'),
(211, 'darkseagreen 2', 'B4EEB4'),
(212, 'darkseagreen 3', '9BCD9B'),
(213, 'darkseagreen 4', '698B69'),
(214, 'palegreen', '98FB98'),
(215, 'palegreen 1', '9AFF9A'),
(216, 'palegreen 2 (lightgreen)', '90EE90'),
(217, 'palegreen 3', '7CCD7C'),
(218, 'palegreen 4', '548B54'),
(219, 'limegreen', '32CD32'),
(220, 'forestgreen', '228B22'),
(221, 'green 1 (lime*)', '00FF00'),
(222, 'green 2', '00EE00'),
(223, 'green 3', '00CD00'),
(224, 'green 4', '008B00'),
(225, 'green*', '8000'),
(226, 'darkgreen', '6400'),
(227, 'sapgreen', '308014'),
(228, 'lawngreen', '7CFC00'),
(229, 'chartreuse 1 (chartreuse)', '7FFF00'),
(230, 'chartreuse 2', '76EE00'),
(231, 'chartreuse 3', '66CD00'),
(232, 'chartreuse 4', '458B00'),
(233, 'greenyellow', 'ADFF2F'),
(234, 'darkolivegreen 1', 'CAFF70'),
(235, 'darkolivegreen 2', 'BCEE68'),
(236, 'darkolivegreen 3', 'A2CD5A'),
(237, 'darkolivegreen 4', '6E8B3D'),
(238, 'darkolivegreen', '556B2F'),
(239, 'olivedrab', '6B8E23'),
(240, 'olivedrab 1', 'C0FF3E'),
(241, 'olivedrab 2', 'B3EE3A'),
(242, 'olivedrab 3 (yellowgreen)', '9ACD32'),
(243, 'olivedrab 4', '698B22'),
(244, 'ivory 1 (ivory)', 'FFFFF0'),
(245, 'ivory 2', 'EEEEE0'),
(246, 'ivory 3', 'CDCDC1'),
(247, 'ivory 4', '8B8B83'),
(248, 'beige', 'F5F5DC'),
(249, 'lightyellow 1 (lightyellow)', 'FFFFE0'),
(250, 'lightyellow 2', 'EEEED1'),
(251, 'lightyellow 3', 'CDCDB4'),
(252, 'lightyellow 4', '8B8B7A'),
(253, 'lightgoldenrodyellow', 'FAFAD2'),
(254, 'yellow 1 (yellow*)', 'FFFF00'),
(255, 'yellow 2', 'EEEE00'),
(256, 'yellow 3', 'CDCD00'),
(257, 'yellow 4', '8B8B00'),
(258, 'warmgrey', '808069'),
(259, 'olive*', '808000'),
(260, 'darkkhaki', 'BDB76B'),
(261, 'khaki 1', 'FFF68F'),
(262, 'khaki 2', 'EEE685'),
(263, 'khaki 3', 'CDC673'),
(264, 'khaki 4', '8B864E'),
(265, 'khaki', 'F0E68C'),
(266, 'palegoldenrod', 'EEE8AA'),
(267, 'lemonchiffon 1 (lemonchiffon)', 'FFFACD'),
(268, 'lemonchiffon 2', 'EEE9BF'),
(269, 'lemonchiffon 3', 'CDC9A5'),
(270, 'lemonchiffon 4', '8B8970'),
(271, 'lightgoldenrod 1', 'FFEC8B'),
(272, 'lightgoldenrod 2', 'EEDC82'),
(273, 'lightgoldenrod 3', 'CDBE70'),
(274, 'lightgoldenrod 4', '8B814C'),
(275, 'banana', 'E3CF57'),
(276, 'gold 1 (gold)', 'FFD700'),
(277, 'gold 2', 'EEC900'),
(278, 'gold 3', 'CDAD00'),
(279, 'gold 4', '8B7500'),
(280, 'cornsilk 1 (cornsilk)', 'FFF8DC'),
(281, 'cornsilk 2', 'EEE8CD'),
(282, 'cornsilk 3', 'CDC8B1'),
(283, 'cornsilk 4', '8B8878'),
(284, 'goldenrod', 'DAA520'),
(285, 'goldenrod 1', 'FFC125'),
(286, 'goldenrod 2', 'EEB422'),
(287, 'goldenrod 3', 'CD9B1D'),
(288, 'goldenrod 4', '8B6914'),
(289, 'darkgoldenrod', 'B8860B'),
(290, 'darkgoldenrod 1', 'FFB90F'),
(291, 'darkgoldenrod 2', 'EEAD0E'),
(292, 'darkgoldenrod 3', 'CD950C'),
(293, 'darkgoldenrod 4', '8B6508'),
(294, 'orange 1 (orange)', 'FFA500'),
(295, 'orange 2', 'EE9A00'),
(296, 'orange 3', 'CD8500'),
(297, 'orange 4', '8B5A00'),
(298, 'floralwhite', 'FFFAF0'),
(299, 'oldlace', 'FDF5E6'),
(300, 'wheat', 'F5DEB3'),
(301, 'wheat 1', 'FFE7BA'),
(302, 'wheat 2', 'EED8AE'),
(303, 'wheat 3', 'CDBA96'),
(304, 'wheat 4', '8B7E66'),
(305, 'moccasin', 'FFE4B5'),
(306, 'papayawhip', 'FFEFD5'),
(307, 'blanchedalmond', 'FFEBCD'),
(308, 'navajowhite 1 (navajowhite)', 'FFDEAD'),
(309, 'navajowhite 2', 'EECFA1'),
(310, 'navajowhite 3', 'CDB38B'),
(311, 'navajowhite 4', '8B795E'),
(312, 'eggshell', 'FCE6C9'),
(313, 'tan', 'D2B48C'),
(314, 'brick', '9C661F'),
(315, 'cadmiumyellow', 'FF9912'),
(316, 'antiquewhite', 'FAEBD7'),
(317, 'antiquewhite 1', 'FFEFDB'),
(318, 'antiquewhite 2', 'EEDFCC'),
(319, 'antiquewhite 3', 'CDC0B0'),
(320, 'antiquewhite 4', '8B8378'),
(321, 'burlywood', 'DEB887'),
(322, 'burlywood 1', 'FFD39B'),
(323, 'burlywood 2', 'EEC591'),
(324, 'burlywood 3', 'CDAA7D'),
(325, 'burlywood 4', '8B7355'),
(326, 'bisque 1 (bisque)', 'FFE4C4'),
(327, 'bisque 2', 'EED5B7'),
(328, 'bisque 3', 'CDB79E'),
(329, 'bisque 4', '8B7D6B'),
(330, 'melon', 'E3A869'),
(331, 'carrot', 'ED9121'),
(332, 'darkorange', 'FF8C00'),
(333, 'darkorange 1', 'FF7F00'),
(334, 'darkorange 2', 'EE7600'),
(335, 'darkorange 3', 'CD6600'),
(336, 'darkorange 4', '8B4500'),
(337, 'orange', 'FF8000'),
(338, 'tan 1', 'FFA54F'),
(339, 'tan 2', 'EE9A49'),
(340, 'tan 3 (peru)', 'CD853F'),
(341, 'tan 4', '8B5A2B'),
(342, 'linen', 'FAF0E6'),
(343, 'peachpuff 1 (peachpuff)', 'FFDAB9'),
(344, 'peachpuff 2', 'EECBAD'),
(345, 'peachpuff 3', 'CDAF95'),
(346, 'peachpuff 4', '8B7765'),
(347, 'seashell 1 (seashell)', 'FFF5EE'),
(348, 'seashell 2', 'EEE5DE'),
(349, 'seashell 3', 'CDC5BF'),
(350, 'seashell 4', '8B8682'),
(351, 'sandybrown', 'F4A460'),
(352, 'rawsienna', 'C76114'),
(353, 'chocolate', 'D2691E'),
(354, 'chocolate 1', 'FF7F24'),
(355, 'chocolate 2', 'EE7621'),
(356, 'chocolate 3', 'CD661D'),
(357, 'chocolate 4 (saddlebrown)', '8B4513'),
(358, 'ivoryblack', '292421'),
(359, 'flesh', 'FF7D40'),
(360, 'cadmiumorange', 'FF6103'),
(361, 'burntsienna', '8A360F'),
(362, 'sienna', 'A0522D'),
(363, 'sienna 1', 'FF8247'),
(364, 'sienna 2', 'EE7942'),
(365, 'sienna 3', 'CD6839'),
(366, 'sienna 4', '8B4726'),
(367, 'lightsalmon 1 (lightsalmon)', 'FFA07A'),
(368, 'lightsalmon 2', 'EE9572'),
(369, 'lightsalmon 3', 'CD8162'),
(370, 'lightsalmon 4', '8B5742'),
(371, 'coral', 'FF7F50'),
(372, 'orangered 1 (orangered)', 'FF4500'),
(373, 'orangered 2', 'EE4000'),
(374, 'orangered 3', 'CD3700'),
(375, 'orangered 4', '8B2500'),
(376, 'sepia', '5E2612'),
(377, 'darksalmon', 'E9967A'),
(378, 'salmon 1', 'FF8C69'),
(379, 'salmon 2', 'EE8262'),
(380, 'salmon 3', 'CD7054'),
(381, 'salmon 4', '8B4C39'),
(382, 'coral 1', 'FF7256'),
(383, 'coral 2', 'EE6A50'),
(384, 'coral 3', 'CD5B45'),
(385, 'coral 4', '8B3E2F'),
(386, 'burntumber', '8A3324'),
(387, 'tomato 1 (tomato)', 'FF6347'),
(388, 'tomato 2', 'EE5C42'),
(389, 'tomato 3', 'CD4F39'),
(390, 'tomato 4', '8B3626'),
(391, 'salmon', 'FA8072'),
(392, 'mistyrose 1 (mistyrose)', 'FFE4E1'),
(393, 'mistyrose 2', 'EED5D2'),
(394, 'mistyrose 3', 'CDB7B5'),
(395, 'mistyrose 4', '8B7D7B'),
(396, 'snow 1 (snow)', 'FFFAFA'),
(397, 'snow 2', 'EEE9E9'),
(398, 'snow 3', 'CDC9C9'),
(399, 'snow 4', '8B8989'),
(400, 'rosybrown', 'BC8F8F'),
(401, 'rosybrown 1', 'FFC1C1'),
(402, 'rosybrown 2', 'EEB4B4'),
(403, 'rosybrown 3', 'CD9B9B'),
(404, 'rosybrown 4', '8B6969'),
(405, 'lightcoral', 'F08080'),
(406, 'indianred', 'CD5C5C'),
(407, 'indianred 1', 'FF6A6A'),
(408, 'indianred 2', 'EE6363'),
(409, 'indianred 4', '8B3A3A'),
(410, 'indianred 3', 'CD5555'),
(411, 'brown', 'A52A2A'),
(412, 'brown 1', 'FF4040'),
(413, 'brown 2', 'EE3B3B'),
(414, 'brown 3', 'CD3333'),
(415, 'brown 4', '8B2323'),
(416, 'firebrick', 'B22222'),
(417, 'firebrick 1', 'FF3030'),
(418, 'firebrick 2', 'EE2C2C'),
(419, 'firebrick 3', 'CD2626'),
(420, 'firebrick 4', '8B1A1A'),
(421, 'red 1 (red*)', 'FF0000'),
(422, 'red 2', 'EE0000'),
(423, 'red 3', 'CD0000'),
(424, 'red 4 (darkred)', '8B0000'),
(425, 'maroon*', '800000'),
(426, 'sgi beet', '8E388E'),
(427, 'sgi slateblue', '7171C6'),
(428, 'sgi lightblue', '7D9EC0'),
(429, 'sgi teal', '388E8E'),
(430, 'sgi chartreuse', '71C671'),
(431, 'sgi olivedrab', '8E8E38'),
(432, 'sgi brightgray', 'C5C1AA'),
(433, 'sgi salmon', 'C67171'),
(434, 'sgi darkgray', '555555'),
(435, 'sgi gray 12', '1E1E1E'),
(436, 'sgi gray 16', '282828'),
(437, 'sgi gray 32', '515151'),
(438, 'sgi gray 36', '5B5B5B'),
(439, 'sgi gray 52', '848484'),
(440, 'sgi gray 56', '8E8E8E'),
(441, 'sgi lightgray', 'AAAAAA'),
(442, 'sgi gray 72', 'B7B7B7'),
(443, 'sgi gray 76', 'C1C1C1'),
(444, 'sgi gray 92', 'EAEAEA'),
(445, 'sgi gray 96', 'F4F4F4'),
(446, 'white*', 'FFFFFF'),
(447, 'white smoke (gray 96)', 'F5F5F5'),
(448, 'gainsboro', 'DCDCDC'),
(449, 'lightgrey', 'D3D3D3'),
(450, 'silver*', 'C0C0C0'),
(451, 'darkgray', 'A9A9A9'),
(452, 'gray*', '808080'),
(453, 'dimgray (gray 42)', '696969'),
(454, 'black*', '0'),
(455, 'gray 99', 'FCFCFC'),
(456, 'gray 98', 'FAFAFA'),
(457, 'gray 97', 'F7F7F7'),
(458, 'white smoke (gray 96)', 'F5F5F5'),
(459, 'gray 95', 'F2F2F2'),
(460, 'gray 94', 'F0F0F0'),
(461, 'gray 93', 'EDEDED'),
(462, 'gray 92', 'EBEBEB'),
(463, 'gray 91', 'E8E8E8'),
(464, 'gray 90', 'E5E5E5'),
(465, 'gray 89', 'E3E3E3'),
(466, 'gray 88', 'E0E0E0'),
(467, 'gray 87', 'DEDEDE'),
(468, 'gray 86', 'DBDBDB'),
(469, 'gray 85', 'D9D9D9'),
(470, 'gray 84', 'D6D6D6'),
(471, 'gray 83', 'D4D4D4'),
(472, 'gray 82', 'D1D1D1'),
(473, 'gray 81', 'CFCFCF'),
(474, 'gray 80', 'CCCCCC'),
(475, 'gray 79', 'C9C9C9'),
(476, 'gray 78', 'C7C7C7'),
(477, 'gray 77', 'C4C4C4'),
(478, 'gray 76', 'C2C2C2'),
(479, 'gray 75', 'BFBFBF'),
(480, 'gray 74', 'BDBDBD'),
(481, 'gray 73', 'BABABA'),
(482, 'gray 72', 'B8B8B8'),
(483, 'gray 71', 'B5B5B5'),
(484, 'gray 70', 'B3B3B3'),
(485, 'gray 69', 'B0B0B0'),
(486, 'gray 68', 'ADADAD'),
(487, 'gray 67', 'ABABAB'),
(488, 'gray 66', 'A8A8A8'),
(489, 'gray 65', 'A6A6A6'),
(490, 'gray 64', 'A3A3A3'),
(491, 'gray 63', 'A1A1A1'),
(492, 'gray 62', '9E9E9E'),
(493, 'gray 61', '9C9C9C'),
(494, 'gray 60', '999999'),
(495, 'gray 59', '969696'),
(496, 'gray 58', '949494'),
(497, 'gray 57', '919191'),
(498, 'gray 56', '8F8F8F'),
(499, 'gray 55', '8C8C8C'),
(500, 'gray 54', '8A8A8A'),
(501, 'gray 53', '878787'),
(502, 'gray 52', '858585'),
(503, 'gray 51', '828282'),
(504, 'gray 50', '7F7F7F'),
(505, 'gray 49', '7D7D7D'),
(506, 'gray 48', '7A7A7A'),
(507, 'gray 47', '787878'),
(508, 'gray 46', '757575'),
(509, 'gray 45', '737373'),
(510, 'gray 44', '707070'),
(511, 'gray 43', '6E6E6E'),
(512, 'gray 42', '6B6B6B'),
(513, 'dimgray (gray 42)', '696969'),
(514, 'gray 40', '666666'),
(515, 'gray 39', '636363'),
(516, 'gray 38', '616161'),
(517, 'gray 37', '5E5E5E'),
(518, 'gray 36', '5C5C5C'),
(519, 'gray 35', '595959'),
(520, 'gray 34', '575757'),
(521, 'gray 33', '545454'),
(522, 'gray 32', '525252'),
(523, 'gray 31', '4F4F4F'),
(524, 'gray 30', '4D4D4D'),
(525, 'gray 29', '4A4A4A'),
(526, 'gray 28', '474747'),
(527, 'gray 27', '454545'),
(528, 'gray 26', '424242'),
(529, 'gray 25', '404040'),
(530, 'gray 24', '3D3D3D'),
(531, 'gray 23', '3B3B3B'),
(532, 'gray 22', '383838'),
(533, 'gray 21', '363636'),
(534, 'gray 20', '333333'),
(535, 'gray 19', '303030'),
(536, 'gray 18', '2E2E2E'),
(537, 'gray 17', '2B2B2B'),
(538, 'gray 16', '292929'),
(539, 'gray 15', '262626'),
(540, 'gray 14', '242424'),
(541, 'gray 13', '212121'),
(542, 'gray 12', '1F1F1F'),
(543, 'gray 11', '1C1C1C'),
(544, 'gray 10', '1A1A1A'),
(545, 'gray 9', '171717'),
(546, 'gray 8', '141414'),
(547, 'gray 7', '121212'),
(548, 'gray 6', '0F0F0F'),
(549, 'gray 5', '0D0D0D'),
(550, 'gray 4', '0A0A0A'),
(551, 'gray 3', '80808'),
(552, 'gray 2', '50505'),
(553, 'gray 1', '30303');

-- --------------------------------------------------------

--
-- Table structure for table `confidentiality`
--

CREATE TABLE IF NOT EXISTS `confidentiality` (
  `confidentiality_id` int(11) NOT NULL AUTO_INCREMENT,
  `confidentiality_name` varchar(10) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`confidentiality_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=4 ;

--
-- Dumping data for table `confidentiality`
--

INSERT INTO `confidentiality` (`confidentiality_id`, `confidentiality_name`) VALUES
(1, 'Public'),
(2, 'Private'),
(3, 'Undefined');

-- --------------------------------------------------------

--
-- Table structure for table `country`
--

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=669 ;

--
-- Dumping data for table `entry`
--

INSERT INTO `entry` (`entry_id`, `entry_user`, `entry_datetime`, `entry_slots`, `entry_assistance`, `entry_repeat`, `entry_status`, `entry_resource`, `entry_action`, `entry_comments`) VALUES
(633, 1, '2011-02-24 11:30:00', 5, 0, 3404, 3, 1, '2011-02-25 16:34:51', NULL),
(634, 1, '2011-02-23 10:30:00', 1, 0, 3404, 3, 1, '2011-02-25 16:34:51', NULL),
(635, 1, '2011-02-25 14:00:00', 2, 0, 3404, 3, 1, '2011-02-25 16:34:51', NULL),
(636, 1, '2011-02-26 14:30:00', 1, 0, 3404, 3, 1, '2011-02-25 16:34:51', NULL),
(637, 1, '2011-03-03 11:30:00', 4, 0, 3405, 3, 1, '2011-02-28 14:52:14', NULL),
(638, 1, '2011-03-04 13:30:00', 3, 0, 3405, 1, 1, '2011-02-28 14:52:14', NULL),
(639, 1, '2011-03-06 10:00:00', 2, 0, 3406, 1, 1, '2011-02-28 15:32:11', NULL),
(640, 1, '2011-03-04 10:00:00', 3, 0, 3406, 1, 1, '2011-02-28 15:32:12', NULL),
(641, 1, '2011-03-03 08:30:00', 4, 0, 3406, 1, 1, '2011-02-28 15:32:12', NULL),
(642, 1, '2011-03-05 10:30:00', 2, 0, 3406, 1, 1, '2011-02-28 15:32:12', NULL),
(643, 2, '2011-03-04 03:00:00', 2, 0, 3407, 2, 3, '2011-02-28 15:41:00', NULL),
(644, 2, '2011-03-01 02:00:00', 3, 0, 3408, 2, 3, '2011-02-28 15:41:05', NULL),
(645, 2, '2011-03-04 08:00:00', 3, 0, 3409, 2, 2, '2011-02-28 15:41:12', NULL),
(646, 2, '2011-03-03 11:00:00', 6, 0, 3409, 2, 2, '2011-02-28 15:41:14', NULL),
(647, 1, '2011-03-04 07:30:00', 5, 0, 3410, 1, 1, '2011-02-28 15:43:23', NULL),
(648, 1, '2011-03-04 15:30:00', 1, 0, 3411, 1, 1, '2011-02-28 15:43:26', NULL),
(649, 1, '2011-03-04 20:30:00', 1, 0, 3413, 1, 1, '2011-02-28 15:43:39', NULL),
(650, 1, '2011-03-05 19:30:00', 3, 0, 3413, 1, 1, '2011-02-28 15:43:39', NULL),
(651, 1, '2011-03-06 13:30:00', 7, 0, 3416, 1, 1, '2011-02-28 15:43:57', NULL),
(652, 1, '2011-02-28 11:00:00', 19, 0, 3417, 1, 1, '2011-02-28 15:44:00', NULL),
(653, 1, '2011-03-04 11:30:00', 1, 0, 3420, 1, 1, '2011-02-28 15:44:21', NULL),
(654, 1, '2011-03-04 12:00:00', 1, 0, 3421, 1, 1, '2011-02-28 15:44:23', NULL),
(655, 1, '2011-03-04 17:00:00', 1, 0, 3422, 1, 1, '2011-02-28 15:44:25', NULL),
(656, 1, '2011-03-04 18:00:00', 1, 0, 3425, 1, 1, '2011-02-28 15:44:31', NULL),
(657, 1, '2011-03-01 11:30:00', 2, 0, 3426, 1, 1, '2011-02-28 15:45:01', NULL),
(658, 1, '2011-03-02 12:30:00', 1, 0, 3426, 1, 1, '2011-02-28 15:45:01', NULL),
(659, 1, '2011-03-01 12:30:00', 1, 0, 3427, 1, 1, '2011-02-28 15:45:03', NULL),
(660, 2, '2011-03-03 12:00:00', 1, 0, 3431, 1, 1, '2011-02-28 15:45:54', NULL),
(661, 2, '2011-03-02 20:00:00', 3, 0, 3432, 1, 1, '2011-02-28 15:45:56', NULL),
(662, 2, '2011-03-05 21:30:00', 1, 0, 3433, 1, 1, '2011-02-28 15:46:02', NULL),
(663, 2, '2011-03-06 18:30:00', 1, 0, 3434, 1, 1, '2011-02-28 15:46:04', NULL),
(664, 2, '2011-03-02 02:00:00', 4, 0, 3436, 2, 3, '2011-02-28 15:46:31', NULL),
(665, 2, '2011-03-03 02:30:00', 3, 0, 3437, 2, 3, '2011-02-28 15:46:33', NULL),
(666, 2, '2011-03-01 03:30:00', 1, 0, 3438, 2, 3, '2011-02-28 15:46:35', NULL),
(667, 1, '2011-03-02 14:00:00', 1, 0, 3441, 1, 1, '2011-02-28 17:33:52', NULL),
(668, 1, '2011-03-03 14:30:00', 4, 0, 3442, 1, 1, '2011-02-28 17:33:55', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `equip`
--

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
-- Table structure for table `help`
--

CREATE TABLE IF NOT EXISTS `help` (
  `help_id` int(11) NOT NULL AUTO_INCREMENT,
  `help_name` varchar(45) DEFAULT NULL,
  `help_text` varchar(2000) DEFAULT NULL,
  `help_parentid` int(11) NOT NULL DEFAULT '0',
  `help_showorder` int(11) NOT NULL DEFAULT '-1',
  `help_mediaurl` varchar(100) DEFAULT NULL,
  `help_mediaposition` int(11) NOT NULL DEFAULT '1',
  `help_mediatype` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`help_id`),
  KEY `help_mediaposition` (`help_mediaposition`),
  KEY `help_mediatype` (`help_mediatype`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='All help content is here.' AUTO_INCREMENT=48 ;

--
-- Dumping data for table `help`
--

INSERT INTO `help` (`help_id`, `help_name`, `help_text`, `help_parentid`, `help_showorder`, `help_mediaurl`, `help_mediaposition`, `help_mediatype`) VALUES
(1, 'Agendo', NULL, 0, -1, NULL, 1, 1),
(2, 'Datumo', NULL, 0, -1, NULL, 1, 1),
(3, 'Homepage Layout', NULL, 1, -1, NULL, 1, 1),
(4, 'Your Profile', NULL, 1, -1, NULL, 1, 1),
(5, 'Resources', NULL, 1, -1, NULL, 1, 1),
(8, 'Creating a new user profile', NULL, 4, -1, NULL, 1, 1),
(9, NULL, 'Open the Agendo Resource Scheduling system homepage.', 8, 1, 'media/agendo_.png', 2, 1),
(10, NULL, 'Open the user menu by clicking:', 8, 2, 'media/agendo_.png', 4, 1),
(11, NULL, 'Selecting New User will make a pop-up window appear.Fill out all the fields selecting the resource you intend to use at the moment. All other resources can be added later by selecting New Permission. For each resource a new permission must be requested. ', 8, 3, 'media/addentry.swf', 1, 2),
(12, NULL, 'A new window will appear. After administrator approval an email will be sent to your account with your password.', 8, 4, 'media/agendo_.png', 2, 1),
(13, 'Changing/Updating your profile', NULL, 4, -1, NULL, 1, 1),
(14, 'Recovering the password', NULL, 4, -1, NULL, 1, 1),
(15, 'Scheduling a resource', NULL, 5, -1, NULL, 1, 1),
(16, 'Reservation without logging in', NULL, 5, -1, NULL, 1, 1),
(17, 'Reservation while logged in', NULL, 5, -1, NULL, 1, 1),
(18, 'Deleting Resource Reservations', NULL, 5, -1, NULL, 1, 1),
(19, 'Updating Resource Reservations', NULL, 5, -1, NULL, 1, 1),
(20, 'Monitoring Resources', NULL, 5, -1, NULL, 1, 1),
(21, 'Permissions', NULL, 1, -1, NULL, 1, 1),
(22, 'Permission Levels', NULL, 21, -1, NULL, 1, 1),
(23, 'Requesting a New Permission', NULL, 21, -1, NULL, 1, 1),
(25, 'Installation', NULL, 1, -1, NULL, 1, 1),
(26, 'Xampp', NULL, 25, 2, NULL, 1, 1),
(28, 'PhP', NULL, 25, 4, NULL, 1, 1),
(29, NULL, 'Run the installer and follow the instructions given.', 26, 2, NULL, 1, 1),
(30, NULL, 'After installing Xampp download all Agendo source files listed <a class=''link'' href="https://github.com/Cirklo/Agendo" target=''_blank''>Here</a> to a folder in the htdocs folder inside the installation directory of Xampp. The name of that folder is part of the address to connect to Agendo.', 26, 3, NULL, 1, 1),
(31, NULL, 'If you have already covered the PhP and Xampp section you should be ready to go, all you need now is to put in your browser address bar the server address followed by the name of the folder mentioned above and you should see the Agendo startup page.', 39, -1, NULL, 1, 1),
(32, 'Introduction', NULL, 25, 1, NULL, 1, 1),
(33, NULL, 'Its recommended to install Xampp first and do the SQL and PhP configurations later.', 32, -1, NULL, 1, 1),
(34, NULL, 'Xampp is a package containing Apache and MySql (and more, but this is all we need) that we recommend to use due to its easy installation.', 32, -1, NULL, 1, 1),
(35, NULL, 'In the folder where you downloaded the Agendo source files (in the Xampp/htdocs/YourFolder) you need to find the .htconnect.php file and edit it using notepad (or equivalent text reader program).', 28, -1, NULL, 1, 1),
(36, NULL, 'Alter "$caldb = "dbtest";" to "$caldb = "YourDatabaseName";" on line 2.', 28, -1, NULL, 1, 1),
(37, NULL, 'Alter "$link = mysql_connect("localhost", "root", "")" to "$link = mysql_connect("YourHost", "NameOfYourRootUser", "YourRootUserPassword")" on line 3.', 28, -1, NULL, 1, 1),
(38, NULL, 'Alter "case 1: $db = "dbtest";" to "case 1: $db = "YourDatabaseName";" on line 14.', 28, -1, NULL, 1, 1),
(39, 'Conclusion', NULL, 25, 5, NULL, 1, 1),
(40, NULL, 'Xampp''s Official site is <a class=''link'' href="http://www.apachefriends.org/en/xampp.html" target=''_blank''>Here</a>. In that page you will find an installation tutorial for differente platforms (Windows, Mac, Linux), choose yours and follow the steps indicated.', 26, 1, NULL, 1, 1),
(41, 'SQL', NULL, 25, 3, NULL, 1, 1),
(42, NULL, 'If you have already installed Xampp on your system and have pressed "start" for Mysql and Apache in the Xampp Panel you should be able to access on your browser <a class=''link'' href="http://localhost/phpmyadmin/" target=''_blank''>Here</a>', 41, -1, NULL, 1, 1),
(43, NULL, 'Your default user should be "root" and no password necessary. For security reasons you should change this eventually.', 41, -1, NULL, 1, 1),
(44, NULL, 'Create a new database with a name to your choosing.', 41, -1, 'media/createDB.png', 1, 1),
(45, NULL, 'Select "Import". ', 41, -1, 'media/importDB.png', 4, 1),
(46, NULL, 'Browse to the location of the Sql file named "database.sql" in your "Xampp/htdocs/YourFolder/" folder.', 41, -1, 'media/browseDB.png', 1, 1),
(47, NULL, ' Press "Go".', 41, -1, 'media/goDB.png', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `hmediaposition`
--

CREATE TABLE IF NOT EXISTS `hmediaposition` (
  `hmediaposition_id` int(11) NOT NULL AUTO_INCREMENT,
  `hmediaposition_name` varchar(45) NOT NULL,
  PRIMARY KEY (`hmediaposition_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Table with the available positions for the help media in rel' AUTO_INCREMENT=5 ;

--
-- Dumping data for table `hmediaposition`
--

INSERT INTO `hmediaposition` (`hmediaposition_id`, `hmediaposition_name`) VALUES
(1, 'Up'),
(2, 'Down'),
(3, 'Left'),
(4, 'Right');

-- --------------------------------------------------------

--
-- Table structure for table `hmediatype`
--

CREATE TABLE IF NOT EXISTS `hmediatype` (
  `hmediatype_id` int(11) NOT NULL AUTO_INCREMENT,
  `hmediatype_name` varchar(45) NOT NULL,
  PRIMARY KEY (`hmediatype_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Types of media available for help' AUTO_INCREMENT=4 ;

--
-- Dumping data for table `hmediatype`
--

INSERT INTO `hmediatype` (`hmediatype_id`, `hmediatype_name`) VALUES
(1, 'Image'),
(2, 'Video'),
(3, 'Audio');

-- --------------------------------------------------------

--
-- Table structure for table `institute`
--

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
-- Table structure for table `level`
--

CREATE TABLE IF NOT EXISTS `level` (
  `level_id` int(11) NOT NULL,
  `level_name` varchar(15) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`level_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `level`
--

INSERT INTO `level` (`level_id`, `level_name`) VALUES
(0, 'Administrator'),
(1, 'Manager'),
(2, 'Regular User');

-- --------------------------------------------------------

--
-- Table structure for table `mainconfig`
--

CREATE TABLE IF NOT EXISTS `mainconfig` (
  `mainconfig_id` int(11) NOT NULL AUTO_INCREMENT,
  `mainconfig_institute` varchar(100) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL,
  `mainconfig_shortname` varchar(10) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL,
  `mainconfig_url` varchar(50) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL,
  `mainconfig_email` varchar(50) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL,
  `mainconfig_password` varchar(50) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL,
  `mainconfig_host` varchar(50) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL,
  `mainconfig_port` int(11) NOT NULL,
  `mainconfig_smtpsecure` varchar(10) CHARACTER SET ucs2 COLLATE ucs2_bin NOT NULL,
  `mainconfig_smtpauth` tinyint(4) NOT NULL,
  PRIMARY KEY (`mainconfig_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=18446744073709551615 ;

--
-- Dumping data for table `mainconfig`
--

INSERT INTO `mainconfig` (`mainconfig_id`, `mainconfig_institute`, `mainconfig_shortname`, `mainconfig_url`, `mainconfig_email`, `mainconfig_password`, `mainconfig_host`, `mainconfig_port`, `mainconfig_smtpsecure`, `mainconfig_smtpauth`) VALUES
(1, 'FCUL', 'ICAT', 'www.fc.ul.pt', 'mail@mail.com', 'pass', 'host', 25, 'stmp', 0);

-- --------------------------------------------------------

--
-- Table structure for table `measure`
--

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

CREATE TABLE IF NOT EXISTS `media` (
  `media_id` int(11) NOT NULL AUTO_INCREMENT,
  `media_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `media_description` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `media_link` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`media_id`),
  UNIQUE KEY `media_name` (`media_name`,`media_description`,`media_link`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

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
-- Table structure for table `menu`
--

CREATE TABLE IF NOT EXISTS `menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_name` varchar(20) COLLATE utf8_bin NOT NULL,
  `menu_description` varchar(50) COLLATE utf8_bin NOT NULL,
  `menu_plugin` int(11) NOT NULL,
  `menu_url` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`menu_id`),
  KEY `menu_plugin` (`menu_plugin`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`menu_id`, `menu_name`, `menu_description`, `menu_plugin`, `menu_url`) VALUES
(1, 'mycalendar', 'mycalendar', 1, 'mycalendar.php');

-- --------------------------------------------------------

--
-- Table structure for table `param`
--

CREATE TABLE IF NOT EXISTS `param` (
  `param_id` int(11) NOT NULL AUTO_INCREMENT,
  `param_report` int(11) NOT NULL,
  `param_name` varchar(25) COLLATE utf8_bin NOT NULL,
  `param_datatype` varchar(25) COLLATE utf8_bin NOT NULL,
  `param_reference` varchar(25) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`param_id`),
  KEY `param_report` (`param_report`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

--
-- Dumping data for table `param`
--


-- --------------------------------------------------------

--
-- Table structure for table `parameter`
--

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
(3, 1, 1, 0),
(4, 1, 1, 0),
(5, 2, 3, 1),
(6, 2, 1, 1),
(7, 2, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `permlevel`
--

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
-- Table structure for table `plugin`
--

CREATE TABLE IF NOT EXISTS `plugin` (
  `plugin_id` int(11) NOT NULL AUTO_INCREMENT,
  `plugin_name` varchar(20) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`plugin_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

--
-- Dumping data for table `plugin`
--

INSERT INTO `plugin` (`plugin_id`, `plugin_name`) VALUES
(1, 'calendar');

-- --------------------------------------------------------

--
-- Table structure for table `repetition`
--

CREATE TABLE IF NOT EXISTS `repetition` (
  `repetition_id` int(11) NOT NULL AUTO_INCREMENT,
  `repetition_code` varchar(20) COLLATE utf8_bin NOT NULL,
  KEY `repetition_id` (`repetition_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3443 ;

--
-- Dumping data for table `repetition`
--

INSERT INTO `repetition` (`repetition_id`, `repetition_code`) VALUES
(2696, '0.3675832701846957'),
(2697, '0.017621592187696544'),
(2698, '0.6862780676683656'),
(2699, '0.6982184126973152'),
(2700, '0.8513427340425639'),
(2701, '0.5896274500495222'),
(2702, '0.025795976445453395'),
(2703, '0.38730017754930424'),
(2704, '0.7032740802771097'),
(2705, '0.8533240327124143'),
(2706, '0.39958571697409684'),
(2707, '0.39958571697409684'),
(2708, '0.05963373389391058'),
(2709, '0.8214578392570908'),
(2710, '0.6000409805564257'),
(2711, '0.6215863731306146'),
(2712, '0.9987993745563952'),
(2713, '0.15921501559205353'),
(2714, '0.15921501559205353'),
(2715, '0.15921501559205353'),
(2716, '0.9612334193661809'),
(2717, '0.6444077333435416'),
(2718, '0.9807606072968367'),
(2719, '0.9807606072968367'),
(2720, '0.8576669187711994'),
(2721, '0.8576669187711994'),
(2722, '0.8576669187711994'),
(2723, '0.8576669187711994'),
(2724, '0.8353372820917344'),
(2725, '0.01754695812517404'),
(2726, '0.7185245704331436'),
(2727, '0.33541206610312135'),
(2728, '0.4357561143115163'),
(2729, '0.95038575027138'),
(2730, '0.28283585980534554'),
(2731, '0.001494931988418102'),
(2732, '0.44154273718595505'),
(2733, '0.42543522268533707'),
(2734, '0.41764748468995094'),
(2735, '0.28052559308707714'),
(2736, '0.1885738493874669'),
(2737, '0.07204780913889408'),
(2738, '0.609054310247302'),
(2739, '0.1795775108039379'),
(2740, '0.18978260532950475'),
(2741, '0.10494153667241335'),
(2742, '0.7108604255004627'),
(2743, '0.09577725806806414'),
(2744, '0.02350144812331545'),
(2745, '0.4988046406992841'),
(2746, '0.1387323419624341'),
(2747, '0.3952355009930075'),
(2748, '0.19534019864761487'),
(2749, '0.3116872596571124'),
(2750, '0.42030264117256333'),
(2751, '0.7985997221733607'),
(2752, '0.9741928809827168'),
(2753, '0.4607510336943087'),
(2754, '0.5567538349776469'),
(2755, '0.5567538349776469'),
(2756, '0.08775657242286039'),
(2757, '0.9049888750918763'),
(2758, '0.9049888750918763'),
(2759, '0.9049888750918763'),
(2760, '0.8537513087478524'),
(2761, '0.48072498571127653'),
(2762, '0.48072498571127653'),
(2763, '0.5678867595270276'),
(2764, '0.05527157931061266'),
(2765, '0.14672838927686171'),
(2766, '0.7191254810022009'),
(2767, '0.5304566764683853'),
(2768, '0.8920068607489003'),
(2769, '0.09191632932233051'),
(2770, '0.38027974385188124'),
(2771, '0.3271952279142871'),
(2772, '0.3271952279142871'),
(2773, '0.3144091886480753'),
(2774, '0.13964345345963114'),
(2775, '0.5600366673165657'),
(2776, '0.5301203239213972'),
(2777, '0.706052035997419'),
(2778, '0.706052035997419'),
(2779, '0.706052035997419'),
(2780, '0.706052035997419'),
(2781, '0.14734552221830222'),
(2782, '0.20455952713454273'),
(2783, '0.4862733092601932'),
(2784, '0.8862018498086812'),
(2785, '0.8862018498086812'),
(2786, '0.8862018498086812'),
(2787, '0.7318310452806833'),
(2788, '0.34556389608922755'),
(2789, '0.9017161087353327'),
(2790, '0.9017161087353327'),
(2791, '0.23695603113771657'),
(2792, '0.23695603113771657'),
(2793, '0.20085629774507885'),
(2794, '0.7340589841917569'),
(2795, '0.7340589841917569'),
(2796, '0.7340589841917569'),
(2797, '0.7340589841917569'),
(2798, '0.7340589841917569'),
(2799, '0.7340589841917569'),
(2800, '0.1202725763107616'),
(2801, '0.6449130661208664'),
(2802, '0.6449130661208664'),
(2803, '0.5971177889646438'),
(2804, '0.7722379639744759'),
(2805, '0.9461287455633283'),
(2806, '0.9320506602525711'),
(2807, '0.9605070062733749'),
(2808, '0.1875932959294413'),
(2809, '0.6753098501337962'),
(2810, '0.6753098501337962'),
(2811, '0.6753098501337962'),
(2812, '0.6753098501337962'),
(2813, '0.8369904384056698'),
(2814, '0.6661292740175396'),
(2815, '0.5732071356486671'),
(2816, '0.5732071356486671'),
(2817, '0.5732071356486671'),
(2818, '0.5732071356486671'),
(2819, '0.5732071356486671'),
(2820, '0.15050140108284338'),
(2821, '0.15050140108284338'),
(2822, '0.15050140108284338'),
(2823, '0.7532336121467794'),
(2824, '0.15648076473882244'),
(2825, '0.0630244844993858'),
(2826, '0.8457914276514202'),
(2827, '0.8457914276514202'),
(2828, '0.8490819903090596'),
(2829, '0.22548726061359048'),
(2830, '0.22548726061359048'),
(2831, '0.9461897620931268'),
(2832, '0.9248343659564853'),
(2833, '0.732575196035268'),
(2834, '0.732575196035268'),
(2835, '0.732575196035268'),
(2836, '0.732575196035268'),
(2837, '0.5009563760831952'),
(2838, '0.8316240606363863'),
(2839, '0.4385878557804972'),
(2840, '0.4385878557804972'),
(2841, '0.4385878557804972'),
(2842, '0.13287866627797484'),
(2843, '0.8285347381606698'),
(2844, '0.670389057835564'),
(2845, '0.8971197681967169'),
(2846, '0.37637964729219675'),
(2847, '0.26964115793816745'),
(2848, '0.11123052099719644'),
(2849, '0.23955149482935667'),
(2850, '0.2584679863836976'),
(2851, '0.5337724770002125'),
(2852, '0.27552777945189155'),
(2853, '0.36833046906347655'),
(2854, '0.4300520120894784'),
(2855, '0.7902539727462029'),
(2856, '0.5327354278200555'),
(2857, '0.47294899451138994'),
(2858, '0.143031645077355'),
(2859, '0.25691296852139756'),
(2860, '0.2010851935815673'),
(2861, '0.8843469984273252'),
(2862, '0.8314904565905242'),
(2863, '0.009494163922774579'),
(2864, '0.6551504023334128'),
(2865, '0.3831993202086311'),
(2866, '0.7536637510839764'),
(2867, '0.26172945476386344'),
(2868, '0.4250504935590599'),
(2869, '0.6186757801408195'),
(2870, '0.15129746356588614'),
(2871, '0.018354428014841773'),
(2872, '0.8290897069674765'),
(2873, '0.8389040374337449'),
(2874, '0.8295701066877584'),
(2875, '0.1357737639329567'),
(2876, '0.8673880857090456'),
(2877, '0.7708265410227819'),
(2878, '0.4623005317605726'),
(2879, '0.003554511473090049'),
(2880, '0.8530828602265017'),
(2881, '0.753730022774808'),
(2882, '0.9951695588604793'),
(2883, '0.6673914636878956'),
(2884, '0.0371078923643865'),
(2885, '0.7326245032125749'),
(2886, '0.5136417231317635'),
(2887, '0.08777206423189365'),
(2888, '0.6337163762099901'),
(2889, '0.48296527137531886'),
(2890, '0.9260488287609744'),
(2891, '0.16074682140660246'),
(2892, '0.6877034664421421'),
(2893, '0.36764006724717047'),
(2894, '0.6067833639619448'),
(2895, '0.06769004015265356'),
(2896, '0.4809501453192032'),
(2897, '0.16168227380260825'),
(2898, '0.12353487548430031'),
(2899, '0.4188774190190805'),
(2900, '0.520914115377832'),
(2901, '0.5432341450769786'),
(2902, '0.14496266681932735'),
(2903, '0.7137890991834912'),
(2904, '0.12846466061915318'),
(2905, '0.1966503341698277'),
(2906, '0.2898184946849317'),
(2907, '0.5159146412296536'),
(2908, '0.9986720217155481'),
(2909, '0.6757558975922403'),
(2910, '0.27908976232074056'),
(2911, '0.43968096125539746'),
(2912, '0.8941320113199162'),
(2913, '0.9100396656184493'),
(2914, '0.12583410616960533'),
(2915, '0.7594372592404822'),
(2916, '0.34677249751213857'),
(2917, '0.8059331590081996'),
(2918, '0.5870106384499297'),
(2919, '0.3738070636833799'),
(2920, '0.525561420098473'),
(2921, '0.9405846003514868'),
(2922, '0.9801498755112187'),
(2923, '0.3599493512146855'),
(2924, '0.31585916534894953'),
(2925, '0.9810854201927978'),
(2926, '0.5780888185002084'),
(2927, '0.5248251115679001'),
(2928, '0.615742896301123'),
(2929, '0.9625003205028518'),
(2930, '0.6726489927027935'),
(2931, '0.9416404766222376'),
(2932, '0.35871279858544947'),
(2933, '0.5983711397596523'),
(2934, '0.7560809343603377'),
(2935, '0.7926796847582668'),
(2936, '0.33752764363045107'),
(2937, '0.47336148519740884'),
(2938, '0.10957168151119956'),
(2939, '0.9582688133150615'),
(2940, '0.388518380647378'),
(2941, '0.08123072285359378'),
(2942, '0.682332568037683'),
(2943, '0.7175416050582328'),
(2944, '0.27994748697446326'),
(2945, '0.9414402635905131'),
(2946, '0.5460606172646307'),
(2947, '0.19349320737643727'),
(2948, '0.8786183773523325'),
(2949, '0.8120523195160466'),
(2950, '0.980583889926908'),
(2951, '0.048252854437778936'),
(2952, '0.5031987568980307'),
(2953, '0.6564848659905264'),
(2954, '0.5799966820165948'),
(2955, '0.1235255143593954'),
(2956, '0.7819732726125045'),
(2957, '0.7130887969703574'),
(2958, '0.5995963867443211'),
(2959, '0.9059433764162417'),
(2960, '0.7818519365614268'),
(2961, '0.3673374131039938'),
(2962, '0.01164182131675362'),
(2963, '0.9419951545151968'),
(2964, '0.36259052410709625'),
(2965, '0.35997110935096277'),
(2966, '0.09505375829732643'),
(2967, '0.9016369575096402'),
(2968, '0.7359191293953402'),
(2969, '0.9280639481871509'),
(2970, '0.5553156310379138'),
(2971, '0.59937944806253'),
(2972, '0.270139513979354'),
(2973, '0.7464506011255818'),
(2974, '0.7860241341821479'),
(2975, '0.057469469542089646'),
(2976, '0.3520913836941246'),
(2977, '0.12124741812370043'),
(2978, '0.9913544891764223'),
(2979, '0.7647980970909926'),
(2980, '0.7267156938761989'),
(2981, '0.3110657321420459'),
(2982, '0.7761467416285972'),
(2983, '0.8638936429722455'),
(2984, '0.150365566676115'),
(2985, '0.26310607803626496'),
(2986, '0.3925590896472033'),
(2987, '0.8414705904769931'),
(2988, '0.08951908285633514'),
(2989, '0.12148194521454714'),
(2990, '0.4108539748378882'),
(2991, '0.7844876767702752'),
(2992, '0.22146472406272222'),
(2993, '0.7970191188948867'),
(2994, '0.9479565310886671'),
(2995, '0.5452245931001237'),
(2996, '0.5830585646710031'),
(2997, '0.9384582960488481'),
(2998, '0.16864701879609278'),
(2999, '0.8086325342677505'),
(3000, '0.697761333191354'),
(3001, '0.7704617399199666'),
(3002, '0.25583299475191457'),
(3003, '0.7733800339526469'),
(3004, '0.591633770045506'),
(3005, '0.8278930087118906'),
(3006, '0.035739178088617485'),
(3007, '0.06943959770991981'),
(3008, '0.8915528598671448'),
(3009, '0.8628257905562735'),
(3010, '0.7169766723908483'),
(3011, '0.625912853659212'),
(3012, '0.5837953417097337'),
(3013, '0.7729732984507959'),
(3014, '0.6523139804035089'),
(3015, '0.5629321986229956'),
(3016, '0.010537633001288182'),
(3017, '0.8199299472628766'),
(3018, '0.9486623269401522'),
(3019, '0.6556107223178549'),
(3020, '0.2796485654878822'),
(3021, '0.1035847813080989'),
(3022, '0.009192955970992345'),
(3023, '0.42672198640544634'),
(3024, '0.0565754860529365'),
(3025, '0.8135306218822749'),
(3026, '0.04816884209169492'),
(3027, '0.6580854899655816'),
(3028, '0.4494509133206368'),
(3029, '0.08933038293690132'),
(3030, '0.5749277245057904'),
(3031, '0.1487964641040047'),
(3032, '0.1998288945386104'),
(3033, '0.3944066790070311'),
(3034, '0.4185651077377712'),
(3035, '0.8334951268606501'),
(3036, '0.4773443440632319'),
(3037, '0.23806902833755583'),
(3038, '0.5638721987718258'),
(3039, '0.19554420469203004'),
(3040, '0.8469653905898541'),
(3041, '0.13108171184602235'),
(3042, '0.20991271068242168'),
(3043, '0.7567596032512528'),
(3044, '0.5213937606881913'),
(3045, '0.7777755261401198'),
(3046, '0.3218101201489214'),
(3047, '0.6991731857140747'),
(3048, '0.6283107970710415'),
(3049, '0.37946098469438505'),
(3050, '0.9129027958515192'),
(3051, '0.899917062943212'),
(3052, '0.39890522809672235'),
(3053, '0.8784091342279251'),
(3054, '0.8109750422340353'),
(3055, '0.06216109470039766'),
(3056, '0.404332869190849'),
(3057, '0.5183770427783521'),
(3058, '0.48152399058871576'),
(3059, '0.6231021249919516'),
(3060, '0.7968256938769235'),
(3061, '0.9013590530092921'),
(3062, '0.4835913435783423'),
(3063, '0.8453279103185364'),
(3064, '0.6182334267171361'),
(3065, '0.22153158727330213'),
(3066, '0.5680393421456181'),
(3067, '0.09133742215015206'),
(3068, '0.13587004769007327'),
(3069, '0.20059734044991273'),
(3070, '0.27006122707533065'),
(3071, '0.4836013612440725'),
(3072, '0.11698459042242138'),
(3073, '0.18397573783422005'),
(3074, '0.36776807997151584'),
(3075, '0.27219193477950676'),
(3076, '0.824575045138879'),
(3077, '0.8201102441580286'),
(3078, '0.7572780454955552'),
(3079, '0.8323222319757481'),
(3080, '0.7194591798312314'),
(3081, '0.6289463625690337'),
(3082, '0.7723732084281557'),
(3083, '0.9055628108608506'),
(3084, '0.7465805401110982'),
(3085, '0.6520829257411566'),
(3086, '0.35992965163574353'),
(3087, '0.7517691241831264'),
(3088, '0.12593250175430049'),
(3089, '0.48929503632923155'),
(3090, '0.17327389119980463'),
(3091, '0.5805106457891686'),
(3092, '0.8883228034384787'),
(3093, '0.4862101531901234'),
(3094, '0.7705127669042395'),
(3095, '0.22487285971160864'),
(3096, '0.8007984007126072'),
(3097, '0.91263157545146'),
(3098, '0.7591423084603625'),
(3099, '0.20354817588615648'),
(3100, '0.029344969172931057'),
(3101, '0.784881084276388'),
(3102, '0.37442652970234414'),
(3103, '0.7157314128732338'),
(3104, '0.7022577703850926'),
(3105, '0.5651123121483032'),
(3106, '0.8307379245865184'),
(3107, '0.310345304272149'),
(3108, '0.4970042631200039'),
(3109, '0.7581441749230886'),
(3110, '0.8038342196869753'),
(3111, '0.03102280373714872'),
(3112, '0.55460429763371'),
(3113, '0.14520332268435088'),
(3114, '0.739124123261594'),
(3115, '0.20361405543934052'),
(3116, '0.49770956817562784'),
(3117, '0.7847316785597909'),
(3118, '0.23917702679056774'),
(3119, '0.8347640707270518'),
(3120, '0.41740043017585415'),
(3121, '0.43382986039842286'),
(3122, '0.9885174818802722'),
(3123, '0.73893317814097'),
(3124, '0.8037290319772538'),
(3125, '0.4694518938020139'),
(3126, '0.8906347848930736'),
(3127, '0.7466090311389767'),
(3128, '0.7753573133092938'),
(3129, '0.13547160709466188'),
(3130, '0.9671461777188031'),
(3131, '0.06376361183771417'),
(3132, '0.24456279223733635'),
(3133, '0.3182256980397469'),
(3134, '0.8124530651211632'),
(3135, '0.3544158525499713'),
(3136, '0.6169187926598148'),
(3137, '0.7955402251213711'),
(3138, '0.2774630167919866'),
(3139, '0.4173137038497087'),
(3140, '0.9067240699923145'),
(3141, '0.7897135916733372'),
(3142, '0.45135083856299507'),
(3143, '0.7007096110175686'),
(3144, '0.6784791630906268'),
(3145, '0.747589565864678'),
(3146, '0.6931589577766496'),
(3147, '0.8241317112278403'),
(3148, '0.2982581563461536'),
(3149, '0.10074670623277482'),
(3150, '0.4821144616645515'),
(3151, '0.9887943824686812'),
(3152, '0.8923338897181188'),
(3153, '0.3253486589502891'),
(3154, '0.8684014030204439'),
(3155, '0.7445532262921263'),
(3156, '0.9852697411786481'),
(3157, '0.7164968243645902'),
(3158, '0.002451148805176606'),
(3159, '0.4418226147036475'),
(3160, '0.8662472500813689'),
(3161, '0.48749098302006455'),
(3162, '0.7265615489942231'),
(3163, '0.09805201801276853'),
(3164, '0.7157438578868022'),
(3165, '0.5313926085733405'),
(3166, '0.7925221930509713'),
(3167, '0.32963492233611613'),
(3168, '0.6482995417873663'),
(3169, '0.14852875190464188'),
(3170, '0.22511758105701807'),
(3171, '0.7833884585259052'),
(3172, '0.03082203784025972'),
(3173, '0.04846422352435786'),
(3174, '0.6412274613267878'),
(3175, '0.21390423526790592'),
(3176, '0.7939433641733117'),
(3177, '0.3546012056233432'),
(3178, '0.932996529509006'),
(3179, '0.8801522197277296'),
(3180, '0.5849137520343684'),
(3181, '0.8631549042813993'),
(3182, '0.08845351227735454'),
(3183, '0.40313883653043425'),
(3184, '0.9597972570007931'),
(3185, '0.6402463525381851'),
(3186, '0.31837706007203825'),
(3187, '0.04406832131461447'),
(3188, '0.8086414275346608'),
(3189, '0.3527584445998072'),
(3190, '0.868138856722979'),
(3191, '0.5845818086878295'),
(3192, '0.01510970484119667'),
(3193, '0.5285003379528107'),
(3194, '0.7546000489543017'),
(3195, '0.9017821854313334'),
(3196, '0.36947881347511635'),
(3197, '0.18386272598047826'),
(3198, '0.42124255176161296'),
(3199, '0.02985813188995401'),
(3200, '0.6165227176794364'),
(3201, '0.20748721363359635'),
(3202, '0.14504546687434694'),
(3203, '0.6058518381202215'),
(3204, '0.1642122973613136'),
(3205, '0.4402088170623948'),
(3206, '0.29355309690227194'),
(3207, '0.768961222511751'),
(3208, '0.7799440614194671'),
(3209, '0.633560636131567'),
(3210, '0.08173605200234646'),
(3211, '0.9775493931106757'),
(3212, '0.4242019337551318'),
(3213, '0.6357930366219922'),
(3214, '0.7807320643371306'),
(3215, '0.2362531557263955'),
(3216, '0.6976758911062368'),
(3217, '0.6622877054424383'),
(3218, '0.11243390540056597'),
(3219, '0.961127472747659'),
(3220, '0.864734368433176'),
(3221, '0.48096436939661724'),
(3222, '0.11682810463225979'),
(3223, '0.6315624494257872'),
(3224, '0.9022736743690974'),
(3225, '0.19126305589202375'),
(3226, '0.3451602161241758'),
(3227, '0.7932099949067244'),
(3228, '0.9679831831124368'),
(3229, '0.9952123432955285'),
(3230, '0.7887237922840991'),
(3231, '0.04716237403997292'),
(3232, '0.6521946981812764'),
(3233, '0.7835173710270651'),
(3234, '0.3966048810497945'),
(3235, '0.3390005201872912'),
(3236, '0.3610339524836559'),
(3237, '0.12306274356825941'),
(3238, '0.16767067815214864'),
(3239, '0.2673711195200329'),
(3240, '0.8167734462441114'),
(3241, '0.5950485735052519'),
(3242, '0.8074047464448888'),
(3243, '0.16315817347604977'),
(3244, '0.6942648873815205'),
(3245, '0.3233283285374736'),
(3246, '0.7561530307686337'),
(3247, '0.48717380769626795'),
(3248, '0.16520027061161546'),
(3249, '0.6310303500145064'),
(3250, '0.5221302150252487'),
(3251, '0.5912259641250486'),
(3252, '0.11993144132113798'),
(3253, '0.8166629283510929'),
(3254, '0.23729407098184696'),
(3255, '0.9544750936672732'),
(3256, '0.11269320258143611'),
(3257, '0.8065616671599233'),
(3258, '0.3657597103720748'),
(3259, '0.20510112884216125'),
(3260, '0.2398828967514327'),
(3261, '0.5983731180504729'),
(3262, '0.7589246615691897'),
(3263, '0.7721434505229388'),
(3264, '0.8902457957297607'),
(3265, '0.9305414852953422'),
(3266, '0.404251136590857'),
(3267, '0.11183484333979077'),
(3268, '0.7781257885569063'),
(3269, '0.03059491223662647'),
(3270, '0.1333959063736091'),
(3271, '0.03984801712791031'),
(3272, '0.5756375385382468'),
(3273, '0.7041831913468426'),
(3274, '0.2648691973073338'),
(3275, '0.19376022688148886'),
(3276, '0.34853535274952363'),
(3277, '0.885371324871007'),
(3278, '0.9137793059198391'),
(3279, '0.44371749648270087'),
(3280, '0.24177045531825447'),
(3281, '0.7135885918743333'),
(3282, '0.08984089566269582'),
(3283, '0.16918141294963596'),
(3284, '0.5054661673214395'),
(3285, '0.9277525702342716'),
(3286, '0.5352789261702384'),
(3287, '0.6249427041990417'),
(3288, '0.6105740058808792'),
(3289, '0.5425028951021147'),
(3290, '0.5484116829073903'),
(3291, '0.6092195859274977'),
(3292, '0.5326850001790774'),
(3293, '0.9364962457828776'),
(3294, '0.5352757277583224'),
(3295, '0.9389256619038798'),
(3296, '0.2855804555062016'),
(3297, '0.7986091821710657'),
(3298, '0.3662072126160931'),
(3299, '0.18417794556526168'),
(3300, '0.9113706654912253'),
(3301, '0.475715221581561'),
(3302, '0.5378775445550498'),
(3303, '0.5378775445550498'),
(3304, '0.5816471332758513'),
(3305, '0.7017039640702332'),
(3306, '0.3618945684083965'),
(3307, '0.5587011889104735'),
(3308, '0.8500856822042324'),
(3309, '0.7643313773380438'),
(3310, '0.316854763558737'),
(3311, '0.9016417263910063'),
(3312, '0.43803333920707255'),
(3313, '0.31637475968563034'),
(3314, '0.5493900745295877'),
(3315, '0.9342326332138794'),
(3316, '0.6282228043789756'),
(3317, '0.022015208927539498'),
(3318, '0.4512822123025133'),
(3319, '0.11612631679704022'),
(3320, '0.27349931405901906'),
(3321, '0.3205748668929683'),
(3322, '0.2581331201337189'),
(3323, '0.877860359768762'),
(3324, '0.5852916825627422'),
(3325, '0.2729112503781539'),
(3326, '0.19385449812693267'),
(3327, '0.4425144386877111'),
(3328, '0.2914921669176984'),
(3329, '0.6441703110972058'),
(3330, '0.4379540698591602'),
(3331, '0.038417768321493684'),
(3332, '0.33021026980020773'),
(3333, '0.7227920095719019'),
(3334, '0.40566732281838025'),
(3335, '0.045887282338458624'),
(3336, '0.17864324863836567'),
(3337, '0.01303986225449505'),
(3338, '0.6968106122770089'),
(3339, '0.17034111492927495'),
(3340, '0.7959913565793216'),
(3341, '0.892041607889773'),
(3342, '0.22537375803790383'),
(3343, '0.2156058251142765'),
(3344, '0.41158480802473385'),
(3345, '0.4682862073504883'),
(3346, '0.1510033926494786'),
(3347, '0.3148476493496679'),
(3348, '0.46113041854904224'),
(3349, '0.982407752466818'),
(3350, '0.044125731036050886'),
(3351, '0.4723030994703139'),
(3352, '0.45597728739433774'),
(3353, '0.859979817959109'),
(3354, '0.7629473179445085'),
(3355, '0.9182377709119699'),
(3356, '0.2462672762036573'),
(3357, '0.26575281400664885'),
(3358, '0.14182932823436334'),
(3359, '0.5044006614797149'),
(3360, '0.052414923361479016'),
(3361, '0.898001674137872'),
(3362, '0.8923394383130857'),
(3363, '0.1464781248054433'),
(3364, '0.892035018626459'),
(3365, '0.7459920832423728'),
(3366, '0.6813072277212301'),
(3367, '0.11774711009178895'),
(3368, '0.06463161847400989'),
(3369, '0.27881270192924823'),
(3370, '0.6371986728806711'),
(3371, '0.9178280827906917'),
(3372, '0.2034133718709903'),
(3373, '0.5741620846707104'),
(3374, '0.22927039595717524'),
(3375, '0.0452342746018084'),
(3376, '0.9768802782764507'),
(3377, '0.5428018738465862'),
(3378, '0.006588465845327018'),
(3379, '0.8983847074207021'),
(3380, '0.9266340585345516'),
(3381, '0.07605572441554642'),
(3382, '0.3970042330610998'),
(3383, '0.696517440512074'),
(3384, '0.7289205459941039'),
(3385, '0.8040757158882766'),
(3386, '0.33527123477276277'),
(3387, '0.08432497141820483'),
(3388, '0.4764977900547025'),
(3389, '0.629136998936255'),
(3390, '0.9487093050406379'),
(3391, '0.9422986972626165'),
(3392, '0.873707552089614'),
(3393, '0.009605232537043595'),
(3394, '0.6564441430566358'),
(3395, '0.8620475697163223'),
(3396, '0.2671307973159981'),
(3397, '0.05161594855828611'),
(3398, '0.17544551130840835'),
(3399, '0.14168404047021388'),
(3400, '0.44098880683059827'),
(3401, '0.5079962854649188'),
(3402, '0.07550613402295614'),
(3403, '0.46333789437623063'),
(3404, '0.4909580715281596'),
(3405, '0.9270579939542881'),
(3406, '0.5579042566104263'),
(3407, '0.287085103303355'),
(3408, '0.845893471405472'),
(3409, '0.951782169067876'),
(3410, '0.6632322887117525'),
(3411, '0.6320615454528032'),
(3412, '0.05972283979677251'),
(3413, '0.2813506209038751'),
(3414, '0.2748147606931647'),
(3415, '0.3172798765588336'),
(3416, '0.6402205858346712'),
(3417, '0.404134524637201'),
(3418, '0.8591181253932361'),
(3419, '0.7541323743664196'),
(3420, '0.9214702903802804'),
(3421, '0.21834996696845976'),
(3422, '0.7454465367216286'),
(3423, '0.6031018010425042'),
(3424, '0.4965895954314342'),
(3425, '0.5629729401677024'),
(3426, '0.5619050878147807'),
(3427, '0.30870899753312797'),
(3428, '0.12175274791218416'),
(3429, '0.47606120117638706'),
(3430, '0.978791648099093'),
(3431, '0.07428890488920392'),
(3432, '0.4333309044508721'),
(3433, '0.1420124117517777'),
(3434, '0.7044971671687451'),
(3435, '0.4542965141966373'),
(3436, '0.057325929436188416'),
(3437, '0.028394730482363406'),
(3438, '0.8473508629257865'),
(3439, '0.7501859301684861'),
(3440, '0.7032453050504988'),
(3441, '0.6859418396936693'),
(3442, '0.57745883509409');

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE IF NOT EXISTS `report` (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_name` varchar(20) COLLATE utf8_bin NOT NULL,
  `report_description` varchar(150) COLLATE utf8_bin NOT NULL,
  `report_query` varchar(1000) COLLATE utf8_bin NOT NULL,
  `report_user` int(11) NOT NULL,
  `report_conf` int(11) NOT NULL,
  PRIMARY KEY (`report_id`),
  KEY `report_user` (`report_user`),
  KEY `report_conf` (`report_conf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

--
-- Dumping data for table `report`
--


-- --------------------------------------------------------

--
-- Table structure for table `resaccess`
--

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
  `resource_color` int(11) NOT NULL,
  PRIMARY KEY (`resource_id`),
  KEY `resource_type` (`resource_type`),
  KEY `resource_status` (`resource_status`),
  KEY `resource_id` (`resource_id`),
  KEY `resource_resp` (`resource_resp`),
  KEY `resource_color` (`resource_color`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=5 ;

--
-- Dumping data for table `resource`
--

INSERT INTO `resource` (`resource_id`, `resource_name`, `resource_type`, `resource_status`, `resource_maxdays`, `resource_starttime`, `resource_stoptime`, `resource_resp`, `resource_wikilink`, `resource_price`, `resource_resolution`, `resource_maxslots`, `resource_confIP`, `resource_confirmtol`, `resource_delhour`, `resource_color`) VALUES
(1, 'Demo Resource', 1, 1, 7, 7, 22, 1, '', 1, 30, 8, '0.0.0.0', 2, 2, 5),
(2, 'Technician operated resource', 3, 4, 7, 5, 22, 1, '', 30, 60, 4, '0.0.0.0', 2, 2, 20),
(3, 'FACSARIAII', 3, 3, 4, 2, 5, 1, '', 20, 30, 4, '0.0.0.0', 1, 0, 10),
(4, 'Influx', 3, 4, 7, 9, 18, 1, '', 70, 60, 8, '0.0.0.0', 1, 18, 80);

-- --------------------------------------------------------

--
-- Table structure for table `resstatus`
--

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
-- Table structure for table `restree`
--

CREATE TABLE IF NOT EXISTS `restree` (
  `restree_id` int(11) NOT NULL AUTO_INCREMENT,
  `restree_user` int(11) NOT NULL,
  `restree_name` int(11) NOT NULL,
  `restree_access` int(11) NOT NULL,
  PRIMARY KEY (`restree_id`),
  KEY `restree_user` (`restree_user`),
  KEY `restree_name` (`restree_name`),
  KEY `restree_access` (`restree_access`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

--
-- Dumping data for table `restree`
--

INSERT INTO `restree` (`restree_id`, `restree_user`, `restree_name`, `restree_access`) VALUES
(1, 1, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `resxfields`
--

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
-- Table structure for table `treeview`
--

CREATE TABLE IF NOT EXISTS `treeview` (
  `treeview_id` int(11) NOT NULL AUTO_INCREMENT,
  `treeview_name` varchar(20) COLLATE utf8_bin NOT NULL,
  `treeview_description` varchar(70) COLLATE utf8_bin NOT NULL,
  `treeview_table1` varchar(30) COLLATE utf8_bin NOT NULL,
  `treeview_table2` varchar(30) COLLATE utf8_bin NOT NULL,
  `treeview_table3` varchar(30) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`treeview_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=2 ;

--
-- Dumping data for table `treeview`
--

INSERT INTO `treeview` (`treeview_id`, `treeview_name`, `treeview_description`, `treeview_table1`, `treeview_table2`, `treeview_table3`) VALUES
(1, 'users', 'users per department', 'institute', 'department', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `type`
--

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
  `user_level` int(11) NOT NULL DEFAULT '2',
  PRIMARY KEY (`user_id`),
  KEY `user_dep` (`user_dep`),
  KEY `user_alert` (`user_alert`),
  KEY `user_level` (`user_level`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=3 ;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `user_login`, `user_passwd`, `user_firstname`, `user_lastname`, `user_dep`, `user_phone`, `user_phonext`, `user_mobile`, `user_email`, `user_alert`, `user_level`) VALUES
(1, 'admin', '2127f97535023818d7add4a3c2428e06d382160daab440a9183690f18e285010', 'The', 'Admin', 1, '123456789', '123', '987654321', 'admin@mail.com', 1, 0),
(2, 'joao', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4', 'The', 'Admin', 1, '123456789', '123', '987654321', 'admin@mail.com', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `xfields`
--

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
  ADD CONSTRAINT `admin_ibfk_3` FOREIGN KEY (`admin_user`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `admin_ibfk_4` FOREIGN KEY (`admin_permission`) REFERENCES `access` (`access_id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `entry_ibfk_10` FOREIGN KEY (`entry_user`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `entry_ibfk_11` FOREIGN KEY (`entry_repeat`) REFERENCES `repetition` (`repetition_id`),
  ADD CONSTRAINT `entry_ibfk_12` FOREIGN KEY (`entry_status`) REFERENCES `status` (`status_id`),
  ADD CONSTRAINT `entry_ibfk_13` FOREIGN KEY (`entry_resource`) REFERENCES `resource` (`resource_id`);

--
-- Constraints for table `equip`
--
ALTER TABLE `equip`
  ADD CONSTRAINT `equip_ibfk_14` FOREIGN KEY (`equip_resourceid`) REFERENCES `resource` (`resource_id`),
  ADD CONSTRAINT `equip_ibfk_15` FOREIGN KEY (`equip_boardID`) REFERENCES `board` (`board_id`),
  ADD CONSTRAINT `equip_ibfk_16` FOREIGN KEY (`equip_para`) REFERENCES `parameter` (`parameter_id`),
  ADD CONSTRAINT `equip_ibfk_17` FOREIGN KEY (`equip_user`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `help`
--
ALTER TABLE `help`
  ADD CONSTRAINT `help_ibfk_1` FOREIGN KEY (`help_mediaposition`) REFERENCES `hmediaposition` (`hmediaposition_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `help_ibfk_2` FOREIGN KEY (`help_mediatype`) REFERENCES `hmediatype` (`hmediatype_id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
-- Constraints for table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`menu_plugin`) REFERENCES `plugin` (`plugin_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `param`
--
ALTER TABLE `param`
  ADD CONSTRAINT `param_ibfk_1` FOREIGN KEY (`param_report`) REFERENCES `report` (`report_id`);

--
-- Constraints for table `permissions`
--
ALTER TABLE `permissions`
  ADD CONSTRAINT `permissions_ibfk_4` FOREIGN KEY (`permissions_user`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permissions_ibfk_5` FOREIGN KEY (`permissions_resource`) REFERENCES `resource` (`resource_id`),
  ADD CONSTRAINT `permissions_ibfk_6` FOREIGN KEY (`permissions_level`) REFERENCES `permlevel` (`permlevel_id`);

--
-- Constraints for table `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `report_ibfk_1` FOREIGN KEY (`report_user`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `report_ibfk_2` FOREIGN KEY (`report_conf`) REFERENCES `confidentiality` (`confidentiality_id`);

--
-- Constraints for table `resaccess`
--
ALTER TABLE `resaccess`
  ADD CONSTRAINT `resaccess_ibfk_1` FOREIGN KEY (`resaccess_user`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `resource`
--
ALTER TABLE `resource`
  ADD CONSTRAINT `resource_ibfk_10` FOREIGN KEY (`resource_resp`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `resource_ibfk_11` FOREIGN KEY (`resource_color`) REFERENCES `color` (`color_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `resource_ibfk_8` FOREIGN KEY (`resource_type`) REFERENCES `type` (`type_id`),
  ADD CONSTRAINT `resource_ibfk_9` FOREIGN KEY (`resource_status`) REFERENCES `resstatus` (`resstatus_id`);

--
-- Constraints for table `restree`
--
ALTER TABLE `restree`
  ADD CONSTRAINT `restree_ibfk_1` FOREIGN KEY (`restree_user`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `restree_ibfk_2` FOREIGN KEY (`restree_name`) REFERENCES `treeview` (`treeview_id`),
  ADD CONSTRAINT `restree_ibfk_3` FOREIGN KEY (`restree_access`) REFERENCES `access` (`access_id`);

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
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`user_dep`) REFERENCES `department` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_ibfk_2` FOREIGN KEY (`user_level`) REFERENCES `level` (`level_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `xfieldsval`
--
ALTER TABLE `xfieldsval`
  ADD CONSTRAINT `xfieldsval_ibfk_2` FOREIGN KEY (`xfieldsval_field`) REFERENCES `xfields` (`xfields_id`),
  ADD CONSTRAINT `xfieldsval_ibfk_3` FOREIGN KEY (`xfieldsval_entry`) REFERENCES `entry` (`entry_id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
