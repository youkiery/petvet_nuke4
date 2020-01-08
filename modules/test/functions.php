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
define('PATH', NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file); 
define('PATH2', NV_ROOTDIR . "/modules/" . $module_file . '/template/user/' . $op); 
require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';
// kiểm tra phân quyền

$opType = array('main' => 1, 'confirm' => 1, 'list' => 1, 'vac_list' => 1, 'sieuam' => 2, 'danhsachsieuam' => 2, 'sieuam-birth' => 2, 'themsieuam' => 2, 'xacnhansieuam' => 2, 'luubenh' => 3, 'danhsachluubenh' => 3, 'themluubenh' => 3, 'spa' => 4, 'redrug' => 5, 'heal' => 6, 'heal_drug' => 6);

$check = false;
if (!empty($user_info) && !empty($user_info['userid'])) {
  $sql = 'select * from `' . $db_config['prefix'] . '_users` where userid = ' . $user_info['userid'];
  $query = $db->query($sql);
  $user = $query->fetch();
  $group = explode(',', $user['in_groups']);
  if (!(in_array('1', $group) || in_array('2', $group))) {
    if ($op !== 'proces' && !empty($opType[$op])) {
      $sql = 'select * from `pet_test_heal_manager` where groupid in (' . implode(',', $user_info['in_groups']) . ') and type = ' . $opType[$op];
      $query = $db->query($sql);
  
      if (empty($query->fetch())) {
        $check = true;
        $contents = '<p style="padding: 10px;">Tài khoản chưa có quyền truy cập nội dung này</p>';
      }
      else if ($op == 'heal' || $op == 'heal_drug') {
          
      }
      else {
        $today = strtotime(date('Y/m/d'));
        $time = time();
        $fromTime = $today + $vacconfigv2['hour_from'] * 60 * 60 + $vacconfigv2['minute_from'] * 60;
        $endTime = $today + $vacconfigv2['hour_end'] * 60 * 60 + $vacconfigv2['minute_end'] * 60;

        if ($time < $fromTime || $time > $endTime) {
          $check = true;
          $contents = '<p style="padding: 10px;">Đã quá thời gian làm việc, xin vui lòng quay lại sau</p>';
        }
      }
    }
  } 
} 
else {
  $check = true;
  $contents = '<p style="padding: 10px;">Chỉ có thành viên được phân quyền mới có thể thấy được mục này</p>';
}

if ($check) {
  include ( NV_ROOTDIR . "/includes/header.php" );
  echo nv_site_theme($contents);
  include ( NV_ROOTDIR . "/includes/footer.php" );
  die();
}

function usgModal($lang_module) {
  global $sort_type, $filter_type;
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $doctor = getDoctorList();
  $xtpl->assign('lang', $lang_module);
  $xtpl->assign('now', date('d/m/Y', time()));

  $diseases = getDiseaseList();
  foreach ($diseases as $key => $value) {
    $xtpl->assign("id", $value["id"]);
    $xtpl->assign("name", $value["name"]);
    $xtpl->parse("main.disease");
    $xtpl->parse("main.disease2");
  }
  
  foreach ($doctor as $data) {
    $xtpl->assign('doctor_value', $data['id']);
    $xtpl->assign('doctor_name', $data['name']);
    $xtpl->parse('main.doctor');
    $xtpl->parse('main.doctor2');
    $xtpl->parse('main.doctor3');
    $xtpl->parse('main.doctor4');
  }

  foreach ($sort_type as $key => $sort_name) {
    $xtpl->assign("sort_name", $sort_name);
    $xtpl->assign("sort_value", $key);
    if ($key == $sort) $xtpl->assign("sort_check", "selected");
    else $xtpl->assign("sort_check", "");
    $xtpl->parse("main.sort");
  }
  
  foreach ($filter_type as $filter_value) {
    $xtpl->assign("time_value", $filter_value);
    $xtpl->assign("time_name", $filter_value);
    if ($filter_value == $filter) $xtpl->assign("time_check", "selected");
    else $xtpl->assign("time_check", "");
    $xtpl->parse("main.time");
  }

  $xtpl->parse('main');
  return $xtpl->text();
}
