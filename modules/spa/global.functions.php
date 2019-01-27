<?php

/**
* @Project PETCOFFEE 
* @Youkiery (youkiery@gmail.com)
* @Copyright (C) 2019
* @Createdate 13-11-2019 16:00
*/

if (!defined('NV_MAINFILE')) {
	die('Stop!!!');
}
define('SPA_PREFIX', $db_config['prefix'] . "_" . $module_name);

function fetchall($query) {
  $list = array();
  while ($row = $query->fetch()) {
      $list[] = $row;
  }
  return $list;
}
