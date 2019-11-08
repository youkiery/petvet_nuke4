<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_MAINFILE')) { die('Stop!!!'); }
define('PREFIX', $db_config['prefix'] . '_' . $module_name . '_');
define('PATH', NV_ROOTDIR . "/modules/". $module_file ."/template");

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

function getItemData($id) {
  global $db;
  $empty = 'chưa xác định';

  if (empty($id)) return $empty;
  $query = $db->query('select * from `'. PREFIX .'item` where id = '. $id);
  if ($row = $query->fetch()) {
    return $row;
  }
  return $empty;
}

function getCompanyName($id) {
  global $db;
  $empty = 'chưa xác định';

  if (empty($id)) return $empty;
  $query = $db->query('select * from `'. PREFIX .'company` where id = '. $id);
  if ($row = $query->fetch()) {
    return $row['name'];
  }
  return $empty;
}

function parseFilter() {
  global $nv_Request;
  $filter = $nv_Request->get_array('filter', 'post');

  if (empty($filter['page']) || $filter['page'] < 1) {
    $filter['page'] = 1;
  }
  if (empty($filter['limit']) || $filter['limit'] < 10) {
    $filter['limit'] = 10;
  }
  return $filter;
}