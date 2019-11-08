<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_MAINFILE')) { die('Stop!!!'); }
define('PREFIX', $db_config['prefix'] . '_' . $module_name . '_');

function checkItemName($name) {
  global $db;

  $query = $db->query('select * from `'. PREFIX .'item` where name = "'. $name .'"');
  if ($row = $query->fetch()) return $row['id'];
  return false;
}

function checkCompany($name) {
  global $db;

  if (empty($name)) return 0;
  $query = $db->query('select * from `'. PREFIX .'company` where name = "'. $name .'"');
  if ($row = $query->fetch()) {
    return $row['id'];
  }
  else {
    // die('insert into `'. PREFIX .'company` (name) values("'. $name .'")');
    $query = $db->query('insert into `'. PREFIX .'company` (name) values("'. $name .'")');
    if ($query) return $row->lastInsertId();
  }
  return 0;
}
