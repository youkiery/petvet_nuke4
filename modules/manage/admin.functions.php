<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE') or !defined('NV_IS_MODADMIN')) die('Stop!!!');
define('NV_IS_FILE_ADMIN', true);
define('PATH', NV_ROOTDIR . "/modules/". $module_file ."/template/admin/" . $op);
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php');
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/theme.php');

function memberModal() {
  $xtpl = new XTemplate("member-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function deviceModal() {
  global $module_file, $op;
  $xtpl = new XTemplate("device-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/" . $op);
  $xtpl->parse('main');
  return $xtpl->text();
}

function departModal() {
  global $module_file, $op;
  $xtpl = new XTemplate("depart-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/" . $op);
  $xtpl->parse('main');
  return $xtpl->text();
}

function removeModal() {
  global $module_file, $op;
  $xtpl = new XTemplate("remove-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/" . $op);
  $xtpl->parse('main');
  return $xtpl->text();
}

function removeAllModal() {
  global $module_file, $op;
  $xtpl = new XTemplate("remove-all-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/" . $op);
  $xtpl->parse('main');
  return $xtpl->text();
}

function deviceList() {
  global $db, $module_file, $op, $nv_Request;
  
  $filter = parseFilter('device');
  $xtpl = new XTemplate("device-list.tpl", PATH);

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

// function importModal() {
//   global $op;
//   $xtpl = new XTemplate("import-modal.tpl", PATH);
//   $xtpl->assign('content', importList());
//   $xtpl->parse('main');
//   return $xtpl->text();
// }

function importInsertModal() {
  global $op;
  $xtpl = new XTemplate("import-insert-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

// function importList() {
//   global $db, $module_file, $op;

//   $filter = parseFilter('import');
//   $xtpl = new XTemplate("import-modal-content.tpl", PATH);

//   $query = $db->query('select count(*) as count from `'. PREFIX .'import`');
//   $number = $query->fetch();

//   // die('select * from `'. PREFIX .'import` limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
//   $query = $db->query('select * from `'. PREFIX .'import` limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
//   $index = ($filter['page'] - 1) * $filter['limit'] + 1;
//   while ($row = $query->fetch()) {
//     $id = $row['id'];
//     $importData = getImportData($row['id']);

//     $xtpl->assign('id', 'ip' . spat(6 - strlen($row['id']), '0'));
//     $xtpl->assign('import_id', $row['id']);
//     $xtpl->assign('date', date('d/m/Y H:i', $row['import_date']));
//     $xtpl->assign('count', $importData['count']);
//     $xtpl->assign('total', $importData['total']);
//     $xtpl->parse('main.row');
//   }
//   $xtpl->parse('main');
//   return $xtpl->text();
// }

function materialModal() {
  global $op;
  $xtpl = new XTemplate("material-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function importModal() {
  global $op;
  $xtpl = new XTemplate("import-modal.tpl", PATH);
  $xtpl->assign('content', importList());
  $xtpl->parse('main');
  return $xtpl->text();
}

function importModalInsert() {
  global $op;
  $xtpl = new XTemplate("import-modal-insert.tpl", PATH);
  $xtpl->assign('content', importList());
  $xtpl->parse('main');
  return $xtpl->text();
}

function importModalRemove() {
  global $op;
  $xtpl = new XTemplate("import-modal-remove.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function importList() {
  global $db, $module_file, $op;

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
  global $op;
  $xtpl = new XTemplate("export-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function departList() {
  global $db;

  $xtpl = new XTemplate("depart-list.tpl", PATH);

  $sql = 'select * from `'. PREFIX .'depart`';
  $query = $db->query($sql);

  while($row = $query->fetch()) {
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->parse('main');
  }

  return $xtpl->text();
}

function materialList() {
  global $db, $op, $module_file;

  $type_list = array(0 => 'Vật tư', 1 => 'Hóa chất');
  $filter = parseFilter('import');
  $xtpl = new XTemplate("material-list.tpl", PATH);

  $sql = 'select count(*) as count from `'. PREFIX .'material` limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $number = $query->fetch()['count'];

  $sql = 'select * from `'. PREFIX .'material` order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;

  while($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('type', $type_list[$row['type']]);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('number', $row['number']);
    $xtpl->assign('description', $row['description']);
    if ($row['unit']) $xtpl->assign('unit', "($row[unit])");
    else $xtpl->assign('unit', '');
    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function editMemberModal() {
  global $db;
  $xtpl = new XTemplate("edit-member-modal.tpl", PATH);

  $xtpl->assign('content', departList());
  $xtpl->parse('main');
  return $xtpl->text();
}

function removeMemberModal() {
  $xtpl = new XTemplate("remove-member-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function memberList() {
  global $db, $db_config;

  $xtpl = new XTemplate("member-list.tpl", PATH);
  $allowance = array(1 => 'Chỉ xem', 'Chỉnh sửa');

  $sql = 'select a.id, a.author, b.first_name from `'. PREFIX .'member` a inner join `'. $db_config['prefix'] .'_users` b on a.userid = b.userid';
  $query = $db->query($sql);
  $index = 1;

  while($row = $query->fetch()) {
    $authors = json_decode($row['author']);
    $author = '';
    if (!empty($authors->{depart})) {
      if (!empty($authors->{device}) || !empty($authors->{device})) {
        $depart = array();
        $query2 = $db->query('select * from `'. PREFIX .'depart` where id in (' . implode(', ', $authors->{depart}) . ')');
        while ($row2 = $query2->fetch()) $depart[]= '[' .$row2['name'] . ']';
        $author =  ($authors->{device} ? ' [' . $allowance[$authors->{device}] . '] thiết bị' : '') . ($authors->{material} ? ' [' . $allowance[$authors->{material}] . '] vật tư' : '') . ' của phòng ban ' . implode(', ', $depart);
      }
    }
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['first_name']);
    $xtpl->assign('author', $author);
    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}
