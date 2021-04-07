<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_SYSTEM')) {
  die('Stop!!!');
}

define('NV_IS_MODULE', true); 
define("PATH", NV_ROOTDIR . '/modules/' . $module_file . '/template/user/' . $op);
define("PREFIX", $db_config['prefix'] . "_" . $module_name);
