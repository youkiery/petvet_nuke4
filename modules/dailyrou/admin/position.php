<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_ADMIN_DAILY')) {
	die('Stop!!!');
}

$page_title = "Quản lý tầng";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'insert-position':
			$name = $nv_Request->get_string('name', 'get/post', '');

			if (empty($name)) {
				$result['notify'] = 'Chưa nhập tên tầng';
			}
			else {
				if (checkPositionName($name)) {
					$result['notify'] = 'Tên tầng đã tồn tại';
				}
				else {
					if (insertPosition($name)) {
						$result['status'] = '1';
						$result['notify'] = 'Đã thêm tầng';
						$result['position'] = positionList();
						$result['position_user'] = positionUserList();
					}
				}
			}
		break;
		case 'remove-position':
			$id = $nv_Request->get_string('id', 'get/post', '');

			if (removePosition($id)) {
				$result['status'] = '1';
				$result['notify'] = 'Đã xóa tầng';
				$result['position'] = positionList();
				$result['position_user'] = positionUserList();
			}
		break;
		case 'set-position':
			$type = $nv_Request->get_string('type', 'get/post', '');
			$userid = $nv_Request->get_string('userid', 'get/post', '');
			$id = $nv_Request->get_string('id', 'get/post', '');

			if (setUserPosition($type, $userid, $id)) {
				$result['status'] = '1';
				$result['position_user'] = positionUserList();
			}

		break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("position.tpl", PATH);

$xtpl->assign("content", positionUserList());
$xtpl->assign("position_user", positionList());
$xtpl->parse("main");

$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");