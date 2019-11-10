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

function parseFilter($name) {
  global $nv_Request;
  $filter = $nv_Request->get_array($name . '-filter', 'post');

  if (empty($filter['page']) || $filter['page'] < 1) {
    $filter['page'] = 1;
  }
  if (empty($filter['limit']) || $filter['limit'] < 10) {
    $filter['limit'] = 10;
  }
  return $filter;
}

function getImportData($id) {
  global $db;

  $query = $db->query('select * from `'. PREFIX .'import_detail` where import_id = '. $id);
  $data = array('total' => 0, 'count' => 0);
  while ($row = $query->fetch()) {
    $data['count'] ++;
    $data['total'] += $row['number'];
  }
  return $data;
}

function spat($number, $str) {
  $string = '';
  for ($i = 0; $i < $number; $i++) { 
    $string .= $str;
  }
  return $string;
}

function getItemDataList() {
  global $db;

  $list = array();
  $query = $db->query('select * from `'. PREFIX .'item`');
  while ($row = $query->fetch()) {
    $list []= $row;
  }
  return json_encode($list, JSON_UNESCAPED_UNICODE);
}

function checkItemId($item_id, $item_date, $item_status) {
  global $db;

  // die('select * from `'. PREFIX .'item_detail` where item_id = '. $item_id .' and date = '. $item_date .' and status = "'. $item_status .'"');
  $query = $db->query('select * from `'. PREFIX .'item_detail` where item_id = '. $item_id .' and date = '. $item_date .' and status = "'. $item_status .'"');
  if ($row = $query->fetch()) {
    return $row['id'];
  }
  $query = $db->query('insert into `'. PREFIX .'item_detail` (item_id, number, date, status) values ('. $item_id .', 0, '. $item_date .', "'. $data['status'] .'")');
  if ($query) return $db->lastInsertId();  
  return 0;
}

function totime($time) {
  if (preg_match("/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/", $time, $m)) {
    $time = mktime(0, 0, 0, $m[2], $m[1], $m[3]);
    if (!$time) {
      $time = time();
    }
  }
  else {
    $time = time();
  }
  return $time;
}

function totimev2($time) {
  if (preg_match("/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/", $time, $m)) {
    $time = mktime(0, 0, 0, $m[2], $m[1], $m[3]);
    if (!$time) {
      $time = 0;
    }
  }
  else {
    $time = 0;
  }
  return $time;
}


