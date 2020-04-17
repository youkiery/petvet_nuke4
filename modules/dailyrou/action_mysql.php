<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_FILE_MODULES')) {
    die('Stop!!!');
}

define("PREFIX", $db_config['prefix'] . "_" . $module_name);

$sql_drop_module = array();
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . PREFIX . "_row`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . PREFIX . "_user`";
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . PREFIX . "_penety`";
$sql_create_module = $sql_drop_module;
$sql_create_module[] = "CREATE TABLE `" . PREFIX . "_row` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";
$sql_create_module[] = "CREATE TABLE `" . PREFIX . "_penety` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;";
$sql_create_module[] = "CREATE TABLE `" . PREFIX . "_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `manager` int(11) NOT NULL DEFAULT '0',
  `except` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";
