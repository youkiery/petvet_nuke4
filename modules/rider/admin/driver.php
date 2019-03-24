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
define("DRIVER_TYPE", 0);

$page_title = "Danh sách người lái xe";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'driver-insert':
			$driverId = $nv_Request->get_string('driverId', 'post/get', "");
			if (!empty($driverId)) {
				$sql = "select * from `" . PREFIX . "_user` where user_id = $driverId and type = 0";
				$query = $db->query($sql);
				if (!$query->fetch()) {
					$sql = "insert into `" . PREFIX . "_user` (type, user_id) values(0, $driverId)";
					if ($db->query($sql)) {
						$sql = "select * from `" . $db_config["prefix"] . "_users` where userid = $driverId";
						$query = $db->query($sql);
						$user = $query->fetch();

						$result["status"] = 1;
						$result["notify"] = "Đã thêm người lái: \"$user[last_name] $user[first_name]\" vào danh sách";
						$result["driverSuggestList"] = user_list(REVERSAL, DRIVER_TYPE);
						$result["driverList"] = user_list(NO_REVERSAL, DRIVER_TYPE);
					}
				}
			}	
		break;
		case 'driver-remove':
			$driverId = $nv_Request->get_string('driverId', 'post/get', "");
			if (!empty($driverId)) {
				$sql = "select * from `" . PREFIX . "_user` where user_id = $driverId and type = 0";
				$query = $db->query($sql);
				if ($query->fetch()) {
					$sql = "delete from `" . PREFIX . "_user` where user_id = $driverId and type = 0";
					if ($db->query($sql)) {
						$sql = "select * from `" . $db_config["prefix"] . "_users` where userid = $driverId";
						$query = $db->query($sql);
						$user = $query->fetch();
						
						$result["status"] = 1;
						$result["notify"] = "Đã loại người lái: \"$user[last_name] $user[first_name]\"  khỏi danh sách";
						$result["driverSuggestList"] = user_list(REVERSAL, DRIVER_TYPE);
						$result["driverList"] = user_list(NO_REVERSAL, DRIVER_TYPE);
					}
				}
			}	
		break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("driver.tpl", PATH);

$xtpl->assign("driver_suggest_list", user_list(REVERSAL, DRIVER_TYPE));
$xtpl->assign("driver_list", user_list(NO_REVERSAL, DRIVER_TYPE));

$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");