<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 2-10-2010 20:59
 */

if (!defined('NV_IS_FILE_MODULES')) {
    die('Stop!!!');
}

define("PREFIX", $db_config['prefix'] . "_" . $module_name);

$sql_drop_module = array();
$sql_drop_module[] = "DROP TABLE IF EXISTS `" . PREFIX . "_row`";
$sql_create_module = $sql_drop_module;
$sql_create_module[] = "CREATE TABLE `". PREFIX ."_row` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `fullname` varchar(50) NOT NULL,
    `name` varchar(50) NOT NULL,
    `species` varchar(50) NOT NULL,
    `mobile` varchar(15) NOT NULL,
    `address` text NOT NULL,
    `target` varchar(512) NOT NULL,
    `facebook` varchar(215) NOT NULL,
    `image` text NOT NULL,
    `note` text NOT NULL,
    `status` int(11) NOT NULL DEFAULT '0',
    PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;";


