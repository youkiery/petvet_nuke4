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

$page_title = "autoload";

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
		case 'search':
			$keyword = $nv_Request->get_string('keyword', 'post', '');
			
			$result['status'] = 1;
			if (count($list)) {
				$result['html'] = dogRowByList($keyword);
			}

		break;
	}
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("main.tpl", "modules/biograph/template");

// updatePet(array('userid' => 1, 'name' => 'Tũn', 'dateofbirth' => '1561796000', 'species' => 'Giống', 'breed' => 'Loài', 'sex' => 'cái', 'color' => 'Màu', 'microchip' => '48751471200046'), 1);

$xtpl->assign("content", dogRowByList());
$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/biograph/layout/header.php");
echo $contents;
include ("modules/biograph/layout/footer.php");

