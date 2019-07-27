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
define('BUILDER_INSERT', 0);
define('BUILDER_EDIT', 1);

$page_title = "autoload";

$action = $nv_Request->get_string('action', 'post', '');
$userinfo = getUserInfo();
if (empty($userinfo)) {
	header('location: /' . $module_name . '/login/');
	die();
}

if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
		case 'filter':
			$filter = $nv_Request->get_array('filter', 'post');
			
			if (count($filter) > 1) {
				$result['html'] = userDogRowByList($userinfo['id'], $filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
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
		case 'get':
			$id = $nv_Request->get_string('id', 'post');
			
			$sql = 'select * from `'. PREFIX .'_pet` where id = ' . $id;
			$query = $db->query($sql);

			if (!empty($row = $query->fetch())) {
				$result['data'] = array('name' => $row['name'], 'dob' => $row['dateofbirth'], 'species' => $row['species'], 'breed' => $row['breed'], 'sex' => $row['sex'], 'color' => $row['color'], 'microchip' => $row['microchip']);
				$result['status'] = 1;
			}
		break;
		case 'getuser':
			$id = $nv_Request->get_string('id', 'post');
			
			$sql = 'select * from `'. PREFIX .'_user` where id = ' . $id;
			$query = $db->query($sql);

			if (!empty($row = $query->fetch())) {
				$result['data'] = array('fullname' => $row['fullname'], 'mobile' => $row['mobile'], 'address' => $row['address']);
				$result['image'] = $row['image'];
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
		case 'remove':
			$id = $nv_Request->get_string('id', 'post');
			$filter = $nv_Request->get_array('filter', 'post');

			$sql = 'delete from `'. PREFIX .'_pet` where id = ' . $id;
			if ($db->query($sql)) {
				$result['html'] = userDogRowByList($userinfo['id'], $filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
			}
		break;
		case 'removeuser':
			$id = $nv_Request->get_string('id', 'post');
			$filter = $nv_Request->get_array('filter', 'post');

			$sql = 'delete from `'. PREFIX .'_user` where id = ' . $id;
			if ($db->query($sql)) {
				$result['html'] = userRowList($filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
			}
		break;
		case 'login':
			$username = $nv_Request->get_string('username', 'post', '');
			$password = $nv_Request->get_string('password', 'post', '');

			if (!empty($username) && !empty($password)) {
				$username = strtolower($username);
				if (checkLogin($username, $password)) {
					$_SESSION['username'] = $username;
					$_SESSION['password'] = $password;
					$result['status'] = 1;
				}
			}
		case 'signup':
			$username = $nv_Request->get_string('username', 'post', '');
			$password = $nv_Request->get_string('password', 'post', '');
			$fullname = $nv_Request->get_string('fullname', 'post', '');
			$mobile = $nv_Request->get_string('phone', 'post', '');
			$address = $nv_Request->get_string('address', 'post', '');

			if (!empty($username) && !empty($password)) {
				$username = strtolower($username);
				if (!checkLogin($username, $password)) {
					$sql = 'insert into `'. PREFIX .'_user` (username, password, fullname, mobile, address, active, image) values("'. $username .'", "'. md5($password) .'", "'. $fullname .'", "'. $mobile .'", "'. $address .'", 0, "")';
					if ($db->query($sql)) {
						$_SESSION['username'] = $username;
						$_SESSION['password'] = $password;
						$result['status'] = 1;
					}
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
		case 'edituser':
			$id = $nv_Request->get_string('id', 'post', '');
			$data = $nv_Request->get_array('data', 'post');
			$filter = $nv_Request->get_array('filter', 'post');
			$image = $nv_Request->get_string('image', 'post');

			if (count($data) > 1 && !empty($id)) {
				$sql = 'update `'. PREFIX .'_user` set '. sqlBuilder($data, BUILDER_EDIT) . (strlen(trim($image)) > 0 ? ', image = "'. $image .'"' : '') . ' where id = ' . $id;
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['notify'] = 'Đã chỉnh sửa thú cưng';
					$result['html'] = userRowList($filter);
				}
			}
		break;
		case 'center':
			if (!empty($userinfo)) {
				$sql = 'update `'. PREFIX .'_user` set center = 1 where id = ' . $userinfo['id'];

				if ($db->query($sql)) {
					$result['status'] = 1;
				}
			}
		break;
		case 'parent':
			$keyword = $nv_Request->get_string('keyword', 'post', '');

			$sql = 'select a.id, a.name, b.fullname, b.image from `'. PREFIX .'_pet` a inner join `'. PREFIX .'_user` b on a.userid = b.id where a.name like "%'. $keyword .'%" or b.fullname like "%'. $keyword .'%"';
			$query = $db->query($sql);

			$html = '';
			while ($row = $query->fetch()) {
				$html .= `
				<div class="item_suggest" onclick="pickParent(`. $row['id'] .`)">
					<div style="float: left; width: 32px;">
					</div>
					<div style="float: left; width: calc(100% - 32px);">
						<p> `. $row['fullname'] .` </p>
						<p> `. $row['name'] .` </p>
					</div>
				</div>
				`;
			}

			if (empty($html)) {
				$html = 'Không có kết quả trùng khớp';
			}

			$result['status'] = 1;
			$result['html'] = $html;
		break;
	}
	echo json_encode($result);
	die();
}

$id = $nv_Request->get_int('id', 'get', 0);
$global = array();
$global['login'] = 0;

$xtpl = new XTemplate("user.tpl", "modules/biograph/template");

$xtpl->assign('fullname', $userinfo['fullname']);
$xtpl->assign('mobile', $userinfo['mobile']);
$xtpl->assign('address', $userinfo['address']);
$xtpl->assign('image', $userinfo['image']);
$xtpl->assign('list', userDogRowByList($userinfo['id']));

if (!$userinfo['center']) {
	$xtpl->parse('main.log.center');
}
else {
	$xtpl->parse('main.log.xcenter');
}


// if (!empty($user_info) && !empty($user_info['userid']) && (in_array('1', $user_info['in_groups']) || in_array('2', $user_info['in_groups']))) {
// 	$xtpl->assign('userlist', userRowList());
	
// 	$xtpl->parse('main.log.user');
// 	$xtpl->parse('main.log.mod');
// 	$xtpl->parse('main.log.mod2');
// }

$xtpl->parse('main.log');

$xtpl->assign('origin', '/' . $module_name . '/' . $op . '/');

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/biograph/layout/header.php");
echo $contents;
include ("modules/biograph/layout/footer.php");
