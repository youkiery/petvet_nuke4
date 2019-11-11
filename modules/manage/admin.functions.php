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

function deviceModal() {
  global $module_file;
  $xtpl = new XTemplate("device-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/device");
  $xtpl->parse('main');
  return $xtpl->text();
}

function departModal() {
  global $module_file;
  $xtpl = new XTemplate("depart-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/device");
  $xtpl->parse('main');
  return $xtpl->text();
}

function itemList() {
  global $db, $module_file;

  $filter = parseFilter();
  $xtpl = new XTemplate("device-list.tpl", PATH . "/admin/device");

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

function importModal() {
  $xtpl = new XTemplate("import-modal.tpl", PATH . "/admin/device");
  $xtpl->assign('content', importList());
  $xtpl->parse('main');
  return $xtpl->text();
}

function importInsertModal() {
  $xtpl = new XTemplate("import-insert-modal.tpl", PATH . "/admin/device");
  $xtpl->parse('main');
  return $xtpl->text();
}

function importList() {
  global $db, $module_file;

  $filter = parseFilter('import');
  $xtpl = new XTemplate("import-modal-content.tpl", PATH . "/admin/device");

  $query = $db->query('select count(*) as count from `'. PREFIX .'import`');
  $number = $query->fetch();

  // die('select * from `'. PREFIX .'import` limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $query = $db->query('select * from `'. PREFIX .'import` limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  while ($row = $query->fetch()) {
    $id = $row['id'];
    $importData = getImportData($row['id']);

    $xtpl->assign('id', 'ip' . spat(6 - strlen($row['id']), '0'));
    $xtpl->assign('import_id', $row['id']);
    $xtpl->assign('date', date('d/m/Y H:i', $row['import_date']));
    $xtpl->assign('count', $importData['count']);
    $xtpl->assign('total', $importData['total']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}
