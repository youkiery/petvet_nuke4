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
    case 'filter':
      $data = $nv_Request->get_array('data', 'post');

      $result['status'] = 1;
      $result['html'] = mainPetList($data['keyword'], $data['page']);
    break;
	}
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("list.tpl", "modules/news/template");

$keyword = $nv_Request->get_string('keyword', 'get', '');

$xtpl->assign('keyword', $keyword);
$xtpl->assign('content', mainPetList($keyword));

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/news//layout/header.php");
echo $contents;
include ("modules/news//layout/footer.php");

