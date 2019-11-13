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

function removeModal() {
  global $module_file;
  $xtpl = new XTemplate("remove-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/device");
  $xtpl->parse('main');
  return $xtpl->text();
}

function removeAllModal() {
  global $module_file;
  $xtpl = new XTemplate("remove-all-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/device");
  $xtpl->parse('main');
  return $xtpl->text();
}

function deviceList() {
  global $db, $module_file, $nv_Request;
  
  $filter = parseFilter('device');
  $xtpl = new XTemplate("device-list.tpl", PATH . "/admin/device");

  $query = $db->query('select count(*) as count from `'. PREFIX .'device`');
  $number = $query->fetch();
  $xtra = '';
  // var_dump($filter);die();
  if (!empty($filter['depart'])) {
    $list = array();
    foreach ($filter['depart'] as $value) {
      $list[]= 'depart like \'%"'. $value .'"%\'';
    }
    $xtra = ' where ('. implode(' or ', $list) .') ';
  }
  $query = $db->query('select count(*) as count from `'. PREFIX .'device` '. $xtra .' order by update_time desc limit ' . $filter['limit']);
  $count = $query->fetch();
  $number = $count['count'];
  // die('select * from `'. PREFIX .'device` '. $xtra .' order by update_time desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $query = $db->query('select * from `'. PREFIX .'device` '. $xtra .' order by update_time desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  while ($row = $query->fetch()) {
    $depart = json_decode($row['depart']);
    $list = array();
    foreach ($depart as $value) {
      $list[]= checkDepartId($value);
    }
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('depart', implode(', ', $list));
    $xtpl->assign('company', $row['intro']);
    $xtpl->assign('status', $row['status']);
    $xtpl->assign('number', $row['number']);
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));
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
