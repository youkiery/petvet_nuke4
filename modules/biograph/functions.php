<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_SYSTEM')) {
  die('Stop!!!');
}

define('NV_IS_FORM', true); 
define("PATH", 'modules/' . $module_file . '/template');

require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';

function userRowList($filter = array()) {
  global $db, $user_info;

  $xtpl = new XTemplate('user-list.tpl', PATH);
  $sql = 'select * from `'. PREFIX .'_user` where fullname like "%'. $filter['keyword'] .'%"' . ($filter['status'] > 0 ? ' and active = ' . ($filter['status'] - 1) : '');
  $query = $db->query($sql);
  $index = 1;

  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index ++);
    $xtpl->assign('fullname', $row['fullname'] ++);
    $xtpl->assign('address', $row['address']);
    $xtpl->assign('mobile', $row['mobile']);
    $xtpl->assign('id', $row['id']);

    if (!empty($user_info) && !empty($user_info['userid']) && (in_array('1', $user_info['in_groups']) || in_array('2', $user_info['in_groups']))) {

      if ($row['active']) {
        $xtpl->parse('main.row.uncheck');
      }
      else {
        $xtpl->parse('main.row.check');
      }
    }
    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function userDogRow($userid = 0, $filter = array('keyword' => '', ), $limit = array('page' => 0, 'limit' => 10)) {
  global $db, $user_info;
  $index = 1;
  $xtpl = new XTemplate('dog-list.tpl', PATH);

  $data = getUserPetList($userid, $filter, $limit);

  foreach ($data as $row) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('microchip', $row['microchip']);
    $xtpl->assign('breed', $row['breed']);
    $xtpl->assign('sex', $row['sex']);
    $xtpl->assign('dob', cdate($row['dateofbirth']));
    if (!empty($user_info) && !empty($user_info['userid']) && (in_array('1', $user_info['in_groups']) || in_array('2', $user_info['in_groups']))) {
      if ($row['active']) {
        $xtpl->parse('main.row.mod.uncheck');
      }
      else {
        $xtpl->parse('main.row.mod.check');
      }
    }
    $xtpl->parse('main.row.mod');
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function checkLogin($username, $password) {
  global $db;

  $sql = 'select * from ' . PREFIX . '_user where username = "' . $username . '" and password = "' . md5($password) . '"';
  $query = $db->query($sql);

  if (!empty($checker = $query->fetch())) {
    return $checker;
  }
  return false;
}

function getUserInfo() {
  global $db, $_SESSION;
  $data = array();

  if (!empty($_SESSION['username']) && !empty($_SESSION['password'])) {
    $username = $_SESSION['username'];
    $password = $_SESSION['password'];
    // hash split username, password
    if (checkLogin($username, $password)) {
      $sql = 'select * from `'. PREFIX .'_user` where username = "' . $username . '" and password = "' . md5($password) . '"';
      $query = $db->query($sql);
      
      if (!empty($row = $query->fetch())) {
        return $row;
      }
    }
  }

  return $data;
}

function getUserPetList($userid, $tabber, $filter) {
  global $db;

  $list = array();
  // $sql = 'select * from `'. PREFIX .'_pet` where userid = ' . $userid . ' and name like "%'. $filter['keyword'] .'%"' . ($filter['status'] > 0 ? ' and active = ' . ($filter['status'] - 1) : '' . ' and breeder in ('. implode(', ', $tabber) .')');
  $sql = 'select count(*) as count from `'. PREFIX .'_pet`  where userid = ' . $userid . ' and name like "%'. $filter['keyword'] .'%" and breeder in ('. implode(', ', $tabber) .')';
  $query = $db->query($sql);
  $count = $query->fetch();

  $sql = 'select * from `'. PREFIX .'_pet`  where userid = ' . $userid . ' and name like "%'. $filter['keyword'] .'%" and breeder in ('. implode(', ', $tabber) .') limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $list[] = $row;
  }

  return array(
    'count' => $count['count'],
    'list' => $list
  );
}
