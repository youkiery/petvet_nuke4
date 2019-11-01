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
  global $db, $module_file, $nv_Request;

  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page']) || $filter['page'] < 1) {
    $filter['page'] = 1;
  }
  if (empty($filter['limit']) || $filter['limit'] < 10) {
    $filter['limit'] = 10;
  }

  $xtpl = new XTemplate("list.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/item");
  $query = $db->query('select count(*) as number from `'. PREFIX .'item`');
  $number = $query->fetch()['number'];

  $query = $db->query('select * from `'. PREFIX .'item` order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $index = $filter['limit'] * ($filter['page'] - 1) + 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('category', checkCategoryNameId($row['cate_id']));
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function categoryList() {
  global $db, $module_file, $nv_Request;

  $page = $nv_Request->get_string('page', 'post', 1);

  $xtpl = new XTemplate("list.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/category");

  $query = $db->query('select * from `'. PREFIX .'category` order by id desc');
  $index = $limit * ($page - 1) + 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function expList() {
  global $db, $module_file, $nv_Request;

  $page = $nv_Request->get_string('page', 'post', 1);
  $limit = 10;

  $xtpl = new XTemplate("list.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/exp");
  $query = $db->query('select count(*) as number from `'. PREFIX .'row`');
  $number = $query->fetch()['number'];

  $query = $db->query('select * from `'. PREFIX .'row` order by id desc limit ' . $limit . ' offset ' . ($page - 1) * $limit);
  $index = $limit * ($page - 1) + 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $item = getItemId($row['rid']);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('rid', $row['rid']);
    $xtpl->assign('name', $item['name']);
    $xtpl->assign('number', $row['number']);
    $xtpl->assign('time', date('d/m/Y', $row['exp_time']));
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', navList($number, $page, $limit, 'goPage'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function outdateList() {
  global $db, $module_file, $nv_Request;

  $list = $nv_Request->get_array('list', 'post');
  $from = $nv_Request->get_string('from', 'post', '');
  $to = $nv_Request->get_string('to', 'post', '');
  $page = $nv_Request->get_string('page', 'post', 1);
  $time = $nv_Request->get_string('time', 'post', 90);
  $limit = 10;

  $xtpl = new XTemplate("list.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/main");
  $check = 0;

  if (!empty($from)) {
    $check += 1;
  }
  if (!empty($to)) {
    $check += 2;
  }
  $today = time();
  
  if ($check > 0)  {
    // filter by time range
    switch ($check) {
      case '1':
        $xtra = ' where exp_time > ' . totime($from);
      break;
      case '2':
        $xtra = ' where exp_time < ' . totime($to);
      break;
      case '3':
        $xtra = ' where (exp_time between '. totime($from) .' and ' . totime($to) . ')';
      break;
    }
    $to = totime($to);
    if ($to < $today) $to = $today;
    $p1 = $today + ($to - $today) / 2;
  }
  else {
    // filter by time amount
    $to = (time() + $time * 60 * 60 * 24);
    $xtra = 'where exp_time < '. $to;
    if ($to < $today) $to = $today;
    $p1 = $today + ($to - $today) / 2;
  }

  if (count($list)) {
    $list = implode(', ', $list);
    $query = $db->query('select * from `'. PREFIX .'row` a inner join `'. PREFIX .'item` b on a.rid = b.id '. $xtra .' and cate_id in ('. $list .') order by exp_time desc');
  }
  else {
    $query = $db->query('select * from `'. PREFIX .'row` '. $xtra .' order by exp_time desc');
  }

  $index = 1;
  // echo date('d/m/Y', $p1);die();
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $item = getItemId($row['rid']);
    if ($row['exp_time'] < $today) {
      $xtpl->assign('color', 'redbg');
    }
    else if ($row['exp_time'] < $p1) {
      $xtpl->assign('color', 'yellowbg');
    }
    else {
      $xtpl->assign('color', '');
    }
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $item['name']);
    $xtpl->assign('number', $row['number']);
    $xtpl->assign('time', date('d/m/Y', $row['exp_time']));
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function expIdList() {
  global $db, $module_file, $nv_Request;

  $page = $nv_Request->get_string('page', 'post', 1);
  $limit = 10;

  $query = $db->query('select id from `'. PREFIX .'row` order by id desc limit ' . $limit . ' offset ' . ($page - 1) * $limit);
  $list = array();
  while ($row = $query->fetch()) {
    $list[] = $row['id'];
  }
  return $list;
}
