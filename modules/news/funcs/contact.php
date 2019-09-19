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

$page_title = "Danh sách khách hàng";

$userinfo = getUserinfo();
if (empty($userinfo) || $userinfo['active'] == 0) {
	header('location: /'. $module_name .'/login/');
	die();
}

if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
    case 'takeback':
      $id = $nv_Request->get_string('id', 'post');
      $user = $nv_Request->get_string('user', 'post');
      $filter = $nv_Request->get_array('filter', 'post');

      $sql = 'update `'. PREFIX .'_pet` set userid = '. $userinfo['id'] .' and type = 1 where id = ' . $id;

      if ($db->query($sql) && $html = contactContent($user, $filter)) {
        $result['status'] = 1;
        $result['notify'] = 'Đã chuyển về';
        $result['html'] = $html;
      }
    break;
    case 'view':
      $id = $nv_Request->get_string('id', 'post');
      $filter = $nv_Request->get_array('filter', 'post');

      if ($html = contactContent($id, $filter)) {
        $result['status'] = 1;
        $result['html'] = $html;
      }
    break;
    case 'filter':
      $filter = $nv_Request->get_array('filter', 'post');

      if (!empty($html = contactList($filter))) {
        $result['status'] = 1;
        $result['html'] = $html;
      }
    break;
    case 'filter2':
      $id = $nv_Request->get_string('id', 'post');
      $filter = $nv_Request->get_array('filter', 'post');

      if (!empty($html = contactContent($id, $filter))) {
        $result['status'] = 1;
        $result['html'] = $html;
      }
    break;
	}
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("contact.tpl", "modules/". $module_name ."/template");

$xtpl->assign('content', contactList($userinfo['id']));

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/". $module_file ."/layout/header.php");
echo $contents;
include ("modules/". $module_name ."/layout/footer.php");
