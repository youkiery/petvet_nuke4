<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (! defined('NV_ADMIN') or ! defined('NV_MAINFILE') or ! defined('NV_IS_MODADMIN')) {
  die('Stop!!!');
}

define('NV_IS_ADMIN_DAILY', true);
define("PATH", NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file);
define("PATH2", NV_ROOTDIR . "/modules/" . $module_file . '/template/admin/' . $op);

require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';
require NV_ROOTDIR . '/modules/' . $module_file . '/theme.php';

// function penetyList($filter = array('page' => 1, 'limit' => 10, 'date' => '')) {
function penetyList($filter = array('page' => 1, 'limit' => 10, 'from' => '', 'end' => '')) {
  global $db, $db_config;

  // if (empty($filter['date'])) $filter['date'] = date('d/m/Y');
  // $filter['date'] = totime($filter['date']);

  // $filter['from'] = date ('N', $filter['date']) == 1 ? strtotime(date('Y/m/d', $filter['date'])) : strtotime ('last monday', $filter['date']);
  // $filter['end'] = date('N', $filter['date']) == 7 ? strtotime(date('Y/m/d', $filter['date'])) : strtotime ('next sunday', $filter['date']);
  $check = 0;
  if (empty($filter['from'])) $check += 1;
  if (empty($filter['end'])) $check += 2;
  $xtra = '';

  switch ($check) {
    case 0:
      $filter['from'] = totime($filter['from']) + 60 * 60 * 24 - 1;
      $filter['end'] = totime($filter['end']);
      $xtra .= ' where time between ' . $filter['from'] . ' and '. $filter['end'];
      break;
    case 1:
      $filter['from'] = totime($filter['from']) + 60 * 60 * 24 - 1;
      $xtra .= ' where time <= ' . $filter['end'];
      break;
    case 2:
      $filter['from'] = totime($filter['from']);
      $xtra .= ' where time >= ' . $filter['from'];
      break;
  }

  $xtpl = new XTemplate("penety-list.tpl", PATH);

  $sql = 'select count(*) as count from `'. PREFIX .'_penety`'. $xtra;
  $query = $db->query($sql);
  $count = $query->fetch()['count'];
  $xtpl->assign('nav', navList($count, $filter['page'], $filter['limit'], 'goPage'));

  $sql = 'select a.*, b.first_name from `'. PREFIX .'_penety` a inner join `'. $db_config['prefix'] .'_users` b on a.userid = b.userid '. $xtra .' limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;

  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index ++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('user', $row['first_name']);
    $xtpl->assign('time', date('d/m/Y', $row['time']));
    $xtpl->assign('type', 'Buổi sáng');
    if ($row['type'] == 3) {
      $xtpl->assign('type', 'Buổi chiều');
    }
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function memberuserList() {
  global $db, $nv_Request, $db_config;

  $xtpl = new XTemplate("member-list.tpl", PATH2);
  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['limit'])) $filter['limit'] = 10;
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  $query = $db->query('select count(*) as number from `'. PREFIX .'_user`');
  
  $number = $query->fetch()['number'];
  // die('select a.userid, a.level, a.depart, b.username, b.first_name from `'. PREFIX .'devicon` a inner join `'. $db_config['prefix'] .'users` b on a.userid = b.userid order by a.id desc');
  $query = $db->query('select a.*, b.username, b.first_name, b.last_name from `'. PREFIX .'_user` a inner join `'. $db_config['prefix'] .'_users` b on a.userid = b.userid order by a.id desc');

  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('userid', $row['userid']);
    $xtpl->assign('name', $row['last_name'] . ' ' . $row['first_name']);
    $xtpl->assign('username', $row['username']);
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function memberFilter() {
  global $db, $nv_Request, $db_config;

  $xtpl = new XTemplate("member-modal-list.tpl", PATH2);
  $filter = $nv_Request->get_array('memfilter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['limit'])) $filter['limit'] = 10;
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  $query = $db->query('select count(*) as number from `'. $db_config['prefix'] .'_users` where (username like "%'. $filter['keyword'] .'%" or first_name like "%'. $filter['keyword'] .'%" or last_name like "%'. $filter['keyword'] .'%") and userid not in (select userid from `'. PREFIX .'_user`)');
  
  $number = $query->fetch()['number'];
  // die('select userid, username, first_name, last_name from `'. $db_config['prefix'] .'_users` where (first_name like "%'. $filter['keyword'] .'%" or last_name like "%'. $filter['keyword'] .'%") and userid not in (select userid from `'. PREFIX .'devicon`) order by first_name');
  $sql = 'select userid, username, first_name, last_name from `'. $db_config['prefix'] .'_users` where (username like "%'. $filter['keyword'] .'%" or first_name like "%'. $filter['keyword'] .'%" or last_name like "%'. $filter['keyword'] .'%") and userid not in (select userid from `'. PREFIX .'_user`) order by first_name limit '. $filter['limit'] .' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['userid']);
    $xtpl->assign('username', $row['username']);
    $xtpl->assign('name', $row['last_name'] . ' ' . $row['first_name']);
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goMemPage'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function userModal() {
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $xtpl->parse('main');
  return $xtpl->text();
}

function managerModal() {
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $xtpl->parse('main');
  return $xtpl->text();
}

function loadModal($name) {
  $xtpl = new XTemplate($name . ".tpl", PATH2);
  $xtpl->parse('main');
  return $xtpl->text();
}

function memberEditModal() {
  $xtpl = new XTemplate("member-edit-modal.tpl", PATH2);
  $depart = getDepartList();
  foreach ($depart as $data) {
    $xtpl->assign('id', $data['id']);
    $xtpl->assign('name', $data['name']);
    $xtpl->parse('main.depart');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}
