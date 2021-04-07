<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_ADMIN_RIDER')) {
	die('Stop!!!');
}

define("NO_REVERSAL", 0);
define("REVERSAL", 1);
define("DOCTOR_TYPE", 1);

$page_title = "Danh sách Bác sĩ";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'doctor-insert':
			$doctorId = $nv_Request->get_string('doctorId', 'post/get', "");
			if (!empty($doctorId)) {
				$sql = "select * from `" . PREFIX . "_user` where user_id = $doctorId and type = 1";
				$query = $db->query($sql);
				if (!$query->fetch()) {
					$sql = "insert into `" . PREFIX . "_user` (type, user_id, permission, except) values(1, $doctorId, 0, 0)";
					if ($db->query($sql)) {
						$sql = "select * from `" . $db_config["prefix"] . "_users` where userid = $doctorId";
						$query = $db->query($sql);
						$user = $query->fetch();

						$result["status"] = 1;
						$result["notify"] = "Đã thêm bác sĩ: \"$user[last_name] $user[first_name]\" vào danh sách";
						$result["doctorSuggestList"] = user_list(REVERSAL, DOCTOR_TYPE);
						$result["doctorList"] = user_list(NO_REVERSAL, DOCTOR_TYPE);
					}
				}
			}	
		break;
		case 'doctor-remove':
			$doctorId = $nv_Request->get_string('doctorId', 'post/get', "");
			if (!empty($doctorId)) {
				$sql = "select * from `" . PREFIX . "_user` where user_id = $doctorId and type = 1";
				$query = $db->query($sql);
				if ($query->fetch()) {
					$sql = "delete from `" . PREFIX . "_user` where user_id = $doctorId and type = 1";
					if ($db->query($sql)) {
						$sql = "select * from `" . $db_config["prefix"] . "_users` where userid = $doctorId";
						$query = $db->query($sql);
						$user = $query->fetch();
						
						$result["status"] = 1;
						$result["notify"] = "Đã loại người lái: \"$user[last_name] $user[first_name]\"  khỏi danh sách";
						$result["doctorSuggestList"] = user_list(REVERSAL, DOCTOR_TYPE);
						$result["doctorList"] = user_list(NO_REVERSAL, DOCTOR_TYPE);
					}
				}
			}	
		break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("doctor.tpl", PATH);

$xtpl->assign("doctor_suggest_list", user_list(REVERSAL, DOCTOR_TYPE));
$xtpl->assign("doctor_list", user_list(NO_REVERSAL, DOCTOR_TYPE));

$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");