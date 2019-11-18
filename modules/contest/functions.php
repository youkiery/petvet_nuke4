<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_SYSTEM')) die('Stop!!!');
define('NV_IS_MOD_CONGVAN', true);
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php');


function confirmModal() {
  global $module_file, $op;
  $xtpl = new XTemplate("confirm-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/" . $op);
  $xtpl->assign('content', confirmList());
  $xtpl->parse('main');
  return $xtpl->text();
}

function confirmList() {
  global $module_file, $nv_Request, $db, $op;
  $xtpl = new XTemplate("confirm-list.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/" . $op);
  $page = $nv_Request->get_string('page', 'post', 1);
  if (!($page > 0)) {
    $page = 1;
  }

  $query = $db->query("select count(*) as count from `". PREFIX ."row` where active = 1 order by id desc");
  $number = $query->fetch()['count'];

  $query = $db->query("select * from `". PREFIX ."row` where active = 1 order by id desc limit 10 offset " . ($page - 1) * 10);
  $index = ($page - 1) * 10 + 1;
  $count = 0;
  $test_data = getTestDataList();
  while ($row = $query->fetch()) {
    $count ++;
    $xtpl->assign('index', $index ++);
    $contest = json_decode($row['test']);
    $test = array();
    foreach ($contest as $id) {
      if ($test_data[$id]) $test[]= $test_data[$id];
    }

    $xtpl->assign('species', ucwords(getSpecies($row['species'])));
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('petname', $row['petname']);
    $xtpl->assign('address', $row['address']);
    $xtpl->assign('mobile', $row['mobile']);
    $xtpl->assign('contest', implode(', ', $test));
    $xtpl->parse('main.row');
  }
  $xtpl->assign('from', ($page - 1) * 10 + ($count ? 1 : 0));
  $xtpl->assign('to', ($page - 1) * 10 + $count);
  $xtpl->assign('total', $number);
  $xtpl->assign('nav', navList($number, $page, 10, 'goPage'));
  $xtpl->parse('main');
  return $xtpl->text();
}
