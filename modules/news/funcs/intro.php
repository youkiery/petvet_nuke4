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

      if (empty($html = introList($userinfo['id'], $filter))) {
        $result['notify'] = 'Có lỗi xảy ra';
      }
      else {
        $result['status'] = 1;
        $result['html'] = $html;
      }
		break;
	}
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("intro.tpl", "modules/". $module_name ."/template");

$xtpl->assign('content', introList($userinfo['id']));
$xtpl->assign('url', '/' . $module_name . '/' . $op . '/');

$xtpl->assign('module_file', $module_file);
$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/". $module_file ."/layout/header.php");
echo $contents;
include ("modules/". $module_file ."/layout/footer.php");
