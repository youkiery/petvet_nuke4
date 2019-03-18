<?php
/**
* @Project NUKEVIET-MUSIC
* @Phan Tan Dung (phantandung92@gmail.com)
* @Copyright (C) 2011
* @Createdate 26-01-2011 14:43
*/

if (!defined('NV_IS_QUANLY_ADMIN')) die('Stop!!!');
$link = NV_BASE_ADMINURL . "index.php?" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=";

$action = $nv_Request->get_string('action', 'post/get', "");
if($action) {
	$ret = array("status" => 0, "data" => array());
	switch ($action) {
		case "save":
			$filter = $nv_Request->get_int('filter', 'post/get', 0);
			$expect = $nv_Request->get_int('expect', 'post/get', 0);
			$exrecall = $nv_Request->get_int('exrecall', 'post/get', 0);
			$recall = $nv_Request->get_int('recall', 'post/get', 0);
			$redrug = $nv_Request->get_int('redrug', 'post/get', 0);
			$hour_from = $nv_Request->get_int('hour_from', 'post/get', 0);
			$minute_from = $nv_Request->get_int('minute_from', 'post/get', 0);
			$hour_end = $nv_Request->get_int('hour_end', 'post/get', 0);
			$minute_end = $nv_Request->get_int('minute_end', 'post/get', 0);
			$update = array();
			$updatev2 = array();
			if (!empty($filter)) {
				$updatev2["filter"] = $filter;
			}
			if (!empty($expect)) {
				$updatev2["expect"] = $expect;
			}
			if (!empty($exrecall)) {
				$updatev2["exrecall"] = $exrecall;
			}
			if (!empty($recall)) {
				$updatev2["recall"] = $recall;
			}
			if (!empty($redrug)) {
				$updatev2["redrug"] = $redrug;
			}
			$updatev2["hour_from"] = $hour_from;
			$updatev2["hour_end"] = $hour_end;
			$updatev2["minute_from"] = $minute_from;
			$updatev2["minute_end"] = $minute_end;
			if (!empty($updatev2)) {
				configv2($updatev2);
				$ret["status"] = 1;
				$ret["notify"] = $lang_module["saved"];
			}
		break;
	} 
	
	echo json_encode($ret);
	die();
}

$page_title = $lang_module["doctor_config"];
$xtpl = new XTemplate("config.tpl", NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file);
$xtpl->assign("lang", $lang_module);

$day = 24 * 60 * 60;
$week = 7 * $day;
$month = 30 * $day;
$date_option = array("1 tuần" => $week, "2 tuần" => 2 * $week, "3 tuần" => 3 * $week, "4 tuần" => 4 * $week, "5 tuần" => 5 * $week, "6 tuần" => 6 * $week, "7 tuần" => 7 * $week, "8 tuần" => 8 * $week, "3 tháng" => 3 * $month, "4 tháng" => 4 * $month, "5 tháng" => 5 * $month, "6 tháng" => 6 * $month, "7 tháng" => 7 * $month, "8 tháng" => 8 * $month, "9 tháng" => 9 * $month, "10 tháng" => 10 * $month, "11 tháng" => 11 * $month, "12 tháng" => 12 * $month);
$sort_option = array("1" => "Thời gian tiêm phòng giảm dần", "2" => "Thời gian tiêm phòng tăng dần", "3" => "Thời gian tái chủng giảm dần", "4" => "Thời gian tái chủng tăng dần");

// if(empty($module_config[$module_name]["sort_type"])) $sort = $sort_option["3"];
// else $sort = $module_config[$module_name]["sort_type"];

// if(empty($module_config[$module_name]["filter_time"])) $time_amount = $date_option["2 tuần"];
// else $time_amount = $module_config[$module_name]["filter_time"];

// if(empty($module_config[$module_name]["expect_time"])) $expect_time = $date_option["2 tuần"];
// else $expect_time = $module_config[$module_name]["expect_time"];

