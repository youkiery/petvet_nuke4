<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_MAINFILE')) {
	die('Stop!!!');
}

define("PREFIX", $db_config['prefix'] . "_" . $module_name);

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

function getUserDate() {
  global $user_info, $db;
  $today = strtotime(date("Y-m-d"));
  $result = array("startDate" => $today, "endDate" => $today + 60 * 60 * 24, "type" => "0");

  if (!empty($user_info)) {
    $sql = "select * from `" . PREFIX . "_config` where user_id = $user_info[userid] and name = 'startDate'";
    $query = $db->query($sql);
    $startDate = $query->fetch();
    if ($startDate) {
      $sql = "select * from `" . PREFIX . "_config` where user_id = $user_info[userid] and name = 'endDate'";
      $query = $db->query($sql);
      $endDate = $query->fetch();
      if ($endDate) {
        $sql = "select * from `" . PREFIX . "_config` where user_id = $user_info[userid] and name = 'type'";
        $query = $db->query($sql);
        $type = $query->fetch();
        if ($type) {
          $result["startDate"] = $startDate;
          $result["endDate"] = $endDate;
          $result["type"] = $type;
        }
      }
    }
  }
  return $result;
}

function checkUser($userId) {
  global $db, $db_config;

  $sql = "select * from `" .  $db_config["prefix"] . "_users` where userid = $userId";
  $query = $db->query($sql);

  if (!empty($query->fetch())) {
    return 1;
  }
  return 0;
}

function checkCustomer($id) {
  global $db, $db_config;

  $sql = "select * from `" .  $db_config["prefix"] . "_test_customer` where id = $id";
  $query = $db->query($sql);

  if (!empty($query->fetch())) {
    return 1;
  }
  return 0;
}

function checkinRemind($keyword) {
  global $db;

  $sql = "select * from `" .  PREFIX . "_remind` where `key` = '$keyword'";
  $query = $db->query($sql);

  if (empty($query->fetch())) {
    $sql = "insert into `" .  PREFIX . "_remind` (`type`, `key`) values (0, '$keyword')";
    $query = $db->query($sql);
  }
}

function checkinClock($clock) {
  global $db;

  $sql = "update `" .  PREFIX . "_config` set value = '$clock' where user_id = 0 and name = 'clock'";
  $query = $db->query($sql);
}

function deuft8($str) {
  $str = preg_replace("/(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)/", "a", $str);
  $str = preg_replace("/(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)/", "e", $str);
  $str = preg_replace("/(ì|í|ị|ỉ|ĩ)/", "i", $str);
  $str = preg_replace("/(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)/", "o", $str);
  $str = preg_replace("/(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)/", "u", $str);
  $str = preg_replace("/(ỳ|ý|ỵ|ỷ|ỹ)/", "y", $str);
  $str = preg_replace("/(đ)/", "d", $str);
  $str = preg_replace("/(À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ)/", "A", $str);
  $str = preg_replace("/(È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ)/", "E", $str);
  $str = preg_replace("/(Ì|Í|Ị|Ỉ|Ĩ)/", "I", $str);
  $str = preg_replace("/(Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ)/", "O", $str);
  $str = preg_replace("/(Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ)/", "U", $str);
  $str = preg_replace("/(Ỳ|Ý|Ỵ|Ỷ|Ỹ)/", "Y", $str);
  $str = preg_replace("/(Đ)/", "D", $str);
  $str = mb_strtolower($str);
  //$str = str_replace(" ", "-", str_replace("&*#39;","",$str));
  return $str;
}
