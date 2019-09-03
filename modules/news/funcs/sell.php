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

$page_title = "Danh sách chó bán";

if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
		case 'signup':
      $a = 1;
		break;
	}
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("sell.tpl", "modules/". $module_name ."/template");

$xtpl->assign('content', sellList());

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/". $module_file ."/layout/header.php");
echo $contents;
include ("modules/". $module_name ."/layout/footer.php");