// foreach ($sort_option as $value => $name) {
// 	$xtpl->assign("sort_value", $value);
// 	$xtpl->assign("sort_name", $name);
// 	if($value == $sort) $xtpl->assign("fs_select", "selected");
// 	else $xtpl->assign("fs_select", "");
// 	$xtpl->parse("main.fs_time");
// }

$hour_option = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23];
$minute_option = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59];

foreach ($hour_option as $value) {
	$xtpl->assign("hour_value", $value);
	$xtpl->assign("hour_name", $value);
	$hour_from_select = "";
	if (!empty($vacconfigv2["hour_from"]) && $vacconfigv2["hour_from"] == $value) {
		$hour_from_select = "selected";
	}
	$xtpl->assign("hour_from_select", $hour_from_select);
	$xtpl->parse("main.hour_from");
	$hour_end_select = "";
	if (!empty($vacconfigv2["hour_end"]) && $vacconfigv2["hour_end"] == $value) {
		$hour_end_select = "selected";
	}
	$xtpl->assign("hour_end_select", $hour_end_select);
	$xtpl->parse("main.hour_end");
}

foreach ($minute_option as $value) {
	$xtpl->assign("minute_value", $value);
	$xtpl->assign("minute_name", $value);
	$minute_from_select = "";
	if (!empty($vacconfigv2["minute_from"]) && $vacconfigv2["minute_from"] == $value) {
		$minute_from_select = "selected";
	}
	$xtpl->assign("minute_from_select", $minute_from_select);
	$xtpl->parse("main.minute_from");
	$minute_end_select = "";
	if (!empty($vacconfigv2["minute_end"]) && $vacconfigv2["minute_end"] == $value) {
		$minute_end_select = "selected";
	}
	$xtpl->assign("minute_end_select", $minute_end_select);
	$xtpl->parse("main.minute_end");
}

foreach ($date_option as $name => $value) {
	$xtpl->assign("time_value", $value);
	$xtpl->assign("time_name", $name);
	if(!empty($vacconfigv2["filter"]) && $value == $vacconfigv2["filter"]) $xtpl->assign("filter_select", "selected");
	else $xtpl->assign("filter_select", "");
	$xtpl->parse("main.filter");
	if(!empty($vacconfigv2["recall"]) && $value == $vacconfigv2["recall"]) $xtpl->assign("recall_select", "selected");
	else $xtpl->assign("recall_select", "");
	$xtpl->parse("main.recall");
	if(!empty($vacconfigv2["exrecall"]) && $value == $vacconfigv2["exrecall"]) $xtpl->assign("exrecall_select", "selected");
	else $xtpl->assign("exrecall_select", "");
	$xtpl->parse("main.exrecall");
	if(!empty($vacconfigv2["expect"]) && $value == $vacconfigv2["expect"]) $xtpl->assign("expect_select", "selected");
	else $xtpl->assign("expect_select", "");
	$xtpl->parse("main.expect");
	if(!empty($vacconfigv2["redrug"]) && $value == $vacconfigv2["redrug"]) $xtpl->assign("redrug_select", "selected");
	else $xtpl->assign("redrug_select", "");
	$xtpl->parse("main.redrug");
}
$xtpl->assign("fromtime", date("Y-m-d", NV_CURRENTTIME));
$xtpl->assign("totime", date("Y-m-d", NV_CURRENTTIME + NV_NEXTMONTH));	


$xtpl->parse("main");

$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");

function configv2($data) {
	global $db;
	foreach ($data as $key => $value) {
		$sql = "select * from `" . VAC_PREFIX . "_configv2` where name = '$key'";
		$query = $db->query($sql);
		if ($row = $query->fetch()) {
			$sql = "update `" . VAC_PREFIX . "_configv2` set value = '$value' where name = '$key'";
			$query = $db->query($sql);
		}
		else {
			$sql = "insert into `" . VAC_PREFIX . "_configv2` (name, value) values ('$key', '$value')";
			$query = $db->query($sql);
		}
	}
}
