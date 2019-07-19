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

function checkLogin($username, $password) {
  global $db;

  $sql = 'select * from ' . PREFIX . '_user where username = "' . $username . '" and password = "' . md5($password) . '"';
  $query = $db->query($sql);
  
  if (!empty($query->fetch())) {
    return 1;
  }
  return 0;
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

function getUserPetList($userid, $filter) {
  global $db;

  $list = array();
  $sql = 'select * from `'. PREFIX .'_pet` where userid = ' . $userid . ' and name like "%'. $filter['keyword'] .'%"' . ($filter['status'] > 0 ? ' and active = ' . ($filter['status'] - 1) : '');
  // die($sql);
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $list[] = $row;
  }

  return $list;
}
