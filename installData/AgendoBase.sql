-- --------------------------------------------------------

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_user`, `admin_table`, `admin_permission`) VALUES
(1, 'resource', 5),
(1, 'permissions', 5);

-- --------------------------------------------------------

--
-- Table structure for table `allowedips`
--

CREATE TABLE IF NOT EXISTS `allowedips` (
  `allowedips_id` int(11) NOT NULL AUTO_INCREMENT,
  `allowedips_institute` smallint(6) NOT NULL,
  `allowedips_iprange` varchar(45) NOT NULL,
  PRIMARY KEY (`allowedips_id`),
  UNIQUE KEY `allowedips_iprange_UNIQUE` (`allowedips_iprange`),
  KEY `allowedips_institute` (`allowedips_institute`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `allowedips`
--

INSERT INTO `allowedips` (`allowedips_id`, `allowedips_institute`, `allowedips_iprange`) VALUES
(1, 1, '192.168.52');


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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1288 ;

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


-- --------------------------------------------------------

--
-- Dumping data for table `mask`
--

INSERT INTO `mask` (`mask_table`, `mask_name`, `mask_pic`) VALUES
('resource', 'Resources', NULL),
('permissions', 'Resource permissions', NULL);


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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `media`
--

INSERT INTO `media` (`media_id`, `media_name`, `media_description`, `media_link`) VALUES
(1, 'Recover Password', 'Shows how to recover a user''s password', 'http://www.youtube.com/embed/Fmo1EbcXPPE'),
(2, 'New User', 'Shows how to create users', 'videos/askfor.swf'),
(3, 'Entry Confirmation', 'Shows how to confirm entries', 'http://www.youtube.com/embed/C-lr4GyOusA'),
(4, 'New Permission', 'Shows how to give a user permission for a certain resource', 'http://www.youtube.com/embed/jBTVRI77w1g'),
(5, 'Waiting Lists', 'Shows how waiting lists work', 'videos/waitlist.swf'),
(7, 'Adding an entry', 'Shows how to add entries', 'http://www.youtube.com/embed/MCnDTe8Edc8'),
(8, 'Change Password', 'Shows how to change password through the backoffice', 'videos/change_pwd.swf'),
(9, 'Access', 'Shows how to give a user access to a table in Datumo', 'http://www.youtube.com/embed/bdFj9SWLzcA');

-- --------------------------------------------------------

--
-- Table structure for table `parameter`
--

CREATE TABLE IF NOT EXISTS `parameter` (
  `parameter_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Table used with monitoring system only',
  `parameter_type` varchar(10) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`parameter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;


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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
-- Table structure for table `repetition`
--

CREATE TABLE IF NOT EXISTS `repetition` (
  `repetition_id` int(11) NOT NULL AUTO_INCREMENT,
  `repetition_code` varchar(20) COLLATE utf8_bin NOT NULL,
  KEY `repetition_id` (`repetition_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;


-- --------------------------------------------------------

--
-- Table structure for table `resinterface`
--

CREATE TABLE IF NOT EXISTS `resinterface` (
  `resinterface_id` int(11) NOT NULL AUTO_INCREMENT,
  `resinterface_resource` int(11) NOT NULL,
  `resinterface_phpfile` varchar(200) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`resinterface_id`),
  KEY `resinterface_resource` (`resinterface_resource`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=7 ;

--
-- Dumping data for table `resource`
--

INSERT INTO `resource` (`resource_id`, `resource_name`, `resource_type`, `resource_status`, `resource_maxdays`, `resource_starttime`, `resource_stoptime`, `resource_resp`, `resource_wikilink`, `resource_price`, `resource_resolution`, `resource_maxslots`, `resource_confIP`, `resource_confirmtol`, `resource_delhour`, `resource_color`) VALUES
(1, 'Demo Resource', 1, 1, 7, 7, 22, 1, '', 1, 30, 8, '0.0.0.0', 0, 0, 5);
-- --------------------------------------------------------

--
-- Table structure for table `resourcetype`
--

CREATE TABLE IF NOT EXISTS `resourcetype` (
  `resourcetype_id` smallint(6) NOT NULL,
  `resourcetype_name` varchar(64) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`resourcetype_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `resourcetype`
--

INSERT INTO `resourcetype` (`resourcetype_id`, `resourcetype_name`) VALUES
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
(4, 'Pre-reservation with admin confirmation'),
(5, 'Quick Scheduling');

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
  `resxfields_id` int(11) NOT NULL AUTO_INCREMENT,
  `resxfields_field` tinyint(4) NOT NULL,
  `resxfields_resource` int(11) NOT NULL,
  PRIMARY KEY (`resxfields_id`),
  KEY `resxfields_id` (`resxfields_field`),
  KEY `resxfields_resource` (`resxfields_resource`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Table structure for table `similarresources`
--

CREATE TABLE IF NOT EXISTS `similarresources` (
  `similarresources_id` int(11) NOT NULL AUTO_INCREMENT,
  `similarresources_resource` int(11) NOT NULL,
  `similarresources_similar` int(11) NOT NULL,
  PRIMARY KEY (`similarresources_id`),
  KEY `similarresources_resource` (`similarresources_resource`),
  KEY `similarresources_similar` (`similarresources_similar`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

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


--
-- Dumping data for table `treeview`
--

INSERT INTO `treeview` (`treeview_id`, `treeview_name`, `treeview_description`, `treeview_table1`, `treeview_table2`, `treeview_table3`) VALUES
(1, 'users', 'users per department', 'institute', 'department', 'user');


-- --------------------------------------------------------

--
-- Table structure for table `xfields`
--

CREATE TABLE IF NOT EXISTS `xfields` (
  `xfields_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `xfields_name` varchar(15) COLLATE utf8_bin NOT NULL,
  `xfields_label` varchar(32) COLLATE utf8_bin NOT NULL,
  `xfields_type` int(11) NOT NULL,
  PRIMARY KEY (`xfields_id`),
  KEY `xfields_type` (`xfields_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_bin AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Table structure for table `xfieldsinputtype`
--

CREATE TABLE IF NOT EXISTS `xfieldsinputtype` (
  `xfieldsinputtype_id` int(11) NOT NULL AUTO_INCREMENT,
  `xfieldsinputtype_type` varchar(45) NOT NULL,
  PRIMARY KEY (`xfieldsinputtype_id`),
  UNIQUE KEY `xfieldsinputtype_type_UNIQUE` (`xfieldsinputtype_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `xfieldsinputtype`
--

INSERT INTO `xfieldsinputtype` (`xfieldsinputtype_id`, `xfieldsinputtype_type`) VALUES
(3, 'CheckBoxMultiPick'),
(2, 'CheckBoxSinglePick'),
(1, 'TextBox');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=804 ;
