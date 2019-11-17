<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE') or !defined('NV_IS_MODADMIN')) die('Stop!!!');
define('NV_IS_FILE_ADMIN', true);
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php');
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/theme.php');

function testModal() {
  global $module_file, $op;
  $xtpl = new XTemplate("test-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/" . $op);
  $xtpl->assign('content', testList());
  $xtpl->parse('main');
  return $xtpl->text();
}

function removeModal() {
  global $module_file, $op;
  $xtpl = new XTemplate("remove-contest-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/" . $op);
  $xtpl->parse('main');
  return $xtpl->text();
}

function removeAllModal() {
  global $module_file, $op;
  $xtpl = new XTemplate("remove-all-contest-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/" . $op);
  $xtpl->parse('main');
  return $xtpl->text();
}

function testList() {
  global $module_file, $db, $op;
  $xtpl = new XTemplate("test-content.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/" . $op);
  $query = $db->query("select * from `". PREFIX ."test` where active = 1 order by id desc");
  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index ++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function contestList() {
  global $module_file, $db, $op;
  $xtpl = new XTemplate("contest-list.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/" . $op);
  $query = $db->query("select * from `". PREFIX ."row` order by id desc");
  $index = 1;
  $test_data = getTestDataList();
  // var_dump($test_data);die();
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index ++);
    $contest = explode(', ', $row['test']);
    $test = array();
    foreach ($contest as $id) {
      if ($test_data[$id]) $test[]= $test_data[$id];
    }

    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('address', $row['address']);
    $xtpl->assign('mobile', $row['mobile']);
    $xtpl->assign('contest', implode(', ', $test));
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}
