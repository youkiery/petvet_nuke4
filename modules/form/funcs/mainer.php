<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_FORM')) {
	die('Stop!!!');
}

$page_title = "Nhập hồ sơ một chiều";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {

	switch ($action) {
		case 'value':
			# code...
			break;
		
		default:
			# code...
			break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("mainer.tpl", PATH);

$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

