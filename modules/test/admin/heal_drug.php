<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_QUANLY_ADMIN')) {
	die('Stop!!!');
}

$page_title = "Quản lý thuốc & tra cứu ";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
    case 'collect-insert':

    break;
	}

	echo json_encode($result);
	die();
}

$system = getSystemList();
$drug = getDrugList();

$xtpl = new XTemplate("heal_drug.tpl", PATH);

foreach ($system as $key => $row) {
	$xtpl->assign('systemid', $key);
	$xtpl->assign('system', $row['name']);
	$xtpl->parse('main.system');
}

$xtpl->assign('content1', adminDrugList($drug));
$xtpl->assign('system', json_encode($system));
$xtpl->assign('disease', '{}');
$xtpl->assign('drug', json_encode($drug));

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_admin_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

