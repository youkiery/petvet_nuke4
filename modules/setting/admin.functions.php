<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 12/31/2009 2:29
 */

if (! defined('NV_ADMIN') or ! defined('NV_MAINFILE') or ! defined('NV_IS_MODADMIN')) {
    die('Stop!!!');
}

include_once(NV_ROOTDIR . "/modules/". $module_file ."/global.functions.php");

define('NV_IS_ADMIN_MODULE', true);
define('PATH', NV_ROOTDIR . "/modules/". $module_file ."/template/admin/". $op);

function checkUserById($id) {
  global $db;

  $sql = 'select * from `pet_users` where userid = '. $id;
  $query = $db->query($sql);

  if (!empty($row = $query->fetch())) return $row;
  return false;
}

function modal() {
  global $db, $id, $module;
  $xtpl = new XTemplate("modal.tpl", PATH);

  $index = 1;
  foreach ($module as $key => $name) {
    $sql = 'select * from `pet_setting_config_module` where branchid = "'. $id .'" and module="'. $key .'"';
    $query = $db->query($sql);
    $config = $query->fetch();

    $start = '0-0';
    $end = '0-0';
    if (!empty($config)) {
      $start = $config['start'];
      $end = $config['end'];
    }
    $start = explode('-', $start);
    $end = explode('-', $end);
    if (count($start) < 2) $start = array('', '');
    if (count($end) < 2) $end = array('', '');

    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $key);
    $xtpl->assign('start0', $start[0]);
    $xtpl->assign('start1', $start[1]);
    $xtpl->assign('end0', $end[0]);
    $xtpl->assign('end1', $end[1]);
    $xtpl->assign('module', $name);
    $xtpl->parse('main.module');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function mainBranchContent() {
  global $db;

  $xtpl = new XTemplate("branch-list.tpl", PATH);
  $sql = 'select * from `pet_setting_branch`';
  $query = $db->query($sql);
  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('prefix', $row['prefix']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function mainUserContent($id) {
  global $db;

  $xtpl = new XTemplate("user-list.tpl", PATH);
  $sql = 'select * from `pet_setting_user` where branch = '. $id;
  $query = $db->query($sql);
  $index = 1;
  while ($row = $query->fetch()) {
    if (!empty($user = checkUserById($row['userid']))) {
      // var_dump($user);die();
      $xtpl->assign('index', $index ++);
      $xtpl->assign('id', $row['userid']);
      $xtpl->assign('username', $user['username']);
      $xtpl->assign('fullname', (!empty($user['last_name']) ? $user['last_name'] . ' ': '') . $user['first_name']);

      $xtpl->parse('main.row');
    }
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function mainUserSuggest() {
  global $keyword, $db;

  $sql = 'select userid, username, first_name, last_name from `pet_users` where userid not in (select userid from `pet_setting_user`) and (username like "%'. $keyword .'%" or first_name like "%'. $keyword .'%" or last_name like "%'. $keyword .'%")  limit 20';
  $query = $db->query($sql);
  $html = '';
  while ($row = $query->fetch()) {
    $html .= '
      <div class="suggest_item" onclick="insertUserSubmit('. $row['userid'] .')">
        '. $row['last_name'] .' '. $row['first_name'] .'
      </div>
    ';
  }
  return $html;
}

function mainUserModal($keyword) {
  global $db;

  $list = array();
  $sql = 'select * from `pet_setting_user` group by userid';
  $query = $db->query($sql);
  while ($row = $query->fetch()) {
    $list []= $row['userid'];
  }

  $xtpl = new XTemplate("user-list-modal.tpl", PATH);
  $sql = 'select * from `pet_users` where userid not in ('. implode(', ', $list) .') and (last_name like "%'. $keyword .'%" or first_name like "%'. $keyword .'%" or username like "%'. $keyword .'%")';
  $query = $db->query($sql);
  $index = 1;
  while ($row = $query->fetch()) {
    if (!empty($user = checkUserById($row['userid']))) {
      $xtpl->assign('index', $index ++);
      $xtpl->assign('id', $row['userid']);
      $xtpl->assign('username', $row['username']);
      $xtpl->assign('fullname', (!empty($row['last_name']) ? $row['last_name'] . ' ': '') . $row['first_name']);

      $xtpl->parse('main.row');
    }
  }
  $xtpl->parse('main');
  return $xtpl->text();
}
