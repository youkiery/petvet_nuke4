<?php

/**
 * @Project NUKEVIET 4.x
 * @Author Frogsis
 * @Createdate Tue, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE') or !defined('NV_IS_MODADMIN')) die('Stop!!!');
define('NV_IS_FILE_ADMIN', true);
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php');

function itemList() {
  global $db, $module_file, $nv_Request;

  $page = $nv_Request->get_string('page', 'post', 1);
  $limit = 10;

  $xtpl = new XTemplate("list.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/item");
  $query = $db->query('select count(*) as number from `'. PREFIX .'item`');
  $number = $query->fetch()['number'];

  $query = $db->query('select * from `'. PREFIX .'item` order by id desc limit ' . $limit . ' offset ' . ($page - 1) * $limit);
  $index = $limit * ($page - 1) + 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', navList($number, $page, $limit, 'goPage'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function checkItemName($name) {
  global $db;

  $query = $db->query('select * from `'. PREFIX .'item` where name like "%'. $name .'%"');
  if (!empty($query->fetch())) {
    return 1;
  }
  return 0;
}
