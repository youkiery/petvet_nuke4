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

$page_title = "Danh sách nhân viên";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'change':
			$id = $nv_Request->get_string("id", "get/post", "");
			$type = $nv_Request->get_int("type", "get/post", 0);

			if (checkUser($id)) {
				if (!$type) {
					$type = 1;
				}
				else {
					$type = 0;
				}
				
				$sql = "update `" . $db_config["prefix"] . "_rider_user` set permission = $type where user_id = $id and type = 1";
				if ($db->query($sql)) {
					$result["status"] = 1;
					$result["html"] = doctorUserList();
				}
			}
		break;
		case 'remove':
			$id = $nv_Request->get_string("id", "get/post", "");

			if (checkUser($id)) {
				if ($db->query($sql)) {
					$result["status"] = 1;
					$result["html"] = doctorUserList();
				}
			}
		break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("manager.tpl", PATH);

$xtpl->assign("content", doctorUserList());
$xtpl->parse("main");

$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");