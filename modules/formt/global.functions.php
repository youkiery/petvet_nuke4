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

// lấy khoảng thời gian khóa văn bản
function getLocker() {
  global $db, $db_config, $module_name;
  $sql = 'select * from `'. $db_config['prefix'] .'_config` where module = "' . $module_name . '" and config_name = "locked_time"';
  // die($sql);
  $query = $db->query($sql);
  // chọn dữ liệu từ bảng config

  if (empty($row = $query->fetch())) {
    $sql = 'insert into `'. $db_config['prefix'] .'_config` (lang, module, config_name, config_value) values ("sys", "'. $module_name .'", "locked_time", "0")';
    // die($sql);
    $query = $db->query($sql);

    return 0;
  }
  else {
    return $row['config_value'];
  }
}

function getSigner() {
	global $db;

	$sql = 'select * from `'. PREFIX .'_signer`';
	$query = $db->query($sql);
	$list = array(array('name' => 'Không chọn', 'url' => ''));

	while ($row = $query->fetch()) {
		$list[] = array('name' => $row['name'], 'url' => $row['url']);
	}

	return $list;
}

function getUserPermission($userid) {
  global $db, $db_config;

	$sql = 'select * from `'. $db_config['prefix'] .'_user_allow` where userid = ' . $userid;
  $query = $db->query($sql);

  if (empty($row = $query->fetch()) && empty($row['former'])) {
    return 0;
  }
  return $row['former'];
}

