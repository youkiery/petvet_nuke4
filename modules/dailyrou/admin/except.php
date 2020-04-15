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

$page_title = "Danh sách nhân viên ngoại lệ";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'change':
			$id = $nv_Request->get_string("id", "get/post", "");
      $except = $nv_Request->get_int("except", "get/post", 0);
      
      if ($except) {
        $except = 0;
      }
      else {
        $except = 1;
      }

			if (checkUser($id)) {
        $sql = "update `" . PREFIX . "_user` set except = $except where user_id = $id and type = 1";
				if ($db->query($sql)) {
					$result["status"] = 1;
					$result["html"] = exceptUserList();
				}
			}
		break;
		case 'remove':
			$id = $nv_Request->get_string("id", "get/post", "");

			if (checkUser($id)) {
				if ($db->query($sql)) {
					$result["status"] = 1;
					$result["html"] = exceptUserList();
				}
			}
		break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("except.tpl", PATH);

$xtpl->assign("content", exceptUserList());
$xtpl->parse("main");

$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");