<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_FORM')) {
	die('Stop!!!');
}
define('BUILDER_EDIT', 2);

$page_title = "Quản lý thu chi";

$action = $nv_Request->get_string('action', 'post', '');

if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
    case 'filter':
      $filter = $nv_Request->get_array('filter', 'post');

      if ($db->query($sql)) {
        if ($filter['type'] == 1) {
          $result['html'] = revenue($filter);
        } 
        else {
          $result['html'] = paylist($filter);
        }
        if ($result['html']) {
          $result['status'] = 1;
        }
      }
    break;
	}
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("statistic.tpl", PATH);

$xtpl->assign('content', revenue());

$sql = 'select * from `'. PREFIX .'_user` where view = 1';
$query = $db->query($sql);

while ($row = $query->fetch()) {
  $xtpl->assign('userid', $row['id']);
  $xtpl->assign('username', $row['fullname']);
  $xtpl->parse('main.user');
}

$xtpl->assign('url', '/' . $module_name . '/' . $op . '/');
$xtpl->assign('module_file', $module_file);
$xtpl->parse("main");
$contents = $xtpl->text("main");

include ("modules/". $module_file ."/layout/header.php");
echo $contents;
include ("modules/". $module_file ."/layout/footer.php");
