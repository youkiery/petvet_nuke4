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

define("A_DAY", 60 * 60 * 24);
$work = array("trực sáng", "trực tối", "nghỉ sáng", "nghỉ chiều");
$datetime = array(1 => "Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7", "CN");

function userWorkList($doctorId) {
  global $nv_Request, $db, $work;
  $exType = $nv_Request->get_string("exType", "get/post", "");
  $startDate = $nv_Request->get_string("startDate", "get/post", "");
  $endDate = $nv_Request->get_string("endDate", "get/post", "");

  $startDate = totime($startDate);
  $endDate = totime($endDate);
  $xtpl = new XTemplate("work_list.tpl", PATH);

  $sql = "select * from `" . PREFIX . "_row` where user_id = $doctorId and time between $startDate and $endDate order by time, type asc";
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $xtpl->assign("date", date("d/m/Y", $row["time"]));
    $xtpl->assign("type", $work[$row["type"]]);
    $xtpl->assign("type2", $row["type"]);
    $xtpl->parse("main");
  }
  return $xtpl->text();
}

function scheduleList($startDate, $endDate) {
  global $db, $datetime, $work;
  // $startDate = strtotime("2019/05/01");
  // $endDate = strtotime("2019/06/01");
  // $endDate = totime($endDate) + A_DAY * 200;
  $xtpl = new XTemplate("schedule_list.tpl", PATH);

  $userList = userList();
  $date = $startDate;
  $rest_list = array("morning_guard" => array(), "afternoon_guard" => array(), "morning_rest" => array(), "afternoon_rest" => array());
  $check = true;

  $sql = "select * from `" . PREFIX . "_row` where `time` between $startDate and $endDate order by time, type asc, user_id";
  $query = $db->query($sql);
  $currentRow = $query->fetch();
  $count = 0;

  while ($count < 7) {
    // $xtpl->assign("date", date("d/m", $date) . " (" . $datetime[date("N", $date)] . ")");
    $xtpl->assign("date", date("d/m/Y", $date));
    $xtpl->assign("day", $datetime[date("N", $date)]);

    if ($currentRow["time"] == $date) {
      // var_dump($currentRow);
      // echo "<br>";
      switch ($currentRow["type"]) {
        case '0':
          $rest_list["morning_guard"][] = $userList[$currentRow["user_id"]]["first_name"];
          $xtpl->assign("morning_guard", implode(", ", $rest_list["morning_guard"]));
        break;
        case '1':
          $rest_list["afternoon_guard"][] = $userList[$currentRow["user_id"]]["first_name"];
          $xtpl->assign("afternoon_guard", implode(", ", $rest_list["afternoon_guard"]));
        break;
        case '2':
          $rest_list["morning_rest"][] = $userList[$currentRow["user_id"]]["first_name"];
          $xtpl->assign("morning_rest", implode(", ", $rest_list["morning_rest"]));
        break;
        case '3':
          $rest_list["afternoon_rest"][] = $userList[$currentRow["user_id"]]["first_name"];
          $xtpl->assign("afternoon_rest", implode(", ", $rest_list["afternoon_rest"]));
        break;
      }
      $currentRow = $query->fetch();
      $currentRow["time"] = strtotime(date("Y-m-d", $currentRow["time"]));
    }
    else {
      $rest_list = array("morning_guard" => array(), "afternoon_guard" => array(), "morning_rest" => array(), "afternoon_rest" => array());
      $date += A_DAY;
      $count ++;
      $xtpl->parse("main.row");
      $xtpl->assign("morning_guard", "");
      $xtpl->assign("afternoon_guard", "");
      $xtpl->assign("morning_rest", "");
      $xtpl->assign("afternoon_rest", "");
    }
  }  
  $xtpl->parse("main");
  return $xtpl->text();
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

function wconfirm($date, $doctorId, $userList) {
  global $db, $db_config, $work;

  $startDate = date ('N', $date) == 1 ? strtotime(date('Y-m-d', $date)) : strtotime('last monday', $date);
  $endDate = strtotime('next monday', $date);
  $xtpl = new XTemplate("ad_schedule_list.tpl", PATH);
  $user = array();

  $sql = "select * from `" . $db_config["prefix"] . "_users` where userid in (select user_id from `" . $db_config["prefix"] . "_rider_user` where type = 1)";
  $query = $db->query($sql);

  $xtpl->assign("from", date("d/m/Y", $startDate));
  $xtpl->assign("to", date("d/m/Y", $endDate - 1));
  $xtpl->assign("c2", date("d/m", $startDate));
  $xtpl->assign("c3", date("d/m", $startDate + A_DAY));
  $xtpl->assign("c4", date("d/m", $startDate + A_DAY * 2));
  $xtpl->assign("c5", date("d/m", $startDate + A_DAY * 3));
  $xtpl->assign("c6", date("d/m", $startDate + A_DAY * 4));
  $xtpl->assign("c7", date("d/m", $startDate + A_DAY * 5));
  $xtpl->assign("c8", date("d/m", $startDate + A_DAY * 6));

  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign("index", $index ++);
    $xtpl->assign("username", $row["first_name"]);
    $currentDate = $startDate;
    $indexRou = 2;
    $t = array(1 => 0, 0);

    while ($indexRou > 1) {
      if ($indexRou > 7) {
        $indexRou = 0;
      }
      $sql = "select * from `" . PREFIX . "_row` where time = $currentDate and user_id = $row[userid] and type > 1 order by time, type asc";
      $query2 = $db->query($sql);

      $xtpl->assign("color_" . $indexRou . "1", "green");
      $xtpl->assign("color_" . $indexRou . "2", "green");
      $xtpl->assign("date_" . $indexRou . "1", $currentDate);
      $xtpl->assign("date_" . $indexRou . "2", $currentDate);
      $xtpl->assign("type_" . $indexRou . "1", 2);
      $xtpl->assign("type_" . $indexRou . "2", 3);
      while ($rou = $query2->fetch()) {
        $xtpl->assign("color_" . $indexRou . ($rou["type"] - 1), "red");
        $t[$rou["type"] - 1] ++;
      }
      $indexRou += 1;
      $currentDate += A_DAY;
    }
    $xtpl->assign("t1", $t[1]);
    $xtpl->assign("t2", $t[2]);
    $xtpl->assign("t", $t[1] + $t[2]);
    $xtpl->parse("main.row");
  }
  
  $xtpl->parse("main");
  return $xtpl->text();
}

