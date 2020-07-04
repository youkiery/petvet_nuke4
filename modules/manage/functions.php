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
  global $db, $nv_Request, $user_info, $db_config;
  
  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['limit'])) $filter['limit'] = 10;

  $xtpl = new XTemplate("device-list.tpl", PATH);

  // $query = $db->query('select * from `'. PREFIX .'member` where userid = '. $user_info['userid']);
  // $user = $query->fetch();
  // $authors = json_decode($user['author']);

  // $depart = $authors->{depart};
  // $depart2 = array();
  // $departid = array();
  // foreach ($depart as $id) {
  //   $departid[$id] = 1;
  //   $depart2[]= $id;
  // }
  // $xtra = '';
  // if (empty($filter['depart'])) {
  //   $filter['depart'] = $depart2;
  // }
  // else {
  //   foreach ($filter['depart'] as $index => $value) {
  //     if (empty($departid[$value])) unset($filter['depart'][$index]);
  //   }
  // }

  $sql = 'select * from `'. $db_config['prefix'] .'_users` where userid = ' . $user_info['userid'];
  $query = $db->query($sql);
  $user = $query->fetch();
  $group = explode(',', $user['in_groups']);
  // $group = array();
  $list = array();
  $xtra = '';

  if (!in_array('1', $group)) {
    // check if is allowed
    $sql = 'select * from `'. PREFIX .'devicon` where userid = ' . $user_info['userid'];
    $query = $db->query($sql);
    $devicon = $query->fetch();

    if ($devicon['level'] < 3) {
      $list = json_decode($devicon['depart']);
      // var_dump($devicon);die(); 
    } 
    else $list = getDepartidList();
  }
  else $list = getDepartidList();

  if (!empty($filter['depart']) && count($filter['depart'])) {
    $query_list = array();
    foreach ($filter['depart'] as $departid) {
      if (in_array($departid, $list)) $query_list[] = 'depart like \'%"'. $departid .'"%\'';
    }
    if (count($query_list)) $xtra = 'where ('. implode(' or ', $query_list) .')';
    else $xtra = 'where 0';
  }

  if (!empty($filter['keyword'])) {
    if ($xtra) $xtra .= ' and name like "%'. $filter['keyword'] .'%"';
    else $xtra .= ' where name like "%'. $filter['keyword'] .'%"';
  }

  // die('select count(*) as count from `'. PREFIX .'device` '. $xtra .' order by update_time desc limit ' . $filter['limit']);
  $sql = 'select count(*) as count from `'. PREFIX .'device` '. $xtra .' order by update_time desc limit ' . $filter['limit'];
  $query = $db->query($sql);

  $count = $query->fetch();
  $number = $count['count'];
  // die('select * from `'. PREFIX .'device` '. $xtra .' order by update_time desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $query = $db->query('select * from `'. PREFIX .'device` '. $xtra .' order by update_time desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  $authors = new object();
  if ($authors->{'device'} == 2) $xtpl->parse('main.v1');
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
    if (empty($devicon) || (!empty($devicon) && $devicon['level'] > 1)) $xtpl->parse('main.row.v2');
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
    if ($op == 'device' && $authors->{'device'}) {
      // ok
    }
    else if ($op == 'material' && $authors->{'material'}) {
      // ok
    }
    else if ($op == 'main' && ($authors->{'device'} || $authors->{'material'})) {
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
  global $db, $url, $filter;

  $xtpl = new XTemplate("material-list.tpl", PATH);

  $sql = 'select count(*) as count from `'. PREFIX .'material`';
  $query = $db->query($sql);
  $count = $query->fetch()['count'];

  $sql = 'select * from `'. PREFIX .'material` order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  $today = time();

  while($row = $query->fetch()) {
    $number = 0;
    $sql = 'select * from `'. PREFIX .'material_detail` where number > 0 and materialid = '. $row['id'];
    $detail_query = $db->query($sql);
    $expire = 9999999999;
    while ($detail = $detail_query->fetch()) {
      if ($detail['expire'] < $expire) $expire = $detail['expire'];
      // echo "$expire, ";
      $number += $detail['number'];
    }

    $xtpl->assign('expire', '-');
    $xtpl->assign('color', '');
    if ($expire !== 9999999999) $xtpl->assign('expire', date('d/m/Y', $expire));
    if ($expire < $today) $xtpl->assign('color', 'red');
    $xtpl->assign('index', $index++);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('number', $number);
    $xtpl->assign('description', $row['description']);
    if ($row['unit']) $xtpl->assign('unit', "($row[unit])");
    else $xtpl->assign('unit', '');
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', nav_generater($url, $count, $filter['page'], $filter['limit']));
  // die();
  $xtpl->parse('main');
  return $xtpl->text();
}

function materialModal() {
  $xtpl = new XTemplate("modal.tpl", PATH);
 
  $day = 60 * 60 * 24;
  $xtpl->assign('last_month', date('d/m/Y', time() - $day * 30));
  $xtpl->assign('next_half_year', date('d/m/Y', time() + $day * 30 * 6));

  $xtpl->parse('main');
  return $xtpl->text();
}

function sourceDataList() {
  global $db;

  $sql = 'select * from `'. PREFIX .'material_source` order by name';
  $query = $db->query($sql);
  $list = array();

  while ($row = $query->fetch()) {
    $list[] = array(
      'id' => $row['id'],
      'name' => $row['name'],
      'alias' => simplize($row['name'])
    );
  }
  return $list;
}

function sourceDataList2() {
  global $db;

  $sql = 'select * from `'. PREFIX .'material_source` order by name';
  $query = $db->query($sql);
  $list = array();

  while ($row = $query->fetch()) {
    $list[$row['id']] = $row['name'];
  }
  return $list;
}
