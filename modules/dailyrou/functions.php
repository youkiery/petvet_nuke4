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

define('NV_IS_DAILY', true); 
define("PATH", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_name);

require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';

