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
$userinfo = getUserInfo();
if (empty($userinfo)) {
	header('location: /' . $module_name . '/login/');
	die();
}
else {
  if ($userinfo['center']) {
    header('location: /biograph/center');
  }
}

if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
		case 'filter':
      $filter = $nv_Request->get_array('filter', 'post');

      if (count($filter) < 2) {
        $result['status'] = 1;
        $result['html'] = transferqList($userinfo);
      }
		break;
		case 'cancel':
      $filter = $nv_Request->get_array('filter', 'post');

      if (count($filter) > 1 && !empty(checkTransferRequest($id))) {
        // zen: change to status
        $sql = 'delete from `'. PREFIX .'_transfer_request` where id = ' . $filter['id'];
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = transferqList($userinfo);
        }
      }
		break;
		case 'confirm':
      $filter = $nv_Request->get_array('filter', 'post');
      $row = checkTransferRequest($filter['id']);

      if (count($filter) > 1 && !empty($row = checkTransferRequest($filter['id']))) {
        // zen: change to status
        $sql = 'delete from `'. PREFIX .'_transfer_request` where id = ' . $filter['id'];
        $sql2 = 'update `'. PREFIX .'_pet` set userid = ' . $userinfo['userid'] . ' id = ' . $row['id'];

        if ($db->query($sql) && $db->query($sql2)) {
          $result['status'] = 1;
          $result['html'] = transferqList($userinfo);
        }
      }
		break;
	}
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("transferq.tpl", "modules/biograph/template");

$xtpl->assign('content', transferqList($userinfo));
$xtpl->assign('url', '/' . $module_name . '/' . $op . '/');

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/biograph/layout/header.php");
echo $contents;
include ("modules/biograph/layout/footer.php");
