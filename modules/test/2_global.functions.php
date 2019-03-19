<?php

/**
 * @Project Petcoffee-technical
 * @Author Chistua
 * @Copyright (C) 2019
 * @Createdate 18/03/2019
 */

 if (!defined('NV_MAINFILE')) {
	die('Stop!!!');
}

define('VAC_PREFIX', $db_config['prefix'] . "_" . $module_name);

if (!function_exists("diseaseList")) {
  function diseaseList() {
    global $db;
    $sql = "select * from " . VAC_PREFIX . "_disease";
    $query = $db->query($sql);
    $list = array();
    
    while ($row = $query->fetch()) {
      $list[$row["id"]] = $row;
    }
    return $list;
  }
}
