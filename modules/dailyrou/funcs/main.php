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
    // case 'editSchedule':
    //   $startDate = $nv_Request->get_string("startDate", "get/post", "");

    //   $result["status"] = 1;
    //   $result["html"] = adminScheduleList($startDate);
    // break;
    // case 'getWorkList':
    //   $doctorId = $nv_Request->get_string("doctorId", "get/post", "");

    //   $sql = "select * from `" . $db_config["prefix"] . "_rider_user` where type = 1 and user_id = $doctorId";
    //   $query = $db->query($sql);

    //   if ($query->fetch()) {
    //     $result["status"] = 1;
    //     $result["html"] = userWorkList($doctorId);
    //   }
    // break;
    // case 'exchange':
    //   // need to change
    //   $exDate = $nv_Request->get_string("exDate", "get/post", "");
    //   $exType = $nv_Request->get_string("exType", "get/post", "");
    //   $exDate2 = $nv_Request->get_string("exDate2", "get/post", "");
    //   $exType2 = $nv_Request->get_string("exType2", "get/post", "");

    //   $exDate = totime($exDate);
    //   $exDate2 = totime($exDate2);

    //   $sql = "insert into * from `" . PREFIX . "_exchange` (user_id, request_user_id, date, type, )";
    //   $query = $db->query($sql);
    // break;
    case 'wconfirm':
      $startDate = $nv_Request->get_string("startDate", "get/post", "");

      $startDate = totime($startDate);

      if ($startDate) {
        $userList = doctorList();
        $result["status"] = 1;
        $result["html"] = wconfirm($startDate, current($userList)["userid"], $userList);
        $result["doctorId"] = current($userList)["userid"];
      }

    break;
    case 'wconfirmSubmit':
      $startDate = $nv_Request->get_string("startDate", "get/post", "");
      $data = $nv_Request->get_array("data", "get/post");

      $startDate = totime($startDate);
      if ($data) {       
        foreach ($data as $row) {
          $time = strtotime(date("Y-m-d", $row["date"]));
          $sql = "select userid from `" . $db_config["prefix"] . "_users` where first_name = '$row[name]'";
          $query = $db->query($sql);
          if ($user = $query->fetch()) {
            if ($row["color"] == "yellow") {
              $sql = "insert into `" . PREFIX . "_row` (type, user_id, time) values ($row[type], $user[userid], $time)";
            }
            else {
              $sql = "delete from `" . PREFIX . "_row` where type = $row[type] and user_id = $user[userid] and time = $time";
            }
            if ($db->query($sql)) {
              $userList = doctorList();
              $result["status"] = 1;
              $result["notify"] = "Đã cập nhật lịch đăng ký";
              $result["html"] = wconfirm($startDate, current($userList)["userid"], $userList);
            }
          }
        }
      }
    break;

    case 'removeWconfirm':
      $startDate = $nv_Request->get_string("startDate", "get/post", "");
      $doctorId = $nv_Request->get_string("doctorId", "get/post", "");
      $date = $nv_Request->get_string("date", "get/post", "");
      $type = $nv_Request->get_string("type", "get/post", "");

      if ($startDate) {
        $sql = "select * from `" . PREFIX . "_row` where user_id = $doctorId and time = $date and type = $type";
        $query = $db->query($sql);

        if ($query->fetch()) {
          $sql = "delete from `" . PREFIX . "_row` where user_id = $doctorId and time = $date and type = $type";
          if ($db->query($sql)) {
            $userList = doctorList();
            $result["status"] = 1;
            $result["html"] = wconfirm($startDate, $doctorId, $userList);
          }
        }
      }

    break;
    case 'regist':
      $itemList = $nv_Request->get_array("itemList", "get/post", "");
      $startDate = $nv_Request->get_string("startDate", "get/post", "");
      $doctorId = $nv_Request->get_string("doctorId", "get/post", "");
      $today = strtotime(date("Y-m-d"));

      if ($itemList) {
        $sql = "select * from `" . $db_config["prefix"] . "_rider_user` where type = 1 and user_id = $user_info[userid]";
        $query = $db->query($sql);
        $user = $query->fetch();
        foreach ($itemList as $itemData) {
          $date = totime($itemData["date"]);
          if ($user["permission"] || $date >= $today) {
            if ($itemData["color"] == "purple") {
              $sql = "delete from `". PREFIX ."_row` where user_id = $doctorId and (time between $date and " . ($date + A_DAY - 1) . ") and type = " . ($itemData["type"] - 2);
            }
            else {
              $sql = "insert into `". PREFIX ."_row` (type, user_id, time) values(" . ($itemData["type"] - 2) . ", $doctorId, $date)";
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
      $startDate = strtotime(date("Y-m-d", totime($startDate)));
      $endDate = $startDate + A_DAY * 7 - 1;
    
      $result["html"] = scheduleList($startDate, $endDate);
      $result["status"] = 1;

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

      $startDate = strtotime(date("Y-m-d", totime($startDate)));
      $endDate = $startDate + A_DAY * 7 - 1;

      $result["html"] = scheduleList($startDate, $endDate);
      $result["status"] = 1;

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

$this_week = date("N") == 1 ? strtotime(date("Y-m-d", time())) : strtotime(date("Y-m-d", strtotime('last monday')));
$next_week = $this_week + A_DAY * 7 - 1;
// $date_option = array(1 => "Tuần này", "Tuần sau", "Tháng này", "Tháng trước", "Tháng sau", "Năm nay", "Năm trước");
$date_option = array(1 => "Tuần này", "Tuần sau", "Tháng này", "Tháng trước", "Tháng sau");
$user_id = 0;
$user_name = "";
$userList = array();
if (!empty($user_info)) {
  $user_id = $user_info["userid"];
  $sql = "select * from `" . $db_config["prefix"] . "_users` where userid = $user_info[userid]";
  $query = $db->query($sql);
  $user = $query->fetch();
  $user_name = $user["first_name"];
}

$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
$xtpl->assign("data", "{}");
$xtpl->assign("this_week", date("d/m/Y", $this_week));
$xtpl->assign("date", date("Y-m-d"));

$sql = "select a.*, b.permission from `" . $db_config["prefix"] . "_users` a inner join `" . $db_config["prefix"] . "_rider_user` b on user_id = $user_id and type = 1 and a.userid = b.user_id";
$query = $db->query($sql);
// die($sql);
$xtpl->assign("admin", "false");
if ($userList = $query->fetch()) {
  if ($userList["permission"]) {
    $xtpl->assign("admin", "true");
    $userList = doctorList();
    $xtpl->assign("doctor", blockSelectDoctor($user_id, $userList));
    $xtpl->parse("main.tab");
    $xtpl->parse("main.doctor");
  }
  else {
    $userList = array($userList);
  }
}

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
}

$xtpl->assign("data", json_encode($daily));
// $xtpl->assign("user_name", $user_name);
$xtpl->assign("username", $user_name);
$xtpl->assign("doctorId", $user_id);
$xtpl->assign("content", scheduleList($this_week, $next_week));

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

