<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('PREFIX')) {
  die('Stop!!!');
}

function preCheckUser() {
  global $db, $db_config, $user_info;
  $check = false;

  if ($user_info && $user_info["userid"]) {
    $sql = "select * from `" . $db_config["prefix"] . "_rider_user` where type = 1 and user_id = $user_info[userid]";
    $query = $db->query($sql);
    if (empty($row = $query->fetch())) {
      $check = true;
    }
  }
  else {
    $check = true;
  }
  if ($check) {
    $contents = "Bạn chưa đăng nhập hoặc tài khoản không có quyền truy cập";
    include ( NV_ROOTDIR . "/includes/header.php" );
    echo nv_site_theme($contents);
    include ( NV_ROOTDIR . "/includes/footer.php" );
  }
}

function kaizenList($userid = 0) {
  global $db, $db_config, $user_info;

  $index = 1;
  $xtpl = new XTemplate("kaizen_list.tpl", PATH);
  $list = getRowList($userid);
  $user = getUserList();

  $xtpl->assign('cell_1', 3);
  $xtpl->assign('cell_2', 2);
  if (empty($userid)) {
    $xtpl->assign('cell_1', 2);
    $xtpl->assign('cell_2', 1);
  }

  if (count($list)) {
    foreach ($list as $row) {
      $xtpl->assign('index', $index++);
      $xtpl->assign('id', $row['id']);
      $xtpl->assign('user', $user[$row['userid']]['first_name']);
      $xtpl->assign('time', date('d/m/Y H:i', $row['edit_time']));
      $xtpl->assign('problem', $row['problem']);
      $xtpl->assign('solution', $row['solution']);
      $xtpl->assign('result', $row['result']);
      if (empty($userid)) {
        $xtpl->parse('main.inbox.row.admin');
      }
      $xtpl->parse('main.inbox.row');
    }
    $xtpl->parse('main.inbox');
  }
  else {
    $xtpl->parse('main.empty');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}
