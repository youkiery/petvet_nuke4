<?php

/**
 * @Project NUKEVIET-MUSIC
 * @Phan Tan Dung (phantandung92@gmail.com)
 * @Copyright (C) 2011
 * @Createdate 26-01-2011 14:43
 */

if (!defined('NV_IS_QUANLY_ADMIN')) die('Stop!!!');

$action = $nv_Request->get_string('action', 'post', '');
if ($action) {
  $result = array("status" => 0);
  switch ($action) {
    case 'remove-employ':
      $id = $nv_Request->get_int('id', 'post', '');

      $sql = 'delete from `' . VAC_PREFIX . '_xray_user` where userid = ' . $id;
      $db->query($sql);
       $result['status'] = 1;
      $result['html'] = xrayUserContent();
      break;
    case 'insert-employ':
      $id = $nv_Request->get_int('id', 'post', '');
      $name = $nv_Request->get_string('name', 'post', '');

      $sql = 'select * from `' . VAC_PREFIX . '_xray_user` where userid = ' . $id;
      $query = $db->query($sql);
      if (empty($row = $query->fetch())) {
        $sql = 'insert into `' . VAC_PREFIX . '_xray_user` (userid) values(' . $id . ')';
        $db->query($sql);
        $result['status'] = 1;
        $result['html'] = xrayUserContent();
        $result['html2'] = xrayUserSuggest($name);
      }
      break;
    case 'get-employ':
      $name = $nv_Request->get_string('name', 'post', '');

      $result['status'] = 1;
      $result['html'] = xrayUserSuggest($name);
      break;
  }
  echo json_encode($result);
  exit();
}

$xtpl = new XTemplate('main.tpl', PATH2);

$xtpl->assign('modal', xrayModal());
$xtpl->assign('content', xrayUserContent());
$xtpl->parse("main");
$contents = $xtpl->text("main");

include(NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include(NV_ROOTDIR . "/includes/footer.php");
