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

$page_title = "Danh sách chuyển nhượng";

$action = $nv_Request->get_string('action', 'post', '');
$userinfo = getUserInfo();
if (empty($userinfo)) {
	header('location: /' . $module_name . '/login/');
	die();
}

if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
		case 'filter':
      $filter = $nv_Request->get_array('filter', 'post');

      $result['status'] = 1;
      $result['html'] = transferList($userinfo['id'], $filter);;
		break;
	}
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("transfer.tpl", "modules/". $module_name ."/template");

$xtpl->assign('content', transferList($userinfo['id']));
$xtpl->assign('url', '/' . $module_name . '/' . $op . '/');

$xtpl->assign('module_file', $module_file);
$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/". $module_name ."/layout/header.php");
echo $contents;
include ("modules/". $module_name ."/layout/footer.php");