function blockSelectDoctor($doctorId, $userList) {
  global $db, $db_config;

  $xtpl = new XTemplate("block_select_doctor.tpl", PATH);
  
  foreach ($userList as $userData) {
    if ($doctorId == $userData["userid"]) {
      $xtpl->assign("select", "selected");
    }
    else {
      $xtpl->assign("select", "");
    }
    $xtpl->assign("doctor_value", $userData["userid"]);
    $xtpl->assign("doctor_name", $userData["first_name"]);
    $xtpl->parse("main.doctor");
  }
  $xtpl->parse("main");
  return $xtpl->text();
}

function adminScheduleList($date) {
  global $db, $db_config;

  $date = totime($date);
  $startDate = date ('N', $date) == 1 ? strtotime(date('Y-m-d', $date)) : strtotime('last monday', $date);
  $endDate = strtotime('next monday', $date);
  $xtpl = new XTemplate("ad_schedule_list.tpl", PATH);
  $user = array();

  $sql = "select * from `" . $db_config["prefix"] . "_users` where userid in (select user_id from `" . $db_config["prefix"] . "_rider_user` where type = 1)";
  $query = $db->query($sql);

  $xtpl->assign("from", date("d/m/Y", $startDate));
  $xtpl->assign("to", date("d/m/Y", $endDate));
  $xtpl->assign("c2", date("d/m", $startDate));
  $xtpl->assign("c3", date("d/m", $startDate + A_DAY));
  $xtpl->assign("c4", date("d/m", $startDate + A_DAY * 2));
  $xtpl->assign("c5", date("d/m", $startDate + A_DAY * 3));
  $xtpl->assign("c6", date("d/m", $startDate + A_DAY * 4));
  $xtpl->assign("c7", date("d/m", $startDate + A_DAY * 5));
  $xtpl->assign("c8", date("d/m", $startDate + A_DAY * 6));

  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign("index", $index ++);
    $xtpl->assign("username", $row["last_name"] . " " . $row["first_name"]);
    $currentDate = $startDate;
    $indexRou = 2;
    $t = array(2 => 0, 0);

    while ($indexRou > 1) {
      if ($indexRou > 7) {
        $indexRou = 0;
      }
      $sql = "select * from `" . PREFIX . "_row` where time = $currentDate and user_id = $row[userid] and type > 1 order by time, type asc";
      $query2 = $db->query($sql);

      $xtpl->assign("color_" . $indexRou . "1", "green");
      $xtpl->assign("color_" . $indexRou . "2", "green");
      while ($rou = $query2->fetch()) {
        $xtpl->assign("color_" . $indexRou . ($rou["type"] - 1), "red");
        $t[$rou["type"]] ++;
      }
      $indexRou += 1;
      $currentDate += A_DAY;
    }
    $xtpl->assign("t1", $t[2]);
    $xtpl->assign("t2", $t[3]);
    $xtpl->assign("t", $t[2] + $t[3]);
    $xtpl->parse("main.row");
  }
  
