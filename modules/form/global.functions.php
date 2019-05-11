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
