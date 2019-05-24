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

	$sql = 'select * from `'.PREFIX.'_remind`';
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

function getMethod() {
	global $db;
	$list = array();

	$sql = 'select * from `'.PREFIX.'_method`';
	$query = $db->query($sql);

	while ($row = $query->fetch()) {
		$list[$row['id']] = array('name' => $row['name'], 'symbol' => $row['symbol']);
	} 
	return $list;
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
	}
	return $id;
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
		else if ($row == '') {
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

function checkMethod($name) {
	global $db;

	$sql = 'select * from `'. PREFIX .'_method` where name = "'.$name.'"';
	$query = $db->query($sql);
	if (!empty($query->fetch())) {
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