// var_dump($xtpl);
  // die();
  $xtpl->parse("main");
  return $xtpl->text();
}

function adminSummary($startDate = 0, $endDate = 0) {
  global $db, $db_config;

  if (empty($startDate) || empty($endDate)) {
    $time = time();
    if (date('N', $time) < 23) {
      $time = time() - A_DAY * 23;
    }
    $startDate = strtotime(date("Y", $time) . "-" . date("m", $time) . "-24");
    $endDate = strtotime(date("Y", $time) . "-" . (intval(date("m", $time)) + 1) . "-23");
  }

  $xtpl = new XTemplate("summary.tpl", PATH);
  $user = array();

  $sql = "select * from `" . $db_config["prefix"] . "_users` where userid in (select user_id from `" . $db_config["prefix"] . "_rider_user` where type = 1)";
  $query = $db->query($sql);

  $xtpl->assign("from", date("d/m/Y", $startDate));
  $xtpl->assign("to", date("d/m/Y", $endDate));

  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign("index", $index++);
    $xtpl->assign("username", $row["last_name"] . " " . $row["first_name"]);

    $sql = "select count(*) as num from `" . PREFIX . "_row` where time between $startDate and ".($endDate + A_DAY - 1)." and user_id = $row[userid] and type > 1";
    $query2 = $db->query($sql);
    $count = $query2->fetch();
    $sql = "select count(*) as num from `" . PREFIX . "_penety` where time between $startDate and ".($endDate + A_DAY - 1)." and userid = $row[userid]";
    $query2 = $db->query($sql);
    $count2 = $query2->fetch();
    // $count['num'] += $count2['num'];

    $sql2 = 'select time, type from `' . PREFIX . '_penety` where time between '. $startDate .' and '.($endDate + A_DAY - 1).' and userid = ' . $row['userid'];
    $query2 = $db->query($sql2);
    $list = array();
    while ($row2 = $query2->fetch()) {
      $list[] = $row2;
    }

    $total = round(($count2['num'] + $count['num']) / 2, 1);
    $xtpl->assign("rest", round($count['num'] / 2, 1));
    $xtpl->assign("overflow", round($count2['num'] / 2, 1));
    $xtpl->assign("data", json_encode($list));

    $xtpl->assign("total", $total);
    $xtpl->assign("exceed", $total > 4 ? $total - 4 : 0);
    $xtpl->parse("main.row");
  }
  
  $xtpl->parse("main");
  return $xtpl->text();
}

function doctorUserList() {
  global $db, $db_config;
  $xtpl = new XTemplate("list.tpl", PATH2);

  $sql = "select a.first_name, b.* from `" . $db_config["prefix"] . "_users` a inner join `" . PREFIX . "_user` b on a.userid = b.userid order by userid desc";
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $xtpl->assign("id", $row["userid"]);
    $xtpl->assign("username", $row["first_name"]);
    if ($row["manager"]) {
      $xtpl->parse("main.manager");
    }
    else {
      $xtpl->parse("main.user");
    }
    $xtpl->parse("main");
  }
  return $xtpl->text();
}

function exceptUserList() {
  global $db, $db_config;
  $xtpl = new XTemplate("manager_list.tpl", PATH);

  $sql = "select a.first_name, a.userid, b.except from `" . $db_config["prefix"] . "_users` a inner join `" . $db_config["prefix"] . "_rider_user` b on b.type = 1 and a.userid = b.user_id order by except desc";
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $xtpl->assign("id", $row["userid"]);
    $xtpl->assign("username", $row["first_name"]);
    if ($row["except"]) {
      $xtpl->parse("main.manager");
    }
    else {
      $xtpl->parse("main.user");
    }
    $xtpl->parse("main");
  }
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
    if ($total_pages) {
      for ($i = 1; $i < $total_pages + 1; $i ++) {
        $page_string .= ($i == $on_page) ? '<div class="btn">' . $i . "</div>" : '<button class="btn btn-info" onclick="goPage('.$i.')">' . $i . '</button>';
        if ($i < $total_pages) $page_string .= " ";
      }
    }
    else {
      $page_string .= '<div class="btn">' . 1 . "</div>";
    }
  }
  return $page_string;
}
