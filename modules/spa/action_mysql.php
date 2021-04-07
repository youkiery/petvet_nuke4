<?php

/**
* @Project PETCOFFEE 
* @Youkiery (youkiery@gmail.com)
* @Copyright (C) 2019
* @Createdate 13-11-2019 16:00
*/

if (!defined('NV_IS_FILE_MODULES')) {
    die('Stop!!!');
}
define("SPA_PREFIX", $db_config['prefix'] . "_" . $module_name);

$sql_drop_module = array();
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . SPA_PREFIX . "_customer`";
$sql_create_module = $sql_drop_module;
$sql_create_module[] = "CREATE TABLE `" . SPA_PREFIX . "_spa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doctorid` int(11) NOT NULL,
  `customerid` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `note` text,
  `wash` int(11) NULL DEFAULT 0,
  `wash_note` int(11) NULL DEFAULT 0,
  `cut_hair` int(11) NULL DEFAULT 0,
  `cut_hair_note` int(11) NULL DEFAULT 0,
  `cut_claw` int(11) NULL DEFAULT 0,
  `wash_ear` int(11) NULL DEFAULT 0,
  `wash_teeth` int(11) NULL DEFAULT 0,
  `paint_fur` int(11) NULL DEFAULT 0,
  `paint_fur_note` int(11) NULL DEFAULT 0,
  `pin_ear` int(11) NULL DEFAULT 0,
  `desmell` int(11) NULL DEFAULT 0,  
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8";
