<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_MAINFILE')) { die('Stop!!!'); }
define('PREFIX', $db_config['prefix'] . '_' . $module_name . '_');
define('BLOCK', NV_ROOTDIR . '/modules/' . $module_file . '/template/block/');

function checkCode($code) {
  global $db;

  $query = $db->query('select * from `'. PREFIX .'item` where code = "'. $code .'"');
  if ($query->fetch()) return 1;
  return 0;
}

function checkCategory($category) {
  global $db;

  $query = $db->query('select * from `'. PREFIX .'category` where name = "'. $category .'"');
  if ($row = $query->fetch()) return $row['id'];
  $db->query('insert into `'. PREFIX .'category` (name, active) values("'. $category .'", 1)');
  return $db->lastInsertId();
}

function insertItem($data) {
  global $db;

  $db->query('insert into `'. PREFIX .'item` (code, name, category, number, bound, active, time) values("'. $data['code'] .'", "'. $data['name'] .'", '. $data['category'] .', '. $data['number'] .', 0, 1, '. time() .')');
  return $db->lastInsertId();
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
