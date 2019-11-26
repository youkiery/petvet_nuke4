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

define('NV_IS_DAILY', true); 
define("PATH", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_name);
define("PATH2", NV_ROOTDIR . "/modules/" . $module_file . '/template/user/' . $op);

require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';

$sql = "select * from `" . $db_config['prefix'] . "_test_configv2`";
$query = $db->query($sql);
$vacconfigv2 = array();
while ($row = $query->fetch()) {
  $vacconfigv2[$row["name"]] = $row["value"];
}

$check = false;
if (!empty($user_info) && !empty($user_info['userid'])) {
  // if (!(in_array('1', $user_info['in_groups']) || in_array('2', $user_info['in_groups']))) {
  //   $today = strtotime(date('Y/m/d'));
  //   $time = time();
  //   $fromTime = $today + $vacconfigv2['hour_from'] * 60 * 60 + $vacconfigv2['minute_from'] * 60;
  //   $endTime = $today + $vacconfigv2['hour_end'] * 60 * 60 + $vacconfigv2['minute_end'] * 60;
  
  //   if ($time < $fromTime || $time > $endTime) {
  //     $check = true;
  //     $contents = '<p style="padding: 10px;">Đã quá thời gian làm việc, xin vui lòng quay lại sau</p>';
  //   }
  // } 
} 
else {
  $check = true;
  $contents = '<p style="padding: 10px;">Chỉ có thành viên được phân quyền mới có thể thấy được mục này</p>';
}

function calTable($time, $data, $user) {
  global $db;

  $datetime = array(0 => 'Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'CN');
  $i = 0;
  $j = 0;
  $list = array(0 => array(), array(), array(), array(), array(), array(), array());
  $length = count($data);
  $xtpl = new XTemplate("cal-table.tpl", PATH2);

  foreach ($data as $key => $row) {
    $list[$row['time']][$row['type']][]= $user[$row['user_id']];
  }

  foreach ($list as $i => $day) {
    $xtpl->assign('date', date('d/m/Y', $time + 60 * 60 * 24 * $i));
    $xtpl->assign('day', $datetime[$i]);
    $xtpl->assign('datetime', $i);
    foreach ($day as $court => $row) {
      $xtpl->assign('p' . $court, implode(', ', $row));
    }
    $xtpl->parse('main.row');
  }
  
  $xtpl->parse('main');
  return $xtpl->text();
}

function notifyModal() {
  $xtpl = new XTemplate("notify-modal.tpl", PATH2);
  $xtpl->parse('main');
  return $xtpl->text();
}

if ($check) {
  include ( NV_ROOTDIR . "/includes/header.php" );
  echo nv_site_theme($contents);
  include ( NV_ROOTDIR . "/includes/footer.php" );
  die();
}
