<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 10/03/2010 10:51
 */

if (!defined('NV_IS_FILE_MODULES')) {
    die('Stop!!!');
}
define("VAC_PREFIX", $db_config['prefix'] . "_" . $module_name);

$sql_drop_module = array();
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_config`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_configv2`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_cfg`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_customer`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_disease`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_doctor`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_pet`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_spa`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_treat`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_treating`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_usg`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_vaccine`";
$sql_create_module = $sql_drop_module;
// $sql_create_module[] = "CREATE TABLE `" . VAC_PREFIX . "_cfg` (
//   `id` int(11) NOT NULL AUTO_INCREMENT,
//   `userid` int(11) NOT NULL,
//   `name` varchar(50) NOT NULL,
//   `value` varchar(50) NOT NULL,
//   PRIMARY KEY (`id`)
// ) ENGINE=MyISAM DEFAULT CHARSET=utf8";
$sql_create_module[] = "CREATE TABLE `" . VAC_PREFIX . "_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `filter` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '604800',
  `recall` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '604800',
  `expect` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '604800',
  `exrecall` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '604800',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8";
$sql_create_module[] = "INSERT INTO `" . VAC_PREFIX . "_config` (`id`, `userid`, `filter`, `recall`, `expect`, `exrecall`) VALUES
(1, 0, '604800', '604800', '604800', '604800');";
$sql_create_module[] = "CREATE TABLE `" . VAC_PREFIX . "_configv2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8";
$sql_create_module[] = "INSERT INTO `" . VAC_PREFIX . "_configv2` (`id`, `name`, `value`) VALUES (1, 'filter', '604800');";
$sql_create_module[] = "INSERT INTO `" . VAC_PREFIX . "_configv2` (`id`, `name`, `value`) VALUES (2, 'recall', '604800');";
$sql_create_module[] = "INSERT INTO `" . VAC_PREFIX . "_configv2` (`id`, `name`, `value`) VALUES (3, 'expect', '604800');";
$sql_create_module[] = "INSERT INTO `" . VAC_PREFIX . "_configv2` (`id`, `name`, `value`) VALUES (4, 'exrecall', '604800');";
$sql_create_module[] = "INSERT INTO `" . VAC_PREFIX . "_configv2` (`id`, `name`, `value`) VALUES (5, 'redrug', '604800');";
$sql_create_module[] = "INSERT INTO `" . VAC_PREFIX . "_configv2` (`id`, `name`, `value`) VALUES (6, 'hour_from', '7');";
$sql_create_module[] = "INSERT INTO `" . VAC_PREFIX . "_configv2` (`id`, `name`, `value`) VALUES (7, 'hour_end', '17');";
$sql_create_module[] = "INSERT INTO `" . VAC_PREFIX . "_configv2` (`id`, `name`, `value`) VALUES (8, 'minute_from', '0');";
$sql_create_module[] = "INSERT INTO `" . VAC_PREFIX . "_configv2` (`id`, `name`, `value`) VALUES (9, 'minute_end', '30');";
$sql_create_module[] = "CREATE TABLE `" . VAC_PREFIX . "_customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8";
$sql_create_module[] = "CREATE TABLE `" . VAC_PREFIX . "_disease` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";
$sql_create_module[] = "CREATE TABLE `" . VAC_PREFIX . "_doctor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8";
$sql_create_module[] = "CREATE TABLE `" . VAC_PREFIX . "_pet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `customerid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";

$sql_create_module[] = "CREATE TABLE `" . VAC_PREFIX . "_spa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctorid` int(11) NOT NULL,
  `doctor` int(11) NULL DEFAULT 1,
  `customerid` int(11) NOT NULL,
  `weight` int(11) NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `wash_dog` int(11) NOT NULL DEFAULT '0',
  `wash_cat` int(11) NOT NULL DEFAULT '0',
  `wash_white` int(11) NOT NULL DEFAULT '0',
  `cut_fur` int(11) NOT NULL DEFAULT '0',
  `shave_foot` int(11) NOT NULL DEFAULT '0',
  `shave_fur` int(11) NOT NULL DEFAULT '0',
  `cut_claw` int(11) NOT NULL DEFAULT '0',
  `cut_curly` int(11) NOT NULL DEFAULT '0',
  `wash_ear` int(11) NOT NULL DEFAULT '0',
  `wash_mouth` int(11) NOT NULL DEFAULT '0',
  `paint_footear` int(11) NOT NULL DEFAULT '0',
  `paint_all` int(11) NOT NULL DEFAULT '0',
  `pin_ear` int(11) NOT NULL DEFAULT '0',
  `cut_ear` int(11) NOT NULL DEFAULT '0',
  `dismell` int(11) NOT NULL DEFAULT '0',
  `time` int(11) NOT NULL DEFAULT '0',
  `done` int(11) NOT NULL DEFAULT '0',
  `payment` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";
$sql_create_module[] = "CREATE TABLE `" . VAC_PREFIX . "_treat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `petid` int(11) NOT NULL,
  `doctorid` int(11) NOT NULL,
  `cometime` int(11) NOT NULL,
  `calltime` int(11) DEFAULT NULL,
  `insult` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";
$sql_create_module[] = "CREATE TABLE `" . VAC_PREFIX . "_treating` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `treatid` int(11) NOT NULL,
  `temperate` varchar(200) NOT NULL,
  `eye` varchar(200) NOT NULL,
  `other` varchar(500) NOT NULL,
  `examine` tinyint(4) NOT NULL,
  `image` varchar(200) NOT NULL,
  `time` int(11) NOT NULL,
  `treating` varchar(500) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `doctorx` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";
$sql_create_module[] = "CREATE TABLE `" . VAC_PREFIX . "_usg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `petid` int(11) NOT NULL,
  `doctorid` int(11) NOT NULL,
  `cometime` int(11) NOT NULL,
  `calltime` int(11) NOT NULL,
  `image` varchar(200) NOT NULL,
  `status` int(11) NOT NULL,
  `note` varchar(200) NOT NULL,
  `birth` int(11) DEFAULT 0,
  `birthday` int(11) DEFAULT 0,
  `expectbirth` int(11) DEFAULT 0,
  `vaccine` int(11) DEFAULT 0,
  `recall` int(11) DEFAULT 0,
  `childid` int(11) DEFAULT 0,
  `firstvac` int(11) DEFAULT 0,
  `vacday` int(11) DEFAULT 0,
  `cbtime` int(11) DEFAULT 0,
  `ctime` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";
$sql_create_module[] = "CREATE TABLE `" . VAC_PREFIX . "_vaccine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `petid` int(11) NOT NULL,
  `diseaseid` int(11) NOT NULL,
  `cometime` int(11) NOT NULL,
  `calltime` int(11) NOT NULL,
  `note` text NOT NULL,
  `status` tinyint(4) NOT NULL,
  `recall` int(11) NOT NULL,
  `doctorid` int(11) NOT NULL,
  `ctime` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";