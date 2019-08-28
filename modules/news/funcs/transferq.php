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

$page_title = "Danh sách yêu cầu";

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

      $result['status'] = 1;
      $result['html'] = transferqList($userinfo['id'], $filter);
		break;
		case 'cancel':
      $filter = $nv_Request->get_array('filter', 'post');
      $id = $nv_Request->get_int('id', 'post');

      if (count($filter) > 1 && !empty(checkTransferRequest($id))) {
        // zen: change to status
        $sql = 'delete from `'. PREFIX .'_transfer_request` where id = ' . $id;
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = transferqList($userinfo['id'], $filter);
        }
      }
		break;
		case 'confirm':
      $filter = $nv_Request->get_array('filter', 'post');
      $id = $nv_Request->get_int('id', 'post');
      $row = checkTransferRequest($id);

      if (count($filter) > 1 && !empty($row)) {
        // zen: change to status
        $pet = getPetById($row['petid']);

        $sql = 'delete from `'. PREFIX .'_transfer_request` where id = ' . $row['id'];
        $sql2 = 'update `'. PREFIX .'_pet` set userid = ' . $userinfo['id'] . ' where id = ' . $pet['id'];
        $sql3 = 'insert into `'. PREFIX .'_transfer` (fromid, targetid, petid, time, type) values('. $pet['userid'] .', '. $userinfo['id'] .', '. $row['petid'] .', '. time() .', 1)';

        if ($db->query($sql) && $db->query($sql2) && $db->query($sql3)) {
          $result['status'] = 1;
          $result['html'] = transferqList($userinfo['id'], $filter);
        }
      }
		break;
	}
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("transferq.tpl", "modules/news/template");

$xtpl->assign('content', transferqList($userinfo['id']));
$xtpl->assign('url', '/' . $module_name . '/' . $op . '/');
$xtpl->assign('url', '/' . $module_name . '/' . $op . '/');

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/news//layout/header.php");
echo $contents;
include ("modules/news//layout/footer.php");
