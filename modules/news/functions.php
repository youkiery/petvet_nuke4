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

function checkUsername($user) {
  global $db;

  $sql = 'select * from `'. PREFIX .'_user` where username = "'. $user . '"';
  $query = $db->query($sql);

  if (!empty($query->fetch())) {
    return true;
  }
  return false;
}

function getPetRequest($petid, $type = -1) {
  global $db;

  if ($type >= 0) {
    $sql = 'select * from `'. PREFIX .'_request` where petid = ' . $petid . ' and type = 1 and value = ' . $type . ' order by time';
    $query = $db->query($sql);

    if (!empty($row = $query->fetch())) {
      return $row;
    }
    return array();
  }
  $list = array();
  $sql = 'select * from `'. PREFIX .'_request` where petid = ' . $petid . ' order by time';
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $list[] = $row;
  }

  return $list;
}

function parseLink($info) {
  if (!empty($info['id'])) {
    return '<a href="/index.php?nv=biograph&op=detail&id=' . $info['id'] . '">' . $info['name'] . '</a>';
  }
  return '-';
}

function parseLink2($info) {
  if (!empty($info['id'])) {
    return '<a href="/index.php?nv=biograph&op=info&id=' . $info['id'] . '">' . $info['name'] . '</a>';
  }
  return '-';
}

function parseInfo($info) {
  $age = round( time() - $info['dateofbirth']) / 60 / 60 / 24 / 365.25;
  if ($age < 1) {
    $age = 1;
  }

  // die( - $info['dob'] . "");
  if (!empty($info['id'])) {
    return 'Tên: '. $info['name'] .'<br>Tuổi: '. $age .'<br>Giống: '. $info['species'] .'<br>Loài: '. $info['breed'] .'<br>';
  }
  return '';
}

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

function checkLogin($username, $password = '') {
  global $db;

  $sql = 'select * from ' . PREFIX . '_user where username = "' . $username . '" and password = "' . md5($password) . '"';
  $query = $db->query($sql);

  if (!empty($checker = $query->fetch())) {
    return $checker;
  }
  return false;
}

// checkMost($row, $stat) {
//   if (in_array($row['species'], $stat['species'])) {
//     if (empty($stat['species'])) {
//       $stat['species'][$row['species']] = 0;
//     }
//     $stat['species'][$row['species']] ++;
//   }

// }

// function checkUser($username) {
//   global $db;

//   $sql = 'select * from ' . PREFIX . '_user where username = "' . $username . '"';
//   die($sql);

//   if (!empty($checker = $query->fetch())) {
//     return $checker;
//   }
//   return false;
// }

function breederList($petid) {
  global $db;

  $sql = 'select * from `'. PREFIX .'_breeder` where petid = '. $petid .' order by time desc';
  $query = $db->query($sql);
  $xtpl = new XTemplate('breeder.tpl', PATH);
  $index = 1;

  while (!empty($row = $query->fetch())) {
    $pet = getPetById($row['targetid']);
    $owner = getOwnerById($pet['userid'], $pet['type']);

    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('time', date('d/m/Y', $row['time']));
    $xtpl->assign('target', $pet['name']);
    $xtpl->assign('owner', $owner['fullname']);
    $xtpl->assign('number', $row['number']);
    $xtpl->assign('note', ($row['note']));
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
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

function checkTransferRequest($id) {
  global $db;

  $sql = 'select * from `'. PREFIX .'_transfer_request` where id = ' . $id;
  $query = $db->query($sql);

  if ($row = $query->fetch()) {
    return $row;
  }
  return false;
}

function getUserPetList($userid, $tabber, $filter) {
  global $db;

  $list = array();
  $sql = 'select count(*) as count from `'. PREFIX .'_pet` where id not in ( select id from ((select mid as id from `'. PREFIX .'_pet`) union (select fid as id from `'. PREFIX .'_pet`)) as a) and userid = ' . $userid . ' and type = 1 and name like "%'. $filter['keyword'] .'%" and breeder in ('. implode(', ', $tabber) .') order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $count = $query->fetch();

  // $sql = 'select * from `'. PREFIX .'_pet` where userid = ' . $userid . ' and type = 1 and name like "%'. $filter['keyword'] .'%" and breeder in ('. implode(', ', $tabber) .') order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $sql = 'select * from `'. PREFIX .'_pet` where id not in ( select id from ((select mid as id from `'. PREFIX .'_pet`) union (select fid as id from `'. PREFIX .'_pet`)) as a) and userid = ' . $userid . ' and type = 1 and name like "%'. $filter['keyword'] .'%" and breeder in ('. implode(', ', $tabber) .') order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  // die($sql);
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $list[] = $row;
  }

  return array(
    'count' => $count['count'],
    'list' => $list
  );
}

function getParentTree($data) {
  global $db;

  $list = array();
  $papa = getPetById($data['mid']);
  $mama = getPetById($data['fid']);

  if (!empty($papa)) {
    $list[] = $papa;
  }
  if (!empty($mama)) {
    $list[] = $mama;
  }
  return $list;
}
