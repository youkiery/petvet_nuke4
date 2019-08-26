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

define('NV_IS_ADMIN_FORM', true);
define("PATH", NV_ROOTDIR . "/modules/" . $module_file . '/template/admin/');

require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';
require NV_ROOTDIR . '/modules/' . $module_file . '/theme.php';

function remindList($filter = array('page' => 1, 'limit' => 10, 'keyword' => '', 'status' => 0, 'type' => '')) {
  global $db;

  $xtpl = new XTemplate('remind-list.tpl', PATH);

  $filter['status'] = intval($filter['status']);
  if (empty($filter['status'])) {
    $filter['status'] = '0, 1';
  }
  else {
    $filter['status'] = $filter['status'] - 1;
  }
  $xtra = '';
  if (!empty($filter['type'])) {
    $xtra .= 'and type = "'. $filter['type'] .'"';
  }

  $sql = 'select count(*) as count from `'. PREFIX .'_remind` where (name like "%'. $filter['keyword'] .'%" or type like "%'. $filter['keyword'] .'%") and visible in (' . $filter['status'] . ') ' . $xtra;
  $query = $db->query($sql);
  $count = $query->fetch()['count'];
  $xtpl->assign('nav', navList($count, $filter['page'], $filter['limit']));

  $sql = 'select * from `'. PREFIX .'_remind` where (name like "%'. $filter['keyword'] .'%" or type like "%'. $filter['keyword'] .'%") and visible in (' . $filter['status'] . ') '. $xtra .' limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;

  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('type', $row['type']);
    $xtpl->assign('rate', $row['rate']);
    if ($row['visible']) {
      $xtpl->parse('main.row.no');
    }
    else {
      $xtpl->parse('main.row.yes');
    }

    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function centerList($filter = array('page' => 1, 'limit' => 10, 'keyword' => '', 'status' => 0)) {
  global $db;

  $xtpl = new XTemplate('center-list.tpl', PATH);

  $filter['status'] = intval($filter['status']);
  if (empty($filter['status'])) {
    $filter['status'] = '0, 1';
  }
  else {
    $filter['status'] = $filter['status'] - 1;
  }

  $sql = 'select count(*) as count from `'. PREFIX .'_user` where (fullname like "%'. $filter['keyword'] .'%") and center in (' . $filter['status'] . ')';
  $query = $db->query($sql);
  $count = $query->fetch()['count'];
  $xtpl->assign('nav', navList($count, $filter['page'], $filter['limit']));

  $sql = 'select * from `'. PREFIX .'_user` where (fullname like "%'. $filter['keyword'] .'%") and center in (' . $filter['status'] . ') limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;

  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('fullname', $row['fullname']);
    $xtpl->assign('mobile', $row['mobile']);
    $xtpl->assign('address', $row['address']);
    $xtpl->assign('politic', $row['politic']);

    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function requestList($filter = array('keyword' => '', 'page' => 1, 'limit' => 10, 'status' => 0)) {
  global $db, $request_array;

  $time = time();
  if (empty($filter['atime'])) {    
    $filter['atime'] = date('d/m/Y', $time - 60 * 60 * 24 * 30);
  }
  if (empty($filter['ztime'])) {    
    $filter['atime'] = date('d/m/Y', $time);
  }
  $filter['atime'] = totime($filter['atime']);
  $filter['ztime'] = totime($filter['ztime']);

  $xtpl = new XTemplate('request-list.tpl', PATH);
  // die(PATH);

  $filter['status'] = intval($filter['status']);
  if (empty($filter['status'])) {
    $filter['status'] = '0, 1, 2';
  }
  else {
    $filter['status'] = $filter['status'] - 1;
  }

  $sql = 'select count(*) as count from `'. PREFIX .'_request` a inner join `'. PREFIX .'_pet` b on a.petid = b.id inner join `'. PREFIX .'_user` c on b.userid = c.id where (b.name like "%'. $filter['keyword'] .'%" or c.fullname like "%'. $filter['keyword'] .'%") and a.status in (' . $filter['status'] . ')';
  $query = $db->query($sql);
  $count = $query->fetch()['count'];
  $xtpl->assign('nav', navList($count, $filter['page'], $filter['limit']));

  $sql = 'select a.*, b.name, c.fullname, c.mobile, c.address from `'. PREFIX .'_request` a inner join `'. PREFIX .'_pet` b on a.petid = b.id inner join `'. PREFIX .'_user` c on b.userid = c.id  where (b.name like "%'. $filter['keyword'] .'%" or c.fullname like "%'. $filter['keyword'] .'%") and a.status in (' . $filter['status'] . ') limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;

  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    // if ($row['type'] == 2) {
    //   $sql = 'select * from `'. PREFIX .'_remind` where type = "request" and id = ' . $row['value'];
    // }
    // else {
    //   $sql = 'select * from `'. PREFIX .'_remind` where type = "request" and xid = ' . $row['value'];
    // }
    $sql = 'select * from `'. PREFIX .'_remind` where type = "request" and id = ' . $row['value'];

    // die($sql);
    $query2 = $db->query($sql);
    $remind = $query2->fetch();

    $xtpl->assign('id', $row['id']);
    $xtpl->assign('pet', $row['name']);
    $xtpl->assign('owner', $row['fullname']);
    $xtpl->assign('mobile', $row['mobile']);
    $xtpl->assign('address', $row['address']);
    $xtpl->assign('type', $remind['name']);
    switch ($row['status']) {
      case 0:
        $xtpl->assign('color', 'red');
      break;
      case 1:
        $xtpl->assign('color', '');
        $xtpl->parse('main.row.tick');
      break;
      case 2:
        $xtpl->assign('color', 'green');
      break;
      default:
        $xtpl->assign('color', '');
    }

    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function userRowList($filter = array('keyword' => '', 'status' => 0, 'page' => 1, 'limit' => 10)) {
  global $db, $user_info;

  $xtpl = new XTemplate('user-list.tpl', PATH);
  $sql = 'select count(*) as count from `'. PREFIX .'_user` where fullname like "%'. $filter['keyword'] .'%"' . ($filter['status'] > 0 ? ' and active = ' . ($filter['status'] - 1) : '');
  $query = $db->query($sql);
  $count = $query->fetch()['count'];
  $xtpl->assign('nav', navList($count, $filter['page'], $filter['limit']));

  $sql = 'select * from `'. PREFIX .'_user` where fullname like "%'. $filter['keyword'] .'%"' . ($filter['status'] > 0 ? ' and active = ' . ($filter['status'] - 1) : '') . ' limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  // die($sql);
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;

  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index ++);
    $xtpl->assign('fullname', $row['fullname'] ++);
    $xtpl->assign('address', $row['address']);
    $xtpl->assign('mobile', $row['mobile']);
    $xtpl->assign('id', $row['id']);

    if ($row['active']) {
      $xtpl->parse('main.row.uncheck');
    }
    else {
      $xtpl->parse('main.row.check');
    }
    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function getUserInfo($userid) {
  global $db;

  $sql = 'select * from `'. PREFIX .'_user` where id = ' . $userid;
  $query = $db->query($sql);

  return $query->fetch();
}

function userDogRow($filter = array('keyword' => '', 'status' => 0, 'page' => 1, 'limit' => 10)) {
  global $db, $user_info;
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  $xtpl = new XTemplate('pet-list.tpl', PATH);

  $sql = 'select count(*) as count from `'. PREFIX .'_pet` where name like "%'. $filter['keyword'] .'%"' . ($filter['status'] > 0 ? ' and active = ' . ($filter['status'] - 1) : '');
  $query = $db->query($sql);
  $count = $query->fetch()['count'];
  $xtpl->assign('nav', navList($count, $filter['page'], $filter['limit']));

  $sql = 'select * from `'. PREFIX .'_pet` where name like "%'. $filter['keyword'] .'%"' . ($filter['status'] > 0 ? ' and active = ' . ($filter['status'] - 1) : '') . ' limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);

  // $data = getUserPetList($filter);

  while ($row = $query->fetch()) {
    $owner = getUserInfo($row['userid']);
    $xtpl->assign('index', $index++);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('owner', $owner['fullname']);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('microchip', $row['microchip']);
    $xtpl->assign('breed', $row['breed']);
    $xtpl->assign('sex', $row['sex']);
    $xtpl->assign('dob', cdate($row['dateofbirth']));
    if ($row['active']) {
      $xtpl->parse('main.row.uncheck');
    }
    else {
      $xtpl->parse('main.row.check');
    }
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function getUserPetList($filter, $limit) {
  global $db;

  $list = array();
  $sql = 'select * from `'. PREFIX .'_pet` where name like "%'. $filter['keyword'] .'%"' . ($filter['status'] > 0 ? ' and active = ' . ($filter['status'] - 1) : '') . ' limit ' . $limit['limit'] . ' offset ' . ($limit['page'] - 1) * $limit['limit'];
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $list[] = $row;
  }

  return $list;
}
