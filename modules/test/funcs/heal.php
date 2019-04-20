<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 19-04-2019 11:00
 */

if (!defined('NV_IS_MOD_QUANLY')) {
  die('Stop!!!');
}

quagio();
define('INI_PAGE', 1);
// define('INI_INSULT', 0);
define('INI_LIMIT', 10);
define('INI_COME', strtotime(date('Y-m-d')) - 60 * 60 * 24 * 15);
define('INI_CALL', strtotime(date('Y-m-d')) + 60 * 60 * 24 * 15);

$action = $nv_Request->get_string('action', 'post/get', '');
if (!empty($action)) {
	$result = array('status' => 0);
  switch ($action) {
		// case 'get-customer':
		// 	$result['status'] = 1;
		// 	$result['customer'] = getCustomerData();
		// break;
		case 'customer-suggest':
			$keyword = $nv_Request->get_string('keyword', 'get/post', '');

			$result['status'] = 1;
			$result['customer'] = getCustomerSuggestList($keyword);
		break;
		case 'filter':
			$page = $nv_Request->get_string('page', 'get/post', '');
			$limit = $nv_Request->get_string('insult', 'get/post', '');
			$cometime = $nv_Request->get_string('cometime', 'get/post', '');
			$calltime = $nv_Request->get_string('calltime', 'get/post', '');

			$cometime = totime($cometime);
			$calltime = totime($calltime);

			$html = healList($page, $limit, $cometime, $calltime);
			if (!empty($html)) {
				$result['status'] = 1;
				$result['html'] = $html;
			}
		break;
		case 'get_edit':
			$id = $nv_Request->get_int('id', 'get/post', 0);

			$data = getHealId($id);
			if (!empty($data)) {
				$result = $data;
				$result['status'] = 1;
			}
		break;
	}

  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("heal.tpl", PATH);

$xtpl->assign('content', healList(INI_PAGE, INI_LIMIT, INI_COME, INI_CALL));
$xtpl->assign('cometime', date('d/m/Y', INI_COME));
$xtpl->assign('calltime', date('d/m/Y', INI_CALL));
$xtpl->parse("main");

$contents = $xtpl->text();
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
