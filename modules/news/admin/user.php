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
define('BUILDER_EDIT', 2);

$page_title = "Quản lý người dùng";

$action = $nv_Request->get_string('action', 'post', '');

if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
		case 'checkuser':
			$id = $nv_Request->get_string('id', 'post');
			$type = $nv_Request->get_string('type', 'post');
			$filter = $nv_Request->get_array('filter', 'post');

			$sql = 'update `'. PREFIX .'_user` set active = '. $type .' where id = ' . $id;
			if ($db->query($sql)) {
				$result['html'] = userRowList($filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
			}
		break;
		case 'getuser':
			$id = $nv_Request->get_string('id', 'post');
			
			$sql = 'select * from `'. PREFIX .'_user` where id = ' . $id;
			$query = $db->query($sql);

			if (!empty($row = $query->fetch())) {
        $row['address'] = xdecrypt($row['address']);
        $row['mobile'] = xdecrypt($row['mobile']);
				$result['data'] = array('fullname' => $row['fullname'], 'mobile' => $row['mobile'], 'address' => $row['address']);
				$result['image'] = $row['image'];
				$result['status'] = 1;
			}
		break;
 		case 'filteruser':
			$filter = $nv_Request->get_array('filter', 'post');
			
			if (count($filter) > 1) {
				$result['html'] = userRowList($filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
			}
		break;
		case 'edituser':
			$id = $nv_Request->get_string('id', 'post', '');
			$data = $nv_Request->get_array('data', 'post');
			$image = $nv_Request->get_string('image', 'post');

			if (count($data) > 1 && !empty($id)) {
        $data['mobile'] = xencrypt($data['mobile']);
        $data['address'] = xencrypt($data['address']);
				$sql = 'update `'. PREFIX .'_user` set '. sqlBuilder($data, BUILDER_EDIT) . (strlen(trim($image)) > 0 ? ', image = "'. $image .'"' : '') . ' where id = ' . $id;
        die($sql);
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['notify'] = 'Đã chỉnh sửa thú cưng';
				}
			}
		break;
	}
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("user.tpl", PATH);

$xtpl->assign('userlist', userRowList());
// $xtpl->assign('remind', json_encode(getRemind()));
$xtpl->assign('module_file', $module_file);
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
include (NV_ROOTDIR . "/modules/". $module_file ."/layout/prefix.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");