<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES <contact@vinades.vn>
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 12/31/2009 2:29
 */

if (! defined('NV_ADMIN') or ! defined('NV_MAINFILE') or ! defined('NV_IS_MODADMIN')) {
    die('Stop!!!');
}

define( 'NV_IS_QUANLY_ADMIN', true );
define('PATH', NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file); 
define('PATH2', NV_ROOTDIR . "/modules/" . $module_file . '/template/admin/' . $op); 
require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';
require NV_ROOTDIR . '/modules/' . $module_file . '/theme.php';

function userContent() {
  global $db, $db_config;

  $xtpl = new XTemplate("list.tpl", PATH2);
  $sql = 'select * from `'. VAC_PREFIX .'_user` order by id desc';
  $query = $db->query($sql);

  $index = 1;
  while ($row = $query->fetch()) {
    $sql2 = 'select concat(last_name, " ", first_name) as fullname, username from `'. $db_config['prefix'] .'_users` where userid = ' . $row['userid'];
    $query2 = $db->query($sql2);
    $info = $query2->fetch();
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['userid']);
    $xtpl->assign('username', $info['username']);
    $xtpl->assign('fullname', $info['fullname']);
    $xtpl->assign('manager_value', intval(!$row['manager']));
    $xtpl->assign('except_value', intval(!$row['except']));
    if ($row['manager']) $xtpl->assign('btn_manager', 'btn-warning');
    else $xtpl->assign('btn_manager', 'btn-info');
    if ($row['except']) $xtpl->assign('btn_except', 'btn-warning');
    else $xtpl->assign('btn_except', 'btn-info');
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function userContentSuggest($keyword = '') {
  global $db, $db_config;

  $xtpl = new XTemplate("suggest.tpl", PATH2);
  $sql = 'select * from `'. VAC_PREFIX .'_user` order by id desc';
  $query = $db->query($sql);

  $list = array();
  while ($row = $query->fetch()) {
    $list []= $row['userid'];
  }
  if (count($list)) $list_s = implode(', ', $list);
  else $list_s = 0;
  $keyword = mb_strtolower($keyword);

  $sql = 'select userid, concat(last_name, " ", first_name) as fullname, username from `'. $db_config['prefix'] .'_users` where userid not in ('. $list_s .') and (LOWER(last_name) like "%'. $keyword .'%" or LOWER(first_name) like "%'. $keyword .'%" or LOWER(username) like "%'. $keyword .'%")';
  $query = $db->query($sql);
  $check = true;
  while ($info = $query->fetch()) {
    $check = false;
    $xtpl->assign('id', $info['userid']);
    $xtpl->assign('username', $info['username']);
    $xtpl->assign('fullname', $info['fullname']);
    $xtpl->parse('main.row');
  }
  if ($check) $xtpl->parse('main.no');
  $xtpl->parse('main');
  return $xtpl->text();
}

function admin_schedule() {
  global $db, $global_config, $module_file, $lang_module, $db_config;
  $xtpl = new XTemplate("schedule-list.tpl", NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file);
  $xtpl->assign("lang", $lang_module);
  $today = strtotime(date("Y-m-d"));

  $sql = "select * from `" . VAC_PREFIX . "_schedule` where time >= $today order by time";
  $query = $db->query($sql);
  while ($schedule = $query->fetch()) {
    $sql = "select * from `" . $db_config["prefix"] . "_users` where userid = $schedule[userid]";
    $user_query = $db->query($sql);
    $user = $user_query->fetch();

    $xtpl->assign("id", $schedule["id"]);
    $xtpl->assign("user", $user["first_name"]);
    $xtpl->assign("restday", date("d/m/Y", $schedule["time"]));
    $xtpl->parse("main");
  }

  return $xtpl->text();
}

function settingModal() {
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $xtpl->parse('main');
  return $xtpl->text();
}

function settingContent() {
  global $db, $db_config, $filter;

  $xtpl = new XTemplate("list.tpl", PATH2);
  $index = 1;
  $array = array(2, 1);
  foreach ($array as $value) {
    $xtpl->assign('typeid', $value);
    $sql = 'select userid, username, concat(last_name, " ", first_name) as fullname from `'. $db_config['prefix'] .'_users` where userid in (select userid from `'. VAC_PREFIX .'_setting` where module = "'. $filter['type'] .'" and type = '. $value .') order by fullname';
    $query = $db->query($sql);
    if ($value > 1) {
      $xtpl->assign('typeid', 1);
      $xtpl->assign('type', 'btn-warning');
    }
    else {
      $xtpl->assign('typeid', 2);
      $xtpl->assign('type', 'btn-info');
    }
  
    while ($row = $query->fetch()) {
      $xtpl->assign('index', $index++);
      $xtpl->assign('id', $row['userid']);
      $xtpl->assign('username', $row['username']);
      $xtpl->assign('fullname', $row['fullname']);
      $xtpl->parse('main.row');
    }
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function employContentId($id, $name) {
  global $db, $db_config, $filter;
  $xtpl = new XTemplate("employ-list.tpl", PATH2);
  $sql = 'select userid, username, concat(last_name, " ", first_name) as fullname from `'. $db_config['prefix'] .'_users` where (last_name like "%'. $name .'%" or first_name like "%'. $name .'%" or username like "%'. $name .'%") and userid not in (select userid from `'. VAC_PREFIX .'_setting` where module = "'. $filter['type'] .'")';
  $query = $db->query($sql);
  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['userid']);
    $xtpl->assign('username', $row['username']);
    $xtpl->assign('fullname', $row['fullname']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function xrayModal()
{
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $xtpl->parse('main');
  return $xtpl->text();
}

function xrayUserContent()
{
  global $db, $db_config;
  $xtpl = new XTemplate("user-list.tpl", PATH2);

  $sql = 'select userid, username, concat(last_name, " ", first_name) as fullname from `' . $db_config['prefix'] . '_users` where userid in (select userid from `' . VAC_PREFIX . '_xray_user`)';
  $query = $db->query($sql);
  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['userid']);
    $xtpl->assign('username', $row['username']);
    $xtpl->assign('fullname', $row['fullname']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function xrayUserSuggest($name = "")
{
  global $db, $db_config;
  $xtpl = new XTemplate("user-suggest.tpl", PATH2);
  $name = mb_strtolower($name);
  $sql = 'select userid, username, concat(last_name, " ", first_name) as fullname from `' . $db_config['prefix'] . '_users` where (LOWER(first_name) like "%' . $name . '%" or LOWER(last_name) like "%' . $name . '%" or LOWER(username) like "%' . $name . '%") and userid not in (select userid from `' . VAC_PREFIX . '_xray_user`) limit 10';
  $query = $db->query($sql);
  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['userid']);
    $xtpl->assign('username', $row['username']);
    $xtpl->assign('fullname', $row['fullname']);
    $xtpl->parse('main');
  }
  return $xtpl->text();
}
