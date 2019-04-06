<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_KAIZEN')) {
	die('Stop!!!');
}

$page_title = 'Chiến lược Kaizen';
preCheckUser();

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
			$problem = $nv_Request->get_string('problem', 'post/get', '');
			$solution = $nv_Request->get_string('solution', 'post/get', '');
			$result_s = $nv_Request->get_string('result', 'post/get', '');

			if (!(empty($problem) || empty($solution) || empty($result_s))) {
				$sql = 'insert into `'. PREFIX .'_row` (userid, problem, solution, result, post_time, edit_time) values ('.$user_info['userid'].', "'. $problem .'", "'. $solution .'", "'. $result_s .'", '. time() .', '. time() .')';
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['notify'] = 'Đã gửi giải pháp';
					$result['html'] = kaizenList($user_info['userid']);
				}
			}
    break;
    case 'edit':
			$id = $nv_Request->get_int('id', 'post/get', 0);
			$problem = $nv_Request->get_string('problem', 'post/get', '');
			$solution = $nv_Request->get_string('solution', 'post/get', '');
			$result_s = $nv_Request->get_string('result', 'post/get', '');

			if (!(empty($id) || empty($problem) || empty($solution) || empty($result_s))) {
				if (checkRow($id)) {
					$sql = 'update `'. PREFIX .'_row` set problem = "'. $problem .'", solution = "'. $solution .'", result = "'. $result_s .'", edit_time = '. time() .' where id = ' . $id;
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
				if (checkRow($id)) {
					$sql = 'delete from `'. PREFIX .'_row` where id = ' . $id;
					if ($db->query($sql)) {
						$result['status'] = 1;
						$result['notify'] = 'Đã lưu thay đổi';
						$result['html'] = kaizenList($user_info['userid']);
					}
				}
			}
		break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate('main.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);

$xtpl->assign('content', kaizenList($user_info['userid']));
$xtpl->parse('main');
$contents = $xtpl->text('main');

include ( NV_ROOTDIR . '/includes/header.php' );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . '/includes/footer.php' );

