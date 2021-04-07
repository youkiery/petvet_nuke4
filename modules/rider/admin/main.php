<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_ADMIN_RIDER')) {
	die('Stop!!!');
}
define('COLLECT_TYPE', 0);
define('PAY_TYPE', 1);

$page_title = "Quản lý thu chi xe bệnh viện";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'remove':
			$startDate = $nv_Request->get_string("startDate", "get/post", "");
			$endDate = $nv_Request->get_string("endDate", "get/post", "");
			$id = $nv_Request->get_string("id", "get/post", "");
			$type = $nv_Request->get_string("type", "get/post", "");

			$sql = 'select * from `' . PREFIX . '_row` where id = ' . $id;
			$query = $db->query($sql);

			if ($query->fetch()) {
				$sql = 'delete from `' . PREFIX . '_row` where id = ' . $id;
				if ($db->query($sql)) {
					$result["status"] = 1;
					$result["notify"] = "Đã xóa bản ghi";
					$result["html"] = riderList($type, $startDate, $endDate);
				}
			}
		break;
		// case 'edit':
		// 	$startDate = $nv_Request->get_string("startDate", "get/post", "");
		// 	$endDate = $nv_Request->get_string("endDate", "get/post", "");
		// 	$id = $nv_Request->get_string("id", "get/post", "");
		// 	$type = $nv_Request->get_string("type", "get/post", "");

		// 	$sql = 'select * from `' . PREFIX . '_row` where id = ' . $id;
		// 	$query = $db->query($sql);

		// 	if ($query->fetch()) {
		// 		$sql = 'delete from `' . PREFIX . '_row` where id = ' . $id;
		// 		if ($db->query($sql)) {
		// 			$result["status"] = 1;
		// 			$result["notify"] = "Đã xóa bản ghi";
		// 			$result["data"] = riderList($type, $startDate, $endDate);
		// 		}
		// 	}
		// break;
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
          $sql = "insert into `" . PREFIX . "_row` (type, driver_id, doctor_id, customer_id, amount, clock_from, clock_to, destination, note, time) values (0, $collectDriver, $collectDoctor, $collectCustomer, 0, $collectStart, $collectEnd, '$collectDestination', '$collectNote', " . time() . ")";
          // die($sql);
          if ($db->query($sql)) {
            checkinRemind($collectDestination);
            checkinClock($collectEnd);
            $result["status"] = 1;
            $result["html"] = riderList(COLLECT_TYPE, $startDate, $dateType);
            $result["notify"] = "Đã thêm lịch trình thành công";
          }
        }
      }
    break;
    case 'pay-insert':
      $startDate = $nv_Request->get_string("startDate", "get/post", "");
      $dateType = $nv_Request->get_int("dateType", "get/post", 0);
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
            $result["html"] = riderList(PAY_TYPE, $startDate, $dateType);
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
				$type = 1;
			}
			$result["html"] = riderList($type, $startDate, $endDate);
      $result["status"] = 1;
    break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file);

$today = date("d/m/Y");
$tomorrow = date("d/m/Y", mktime(0, 0, 0, date("m"), date("d") + 1, date("Y")));
$date_option = array(1 => "Hôm nay", "Tuần này", "Tháng này", "Tháng trước", "Năm nay", "Năm trước", "Toàn bộ");

$xtpl->assign("data", "{}");
$xtpl->assign("today", $today);
$xtpl->assign("tomorrow", $tomorrow);

$sql = "select * from `" . PREFIX . "_config` where user_id = 0 and name = 'clock'";
$query = $db->query($sql);
$clock = $query->fetch();
if (!$clock) {
  $clock = 0;
}

$xtpl->assign("clock", $clock["value"]);

$sql = "select * from `pet_test_customer`";
$query = $db->query($sql);
$customer = array();

while ($row = $query->fetch()) {
  $row["name"] = str_replace("'", "\'", $row["name"]);
  $customer[$row["id"]] = array("id" => $row["id"], "name" => $row["name"], "phone" => $row["phone"]);
}

$sql = "select * from `" . PREFIX . "_remind`";
$query = $db->query($sql);
$remind = array();

while ($row = $query->fetch()) {
  $remind[$row["id"]] = array("id" => $row["id"], "value" => $row["key"]);
}

$data = json_encode(array("customer" => $customer, "remind" => $remind));

$xtpl->assign("data", $data);

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

$sql = "select * from `" . PREFIX . "_user` where type = 1";
$query = $db->query($sql);

while ($row = $query->fetch()) {
  $xtpl->assign("driver_id", $user[$row["user_id"]]["userid"]);
  $xtpl->assign("driver_name", $user[$row["user_id"]]["last_name"] . " " . $user[$row["user_id"]]["first_name"]);
  $xtpl->parse("main.collect_doctor");
}

foreach ($date_option as $date_value => $date_name) {
  $xtpl->assign("date_name", $date_name);
  $xtpl->assign("date_value", $date_value);
  $xtpl->parse("main.date_option");
}

$xtpl->assign("page", 1);
$xtpl->assign("limit", 10);
$xtpl->assign("content", riderList(COLLECT_TYPE, $today, $tomorrow));
$xtpl->parse("main");
$contents = $xtpl->text();

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");