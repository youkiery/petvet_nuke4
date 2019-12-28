<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_SYSTEM')) die('Stop!!!');
define('NV_IS_MOD_CONGVAN', true);
define('PATH', NV_ROOTDIR . "/modules/". $module_file ."/template/user/" . $op);
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php');

function deviceModal() {
  $xtpl = new XTemplate("device-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function excelModal() {
  $xtpl = new XTemplate("excel-modal.tpl", PATH);

  $depart = getDepartList();
  foreach ($depart as $data) {
    $xtpl->assign('id', $data['id']);
    $xtpl->assign('name', $data['name']);
    $xtpl->parse('main.depart');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function transferModal() {
  $xtpl = new XTemplate("transfer-modal.tpl", PATH);

  $depart = getDepartList();
  foreach ($depart as $data) {
    $xtpl->assign('id', $data['id']);
    $xtpl->assign('name', $data['name']);
    $xtpl->parse('main.depart');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function removeModal() {
  $xtpl = new XTemplate("remove-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function removeAllModal() {
  $xtpl = new XTemplate("remove-all-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function deviceList() {
  global $db, $nv_Request, $user_info;
  
  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['limit'])) $filter['limit'] = 10;

  $xtpl = new XTemplate("device-list.tpl", PATH);

  $query = $db->query('select * from `'. PREFIX .'member` where userid = '. $user_info['userid']);
  $user = $query->fetch();
  $authors = json_decode($user['author']);

  $depart = $authors->{depart};
  $depart2 = array();
  $departid = array();
  foreach ($depart as $id) {
    $departid[$id] = 1;
    $depart2[]= $id;
  }
  $xtra = '';
  if (empty($filter['depart'])) {
    $filter['depart'] = $depart2;
  }
  else {
    foreach ($filter['depart'] as $index => $value) {
      if (empty($departid[$value])) unset($filter['depart'][$index]);
    }
  }

  if (!empty($filter['depart'])) {
    $list = array();
    foreach ($filter['depart'] as $value) {
      $list[]= 'depart like \'%"'. $value .'"%\'';
    }
    $xtra = ' where ('. implode(' or ', $list) .') ';
  }
  if (!empty($filter['keyword'])) {
    if ($xtra) $xtra .= ' and name like "%'. $filter['keyword'] .'%"';
    else $xtra .= ' where name like "%'. $filter['keyword'] .'%"';
  }

  // die('select count(*) as count from `'. PREFIX .'device` '. $xtra .' order by update_time desc limit ' . $filter['limit']);
  $query = $db->query('select count(*) as count from `'. PREFIX .'device` '. $xtra .' order by update_time desc limit ' . $filter['limit']);
  $count = $query->fetch();
  $number = $count['count'];
  // die('select * from `'. PREFIX .'device` '. $xtra .' order by update_time desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $query = $db->query('select * from `'. PREFIX .'device` '. $xtra .' order by update_time desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  if ($authors->{device} == 2) $xtpl->parse('main.v1');
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
    $xtpl->assign('departid', $depart[0]);
    $xtpl->assign('company', $row['intro']);
    $xtpl->assign('status', $row['status']);
    $xtpl->assign('number', $row['number']);
    if ($authors->{device} == 2) $xtpl->parse('main.row.v2');
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function checkMember() {
  global $db, $user_info, $op;

  if (empty($user_info)) {
    $content = 'Xin hãy đăng nhập trước khi sử dụng chức năng này';
  }
  else {
    $query = $db->query('select * from `'. PREFIX .'member` where userid = '. $user_info['userid']);
    $user = $query->fetch();
    $authors = json_decode($user['author']);
    if ($op == 'device' && $authors->{device}) {
      // ok
    }
    else if ($op == 'material' && $authors->{material}) {
      // ok
    }
    else if ($op == 'main' && ($authors->{device} || $authors->{material})) {
      // ok
    }
    else {
      // prevent
      $content = 'Tài khoản không có quyền truy cập';
    }
  }
  if ($content) {
    include NV_ROOTDIR . '/includes/header.php';
    echo nv_site_theme($content);
    include NV_ROOTDIR . '/includes/footer.php';
  }
}

function materialList() {
  global $db, $op, $module_file, $nv_Request;

  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['limit'])) $filter['limit'] = 10;

  $type_list = array(0 => 'Vật tư', 1 => 'Hóa chất');
  $xtpl = new XTemplate("material-list.tpl", PATH);

  $sql = 'select count(*) as count from `'. PREFIX .'material` limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $number = $query->fetch()['count'];

  $sql = 'select * from `'. PREFIX .'material` order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;

  while($row = $query->fetch()) {
    // echo json_encode($row);
    // echo '<br>';
    $xtpl->assign('index', $index++);
    $xtpl->assign('type', $type_list[$row['type']]);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('number', $row['number']);
    $xtpl->assign('description', $row['description']);
    if ($row['unit']) $xtpl->assign('unit', "($row[unit])");
    else $xtpl->assign('unit', '');
    $xtpl->parse('main.row');
  }
  // die();

  $xtpl->parse('main');
  return $xtpl->text();
}

function materialModal() {
  $xtpl = new XTemplate("material-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function importModal() {
  $xtpl = new XTemplate("import-modal.tpl", PATH);
  $xtpl->assign('content', importList());
  $xtpl->parse('main');
  return $xtpl->text();
}

function importModalInsert() {
  $xtpl = new XTemplate("import-modal-insert.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function exportModalInsert() {
  $xtpl = new XTemplate("export-modal-insert.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function importModalRemove() {
  $xtpl = new XTemplate("import-modal-remove.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function exportModalRemove() {
  $xtpl = new XTemplate("export-modal-remove.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function importList() {
  global $db;

  $filter = parseFilter('import');
  $xtpl = new XTemplate("import-modal-list.tpl", PATH);

  $query = $db->query('select count(*) as count from `'. PREFIX .'import`');
  $number = $query->fetch();

  // die('select * from `'. PREFIX .'import` limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $query = $db->query('select * from `'. PREFIX .'import` order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  while ($row = $query->fetch()) {
    $id = $row['id'];
    $importData = getImportData($row['id']);

    // $xtpl->assign('id', 'ip' . spat(6 - strlen($row['id']), '0'));
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('date', date('d/m/Y H:i', $row['import_date']));
    $xtpl->assign('count', $importData['count']);
    $xtpl->assign('total', $importData['total']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function exportModal() {
  $xtpl = new XTemplate("export-modal.tpl", PATH);
  $xtpl->assign('content', exportList());
  $xtpl->parse('main');
  return $xtpl->text();
}

function exportList() {
  global $db;

  $filter = parseFilter('export');
  $xtpl = new XTemplate("export-list.tpl", PATH);

  $query = $db->query('select count(*) as count from `'. PREFIX .'export`');
  $number = $query->fetch();

  // die('select * from `'. PREFIX .'import` limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $query = $db->query('select * from `'. PREFIX .'export` order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  while ($row = $query->fetch()) {
    $id = $row['id'];
    $exportData = getExportData($row['id']);

    // $xtpl->assign('id', 'ip' . spat(6 - strlen($row['id']), '0'));
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('date', date('d/m/Y H:i', $row['export_date']));
    $xtpl->assign('count', $exportData['count']);
    $xtpl->assign('total', $exportData['total']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}
