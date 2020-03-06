<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_ADMIN_FORM')) {
	die('Stop!!!');
}

// lấy dữ liệu lọc từ url
$filter = array(
	'page' => $nv_Request->get_int('page', 'get', 1),
	'limit' => $nv_Request->get_int('page', 'get', 10)
);

$page_title = "Danh sách hồ sơ";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'insert':
			$name = $nv_Request->get_string('name', 'post');
			if (!empty($name)) {
				$sql = 'insert into `'. PREFIX .'_table_info` (name, html, style, prequire) values("'. $name .'", "", "", "")';
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['notify'] = 'Đã thêm';
					$result['html'] = tableContent($filter);
				}
			}
		break;
	}
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("main.tpl", PATH2);

$xtpl->assign('content', tableContent($filter));
$xtpl->assign('modal', tableModal());
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");