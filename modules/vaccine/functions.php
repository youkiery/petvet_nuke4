<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 10/03/2010 10:51
 */

if (!defined('NV_SYSTEM')) {
    die('Stop!!!');
}

define('NV_IS_MOD_QUANLY', true); 
require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';
$permist = array("main" => "1, 16, 18", "list" => "1, 16, 18", "sieuam" => "1, 16, 19", "danhsachsieuam" => "1, 16, 19", "sieuam-birth" => "1, 16, 19", "luubenh" => "1, 16, 21", "danhsachluubenh" => "1, 16, 21", "spa" => "1, 16, 20", "drug" => "1, 16, 21", "process" => "1, 16, 18, 19, 20, 21, 22");

// kiểm tra phân quyền
function permist() {
  global $db_config, $user_info, $db, $op, $permist;
  // init
  $check = 0;

  if (empty($permist[$op])) {
    $key = "main";
  }
  else {
    $key = $op;
  }

  if (empty($user_info)) {
    $check = true;
  }
  else {
    $sql = "select * from `" . $db_config['prefix'] . "_users_groups_users` where userid = $user_info[userid] and group_id in ($permist[$key])";
    $query = $db->query($sql);
    $row = $query->fetch();
    if (empty($row)) {
      $check = true;
    }
  }

  if ($check) {
    $contents = "Tài khoản này không có đủ quyền truy cập, hãy liên hệ với nhà quản lý hoặc email petcoffee@gmail.com để được hỗ trợ";
    
    include (NV_ROOTDIR . "/includes/header.php");
    echo nv_site_theme();
    include (NV_ROOTDIR . "/includes/footer.php");
    die();
  }
  else {
    $sql = "select * from `" . $db_config['prefix'] . "_users_groups_users` where userid = $user_info[userid] and group_id in (1)";
    $query = $db->query($sql);
    $row = $query->fetch();
    if (empty($row)) {
      if ($now < $from || $now > $end) {
        $check = true;
      }
    }
    if ($check) {
      $today = strtotime(date("Y-m-d"));
      $now = time();
      $check = false;
      $hour_from = $vacconfigv2["hour_from"];
      $hour_end = $vacconfigv2["hour_end"];
      $minute_from = $vacconfigv2["minute_from"];
      $minute_end = $vacconfigv2["minute_end"];
      $worktime = 6 * 60 * 60;    
      $resttime = 17 * 60 * 60 + 30 * 60;
      if (!empty($hour_from)) {
        $worktime = $hour_from * 60 * 60 + $minute_from * 60;
      }
      if (!empty($hour_end)) {
        $resttime = $hour_end * 60 * 60 + $minute_end * 60;
      }
      $from = $today + $worktime;
      $end = $today + $resttime;

      $contents = "Đã quá giờ làm việc, xin hãy quay lại sau";
      include ( NV_ROOTDIR . "/includes/header.php" );
      echo nv_site_theme($contents);
      include ( NV_ROOTDIR . "/includes/footer.php" );
      die();
    }
  }
}

permist();

