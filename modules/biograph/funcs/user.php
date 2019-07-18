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
		case 'login':
			$username = $nv_Request->get_string('login', 'post', '');
			$password = $nv_Request->get_string('password', 'post', '');

			if (!empty($username) && !empty($password)) {
				if (checkLogin($username, $password)) {
					$_SESSION['username'] = $username;
					$_SESSION['password'] = $password;

					
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

$xtpl = new XTemplate("user.tpl", "modules/biograph/template");

if (!empty($_SESSION['username']) && !empty($_SESSION['password'])) {
	$username = $_SESSION['username'];
	$password = $_SESSION['password'];
	// hash split username, password
	if (checkLogin($username, $password)) {
		$global['login'] = 1;
	}
}

if ($global['login']) {
	$xtpl->parse('main.log');
}
else {
	$xtpl->parse('main.nolog');
}

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/biograph/layout/header.php");
echo $contents;
include ("modules/biograph/layout/footer.php");

