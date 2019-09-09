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

$page_title = "Thống kê thu chi";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'filter':
    $filter = $nv_Request->get_array('filter', 'post');

    $result['status'] = 1;
    $result['html'] = statistic($filter);
		break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("statistic.tpl", NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file);

$time = strtotime(date('Y/m/d'));
// $time = strtotime(date('8/8/2019'));
$filter['from'] = $time - 60 * 60 * 24 * 15;
$filter['end'] = $time + 60 * 60 * 24 * 15;

$xtpl->assign('from', date('d/m/Y', $filter['from']));
$xtpl->assign('end', date('d/m/Y', $filter['end']));
$xtpl->assign('content', statistic());
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");