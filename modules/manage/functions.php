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
  global $module_file, $op;
  $xtpl = new XTemplate("device-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function removeModal() {
  global $module_file, $op;
  $xtpl = new XTemplate("remove-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function removeAllModal() {
  global $module_file, $op;
  $xtpl = new XTemplate("remove-all-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function deviceList() {
  global $db, $module_file, $op, $nv_Request, $user_info;
  
  $filter = parseFilter('device');
  $xtpl = new XTemplate("device-list.tpl", PATH);

  $query = $db->query('select * from `'. PREFIX .'member` where userid = '. $user_info['userid']);
  $user = $query->fetch();
  $authors = json_decode($user['author']);

  $depart = $authors->{depart};
  $depart2 = array();
  $departid = array();
  foreach ($depart as $row) {
    $departid[$row['id']] = 1;
    $depart2[]= $row['id'];
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
