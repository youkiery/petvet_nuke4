<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_MOD_QUANLY')) {
	die('Stop!!!');
}

define("A_DAY", 60 * 60 * 24);
$page_title = "Đăng ký lịch nghỉ/trực";
checkUserPermit(NO_OVERCLOCK);

$date = strtotime(date('Y/m/d'));
$itemData["type"] = 3;

$type = 0;
$sql = 'select * from `'. VAC_PREFIX .'_user` where userid = ' . $user_info['userid'];
$query = $db->query($sql);
$user = $query->fetch();
if (!empty($user)) {
  if ($user['manager']) $type = 1;
}

$this_week = date("N") == 1 ? strtotime(date("Y-m-d", time())) : strtotime(date("Y-m-d", strtotime('last monday')));
$next_week = $this_week + A_DAY * 7 - 1;

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
 		case 'summary':
			$startDate = $nv_Request->get_string("startDate", "get/post", "");
			$endDate = $nv_Request->get_string("endDate", "get/post", "");

			$startDate = totime($startDate);
			$endDate = totime($endDate);

			$result["status"] = 1;
			$result["html"] = adminSummary($startDate, $endDate);			
		break;
    case 'wconfirm':
      $startDate = $nv_Request->get_string("startDate", "get/post", "");

      $startDate = totime($startDate);

      if ($startDate) {
        $userList = doctorList2();
        $result["status"] = 1;
        $result["html"] = wconfirm($startDate, current($userList)["userid"], $userList);
        $result["doctorId"] = current($userList)["userid"];
      }

    break;
    case 'wconfirmSubmit':
      $startDate = $nv_Request->get_string("startDate", "get/post", "");
      $data = $nv_Request->get_array("data", "get/post");
      $day = date('w');

      $startDate = totime($startDate);
      if ($data) {       
        foreach ($data as $row) {
          $time = strtotime(date("Y-m-d", $row["date"]));

          $sql = "select userid from `" . $db_config["prefix"] . "_users` where first_name = '$row[name]'";
          $query = $db->query($sql);
          if ($user = $query->fetch()) {
            if ($row["color"] == "yellow") {
              $sql = "insert into `" . VAC_PREFIX . "_row` (type, user_id, time) values ($row[type], $user[userid], $time)";
              if ($db->query($sql) && $row['type'] > 1) {
                $sql = "select count(*) as count from `". VAC_PREFIX ."_row` where user_id not in (select userid from `". VAC_PREFIX . "_user` where `except` = 1) and (time between $time and " . ($time + A_DAY - 1) . ") and type = " . ($row["type"]);
                $query = $db->query($sql);
                $count = $query->fetch()['count'];
                $limit = 2;
                if ($day == 0 || $day == 6) {
                  $limit = 1;
                }

                if ($count > $limit) {
                  $sql = 'insert into `'. VAC_PREFIX .'_penety` (userid, time, type) values('. $user['userid'] .', '. $time .', ' . ($row["type"]) . ')';
                  $db->query($sql);
                }
              }
            }
            else {
              $sql = "delete from `" . VAC_PREFIX . "_row` where type = $row[type] and user_id = $user[userid] and time = $time";
              if ($db->query($sql)) {
                $sql = 'delete from `'. VAC_PREFIX .'_penety` where userid = '. $user['userid'] .' and (time between '. $time .' and ' . ($time + A_DAY - 1) . ') and type = ' . ($row["type"]);
                $db->query($sql);
              }
            }
          }
        }
        $userList = doctorList2();
        $result["status"] = 1;
        $result["notify"] = "Đã cập nhật lịch đăng ký";
        $result["html"] = wconfirm($startDate, current($userList)["userid"], $userList);
      }
    break;

    case 'removeWconfirm':
      $startDate = $nv_Request->get_string("startDate", "get/post", "");
      $doctorId = $nv_Request->get_string("doctorId", "get/post", "");
      $date = $nv_Request->get_string("date", "get/post", "");
      $type = $nv_Request->get_string("type", "get/post", "");

      if ($startDate) {
        $sql = "select * from `" . VAC_PREFIX . "_row` where user_id = $doctorId and time = $date and type = $type";
        $query = $db->query($sql);

        if ($query->fetch()) {
          $sql = "delete from `" . VAC_PREFIX . "_row` where user_id = $doctorId and time = $date and type = $type";
          if ($db->query($sql)) {
            $userList = doctorList2();
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
        $unuse = array();
        $sql = "select * from `" . VAC_PREFIX . "_user` where userid = $user_info[userid]";
        $query = $db->query($sql);
        $user = $query->fetch();
        foreach ($itemList as $itemData) {
          $date = totime($itemData["date"]);
          $day = date('w', $date);
          if (($user["manager"] || $date >= $today) || $itemData['color'] == 'purple') {
            if ($itemData["color"] == "purple") {
              $sql = "delete from `". VAC_PREFIX ."_row` where user_id = $doctorId and (time between $date and " . ($date + A_DAY - 1) . ") and type = " . ($itemData["type"] - 2);
              if ($db->query($sql)) {
                $sql = 'delete from `'. VAC_PREFIX .'_penety` where userid = '. $doctorId .' and (time between '. $date .' and ' . ($date + A_DAY - 1) . ') and type = ' . ($itemData["type"] - 2);
                $db->query($sql);
              }
            }
            else {
              $sql = "insert into `". VAC_PREFIX ."_row` (type, user_id, time) values(" . ($itemData["type"] - 2) . ", $doctorId, $date)";
              $db->query($sql);
            }
          }
          else {
            // push unuse and notify
            $unuse[] = $itemData['date'] . ': ' . $work[$itemData['type'] - 2];
            $poi = 1;
          }
        }
        $result["notify"] = "Cập nhật thành công lịch đăng ký";
        if (count($unuse)) {
          $result['notify'] .= '<div style="color: red">' . implode('<br>', $unuse) . '</div>';
        }
      }
      else {
        $result["notify"] = "Có lỗi xảy ra trong quá trình xử lý dữ liệu";
      }
      $startDate = strtotime(date("Y-m-d", totime($startDate)));
      $endDate = $startDate + A_DAY * 7 - 1;
    
      $result["html"] = scheduleList($startDate, $endDate);
      $result["status"] = 1;

      $sql = "select * from `" . VAC_PREFIX . "_row` where time between $startDate and $endDate order by time, type asc";
      $query = $db->query($sql);
      $daily = array();
      
      while ($row = $query->fetch()) {
        $use = 0;
        if ($row["user_id"] == $user_info["userid"]) {
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

      $sql = "select * from `" . VAC_PREFIX . "_row` where time between $startDate and $endDate order by time, type asc";
      $query = $db->query($sql);
      $daily = array();
      
      while ($row = $query->fetch()) {
        $use = 0;
        if ($row["user_id"] == $user_info['userid']) {
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

// $date_option = array(1 => "Tuần này", "Tuần sau", "Tháng này", "Tháng trước", "Tháng sau", "Năm nay", "Năm trước");
$date_option = array(1 => "Tuần này", "Tuần sau", "Tháng này", "Tháng trước", "Tháng sau");
$userList = array();

$xtpl = new XTemplate("main.tpl", PATH2);
$xtpl->assign("data", "{}");
$xtpl->assign("this_week", date("d/m/Y", $this_week));
$xtpl->assign("date", date("Y-m-d"));

// die($sql);
$xtpl->assign("admin", "false");
if ($type) {
  $xtpl->assign("admin", "true");
  $list = getdoctorlist3();

  foreach ($list as $doctor) {
    $xtpl->assign("select", "");
    if ($doctor['userid'] == $user_info["userid"]) $xtpl->assign("select", "selected");
    $xtpl->assign("doctor_value", $doctor["userid"]);
    $xtpl->assign("doctor_name", $doctor["first_name"]);
    $xtpl->parse("main.doctor.row");
  }

  $xtpl->parse("main.tab");
  $xtpl->parse("main.manager");
  $xtpl->parse("main.doctor");
}

foreach ($date_option as $date_value => $date_name) {
  $xtpl->assign("date_name", $date_name);
  $xtpl->assign("date_value", $date_value);
  $xtpl->parse("main.date_option");
}

$sql = "select * from `" . VAC_PREFIX . "_row` where time between $this_week and $next_week order by time, type asc";
$query = $db->query($sql);
$daily = array();

while ($row = $query->fetch()) {
  $use = 0;
  if ($row["user_id"] == $user_info['userid']) {
    $use = 1;
  }
  $daily[] = array("userid" => $row["user_id"], "date" => date("d/m/Y", $row["time"]), "type" => $row["type"], "use" => $use);
}

$sql = "select first_name from `" . $db_config["prefix"] . "_users` where userid in (select userid from `" . VAC_PREFIX . "_user` where `except` = 1)";
$query = $db->query($sql);
$except = array();
while($row = $query->fetch()) {
  $except[] = $row['first_name'];
}
$time = time();

if (date('N', $time) < 23) {
	$time = time() - A_DAY * 23;
}
$startDate = strtotime(date("Y", $time) . "-" . date("m", $time) . "-24");
$endDate = strtotime(date("Y", $time) . "-" . (intval(date("m", $time)) + 1) . "-23");
$xtpl->assign("startDate", date('d/m/Y', $startDate));
$xtpl->assign("endDate", date('d/m/Y', $endDate));

$xtpl->assign("modal", dailyrouModal());
$xtpl->assign("except", json_encode($except));
$xtpl->assign("data", json_encode($daily));
$xtpl->assign("username", $user_info['first_name']);
$xtpl->assign("doctorId", $user_info['userid']);
$time = time();
$xtpl->assign("content", scheduleList($this_week, $next_week));

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

