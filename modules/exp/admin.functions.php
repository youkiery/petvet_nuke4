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
    $xtpl->assign('code', $row['code']);
    $xtpl->assign('number', $row['number']);
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

  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page']) || $filter['page'] < 1) {
    $filter['page'] = 1;
  }
  if (empty($filter['limit']) || $filter['limit'] < 10) {
    $filter['limit'] = 10;
  }

  $xtpl = new XTemplate("list.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/exp");
  $query = $db->query('select count(*) as number from `'. PREFIX .'row`');
  $number = $query->fetch()['number'];

  $query = $db->query('select * from `'. PREFIX .'row` order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $index = $filter['limit'] * ($filter['page'] - 1) + 1;
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
  $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function outdateList() {
  global $db, $module_file, $nv_Request;

  $filter = $nv_Request->get_array('filter', 'post');
  $list = $nv_Request->get_array('list', 'post');

  $xtpl = new XTemplate("list.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/main");
  $check = 0;

  if (!empty($filter['from'])) {
    $check += 1;
  }
  if (!empty($filter['to'])) {
    $check += 2;
  }
  $today = time();
  
  if ($check > 0)  {
    // filter by time range
    switch ($check) {
      case '1':
        $xtra = ' where exp_time > ' . totime($filter['from']);
      break;
      case '2':
        $xtra = ' where exp_time < ' . totime($filter['to']);
      break;
      case '3':
        $xtra = ' where (exp_time between '. totime($filter['from']) .' and ' . totime($filter['to']) . ')';
      break;
    }
    $filter['to'] = totime($filter['to']);
    if ($filter['to'] < $today) $filter['to'] = $today;
    $p1 = $today + ($filter['to'] - $today) / 2;
  }
  else {
    // filter by time amount
    if (empty($filter['time'])) $filter['time'] = 90;
    $filter['to'] = (time() + $filter['time'] * 60 * 60 * 24);
    $xtra = 'where exp_time < '. $filter['to'];
    if ($filter['to'] < $today) $filter['to'] = $today;
    $p1 = $today + ($filter['to'] - $today) / 2;
  }

  if (count($list)) {
    $list = implode(', ', $list);
    $query = $db->query('select * from `'. PREFIX .'row` a inner join `'. PREFIX .'item` b on a.rid = b.id '. $xtra .' and cate_id in ('. $list .') order by exp_time desc');
  }
  else {
    $query = $db->query('select * from `'. PREFIX .'row` '. $xtra .' and number > 0 order by exp_time desc');
  }
  // var_dump($query);die();

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

function expContent() {
  global $nv_Request, $module_file;
  $list = $nv_Request->get_array('list', 'post');
  $xtpl = new XTemplate("content.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/exp");
  $index = 1;

  if (count($list) > 0) {
    foreach ($list as $id) {
      $row = getRowId($id);
      $item = getItemId($row['rid']);
      $xtpl->assign('index', $index++);
      $xtpl->assign('id', $row['id']);
      $xtpl->assign('name', $item['name']);
      $xtpl->assign('time', date('d/m/Y', $row['exp_time']));
      $xtpl->assign('number', $row['number']);
      $xtpl->assign('number2', $item['number']);
      $xtpl->parse('main.row');
    }
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
