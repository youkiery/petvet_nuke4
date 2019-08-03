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
define("PATH", NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file);

require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';
require NV_ROOTDIR . '/modules/' . $module_file . '/theme.php';

function getNotAllow($key = '') {
  global $db, $db_config;

  $sql = 'select * from `'. $db_config['prefix'] .'_users` where first_name like "%'.$key.'%" and userid not in (select userid from `'. $db_config['prefix'] .'_user_allow` where module = '. PERMISSION_MODULE . ') limit 10';
  $query = $db->query($sql);

  $list = array();
  while ($row = $query->fetch()) {
    $list[] = $row;
  }
  return $list;
}

function getAllowUser($key = '') {
  global $db, $db_config;

  $sql = 'select a.*, b.type, b.former, b.admin from `'. $db_config['prefix'] .'_users` a inner join `'. $db_config['prefix'] .'_user_allow` b on a.userid = b.userid where a.first_name like "%'. $key .'%" and module = ' . PERMISSION_MODULE . ' order by type desc';
  $query = $db->query($sql);

  $list = array();
  while ($row = $query->fetch()) {
    $list[] = $row;
  }
  return $list;
}

function checkEmptyPemission($userid) {
  global $db, $db_config;

  $sql = 'select * from `'. $db_config['prefix'] .'_user_allow` where userid = ' . $userid . ' and module = ' . PERMISSION_MODULE;
  $query = $db->query($sql);

  if (!empty($query->fetch())) {
    return false;
  }
  return true;
}

function checkUserPermission($userid) {
  global $db, $db_config;

  $sql = 'select * from `'. $db_config['prefix'] .'_user_allow` where userid = ' . $userid . ' and module = ' . PERMISSION_MODULE;
  $query = $db->query($sql);

  if (!empty($row = $query->fetch())) {
    return $row['id'];
  }
  return 0;
}
