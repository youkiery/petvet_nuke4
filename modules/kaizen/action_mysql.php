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

define('PREFIX', $db_config['prefix'] . '_' . $module_name);

$sql_drop_module = array();
$sql_drop_module[] = 'DROP TABLE IF EXISTS `' . PREFIX . '_row`';
$sql_create_module = $sql_drop_module;
$sql_create_module[] = 'CREATE TABLE `' . PREFIX . '_row` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `problem` varchar(500) NOT NULL,
  `solution` varchar(500) NOT NULL,
  `result` varchar(500) NOT NULL,
  `post_time` int(11) NOT NULL,
  `edit_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;';
