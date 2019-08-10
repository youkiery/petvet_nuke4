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

$userinfo = getUserInfo();
if (empty($userinfo)) {
	header('location: /' . $module_name . '/login/');
	die();
}

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
		case 'search':

		break;
 		case 'target':
			$keyword = $nv_Request->get_string('keyword', 'post', '');

			$sql = 'select a.id, a.name, b.fullname, b.image from `'. PREFIX .'_pet` a inner join `'. PREFIX .'_user` b on a.userid = b.id where (a.name like "%'. $keyword .'%" or b.fullname like "%'. $keyword .'%") and userid = ' . $userinfo['id'];
			$query = $db->query($sql);

			$html = '';
			while ($row = $query->fetch()) {
				$html .= '
				<div class="suggest_item2" onclick="pickTarget(\''. $row['name'] .'\', '. $row['id'] .')">
					<div class="xleft">
					</div>
					<div class="xright">
						<p> '. $row['fullname'] .' </p>
						<p> '. $row['name'] .' </p>
					</div>
				</div>
				';
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
$xtpl = new XTemplate("info.tpl", "modules/biograph/template");

$sql = 'select * from `'. PREFIX .'_pet` where id = ' . $id;
$query = $db->query($sql);

if (!empty($row = $query->fetch())) {
	$xtpl->assign('name', $row['name']);
	$xtpl->assign('dob', $row['dateofbirth']);
	$xtpl->assign('breed', $row['breed']);
	$xtpl->assign('species', $row['species']);
	$xtpl->assign('sex', $row['sex']);
	$xtpl->assign('color', $row['color']);
	$xtpl->assign('microchip', $row['microchip']);
	$xtpl->assign('image', $row['image']);
  $xtpl->assign('breeder', breederList($id));
}

$xtpl->assign('url', '/' . $module_name . '/' . $op . '/');

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/biograph/layout/header.php");
echo $contents;
include ("modules/biograph/layout/footer.php");

