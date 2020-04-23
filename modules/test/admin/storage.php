<?php
/**
* @Project NUKEVIET-MUSIC
* @Phan Tan Dung (phantandung92@gmail.com)
* @Copyright (C) 2011
* @Createdate 26-01-2011 14:43
*/

if (!defined('NV_IS_QUANLY_ADMIN')) die('Stop!!!');
$action = $nv_Request->get_string('action', 'post', "");
$filter = array(
  'page' => $nv_Request->get_int('page', 'get', 1),
  'limit' => $nv_Request->get_int('limit', 'get', 10),
  'id' => $nv_Request->get_int('id', 'get', 0)
);

if (!empty($action)) {
  $result = array('status' => 0);
	switch ($action) {
    case 'insert-position':
      $name = $nv_Request->get_string('name', 'post', '');

      $sql ='select * from `'. VAC_PREFIX .'_position`  where name = "'. $name .'"';
      $query = $db->query($sql);
      $position = $query->fetch();

      if (empty($position)) {
        $sql ='insert `'. VAC_PREFIX .'_position` (name) values ("'. $name .'")';
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = storageContent();
        }
      }
			break;
    case 'insert-item':
      $name = $nv_Request->get_string('name', 'post', '');

      $sql ='select * from `'. VAC_PREFIX .'_item` where name = "'. $name .'" and posid = '. $filter['id'];
      $query = $db->query($sql);
      $item = $query->fetch();

      if (empty($item)) {
        $sql ='insert `'. VAC_PREFIX .'_item` (name, posid) values ("'. $name .'", '. $filter['id'] .')';
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = storageList();
        }     
      }
    break;
    case 'remove-position':
      $id = $nv_Request->get_int('id', 'post');

      $sql = 'delete from `'. VAC_PREFIX .'_position` where id = '. $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = storageContent();
      }
    break;
    case 'insert-item':
      $id = $nv_Request->get_int('id', 'post');

      $sql = 'delete from `'. VAC_PREFIX .'_item` where id = '. $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = storageList();
      }
    break;
  }
  echo json_encode($result);
	die();
}

$xtpl = new XTemplate("main.tpl", PATH2);
$selectStorage = storageSelectContent();
$xtpl->assign('type', $selectStorage['type']);
$xtpl->assign('content', $selectStorage['content']);

$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");
