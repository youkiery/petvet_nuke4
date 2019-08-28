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

$page_title = "Đăng nhập";

$action = $nv_Request->get_string('action', 'post', '');
$userinfo = getUserInfo();
if (!empty($userinfo)) {
  if ($userinfo['center']) {
    header('location: /'. $module_name .'/center');
  }
  header('location: /'. $module_name .'/private');
}

if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
		case 'login':
			$data = $nv_Request->get_array('data', 'post');

			if (checkObj($data)) {
				$data['username'] = strtolower($data['username']);
        if (!checkUsername($data['username'])) {
  				$result['error'] = 'Tài khoản không tồn tại';
        }
        else if (empty($checker = checkLogin($data['username'], $data['password']))) {
					$result['error'] = 'Mật khẩu không đúng';
				}
        else {
          if ($checker['active'] <= 0) {
  					$result['error'] = 'Tài khoản chưa được cấp quyền đăng nhập';
          }
          else {
            $_SESSION['username'] = $data['username'];
            $_SESSION['password'] = $data['password'];
            $result['status'] = 1;
          }
        }
			}
		break;
		case 'signup':
			$data = $nv_Request->get_array('data', 'post');

			if (checkObj($data)) {
				$data['username'] = strtolower($data['username']);
				if (!checkLogin($data['username'], $data['password'])) {
					$sql = 'insert into `'. PREFIX .'_user` (username, password, fullname, mobile, politic, address, active, image) values("'. $data['username'] .'", "'. md5($data['password']) .'", "'. $data['fullname'] .'", "'. $data['phone'] .'", "'. $data['politic'] .'", "'. $data['address'] .'", 1, "")';
					if ($db->query($sql)) {
						$_SESSION['username']	 = $data['username'];
						$_SESSION['password'] = $data['password'];
						$result['status'] = 1;
					}
				}
        else {
					$result['error'] = 'Tên đăng nhập hoặc mật khẩu không đúng';
        }
			}
		break;
	}
	echo json_encode($result);
	die();
}

$id = $nv_Request->get_int('id', 'get', 0);
$global = array();
$global['login'] = 0;

$xtpl = new XTemplate("login.tpl", "modules/". $module_name ."/template");

if (count($userinfo) > 0) {
	// logged
	$xtpl->assign('fullname', $userinfo['fullname']);
	$xtpl->assign('mobile', $userinfo['mobile']);
	$xtpl->assign('address', $userinfo['address']);
	$xtpl->assign('image', $userinfo['image']);
	$xtpl->assign('list', userDogRowByList($userinfo['id']));

	if (!empty($user_info) && !empty($user_info['userid']) && (in_array('1', $user_info['in_groups']) || in_array('2', $user_info['in_groups']))) {
		$xtpl->assign('userlist', userRowList());
	
		$xtpl->parse('main.log.user');
		$xtpl->parse('main.log.mod');
		$xtpl->parse('main.log.mod2');
	}

	$xtpl->parse('main.log');
}
else {
	$xtpl->parse('main.nolog');
}

$xtpl->assign('origin', '/' . $module_name . '/' . $op . '/');
$xtpl->assign('module_file', $module_file);

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/". $module_name ."/layout/header.php");
echo $contents;
include ("modules/". $module_name ."/layout/footer.php");
