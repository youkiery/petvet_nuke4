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

$page_title = "Quản lý thú cưng";

$action = $nv_Request->get_string('action', 'post', '');

if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
 		case 'checkpet':
			$id = $nv_Request->get_string('id', 'post');
			$type = $nv_Request->get_string('type', 'post');
			$filter = $nv_Request->get_array('filter', 'post');

			$sql = 'update `'. PREFIX .'_pet` set active = '. $type .' where id = ' . $id;
			if ($db->query($sql)) {
				$result['html'] = userDogRow($filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
			}
		break;

		case 'filter':
			$filter = $nv_Request->get_array('filter', 'post');
			
			if (count($filter) > 1) {
				$result['html'] = userDogRow($filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
			}
		break;
		case 'get':
			$id = $nv_Request->get_string('id', 'post');
			
			$sql = 'select * from `'. PREFIX .'_pet` where id = ' . $id;
			$query = $db->query($sql);

			if (!empty($row = $query->fetch())) {
				$result['data'] = array('name' => $row['name'], 'dob' => $row['dateofbirth'], 'species' => $row['species'], 'breed' => $row['breed'], 'sex' => $row['sex'], 'color' => $row['color'], 'microchip' => $row['microchip']);
				$result['status'] = 1;
			}
		break;
		case 'check':
			$id = $nv_Request->get_string('id', 'post');
			$type = $nv_Request->get_string('type', 'post');
			$filter = $nv_Request->get_array('filter', 'post');

			$sql = 'update `'. PREFIX .'_pet` set active = '. $type .' where id = ' . $id;
			if ($db->query($sql)) {
				$result['html'] = userDogRowByList($userinfo['id'], $filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
			}
		break;
		case 'remove':
			$id = $nv_Request->get_string('id', 'post');
			$filter = $nv_Request->get_array('filter', 'post');
			
			$sql = 'delete from `'. PREFIX .'_pet` where id = ' . $id;
			if ($db->query($sql)) {
				$result['html'] = userDogRow($userinfo['id'], $filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
			}
		break;
		case 'insertpet':
			$data = $nv_Request->get_array('data', 'post');

			if (count($data) > 1 && !checkPet($data['name'], $userinfo['id'])) {
				$data['dob'] = totime($data['dob']);
				$sql = 'insert into `'. PREFIX .'_pet` (userid, name, dateofbirth, species, breed, sex, color, microchip, active, image) values('. $userinfo['id'] .', '. sqlBuilder($data, BUILDER_INSERT) .', 0, "")';

				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['notify'] = 'Đã thêm thú cưng';
					$result['html'] = userDogRowByList($userinfo['id']);
				}
			}
		break;
		case 'editpet':
			$id = $nv_Request->get_string('id', 'post', '');
			$data = $nv_Request->get_array('data', 'post');

			if (count($data) > 1 && !empty($id)) {
				$data['dateofbirth'] = totime($data['dob']);
				unset($data['dob']);
				$sql = 'update `'. PREFIX .'_pet` set '. sqlBuilder($data, BUILDER_EDIT) .' where id = ' . $id;
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['notify'] = 'Đã chỉnh sửa thú cưng';
					$result['html'] = userDogRowByList($userinfo['id']);
				}
			}
		break;
	}
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("pet.tpl", PATH);
$xtpl->assign('list', userDogRow());
$xtpl->assign('module_file', $module_file);
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");