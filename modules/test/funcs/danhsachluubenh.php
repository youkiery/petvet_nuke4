<?php

/**
 * @Project NUKEVIET-MUSIC
 * @Author Phan Tan Dung
 * @Copyright (C) 2011
 * @Createdate 26/01/2011 10:26 AM
 */
if (!defined('NV_IS_MOD_QUANLY')) {
  die('Stop!!!');
}
quagio();
// initial
$xtpl = new XTemplate("luubenh-danhsach.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
$page_title = $lang_module["treat_title"];
$link = "/index.php?" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=";
// $vaccine_config = get_user_config();
$today = date("d/m/Y", NV_CURRENTTIME);
$now = totime($today);
$status_option = array("Bình thường", "Hơi yếu", "Yếu", "Sắp chết");
$xtpl->assign("now", $today);
$xtpl->assign("lang", $lang_module);
$xtpl->assign("nv", $module_name);
$xtpl->assign("op", $op);
// keyword
$keyword = $nv_Request->get_string('key', 'get', '');
$xtpl->assign("keyword", $keyword);
// page
// $page = $nv_Request->get_int('page', 'get', 1);
// if ($page < 0) {
// 	$page = 1;
// }
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
// if (!empty($_SESSION["usg_filter"]) && $_SESSION["usg_filter"] > 0 && !(strpos($_SESSION["usg_filter"], "0") == false || strpos($_SESSION["usg_filter"], "1") == false || strpos($_SESSION["usg_filter"], "2") == false)) {
// 	$filter = $_SESSION["usg_filter"];
// }
// else {
// 	$filter = $vaccine_config["usg_s"];
// 	$_SESSION["usg_filter"] = $filter;
// }

// $filter_array = str_split($filter);

foreach ($lang_module["treatstatusname"] as $key => $value) {
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
}// doctor
$sql = "select * from " .  VAC_PREFIX . "_doctor";
$result = $db->query($sql);

while ($row = $result->fetch()) {
  $xtpl->assign("doctorid", $row["id"]);
  $xtpl->assign("doctorname", $row["name"]);
  $xtpl->parse("main.doctor");
}
// status_option
foreach ($status_option as $key => $value) {
  $xtpl->assign("status_value", $key);  
  $xtpl->assign("status_name", $value);
  $xtpl->parse("main.status_option");
}

// var_dump($display_list);
// die();

$xtpl->assign("content", user_treat());

$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

function displaySSList($list, $time, $path, $lang_module) {
}

?>
