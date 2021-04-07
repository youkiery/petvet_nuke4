<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_RIDER')) {
	die('Stop!!!');
}

$page_title = "Quản lý thu chi xe bệnh viện";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
    case 'get-customer':
      $keyword = $nv_Request->get_string('keyword', 'post', '');

      $sql = 'select * from `pet_test_customer` where name like "%'. $keyword .'%" order by name limit 20';
      $query = $db->query($sql);

      $html = '';
      while ($row = $query->fetch()) {
        $html .= '<div class="suggest-item" onclick="selectCustomer('. $row['id'] .', \''. $row['name'] .'\', \''. $row['phone'] .'\')">'. $row['name'] .' <br> '. $row['phone'] .' </div>';
      }

      $result['status'] = 1;
      $result['html'] = $html;
    break;
    case 'get-destination':
      $keyword = $nv_Request->get_string('keyword', 'post', '');

      $sql = 'select * from `pet_rider_remind` where `key` like "%'. $keyword .'%" order by `key` limit 20';
      $query = $db->query($sql);

      $html = '';
      while ($row = $query->fetch()) {
        $html .= '<div class="suggest-item" onclick="selectDestination('. $row['id'] .', \''. $row['key'] .'\')">'. $row['key'] .'</div>';
      }

      $result['status'] = 1;
      $result['html'] = $html;
    break;
    case 'remove':
      $startDate = $nv_Request->get_string("startDate", "get/post", "");
      $endDate = $nv_Request->get_string("endDate", "get/post", "");
      $id = $nv_Request->get_string("id", "get/post", "");
      $type = $nv_Request->get_string("type", "get/post", "");

      if (!(empty($startDate) || empty($endDate) || empty($id) || empty($type))) {
        $sql = 'delete from `'. PREFIX .'_row` where id = ' . $id;
        if ($db->query($sql)) {
          $result["status"] = 1;
          $result["notify"] = "Đã xóa bản ghi";
          if ($type == 2) {
            $result["html"] = payList($startDate, $endDate);
          }
          else {
            $result["html"] = collectList($startDate, $endDate);
          }
        }
      }

    case 'collect-insert':
      $startDate = $nv_Request->get_string("startDate", "get/post", "");
      $endDate = $nv_Request->get_string("endDate", "get/post", "");
      $collectDriver = $nv_Request->get_int("collectDriver", "get/post", 0);
      $collectDoctor = $nv_Request->get_int("collectDoctor", "get/post", 0);
      $collectCustomer = $nv_Request->get_int("collectCustomer", "get/post", 0);
      $collectStart = $nv_Request->get_string("collectStart", "get/post", "");
      $collectEnd = $nv_Request->get_string("collectEnd", "get/post", "");
      $collectNote = $nv_Request->get_string("collectNote", "get/post", "");
      $collectDestination = $nv_Request->get_string("collectDestination", "get/post", "");
      $price = $nv_Request->get_int("collectPrice", "get/post", 0);

      if (!(empty($startDate) || empty($endDate) || empty($collectDriver) || empty($collectDoctor) || empty($collectStart) || empty($collectEnd))) {
        if (!checkUser($collectDriver)) {
          $result["notify"] = "Người lái xe không tồn tại";
        }
        else if (!checkUser($collectDoctor)) {
          $result["notify"] = "Bác sĩ không tồn tại";
        }
        else {
          if (checkCustomer($collectCustomer)) {
            $collectCustomer = 0;
          }
          $sql = "insert into `" . PREFIX . "_row` (type, driver_id, doctor_id, customer_id, amount, clock_from, clock_to, price, destination, note, time) values (0, $collectDriver, $collectDoctor, $collectCustomer, 0, $collectStart, $collectEnd, '$price', '$collectDestination', '$collectNote', " . time() . ")";
          if ($db->query($sql)) {
            checkinRemind($collectDestination);
            checkinClock($collectEnd);
            $result["status"] = 1;
            $result["html"] = collectList($startDate, $endDate);
            $result["notify"] = "Đã thêm lịch trình thành công";
          }
        }
      }
    break;
    case 'pay-insert':
      $startDate = $nv_Request->get_string("startDate", "get/post", "");
      $endDate = $nv_Request->get_int("endDate", "get/post", 0);
      $payDriver = $nv_Request->get_int("payDriver", "get/post", 0);
      $payMoney = $nv_Request->get_int("payMoney", "get/post", 0);
      $payNote = $nv_Request->get_string("payNote", "get/post", "");

      if (!(empty($startDate) || empty($payDriver) || empty($payMoney))) {
        if (!checkUser($payDriver)) {
          $result["notify"] = "Người lái xe không tồn tại";
        }
        else {
          $sql = "insert into `" . PREFIX . "_row` (type, driver_id, doctor_id, customer_id, amount, clock_from, clock_to, destination, note, time) values (1, $payDriver, 0, 0, $payMoney, 0, 0, '', '$payNote', " . time() . ")";
          if ($db->query($sql)) {
            $result["status"] = 1;
            $result["html"] = payList($startDate, $endDate);
            $result["notify"] = "Đã thêm phiếu chi thành công";
          }
        }
      }
    break;
    case 'filter_data':
      $type = $nv_Request->get_int("type", "get/post", 0);
      $startDate = $nv_Request->get_string("startDate", "get/post", "");
      $endDate = $nv_Request->get_string("endDate", "get/post", "");
      
      if ($type) {
        $result["html"] = payList($startDate, $endDate);
      }
      else {
        $result["html"] = collectList($startDate, $endDate);
      }
      $result["status"] = 1;
    break;
    case 'statistic':
      $filter = $nv_Request->get_array('filter', 'post');

      $result['status'] = 1;
      $result['html'] = riderStatistic($filter);
    break;
	}

	echo json_encode($result);
	die();
}

$today = date("d/m/Y");
$tomorrow = date("d/m/Y", mktime(0, 0, 0, date("m"), date("d") + 1, date("Y")));
$date_option = array(1 => "Hôm nay", "Tuần này", "Tháng này", "Tháng trước", "Năm nay", "Năm trước", "Toàn bộ");

$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
$xtpl->assign("data", "{}");
$xtpl->assign("today", $today);
$xtpl->assign("tomorrow", $tomorrow);

$sql = "select * from `" . PREFIX . "_config` where user_id = 0 and name = 'clock'";
$query = $db->query($sql);
$clock = $query->fetch();
if (!$clock) {
  $clock = 0;
}

$xtpl->assign("clock", $clock["value"] . '.0');

$sql = "select userid, username, first_name, last_name from `" . $db_config["prefix"] . "_users`";
$query = $db->query($sql);
$user = array();

while($row = $query->fetch()) {
  $user[$row["userid"]] = $row;
}

$sql = "select * from `" . PREFIX . "_user` where type = 0";
$query = $db->query($sql);

while ($row = $query->fetch()) {
  $xtpl->assign("driver_id", $user[$row["user_id"]]["userid"]);
  $xtpl->assign("driver_name", $user[$row["user_id"]]["last_name"] . " " . $user[$row["user_id"]]["first_name"]);
  $xtpl->parse("main.collect_driver");
  $xtpl->parse("main.pay_driver");
}

foreach ($date_option as $date_value => $date_name) {
  $xtpl->assign("date_name", $date_name);
  $xtpl->assign("date_value", $date_value);
  $xtpl->parse("main.date_option");
}

$xtpl->assign("page", 1);
$xtpl->assign("limit", 10);
$xtpl->assign("content", collectList($today, $tomorrow));
$xtpl->assign("modal", riderModal());

$xtpl->assign('rider', $user_info['userid']);

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

