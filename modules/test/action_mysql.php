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
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_customer`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_disease`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_doctor`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_drug`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_heal`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_heal_disease`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_heal_insult`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_heal_manager`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_heal_medicine`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_heal_system`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_medicine`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_pet`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_redrug`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_schedule`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_spa`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_species`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_system`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_treat`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_treating`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_usg`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_usg2`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_vaccine`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . VAC_PREFIX . "_kaizen`";
$sql_create_module = $sql_drop_module;
// $sql_create_module[] = "CREATE TABLE `" . VAC_PREFIX . "_cfg` (
//   `id` int(11) NOT NULL AUTO_INCREMENT,
//   `userid` int(11) NOT NULL,
//   `name` varchar(50) NOT NULL,
//   `value` varchar(50) NOT NULL,
//   PRIMARY KEY (`id`)
// ) ENGINE=MyISAM DEFAULT CHARSET=utf8";
$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_config` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `filter` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '604800',
  `recall` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '604800',
  `expect` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '604800',
  `exrecall` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '604800'
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_configv2` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `value` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_customer` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_disease` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_doctor` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_drug` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_heal` (
  `id` int(11) NOT NULL,
  `petid` int(11) NOT NULL,
  `doctorid` int(11) NOT NULL,
  `appear` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `oriental` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `exam` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `usg` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `xray` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` int(11) NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_heal_disease` (
  `id` int(11) NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_heal_insult` (
  `id` int(11) NOT NULL,
  `healid` int(11) NOT NULL,
  `insult` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_heal_manager` (
  `id` int(11) NOT NULL,
  `groupid` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `allow` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_heal_medicine` (
  `id` int(11) NOT NULL,
  `code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `system` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `limits` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `effect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `effective` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `disease` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `note` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_heal_system` (
  `id` int(11) NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_kaizen` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `problem` varchar(500) NOT NULL,
  `solution` varchar(500) NOT NULL,
  `result` varchar(500) NOT NULL,
  `post_time` int(11) NOT NULL,
  `edit_time` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_medicine` (
  `id` int(11) NOT NULL,
  `healid` int(11) NOT NULL,
  `medicineid` int(11) NOT NULL,
  `quanlity` float(11,1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_pet` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `customerid` int(11) NOT NULL,
  `age` int(11) NOT NULL,
  `weight` int(11) NOT NULL,
  `species` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_redrug` (
  `id` int(11) NOT NULL,
  `customerid` int(11) NOT NULL,
  `drugid` int(11) NOT NULL,
  `cometime` int(11) NOT NULL,
  `calltime` int(11) NOT NULL,
  `recall` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `note` varchar(50) NOT NULL,
  `ctime` int(11) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_schedule` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `ctime` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_spa` (
  `id` int(11) NOT NULL,
  `doctorid` int(11) NOT NULL,
  `doctor` int(11) DEFAULT '1',
  `customerid` int(11) NOT NULL,
  `weight` int(11) NOT NULL,
  `note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
  `image` varchar(500) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_species` (
  `id` int(11) NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_system` (
  `id` int(11) NOT NULL,
  `healid` int(11) NOT NULL,
  `systemid` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_treat` (
  `id` int(11) NOT NULL,
  `petid` int(11) NOT NULL,
  `doctorid` int(11) NOT NULL,
  `cometime` int(11) NOT NULL,
  `calltime` int(11) DEFAULT NULL,
  `insult` int(11) NOT NULL DEFAULT '0',
  `ctime` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_treating` (
  `id` int(11) NOT NULL,
  `treatid` int(11) NOT NULL,
  `temperate` varchar(200) NOT NULL,
  `eye` varchar(200) NOT NULL,
  `other` varchar(500) NOT NULL,
  `examine` tinyint(4) NOT NULL,
  `image` varchar(200) NOT NULL,
  `time` int(11) NOT NULL,
  `treating` varchar(500) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  `doctorx` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_usg` (
  `id` int(11) NOT NULL,
  `petid` int(11) NOT NULL,
  `doctorid` int(11) NOT NULL,
  `cometime` int(11) NOT NULL,
  `calltime` int(11) NOT NULL,
  `image` varchar(200) NOT NULL,
  `status` int(11) NOT NULL,
  `note` varchar(200) NOT NULL,
  `birth` int(11) DEFAULT '0',
  `birthday` int(11) DEFAULT '0',
  `expectbirth` int(11) DEFAULT '0',
  `vaccine` int(11) DEFAULT '0',
  `recall` int(11) DEFAULT '0',
  `childid` int(11) DEFAULT '0',
  `firstvac` int(11) DEFAULT '0',
  `vacday` int(11) DEFAULT '0',
  `cbtime` int(11) DEFAULT '0',
  `ctime` int(11) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_usg2` (
  `id` int(11) NOT NULL,
  `petid` int(11) NOT NULL,
  `doctorid` int(11) NOT NULL,
  `usgtime` int(11) NOT NULL,
  `expecttime` int(11) NOT NULL,
  `expectnumber` int(11) NOT NULL,
  `birthtime` int(11) NOT NULL DEFAULT '0',
  `number` int(11) NOT NULL DEFAULT '0',
  `vaccinetime` int(11) NOT NULL,
  `image` varchar(2048) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(11) NOT NULL,
  `note` varchar(1024) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci";

$sql_create_module[] = "CREATE TABLE `". VAC_PREFIX ."_vaccine` (
  `id` int(11) NOT NULL,
  `petid` int(11) NOT NULL,
  `diseaseid` int(11) NOT NULL,
  `cometime` int(11) NOT NULL,
  `calltime` int(11) NOT NULL,
  `note` text NOT NULL,
  `status` tinyint(4) NOT NULL,
  `recall` int(11) NOT NULL,
  `doctorid` int(11) NOT NULL,
  `ctime` int(11) DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_config`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_configv2`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_customer`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_disease`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_doctor`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_drug`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_heal`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_heal_disease`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_heal_insult`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_heal_manager`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_heal_medicine`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_heal_system`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_medicine`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_kaizen`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_pet`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_redrug`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_schedule`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_spa`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_species`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_system`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_treat`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_treating`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_usg`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_usg2`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_vaccine`
  ADD PRIMARY KEY (`id`)";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_configv2`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_disease`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_doctor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_drug`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_heal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_heal_disease`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_heal_insult`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_heal_manager`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_heal_medicine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_heal_system`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_kaizen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_medicine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_pet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_redrug`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_spa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_species`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_system`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_treat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_treating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_usg`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_usg2`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "ALTER TABLE `". VAC_PREFIX ."_vaccine`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT";

$sql_create_module[] = "INSERT INTO `". VAC_PREFIX ."_config` (`id`, `userid`, `filter`, `recall`, `expect`, `exrecall`) VALUES
(1, 0, '604800', '604800', '604800', '604800')";

$sql_create_module[] = "INSERT INTO `". VAC_PREFIX ."_configv2` (`id`, `name`, `value`) VALUES
(1, 'filter', '604800'),
(2, 'recall', '604800'),
(3, 'expect', '604800'),
(4, 'exrecall', '604800'),
(5, 'redrug', '604800'),
(6, 'hour_from', '0'),
(7, 'hour_end', '23'),
(8, 'minute_from', '0'),
(9, 'minute_end', '59'),
(10, 'usg_filter', '2419200'),
(11, 'heal', '1209600')";

$sql_create_module[] = "INSERT INTO `". VAC_PREFIX ."_disease` (`id`, `name`) VALUES
(1, 'Bệnh')";

$sql_create_module[] = "INSERT INTO `". VAC_PREFIX ."_doctor` (`id`, `name`) VALUES
(1, 'Bác sĩ')";