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
  global $db, $db_config, $user_info, $nv_Request;
  
  $page = $nv_Request->get_int('page', 'get/post', 0);
  $limit = $nv_Request->get_int('limit', 'get/post', 0);

  if (empty($page) || $page < 0) $page = 1;
  if (empty($limit) || $limit < 0) $limit = 10;

  $index = 1;
  $start = $limit * ($page - 1);
  $xtpl = new XTemplate("kaizen_list.tpl", PATH);
  $list = getRowList($userid, $page, $limit);
  $user = getUserList();

  $xtpl->assign('cell_1', 3);
  $xtpl->assign('cell_2', 2);
  if (empty($userid)) {
    $xtpl->assign('cell_1', 2);
    $xtpl->assign('cell_2', 1);
  }
  
  if (!empty($userid)) {
    $sql = 'select * from `'. $db_config['prefix'] .'_rider_user` where user_id = ' . $userid . ' and kaizen = 1';
    $query = $db->query($sql);
    if ($row = $query->fetch()) {
      $userid = 0;
      $xtpl->assign('cell_1', 2);
      $xtpl->assign('cell_2', 1);
    }
  }
  
  if (count($list['data'])) {
    foreach ($list['data'] as $row) {
      $xtpl->assign('index', ($start + $index++));
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

  $xtpl->assign('count', $list['count']);
  $xtpl->assign('nav', navList($list['count'], $page, $limit));

  $xtpl->parse('main');
  return $xtpl->text();
}

function navList ($number, $page, $limit) {
  global $lang_global;
  $total_pages = ceil($number / $limit);
  $on_page = $page;
  $page_string = "";
  if ($total_pages > 10) {
    $init_page_max = ($total_pages > 3) ? 3 : $total_pages;
    for ($i = 1; $i <= $init_page_max; $i ++) {
      $page_string .= ($i == $on_page) ? '<div class="btn">' . $i . "</div>" : '<button class="btn btn-info" onclick="goPage('.$i.')">' . $i . '</button>';
      if ($i < $init_page_max) $page_string .= " ";
    }
    if ($total_pages > 3) {
      if ($on_page > 1 && $on_page < $total_pages) {
        $page_string .= ($on_page > 5) ? " ... " : ", ";
        $init_page_min = ($on_page > 4) ? $on_page : 5;
        $init_page_max = ($on_page < $total_pages - 4) ? $on_page : $total_pages - 4;
        for ($i = $init_page_min - 1; $i < $init_page_max + 2; $i ++) {
          $page_string .= ($i == $on_page) ? '<div class="btn">' . $i . "</div>" : '<button class="btn btn-info" onclick="goPage('.$i.')">' . $i . '</button>';
          if ($i < $init_page_max + 1)  $page_string .= " ";
        }
        $page_string .= ($on_page < $total_pages - 4) ? " ... " : ", ";
      }
      else {
        $page_string .= " ... ";
      }
      
      for ($i = $total_pages - 2; $i < $total_pages + 1; $i ++) {
        $page_string .= ($i == $on_page) ? '<div class="btn">' . $i . "</div>" : '<button class="btn btn-info" onclick="goPage('.$i.')">' . $i . '</button>';
        if ($i < $total_pages) $page_string .= " ";
      }
    }
  }
  else {
    for ($i = 1; $i < $total_pages + 1; $i ++) {
      $page_string .= ($i == $on_page) ? '<div class="btn">' . $i . "</div>" : '<button class="btn btn-info" onclick="goPage('.$i.')">' . $i . '</button>';
      if ($i < $total_pages) $page_string .= " ";
    }
  }
  return $page_string;
}
