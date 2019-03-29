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

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
    case 'editSchedule':
      $startDate = $nv_Request->get_string("startDate", "get/post", "");

      $result["status"] = 1;
      $result["html"] = adminScheduleList($startDate);
    break;
    case 'getWorkList':
      $doctorId = $nv_Request->get_string("doctorId", "get/post", "");

      $sql = "select * from `" . $db_config["prefix"] . "_rider_user` where type = 1 and user_id = $doctorId";
      $query = $db->query($sql);

      if ($query->fetch()) {
        $result["status"] = 1;
        $result["html"] = userWorkList($doctorId);
      }
    break;
    case 'exchange':
      // need to change
      $exDate = $nv_Request->get_string("exDate", "get/post", "");
      $exType = $nv_Request->get_string("exType", "get/post", "");
      $exDate2 = $nv_Request->get_string("exDate2", "get/post", "");
      $exType2 = $nv_Request->get_string("exType2", "get/post", "");

      $exDate = totime($exDate);
      $exDate2 = totime($exDate2);

      $sql = "insert into * from `" . PREFIX . "_exchange` (user_id, request_user_id, date, type, )";
      $query = $db->query($sql);
    break;
    case 'regist':
      $itemList = $nv_Request->get_array("itemList", "get/post", "");
      $startDate = $nv_Request->get_string("startDate", "get/post", "");
      $endDate = $nv_Request->get_string("endDate", "get/post", "");
      $today = strtotime(date("Y-m-d"));

      if ($itemList) {
        foreach ($itemList as $itemData) {
          $date = totime($itemData["date"]);
          if ($date >= $today) {
            if ($itemData["color"] == "purple") {
              $sql = "delete from `". PREFIX ."_row` where user_id = $user_info[userid] and time = '$date' and type = " . ($itemData["type"] - 1);
            }
            else {
              $sql = "insert into `". PREFIX ."_row` (type, user_id, time) values(" . ($itemData["type"] - 1) . ", $user_info[userid], $date)";
            }
            $db->query($sql);
          }
          else {
            // push unuse and notify
            $poi = 1;
          }
        }
        $result["notify"] = "Cập nhật thành công lịch đăng ký";
      }
      else {
        $result["notify"] = "Có lỗi xảy ra trong quá trình xử lý dữ liệu";
      }

      $result["html"] = scheduleList($startDate, $endDate);
      $result["status"] = 1;

      $startDate = totime($startDate);
      $endDate = totime($endDate);

      $sql = "select * from `" . PREFIX . "_row` where time between $startDate and $endDate order by time, type asc";
      $query = $db->query($sql);
      $daily = array();
      
      while ($row = $query->fetch()) {
        $use = 0;
        if ($row["user"] == $user_info["userid"]) {
          $use = 1;
        }
        $daily[] = array("date" => date("d/m/Y", $row["time"]), "type" => $row["type"], "use" => $use);
      }
      
      $result["json"] = json_encode($daily);
    break;
    case 'filter_data':
      $startDate = $nv_Request->get_string("startDate", "get/post", "");
      $endDate = $nv_Request->get_string("endDate", "get/post", "");

      $result["html"] = scheduleList($startDate, $endDate);
      $result["status"] = 1;

      $startDate = totime($startDate);
      $endDate = totime($endDate);

      $sql = "select * from `" . PREFIX . "_row` where time between $startDate and $endDate order by time, type asc";
      $query = $db->query($sql);
      $daily = array();
      
      while ($row = $query->fetch()) {
        $use = 0;
        if ($row["user"] == $user_id) {
          $use = 1;
        }
        $daily[] = array("date" => date("d/m/Y", $row["time"]), "type" => $row["type"], "use" => $use);
      }
      
      $result["json"] = json_encode($daily);
    break;
	}

	echo json_encode($result);
	die();
}

$this_week = date("N") == 1 ? strtotime(date("Y-m-d", time())) : strtotime('last monday');
$next_week = (date("N") == 1 ? strtotime(date("Y-m-d", time())) : strtotime('last monday')) + A_DAY * 7;
$this_week_s = date("d/m/Y", $this_week);
$next_week_s = date("d/m/Y", $next_week);
// $date_option = array(1 => "Tuần này", "Tuần sau", "Tháng này", "Tháng trước", "Tháng sau", "Năm nay", "Năm trước");
$date_option = array(1 => "Tuần này", "Tuần sau", "Tháng này", "Tháng trước", "Tháng sau");
$user_id = 0;
$user_name = "";
if (!empty($user_info)) {
  $user_id = $user_info["userid"];
  $sql = "select * from `" . $db_config["prefix"] . "_users` where userid = $user_info[userid]";
  $query = $db->query($sql);
  $user = $query->fetch();
  $user_name = $user["last_name"] . " " . $user["first_name"];
}

$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
$xtpl->assign("data", "{}");
$xtpl->assign("this_week", $this_week_s);
$xtpl->assign("next_week", $next_week_s);
$xtpl->assign("date", date("Y-m-d"));

foreach ($date_option as $date_value => $date_name) {
  $xtpl->assign("date_name", $date_name);
  $xtpl->assign("date_value", $date_value);
  $xtpl->parse("main.date_option");
}

$sql = "select * from `" . PREFIX . "_row` where time between $this_week and $next_week order by time, type asc";
$query = $db->query($sql);
$daily = array();

while ($row = $query->fetch()) {
  $use = 0;
  if ($row["user_id"] == $user_id) {
    $use = 1;
  }
  $daily[] = array("userid" => $row["user_id"], "date" => date("d/m/Y", $row["time"]), "type" => $row["type"], "use" => $use);
}

$sql = "select * from `" . $db_config["prefix"] . "_users` where userid in (select id from `" . $db_config["prefix"] . "_rider_user` where type = 1 and user_id <> $user_info[userid])";
// die($sql);
$query = $db->query($sql);
while($row = $query->fetch()) {
  $xtpl->assign("doctor_value", $row["userid"]);
  $xtpl->assign("doctor_name", $row["last_name"] . " " . $row["first_name"]);
  $xtpl->parse("main.doctor");
}

$xtpl->assign("data", json_encode($daily));
// $xtpl->assign("user_name", $user_name);
$xtpl->assign("username", $user_name);
$xtpl->assign("content", scheduleList($this_week_s, $next_week_s));

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