function getUserType($userid) {
  global $db, $db_config;

	$sql = 'select * from `'. $db_config['prefix'] .'_user_allow` where userid = ' . $userid;
  $query = $db->query($sql);
  if (empty($row = $query->fetch()) && empty($row['type'])) {
		return 0;
	}
  return $row['type'];
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

function getRemind() {
	global $db;
	$list = array();

	$sql = 'select * from `'.PREFIX.'_remind` where visible = 1 and value <> ""';
	$query = $db->query($sql);

	while ($row = $query->fetch()) {
		$list[$row['type']][] = $row;
	} 
	return $list;
}

function getRelation() {
	global $db;
	$list = array();

	$sql = 'select * from `'.PREFIX.'_relation`';
	$query = $db->query($sql);

	while ($row = $query->fetch()) {
		$list[$row['id']] = array('r1' => $row['relation1'], 'r2' => $row['relation2']);
	} 
	return $list;
}

function getRemindv2($type = '') {
	global $db;
	$list = array();

	if (!empty($type)) {
		$sql = 'select * from `'. PREFIX .'_remindv2` where type = "'. $type .'" and visible = 1';
	}
	else {
		$sql = 'select * from `'. PREFIX .'_remindv2` where visible = 1';
	}
	$query = $db->query($sql);

	while ($row = $query->fetch()) {
		if (empty($list[$row['type']])) {
			$list[$row['type']] = array();
		}
		if (!empty($row['name'])) {
			$list[$row['type']][] = $row;
		}
	}

	return $list;
}

function getRemindIdv2Id($id) {
	global $db;

	$sql = 'select * from `'. PREFIX .'_remindv2` where id = ' . $id;
	$query = $db->query($sql);
	$row = $query->fetch();

	if (!empty($row)) {
		return $row['id'];
	}
	return 0;
}

function getDefault() {
	global $db;
	$sql = 'select t1.type, t1.name FROM `'. PREFIX .'_remindv2` t1 INNER JOIN (SELECT Max(rate) as rate, type FROM `'. PREFIX .'_remindv2` GROUP  BY type) t2 ON t1.type = t2.type AND t1.rate = t2.rate';
	$query = $db->query($sql);
	$remind = array();

	while ($row = $query->fetch()) {
		$remind[$row['type']] = $row['name'];
	}
	return $remind;
}

function getRemindIdv2($name, $type) {
	global $db;

	$sql = 'select * from `'. PREFIX .'_remindv2` where name = "' . $name . '" and type = "'. $type .'"';
	// if ($type == "owner") {
	// 	die($sql);
	// }
	// echo $sql . '<br>';
	$query = $db->query($sql);
	$row = $query->fetch();

	if (!empty($row)) {
		return $row['id'];
	}
	return 0;
}

function checkRemindv2($name, $type) {
	global $db;

	if (!empty($name)) {
		if ($id = getRemindIdv2($name, $type)) {
			$sql = 'update `'. PREFIX .'_remindv2` set visible = 1, rate = rate + 1 where id = ' . $id;
			if ($db->query($sql)) {
				return $id;
			}
			return 0;
		}
		else {
			$sql = 'insert into `'. PREFIX .'_remindv2` (type, name, visible) values ("'. $type .'", "'. $name .'", 1)';
			if ($db->query($sql)) {
				return $db->lastInsertId();
			}
			return 0;
		}
	}
	return 0;
}

function removeRemindv2($id) {
	global $db;

	if ($id) {
		$sql = 'remove `'. PREFIX .'_remindv2` where id = ' . $id;
		$db->query($sql);
	}
}

function getMethod() {
	global $db;
	$list = array();

	$sql = 'select * from `'.PREFIX.'_method` where visible = 1';
	$query = $db->query($sql);

	while ($row = $query->fetch()) {
		$list[$row['id']] = array('id' => $row['id'], 'name' => $row['name'], 'symbol' => $row['symbol']);
	} 
	return $list;
}

function getSymbol() {
	global $db;
	$list = array();

	$sql = 'select * from `'.PREFIX.'_symbol` where visible = 1';
	$query = $db->query($sql);

	while ($row = $query->fetch()) {
		$list[$row['id']] = array('id' => $row['id'], 'name' => $row['name']);
	} 
	return $list;
}

function getMethodId($id) {
	global $db;

	$sql = 'select * from `'. PREFIX .'_method` where id = ' . $id;
	$query = $db->query($sql);
	if (!empty($row = $query->fetch())) {
		return $row;
	}
	return '';
}

function getRemindId($id) {
	global $db;
	$remind = '';
	if ($id) {
		$sql = 'select * from `'.PREFIX.'_remind` where id = ' . $id;
		$query = $db->query($sql);
		$remind = $query->fetch();
	}

	if (empty($remind)) {
		return '';
	}
	return $remind['value'];
}

function checkRemindRow($value, $type) {
	global $db;

	$sql = 'select * from `'.PREFIX.'_remind` where value = "'.$value.'" and type = ' . $type;
	$query = $db->query($sql);

	if (empty($row = $query->fetch())) {
		$sql = 'insert into `'.PREFIX.'_remind` (value, type) values ("'.$value.'", '.$type.')';
		$query = $db->query($sql);
		$id = $db->lastInsertId();
	}
	else {
		$id = $row['id'];
		$sql = 'select * from `'.PREFIX.'_remind` where id = ' . $id . ' and visible = 0';
		$query = $db->query($sql);
		if (!empty($row = $query->fetch())) {
			$sql = 'update `'.PREFIX.'_remind` set visible = 1 where id = ' . $id;
			$db->query($sql);
		}
	}
	return $id;
}

function checkRemindRows($list, $type) {
	global $db;

	foreach ($list as $row) {
		$sql = 'select * from `'.PREFIX.'_remind` where value = "'.$row.'" and type = ' . $type;
		$query = $db->query($sql);
	
		if (empty($row = $query->fetch())) {
			$sql = 'insert into `'.PREFIX.'_remind` (value, type) values ("'.$row.'", '.$type.')';
			$query = $db->query($sql);
			$id = $db->lastInsertId();
		}
		else {
			$id = $row['id'];
			$sql = 'select * from `'.PREFIX.'_remind` where id = ' . $id . ' and visible = 0';
			$query = $db->query($sql);
			if (!empty($row = $query->fetch())) {
				$sql = 'update `'.PREFIX.'_remind` set visible = 1 where id = ' . $id;
				$db->query($sql);
			}
		}
	}
}

function checkPrinter($id, $form) {
	global $db;
	$sql = 'select * from `'. PREFIX .'_row` where id = ' . $id . ' and printer >= ' . $form;
	$query = $db->query($sql);
	
	if (empty($row = $query->fetch())) {
		$sql = 'update `'. PREFIX .'_row` set printer = '. $form .' where id = ' . $id;
		if ($db->query($sql)) {
			return true;	
		}
	}
	return false;
}

function precheck($data) {
	$check = '';
	$except = array('note', 'other', 'xnote', 'fax', 'owner', 'sampleplace', 'resend', 'iresend', 'xreceive', 'xreceiver', 'xsender', 'xsend', 'vnote', 'target', 'ownerphone', 'ownermail', 'result', 'examdate', 'xresend', 'phone', 'mail', 'content', 'reformer');
	foreach ($data as $key => $row) {
		// if ($key == 'page') {
		// 	die("$row");
		// }
		if (gettype($row) == 'array') {
			foreach ($row as $name => $value) {
				if ($name != 'value' && $value == '') {
					$check = $key;
				}
			}
		}
		else if ($row == '' && !in_array($key, $except)) {
			$check = $key;
		}
	}
	return $check;
}

function checkRemindRelation($unitid, $employid) {
	global $db;

	$sql = 'select * from `'.PREFIX.'_relation` where relation1 = ' . $unitid . ' and relation2 = ' . $employid;
	$query = $db->query($sql);

	if (empty($row = $query->fetch())) {
		$sql = 'insert into `'.PREFIX.'_relation` (relation1, relation2) values ("'.$unitid.'", '.$employid.')';
		$query = $db->query($sql);
	}
}

function checkRemind($unit, $employ) {
	global $db;

	$unitid = checkRemindRow($unit, 1);
	$employid = checkRemindRow($employ, 2);
	checkRemindRelation($unitid, $employid);
}

function checkExam($formData, $rowid, $examid = 0) {
	global $db;

	if ($examid) {
		// edit
		$sx = 1;
	}
	else {
		// insert
		foreach ($formData as $row) {
			$type = 0;
			for ($i = 0; $i < count($row['type']) && $type; $i++) { 
				if ($row['type'][$i]) {
					$type = $i;
				}
			}
			$sql = 'insert into `'.PREFIX.'_exam` (rowid, type, other, number, sample, code, method, target) values('. $rowid .', '. $type .', "'. $row['other'] .'", '. $row['number'] .', "'. $row['sample'] .'", "'. $row['code'] .'", "'. implode(',', $row['method']) .'", "'. $row['target'] .'")';
			$db->query($sql);
			return 1;
		}
	}
	return 0;
}

function checkMethod($name, $symbol) {
	global $db;

	$sql = 'select * from `'. PREFIX .'_method` where name = "'.$name.'" and symbol = "'. $symbol .'"';
	$query = $db->query($sql);
	if (!empty($row = $query->fetch())) {
		return true;
	}
	return false;
}

function checkIsMod($userid) {
	global $db, $db_config;

	if (!empty($userid)) {
		$sql = 'select * from `'. $db_config['prefix'] .'_user_allow` where userid = ' . $userid . ' and type = 2 and module = ' . PERMISSION_MODULE;
		$query = $db->query($sql);
	
		if (!empty($row = $query->fetch())) {
			return true;
		}
	}
	return false;
}

function checkIsViewer($userid) {
	global $db, $db_config;
	if (!empty($userid)) {
		$sql = 'select * from `'. $db_config['prefix'] .'_user_allow` where userid = ' . $userid . ' and type > 0 and module = ' . PERMISSION_MODULE;
		$query = $db->query($sql);
	
		if (!empty($row = $query->fetch())) {
			return true;
		}
	}
	return false;
}

// function checkPrinter($data) {
// 	if (!empty($data['target'])) {
// 		return 5;
// 	}
// 	else if (!empty($data['note'])) {
// 		return 4;
// 	}
// 	else if (!empty($data['page'])) {
// 		return 3;
// 	}
// 	else if (!empty($data['xcode'])) {
// 		return 2;
// 	}
// 	return 1;
// }

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
