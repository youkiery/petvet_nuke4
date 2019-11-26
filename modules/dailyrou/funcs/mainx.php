<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */
if (!defined('NV_IS_DAILY')) {
  die('Stop!!!');
}

$page_title = "Đăng ký lịch nghỉ/trực";
preCheckUser();

$data = array();
$user = array();
$except = array();

$from = strtotime('monday this week');
$to = strtotime('sunday this week') + 60 * 60 * 24 - 1;

$query = $db->query('select * from `' . PREFIX . '_row` where (time between ' . $from . ' and ' . $to . ') order by time');
while ($row = $query->fetch()) {
  unset($row['id']);
  $row['time'] = ($row['time'] - $from) / 60 / 60 / 24;
  $data[] = $row;
}

$query = $db->query('select b.userid, b.first_name from `' . $db_config["prefix"] . '_rider_user` a inner join `' . $db_config["prefix"] . '_users` b on a.user_id = b.userid where type = 1');
while ($row = $query->fetch()) {
  $user[$row['userid']] = $row['first_name'];
}

$query = $db->query('select first_name from `' . $db_config["prefix"] . '_users` where userid in (select user_id from `' . $db_config["prefix"] . '_rider_user` where type = 1 and except = 1 and user_id <> ' . $user_info['userid'] . ')');
while ($row = $query->fetch()) {
  $except[] = $row['first_name'];
}

$query = $db->query('select * from `' . $db_config["prefix"] . '_rider_user` where user_id = ' . $user_info['userid']);
$used = $query->fetch();

$action = $nv_Request->get_string('action', 'post');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'insert-regist':
      $list = $nv_Request->get_array("list", "get/post");

      if (!count($list)) {
        $result = 'Chọn ít nhất một ngày để nghỉ';
      } else {
        foreach ($list as $item) {
          $date = totime($item["time"]);
          if ($item['color'] == 'yellow') {
            $sql = "delete from `" . PREFIX . "_row` where user_id = $user_info[userid] and (time between $date and " . ($date + A_DAY - 1) . ") and type = " . $item["type"];
            if ($db->query($sql)) {
              $sql = 'delete from `' . PREFIX . '_penety` where userid = ' . $user_info['userid'] . ' and (time between ' . $date . ' and ' . ($date + A_DAY - 1) . ') and type = ' . $item['type'];
              $db->query($sql);
            }
          } else if ($item['color'] == 'blue') {
            $sql = "insert into `" . PREFIX . "_row` (type, user_id, time) values($item[type], $user_info[userid], $date)";
            $db->query($sql);
          }
        }
      }
      $query = $db->query('select * from `' . PREFIX . '_row` where (time between ' . $from . ' and ' . $to . ') order by time');
      $data = array();
      while ($row = $query->fetch()) {
        unset($row['id']);
        $row['time'] = ($row['time'] - $from) / 60 / 60 / 24;
        $data[] = $row;
      }
      $result['status'] = 1;
      $result['notify'] = 'Đã đăng ký lịch';
      $result['json'] = $data;
      $result['html'] = calTable($from, $data, $user);
  break;
}
echo json_encode($result);
die();
}

$xtpl = new XTemplate("main.tpl", PATH2);


$xtpl->assign('userid', $user_info['userid']);
$xtpl->assign('user', json_encode($user, JSON_UNESCAPED_UNICODE));
$xtpl->assign('data', json_encode($data, JSON_UNESCAPED_UNICODE));
$xtpl->assign('except', json_encode($except, JSON_UNESCAPED_UNICODE));
$xtpl->assign('permission', ($used['permission'] ? 1 : 0));
$xtpl->assign('today', date('d/m/Y'));

$today = time();

$xtpl->assign('notify_modal', notifyModal());
$xtpl->assign('summary_modal', summaryModal());
$xtpl->assign('table', calTable($from, $data, $user));

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
