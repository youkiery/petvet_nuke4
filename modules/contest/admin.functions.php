<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE') or !defined('NV_IS_MODADMIN')) die('Stop!!!');
define('NV_IS_FILE_ADMIN', true);
define('PATH', NV_ROOTDIR . "/modules/$module_file/template/admin/$op");
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php');
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/theme.php');

function courtList() {
  global $db, $db_config;

  $xtpl = new XTemplate("court-list.tpl", PATH);
  $index = 1;
  $sql = 'select * from `'. PREFIX .'court`';
  $query = $db->query($sql);
  while ($row = $query->fetch()) {
    // cắt ngắn giới thiệu
    $pos = strpos($row['intro'], ' ', 100);
    $dot = true;
    if ($pos <= 0) {
      $dot = false;
      $pos = strlen($row['intro']);
    } 
    // tách người thực hiện
    $performer = array();
    $performer_list = explode(',', $row['performer']);
    foreach ($performer_list as $performerid) {
      if (!empty($performerid)) {
        $sql = 'select * from `'. $db_config['prefix'] .'_users` where userid = ' . $performerid;
        $performer_query = $db->query($sql);
        if ($performer_data = $performer_query->fetch()) $performer[] = $performer_data['first_name'];
      }
    }
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('performer', implode(', ', $performer));
    $xtpl->assign('price', number_format($row['price'], 0, '', ',') . ' VND');
    $xtpl->assign('intro', substr($row['intro'], 0, $pos) . ($dot ? '...' : ''));
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function courtRegistList($filter) {
  global $db, $module_name, $op;

  $xtpl = new XTemplate("regist-list.tpl", PATH);
  $index = 1;

  $xtra = array();
  if ($filter['keyword']) {
    $xtra[]= '(name like "%'. $filter['keyword'] .'%" or mobile like "%'. $filter['keyword'] .'%")';
  }

  if ($filter['court']) {
    $xtra[]= 'court = ' . $filter['court'];
  }

  if ($filter['active']) {
    $filter['active']--;
    $xtra[]= 'active = ' . $filter['active'];
  }

  $sql = 'select * from `'. PREFIX .'row` '. (count($xtra) ? 'where ' . implode(' and ', $xtra) : '') .' limit '. $filter['limit'] .' offset ' . $filter['limit'] * ($filter['page'] - 1);
  $query = $db->query($sql);
  $numer = 0;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('mobile', $row['mobile']);
    $xtpl->assign('court', checkCourt($row['court']));
    if ($row['active']) $xtpl->parse('main.row.yes');
    else $xtpl->parse('main.row.no');
    $number++;
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', nav_generater('/' . $module_name . '/' . $op . '?', $number, $filter['page'], $filter['limit']));
  $xtpl->parse('main');
  return $xtpl->text();
}

function courtModal() {
  global $db, $db_config;
  $xtpl = new XTemplate("modal.tpl", PATH);
  $sql = 'select b.userid, b.first_name from `'. $db_config['prefix'] .'_rider_user` a inner join `'. $db_config['prefix'] .'_users` b on a.user_id = b.userid where a.type = 1';
  $query = $db->query($sql);
  while ($row = $query->fetch()) {
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['first_name']);
    $xtpl->parse('main.performer');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function testModal() {
  global $module_file, $op;
  $xtpl = new XTemplate("test-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/" . $op);
  $xtpl->assign('content', testList());
  $xtpl->parse('main');
  return $xtpl->text();
}

function contestModal() {
  global $module_file, $db, $op;
  $xtpl = new XTemplate("contest-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/" . $op);

  $query = $db->query("select * from `". PREFIX ."test` where active = 1");
  while ($row = $query->fetch()) {
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->parse('main.test');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function removeModal() {
  global $module_file, $op;
  $xtpl = new XTemplate("remove-contest-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/" . $op);
  $xtpl->parse('main');
  return $xtpl->text();
}

function removeAllModal() {
  global $module_file, $op;
  $xtpl = new XTemplate("remove-all-contest-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/" . $op);
  $xtpl->parse('main');
  return $xtpl->text();
}

function testList() {
  global $module_file, $db, $op;
  $xtpl = new XTemplate("test-content.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/" . $op);
  $query = $db->query("select * from `". PREFIX ."test` order by id desc");
  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index ++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    if ($row['active']) $xtpl->parse('main.row.toggleon');
    else $xtpl->parse('main.row.toggleoff');
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function contestList() {
  global $module_file, $nv_Request, $db, $op;

  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['limit'])) $filter['limit'] = 10;

  $xtra = array();

  if (!empty($filter['species'])) {
    $xtra[]= 'species = ' . $filter['species'];
  }
  if (!empty($filter['contest'])) {
    $list = array();
    foreach ($filter['contest'] as $id) {
      $list[]= '(test like \'%"' . $id .'"%\')';
    }
    $xtra[]= implode(' or ', $list);
  }
  $xtra = implode(' and ', $xtra);

  $xtpl = new XTemplate("contest-list.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/" . $op);

  $query = $db->query("select count(*) as count from `". PREFIX ."row`  ". ($xtra ? " where " . $xtra : "") ." order by id desc");
  $number = $query->fetch()['count'];

  $query = $db->query("select * from `". PREFIX ."row` ". ($xtra ? " where " . $xtra : "") ." order by id desc limit 10 offset " . ($filter['page'] - 1) * $filter['limit']);
  $index = 1;
  $test_data = getTestDataList();
  // var_dump($test_data);die();
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index ++);
    $contest = json_decode($row['test']);
    $test = array();
    foreach ($contest as $id) {
      if ($test_data[$id]) $test[]= $test_data[$id];
    }

    $xtpl->assign('id', $row['id']);
    $xtpl->assign('species', ucwords(getSpecies($row['species'])));
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('petname', $row['petname']);
    $xtpl->assign('address', $row['address']);
    $xtpl->assign('mobile', $row['mobile']);
    $xtpl->assign('contest', implode(', ', $test));
    if ($row['active']) $xtpl->parse('main.row.done');
    else $xtpl->parse('main.row.undone');
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function modal() {
  global $db;
  $xtpl = new XTemplate("modal.tpl", PATH);

  $sql = 'select * from `'. PREFIX .'court`';
  $query = $db->query($sql);
  while ($row = $query->fetch()) {
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('court', $row['name'] . ' - Giá: ' . number_format($row['price'], 0, '', ',') . ($row['intro'] ? ' - ' : '') . $row['intro']);
    $xtpl->parse('main.court');
  }
  
  $xtpl->parse('main');
  return $xtpl->text();
}