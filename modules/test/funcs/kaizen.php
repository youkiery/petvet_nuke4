<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_MOD_QUANLY')) {
	die('Stop!!!');
}

define('MODULE', 'kaizen');

$page_title = 'Chiến lược Kaizen';
$filter = array(
	'page' => $nv_Request->get_int('page', 'get', 1),
	'limit' => $nv_Request->get_int('limit', 'get', 10)
);

$action = $nv_Request->get_string('action', 'post/get', '');
if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
    // case 'getEdit':
		// 	$id = $nv_Request->get_int('id', 'post/get', 0);

		// 	if (!empty($id) && ($row = checkRow($id))) {
		// 		$result['status'] = 1;
		// 		$result['data'] = $row;
		// 	}
    // break;
    case 'insert':
		$data = $nv_Request->get_array('data', 'post');
		$sql = 'insert into `'. VAC_PREFIX .'_kaizen` (userid, problem, solution, result, post_time, edit_time) values ('.$user_info['userid'].', "'. $data['problem'] .'", "'. $data['solution'] .'", "'. $data['result'] .'", '. time() .', '. time() .')';
		if ($db->query($sql)) {
			$result['status'] = 1;
			$result['notify'] = 'Đã gửi giải pháp';
			$result['html'] = kaizenList($user_info['userid']);
		}
    break;
    case 'edit':
			$id = $nv_Request->get_int('id', 'post/get', 0);
			$problem = $nv_Request->get_string('problem', 'post/get', '');
			$solution = $nv_Request->get_string('solution', 'post/get', '');
			$result_s = $nv_Request->get_string('result', 'post/get', '');

			if (!(empty($id) || empty($problem) || empty($solution) || empty($result_s))) {
				if (checkRow(MODULE, $id)) {
					$sql = 'update `'. VAC_PREFIX .'_kaizen` set problem = "'. $problem .'", solution = "'. $solution .'", result = "'. $result_s .'", edit_time = '. time() .' where id = ' . $id;
					if ($db->query($sql)) {
						$result['status'] = 1;
						$result['notify'] = 'Đã lưu thay đổi';
						$result['html'] = kaizenList($user_info['userid']);
					}
				}
			}
		break;
		case 'remove':
			$id = $nv_Request->get_int('id', 'post/get', 0);

			if (!empty($id)) {
				if (checkRow(MODULE, $id)) {
					$sql = 'delete from `'. VAC_PREFIX .'_kaizen` where id = ' . $id;
					if ($db->query($sql)) {
						$result['status'] = 1;
						$result['notify'] = 'Đã lưu thay đổi';
						$result['html'] = kaizenList($user_info['userid']);
					}
				}
			}
		break;
		case 'filter':
			$result['status'] = 1;
			$result['html'] = kaizenList($user_info['userid']);
		break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate('main.tpl', PATH2);

$sql = 'select * from `'. $db_config['prefix'] .'_users` where userid = ' . $user_info['userid'];
$query = $db->query($sql);
$users = $query->fetch();

$xtpl->assign('page', 1);
$xtpl->assign('limit', 10);
$xtpl->assign('modal', kaizenModal());
$xtpl->assign('content', kaizenList($users['userid']));
$xtpl->parse('main');
$contents = $xtpl->text('main');

include ( NV_ROOTDIR . '/includes/header.php' );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . '/includes/footer.php' );

