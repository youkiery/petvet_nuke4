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
define('PERMISSION_MODULE', 1);

function checkObj($obj) {
  $check = true;
  foreach ($obj as $key => $value) {
    if (empty($value)) {
      $check = false;
    }
  }

  return $check;
}

function cdate($time) {
  return date('d/m/Y', $time);
}

function ctime($time) {
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

function getRemind($type = '') {
	global $db;
	$list = array();

	if (!empty($type)) {
		$sql = 'select * from `'. PREFIX .'_remind` where type = "'. $type .'"';
	}
	else {
		$sql = 'select * from `'. PREFIX .'_remind`';
	}
	$query = $db->query($sql);

	while ($row = $query->fetch()) {
		if (empty($list[$row['type']])) {
			$list[$row['type']] = array();
		}
		$list[$row['type']][] = $row;
	}

	return $list;
}

function getPetById($id) {
  global $db;

  $sql = 'select * from `'. PREFIX .'_pet` where id = ' . $id;
  $query = $db->query($sql);

  return $query->fetch();
}

function insertPet($data) {
  global $db;

  $sql = 'insert into `'. PREFIX .'_pet` (userid, name, dateofbirth, species, breed, sex, color, microchip) values ('. $data['userid'] .', "'. $data['name'] .'", '. $data['dateofbirth'] .', "'. $data['species'] .'", "'. $data['breed'] .'", "'. $data['sex'] .'", "'. $data['color'] .'", '. $data['microchip'] .')';
  if ($db->query($sql)) {
    return trueWx;
  }
  return false;
}

function insertUser($data) {
  global $db;

  $sql = 'insert into `'. PREFIX .'_user` (username, password, fullname, mobile, address) values ('. $data['username'] .', "'. md5('vet_' . $data['password']) .'", '. $data['fullname'] .', "'. $data['mobile'] .'", "'. $data['address'] .'")';
  if ($db->query($sql)) {
    return true;
  }
  return false;
}

function updatePet($data, $id) {
  global $db;
  $sql_part = array();
  foreach ($data as $key => $value) {
    $sql_part[] = $key . ' = "' . $value . '" ';
  }

  $sql = 'update `'. PREFIX .'_pet` set ' . implode(', ', $sql_part) . ' where id = ' . $id;

  if ($db->query($sql)) {
    return true;
  }
  return false;
}

function updateUser($data, $id) {
  global $db;
  $sql_part = array();
  foreach ($data as $key => $value) {
    $sql_part[] = $key . ' = "' . $value . '" ';
  }

  $sql = 'update `'. PREFIX .'_user` set ' . implode(', ', $sql_part) . ' where id = ' . $id;

  if ($db->query($sql)) {
    return true;
  }
  return false;
}

function checkUser($username, $password) {
  global $db;

  $sql = 'select * from `'. PREFIX .'_user` where username = "'. $username .'" and password = "'. md5('pet_' . $password) .'"';
  $query = $db->query($sql);

  if ($row = $query->fetch()) {
    return $row;
  }
  return false;
}

function getPetDeactiveList($keyword = '', $page = 1, $limit = 10) {
  global $db;
  $data = array('list' => array(), 'count' => 0);

  $sql = 'select count(*) as count from `'. PREFIX .'_pet` where name like "%'. $keyword .'%" or microchip like "%'.$keyword.'%" and active = 0';
  $query = $db->query($sql);
  $data['count'] = $query->fetch()['count'];

  $sql = 'select * from `'. PREFIX .'_pet` where name like "%'. $keyword .'%" or microchip like "%'.$keyword.'%" and active = 0 limit ' . $limit . ' offset ' . (($page - 1) * $limit);
  $query = $db->query($sql);

  while($row = $query->fetch()) {
    $data['list'][] = $row;
  }
  return $data;
}

function getPetActiveList($keyword = '', $page = 1, $limit = 10) {
  global $db;
  $data = array('list' => array(), 'count' => 0);

  $sql = 'select count(*) as count from `'. PREFIX .'_pet` where active > 0 and (name like "%'.$keyword.'%" or microchip like "%'.$keyword.'%")';
  $query = $db->query($sql);
  $data['count'] = $query->fetch()['count'];
  
  $sql = 'select * from `'. PREFIX .'_pet` where active > 0 and (name like "%'.$keyword.'%" or microchip like "%'.$keyword.'%") limit ' . $limit . ' offset ' . (($page - 1) * $limit);
  $query = $db->query($sql);

  while($row = $query->fetch()) {
    $data['list'][] = $row;
  }
  return $data;
}

function checkPet($name, $userid) {
  global $db;

  $sql = 'select * from `'. PREFIX .'_pet` where name = "'. $name .'" and userid = ' . $userid;
  $query = $db->query($sql);

  if (!empty($row = $query->fetch())) {
    return 1;
  }
  return 0;
}

function sqlBuilder($data, $type) {
  $string = array();
  foreach ($data as $key => $value) {
    if ($type) {
      // edit
      $string[] = $key . ' = "' . $value . '"';
    }
    else {
      // insert
      $string[] = '"' . $value . '"';
    }
  }
  return implode(', ', $string);
}

function getPetRelation($petid) {
  global $db;

  $pet = getPetById($petid);
  $parent = array('f' => getPetById($pet['fid']), 'm' => getPetById($pet['mid']));
  $grand = array('i' => array('f' => getPetById($parent['f']['fid']), 'm' => getPetById($parent['f']['mid'])), 'e' => array('f' => getPetById($parent['m']['fid']), 'm' => getPetById($parent['m']['mid'])));

}

function getPetSibling($petid) {
  global $db;

  $sql = 'select * from `'. PREFIX .'_pet` where '
}

function getPetGrand($fid, $mid) {
  global $db;

  $sql = 'select * from `'. PREFIX .'_pet` where id = '
}

function getPetParent($petid) {
  global $db;

  $sql = 'select * from `'. PREFIX .'_pet` where id = '
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
