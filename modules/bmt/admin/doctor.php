<?php
/**
* @Project NUKEVIET-MUSIC
* @Phan Tan Dung (phantandung92@gmail.com)
* @Copyright (C) 2011
* @Createdate 26-01-2011 14:43
*/

if (!defined('NV_IS_QUANLY_ADMIN')) die('Stop!!!');
$page_title = $lang_module["doctor_title"];
$action = $nv_Request->get_string('action', 'post/get', "");

if (!empty($action)) {
	$ret = array("status" => 0, "data" => array());
	switch ($action) {
		case 'doctoradd':
			$doctor = $nv_Request->get_string('doctor', 'post/get', "");
			if (!empty($doctor)) {
				$sql = "select * from " . VAC_PREFIX . "_doctor where name = '$doctor'";
				$result = $db->query($sql);
				if (!$result->fetch()) {
					$sql = "insert into " . VAC_PREFIX . "_doctor (name) values('$doctor')";
					if ($db->query($sql)) {
						$ret["status"] = 1;
						$ret["data"] = doctorlist(NV_ROOTDIR . "/themes/" . $global_config['module_theme'] . "/modules/" . $module_file, $lang_module);
					}
					else {
						$ret["status"] = 2;
					}
				} else $ret["status"] = 3;
			}
		break;
		case 'doctoredit':
			$doctor = $nv_Request->get_string('doctor', 'post/get', "");
			$id = $nv_Request->get_string('id', 'post/get', "");
			if (!empty($doctor) && !empty($id)) {
				$sql = "select * from " . VAC_PREFIX . "_doctor where name = '$doctor'";
				$result = $db->query($sql);
				if (!$result->fetch()) {
					$sql = "update " . VAC_PREFIX . "_doctor set name = '$doctor' where id = $id";
					if ($db->query($sql)) {
						$ret["status"] = 1;
						$ret["data"] = doctorlist(NV_ROOTDIR . "/themes/" . $global_config['module_theme'] . "/modules/" . $module_file, $lang_module);
					}
					else {
						$ret["status"] = 2;
					}
				} else $ret["status"] = 3;
			}
		break;
		case 'doctordel':
			$id = $nv_Request->get_string('id', 'post/get', "");
			if (!empty($id)) {
				$sql = "select * from " . VAC_PREFIX . "_doctor where id = $id";
				$result = $db->query($sql);
				if ($result->fetch()) {
					$sql = "delete from " . VAC_PREFIX . "_doctor where id = '$id'";
					if ($db->query($sql)) {
						$ret["status"] = 1;
						$ret["data"] = doctorlist(NV_ROOTDIR . "/themes/" . $global_config['module_theme'] . "/modules/" . $module_file, $lang_module);
					}
					else {
						$ret["status"] = 2;
					}
				}
			}
		break;
	}

	echo json_encode($ret);
	die();
}

$xtpl = new XTemplate("doctor.tpl", NV_ROOTDIR . "/themes/" . $global_config['module_theme'] . "/modules/" . $module_file);
$xtpl->assign("lang", $lang_module);

$xtpl->assign("list", doctorlist(NV_ROOTDIR . "/themes/" . $global_config['module_theme'] . "/modules/" . $module_file, $lang_module));


$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");

