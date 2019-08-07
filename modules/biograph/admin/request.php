<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_ADMIN_FORM')) {
	die('Stop!!!');
}

$page_title = "Xác nhận yêu cầu tiêm phòng";

$action = $nv_Request->get_string('action', 'post', '');

if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
		case 'gopage':
      $page = $nv_Request->get_int('page', 'post', 1);

      $result['status'] = 1;
      $result['html'] = requestList($page);
		break;
		case 'check':
      $id = $nv_Request->get_int('id', 'post', 1);
      $page = $nv_Request->get_int('page', 'post', 1);

      if (!empty($row = getRequestId($id))) {
        $sql = 'update `'. PREFIX .'_request` set status = 2 where id = ' . $id;
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = requestList($page);
        }
      }
		break;
		case 'remove':
      $id = $nv_Request->get_int('id', 'post', 1);
      $page = $nv_Request->get_int('page', 'post', 1);

      if (!empty($row = getRequestId($id))) {
        $sql = 'update `'. PREFIX .'_request` set status = 0 where id = ' . $id;
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = requestList($page);
        }
      }
		break;
	}
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("request.tpl", PATH);

$xtpl->assign('content', requestList());

$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");