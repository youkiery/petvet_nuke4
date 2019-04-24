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

$page_title = "Quản lý chấm công";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'summary':
			$startDate = $nv_Request->get_string("startDate", "get/post", "");
			$endDate = $nv_Request->get_string("endDate", "get/post", "");

			$startDate = totime($startDate);
			$endDate = totime($endDate);

			$result["status"] = 1;
			$result["html"] = adminSummary($startDate, $endDate);			
		break;
		case 'filter_data':
			$date = $nv_Request->get_string("date", "get/post", "");

			$result["status"] = 1;
			$result["html"] = adminScheduleList($date);			
		break;
	}

	echo json_encode($result);
	die();
}

// $this_week = date("N") == 1 ? strtotime(date("Y-m-d", time())) : strtotime('last monday');
// $next_week = (date("N") == 1 ? strtotime(date("Y-m-d", time())) : strtotime('last monday')) + A_DAY * 7;
$date_option = array(1 => "Tuần này", "Tuần sau", "Tháng này", "Tháng trước", "Tháng sau");

$xtpl = new XTemplate("main.tpl", PATH);

$xtpl->assign("this_week", date("d/m/Y"));

foreach ($date_option as $date_value => $date_name) {
  $xtpl->assign("date_name", $date_name);
  $xtpl->assign("date_value", $date_value);
  $xtpl->parse("main.date_option");
}

$time = time();
if (date('N', $time) < 23) {
	$time = time() - A_DAY * 23;
}

$startDate = strtotime(date("Y", $time) . "-" . date("m", $time) . "-24");
$endDate = strtotime(date("Y", $time) . "-" . (intval(date("m", $time)) + 1) . "-23");

$xtpl->assign("startDate", date('d/m/Y', $startDate));
$xtpl->assign("endDate", date('d/m/Y', $endDate));
$xtpl->assign("summary", adminSummary($startDate, $endDate));
$xtpl->assign("content", adminScheduleList(date("d/m/Y")));
$xtpl->parse("main");

$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");