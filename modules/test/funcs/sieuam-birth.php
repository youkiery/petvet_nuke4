<?php

/**
 * @Project NUKEVIET-MUSIC
 * @Author Phan Tan Dung
 * @Copyright (C) 2011
 * @Createdate 26/01/2011 10:26 AM
 */

if (!defined('NV_IS_MOD_QUANLY')) die('Stop!!!');
$action = $nv_Request->get_string("action", "get/post", "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'detail':
			$id = $nv_Request->get_int("id", "get/post", 0);
			if ($id > 0) {
				$sql = "select * from `" . VAC_PREFIX . "_usg` where id = $id";
				$query = $db->query($sql);
				$usg = $query->fetch();

				$sql = "select * from  `" . VAC_PREFIX . "_pet` where id = $usg[petid]";
				$query = $db->query($sql);
				$pet = $query->fetch();
				
				$sql = "select * from  `" . VAC_PREFIX . "_customer` where id = $pet[customerid]";
				$query = $db->query($sql);
				$customer = $query->fetch();

				if (!empty($customer)) {
					$result["status"] = 1;
					$result["customer"] = $customer["name"];
					$result["phone"] = $customer["phone"];
					$result["petname"] = $pet["name"];
				}
			}
			break;
	}
	echo json_encode($result);
	die();
}
quagio();
// initial
$xtpl = new XTemplate("sieuam-birth.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
$page_title = $lang_module["tieude_usg_danhsach"];
$today = date("Y-m-d", NV_CURRENTTIME);
$xtpl->assign("lang", $lang_module);
$xtpl->assign("now", $today);
$xtpl->assign("nv", $module_name);
$xtpl->assign("op", $op);
// $vaccine_config = get_user_config();
// keyword
$keyword = $nv_Request->get_string('key', 'get', '');
$xtpl->assign("keyword", $keyword);
// page
$page = $nv_Request->get_string('page', 'get', '');
$xtpl->assign("page", $page);
// $limit = $nv_Request->get_string('limit', 'get', '');
// limit 
// $limit_option = array(10, 20, 30, 40, 50, 75, 100); 
// if (!empty($_SESSION["usg_limit"]) && $_SESSION["usg_limit"] > 0) {
// 	$limit = $_SESSION["usg_limit"];
// }
// else {
// 	$limit = $vaccine_config["usg_f"];
// 	$_SESSION["usg_limit"] = $limit;
// }

// foreach ($limit_option as $value) {
// 	$xtpl->assign("limitname", $value);
// 	$xtpl->assign("limitvalue", $value);
// 	if ($value == $limit) {
// 		$xtpl->assign("lcheck", "selected");
// 	}
// 	else {
// 		$xtpl->assign("lcheck", "");
// 	}
// 	$xtpl->parse("main.limit");
// }
// status
// if (!empty($_SESSION["birth_filter"]) && $_SESSION["birth_filter"] > 0 && !(strpos($_SESSION["birth_filter"], "0") == false || strpos($_SESSION["birth_filter"], "1") == false || strpos($_SESSION["birth_filter"], "2") == false)) {
// 	$filter = $_SESSION["birth_filter"];
// }
// else {
// 	$filter = $vaccine_config["vac_s"];
// 	$_SESSION["birth_filter"] = $filter;
// }

// $filter_array = str_split($filter);

foreach ($lang_module["vacstatusname"] as $key => $value) {
	if (!$key) {
		$check = "btn-info";
	}
	else {
		$check = "";
	}
	$xtpl->assign("check", $check);
	$xtpl->assign("ipd", $key);
	$xtpl->assign("vsname", $value);
	$xtpl->parse("main.filter");
}
// doctor
$sql = "select * from " . VAC_PREFIX . "_doctor";
$query = $db->query($sql);
while($row = $query->fetch()) {
  $xtpl->assign("doctorid", $row["id"]);
  $xtpl->assign("doctorname", $row["name"]);
  $xtpl->parse("main.doctor");
}

$sql = "select * from " . VAC_PREFIX . "_disease";
$query = $db->query($sql);
while($row = $query->fetch()) {
  $xtpl->assign("disease_value", $row["id"]);
  $xtpl->assign("disease_name", $row["name"]);
  $xtpl->parse("main.disease");
}

$content = user_birth();
$xtpl->assign("content", $content);

// $nav = user_birth_nav();
// $xtpl->assign("nav", $nav);

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
?>
