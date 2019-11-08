<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE') or !defined('NV_IS_MODADMIN')) die('Stop!!!');
define('NV_IS_FILE_ADMIN', true);
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php');
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/theme.php');

function itemList() {
  global $db, $module_file;

  $filter = parseFilter();
  $xtpl = new XTemplate("item-list.tpl", PATH . "/admin/device");

  $query = $db->query('select count(*) as count from `'. PREFIX .'item_detail`');
  $number = $query->fetch();

  // die('select * from `'. PREFIX .'item_detail` order by item_id, status limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $query = $db->query('select * from `'. PREFIX .'item_detail` order by item_id, status limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  while ($row = $query->fetch()) {
    $item = getItemData($row['item_id']);
    $company = getCompanyName($item['company']);
    $xtpl->assign('index', $index++);
    $xtpl->assign('name', $item['name']);
    $xtpl->assign('company', $company);
    $xtpl->assign('status', $row['status']);
    $xtpl->assign('number', $row['number']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}
