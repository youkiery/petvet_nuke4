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

function getUser($userid) {
  global $db, $db_config;

  $sql = 'select userid, first_name, last_name from `'. $db_config['prefix'] .'_users` where userid = '. $userid;
  $query = $db->query($sql);

  if ($row = $query->fetch()) {
    return $row;
  }
  return array('userid' => 0, 'first_name' => '', 'last_name' => '');
}

function getUserList() {
  global $db, $db_config;

  $sql = 'select userid, first_name, last_name from `'. $db_config['prefix'] .'_users`';
  $query = $db->query($sql);
  $list = array();

  while ($row = $query->fetch()) {
    $list[$row['userid']] = $row;
  }
  return $list;
}

function checkRow($id) {
  global $db;

  $sql = 'select * from `'. PREFIX .'_row` where id = '. $id;
  $query = $db->query($sql);

  if ($row = $query->fetch()) {
    return $row;
  }
  return 0;
}

function getRowList($userid = 0, $page = 1, $limit = 10) {
  global $db, $nv_Request;

  $list = array();
  $extra_sql = '';
  if (!empty($userid)) {
    $extra_sql = ' where userid = ' . $userid;
  }
  
  $sql = 'select count(id) as count from `'. PREFIX .'_row`' . $extra_sql;
  $query = $db->query($sql);
  $count = $query->fetch();
  $sql = 'select * from `'. PREFIX .'_row`' . $extra_sql . ' order by edit_time desc limit ' . $limit . ' offset ' . ($limit * ($page - 1));
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $list[] = $row;
  }
  return array('count' => $count['count'], 'data' => $list);
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
