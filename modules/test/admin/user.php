<?php
/**
* @Project NUKEVIET-MUSIC
* @Phan Tan Dung (phantandung92@gmail.com)
* @Copyright (C) 2011
* @Createdate 26-01-2011 14:43
*/

if (!defined('NV_IS_QUANLY_ADMIN')) die('Stop!!!');
$page_title = 'Quản lý nhân viên';
$action = $nv_Request->get_string('action', 'post/get', "");

if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
    case 'insert':
      $id = $nv_Request->get_int('id', 'post');

      $sql = 'select * from `'. VAC_PREFIX .'_user` where userid = ' . $id;
      $query = $db->query($sql);

      if (empty($query->fetch())) {
        $sql = 'insert into `'. VAC_PREFIX .'_user` (userid) values('. $id .')';
        $db->query($sql);

        $result['status'] = 1;
        $result['html'] = userContent();
        $result['html2'] = userContentSuggest();
      }
		break;
    case 'remove':
      $id = $nv_Request->get_int('id', 'post');

      $sql = 'select * from `'. VAC_PREFIX .'_user` where userid = ' . $id;
      $query = $db->query($sql);

      if (!empty($query->fetch())) {
        $sql = 'delete from `'. VAC_PREFIX .'_user` where userid = '. $id;
        $db->query($sql);

        $result['status'] = 1;
        $result['html'] = userContent();
        $result['html2'] = userContentSuggest();
      }
		break;
    case 'change':
      $id = $nv_Request->get_int('id', 'post');
      $type = $nv_Request->get_string('type', 'post');
      $value = $nv_Request->get_int('value', 'post');

      $sql = 'select * from `'. VAC_PREFIX .'_user` where userid = ' . $id;
      $query = $db->query($sql);

      if (!empty($query->fetch())) {
        $sql = 'update `'. VAC_PREFIX .'_user` set `'. $type .'` = '. $value .' where userid = '. $id;
        $db->query($sql);

        $result['status'] = 1;
        $result['html'] = userContent();
      }
		break;
    case 'get':
      $keyword = $nv_Request->get_string('keyword', 'post', '');

      $result['status'] = 1;
      $result['html'] = userContentSuggest($keyword);
		break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("main.tpl", PATH2);
$xtpl->assign("lang", $lang_module);
$xtpl->assign("content", userContent());

$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");

