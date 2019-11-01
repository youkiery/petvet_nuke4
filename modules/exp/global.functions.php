<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_MAINFILE')) { die('Stop!!!'); }
define('PREFIX', $db_config['prefix'] . '_' . $module_name . '_');

function getItemList() {
  global $db;

  $query = $db->query('select * from `'. PREFIX .'item`');
  $list = array();
  while($row = $query->fetch()) {
    $list[] = array('id' => $row['id'], 'name' => $row['name'], 'key' => convert($row['name']));
  }
  return json_encode($list, JSON_UNESCAPED_UNICODE);
}

function getItemId($id) {
  global $db;

  $query = $db->query('select * from `'. PREFIX .'item` where id = ' . $id);
  if ($row = $query->fetch()) {
    return $row;
  }
  return array();
}

function getItemName($name) {
  global $db;

  $query = $db->query('select * from `'. PREFIX .'item` where name = "' . $name . '"');
  if ($row = $query->fetch()) {
    return $row;
  }
  return array();
}

function checkItemName($name, $rid = 0) {
  global $db;

  if ($rid) {
    $query = $db->query('select * from `'. PREFIX .'item` where name = "'. $name .'" and id = ' . $rid);
    if (!empty($query->fetch())) {
      return 0;
    }
  }
  $query = $db->query('select * from `'. PREFIX .'item` where name = "'. $name .'"');
  if (!empty($query->fetch())) {
    return 1;
  }
  return 0;
}

function checkItemId($id) {
  global $db;

  $query = $db->query('select * from `'. PREFIX .'item` where id = ' . $id);
  if (!empty($query->fetch())) {
    return 1;
  }
  return 0;
}

// check if category exist, if not, insert to table
// return category id
function checkCategory($catename) {
  global $db;
  $catename = mb_strtolower($catename);

  $query = $db->query('select * from `'. PREFIX .'category` where name = "'. $catename .'"');
  $cate = $query->fetch();
  $id = 0; // default id = 0
  if (empty($cate) || empty($cate['id'])) {
    $query = $db->query('insert into `'. PREFIX .'category` (name) values("'. $catename .'")');
    if ($query) {
      $id = $db->lastInsertId();
    }
  } else {
    $id = $cate['id'];
  }
  return $id;
}

function checkCategoryName($name, $rid = 0) {
  global $db;
  $name = mb_strtolower($name);

  if ($rid) {
    $query = $db->query('select * from `'. PREFIX .'category` where name = "'. $name .'" and id = ' . $rid);
    if (!empty($query->fetch())) {
      return 0;
    }
  }
  $query = $db->query('select * from `'. PREFIX .'category` where name = "'. $name .'"');
  if (!empty($query->fetch())) {
    return 1;
  }
  return 0;
}

function checkCategoryId($id) {
  global $db;

  $query = $db->query('select * from `'. PREFIX .'category` where id = ' . $id);
  if (!empty($query->fetch())) {
    return 1;
  }
  return 0;
}

function checkCategoryNameId($id) {
  global $db;

  if (!empty($id)) {
    $query = $db->query('select * from `'. PREFIX .'category` where id = ' . $id);
    if (!empty($row = $query->fetch())) {
      return $row['name'];
    }
  }
  return 'Chưa phân loại';
}

function getCategoryList() {
  global $db;

  $list = array();
  $query = $db->query('select * from `'. PREFIX .'category` order by name');
  while ($row = $query->fetch()) {
    $list[] = $row;
  }
  return $list;
}

function updateCategory($cate_id, $item_id) {
  global $db;
    if (checkCategoryId($cate_id) && $db->query('update `'. PREFIX .'item` set cate_id = '. $cate_id .' where id = ' . $item_id)) {
    return true;
  }
  return false;
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

function convert($str) {
  $str = mb_strtolower($str);
  $str = preg_replace("/(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)/", 'a', $str);
  $str = preg_replace("/(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)/", 'e', $str);
  $str = preg_replace("/(ì|í|ị|ỉ|ĩ)/", 'i', $str);
  $str = preg_replace("/(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)/", 'o', $str);
  $str = preg_replace("/(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)/", 'u', $str);
  $str = preg_replace("/(ỳ|ý|ỵ|ỷ|ỹ)/", 'y', $str);
  $str = preg_replace("/(đ)/", 'd', $str);
  return $str;
}
