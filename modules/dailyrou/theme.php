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

function scheduleList($startDate, $endDate) {
  global $db;
  // $startDate = strtotime("2019/05/01");
  // $endDate = strtotime("2019/06/01");
  $startDate = totime($startDate);
  $endDate = totime($endDate) - A_DAY;
  // $endDate = totime($endDate) + A_DAY * 200;
  $xtpl = new XTemplate("schedule_list.tpl", PATH);

  $userList = userList();
  $date = $startDate;
  $rest_list = array("guard", "morning" => array(), "afternoon" => array());
  $check = true;

  $sql = "select * from `" . PREFIX . "_row` where `time` between $startDate and $endDate order by time, type asc";
  $query = $db->query($sql);
  $currentRow = $query->fetch();

  while ($check) {
    if ($date >= $endDate) {
      $check = false;
    }

    $xtpl->assign("date", date("d/m/Y", $date));

    if ($currentRow["time"] === $date) {
      switch ($currentRow["type"]) {
        case '0':
          $rest_list["guard"][] = $userList[$currentRow["user_id"]]["last_name"] . " " . $userList[$currentRow["user_id"]]["first_name"];
          $xtpl->assign("guard", implode(", ", $rest_list["guard"]));
          $currentRow = $query->fetch();
        break;
        case '1':
          $rest_list["morning"][] = $userList[$currentRow["user_id"]]["last_name"] . " " . $userList[$currentRow["user_id"]]["first_name"];
          $xtpl->assign("morning_rest", implode(", ", $rest_list["morning"]));
          $currentRow = $query->fetch();
        break;
        case '2':
          $rest_list["afternoon"][] = $userList[$currentRow["user_id"]]["last_name"] . " " . $userList[$currentRow["user_id"]]["first_name"];
          $xtpl->assign("afternoon_rest", implode(", ", $rest_list["afternoon"]));
          $currentRow = $query->fetch();
        break;
      }
    }
    else {
      $rest_list = array("guard", "morning" => array(), "afternoon" => array());
      $date += A_DAY;
      $xtpl->parse("main.row");
      $xtpl->assign("guard", "");
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

function adminScheduleList($date) {
  global $db, $db_config;

  $date = totime($date);
  $startDate = date ('N', $date) == 1 ? strtotime(date('Y-m-d', $date)) : strtotime('last monday', $date);
  $endDate = strtotime('next monday', $date);
  $xtpl = new XTemplate("schedule_list.tpl", PATH);
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
    $t = array(1 => 0, 0);

    while ($indexRou > 1) {
      if ($indexRou > 7) {
        $indexRou = 0;
      }
      $sql = "select * from `" . PREFIX . "_row` where time = $currentDate and user_id = $row[userid] and type > 0 order by time, type asc";
      $query2 = $db->query($sql);

      $xtpl->assign("color_" . $indexRou . "1", "green");
      $xtpl->assign("color_" . $indexRou . "2", "green");
      while ($rou = $query2->fetch()) {
        $xtpl->assign("color_" . $indexRou . $rou["type"], "red");
        $t[$rou["type"]] ++;
      }
      $indexRou += 1;
      $currentDate += A_DAY;
    }
    $xtpl->assign("t1", $t[1]);
    $xtpl->assign("t2", $t[2]);
    $xtpl->assign("t", $t[1] + $t[2]);
    $xtpl->parse("main.row");
  }
  
// var_dump($xtpl);
  // die();
  $xtpl->parse("main");
  return $xtpl->text();
}

function adminSummary($date) {
  global $db, $db_config;

  $date = totime($date);

  if (intval(date("d", $date)) > 23) {
    $startDate = strtotime(date("Y", $date) . "-" . date("m", $date) . "-23");
    $endDate = strtotime(date("Y", $date) . "-" . (intval(date("m", $date)) + 1) . "-23");
  }
  else {
    $startDate = strtotime(date("Y", $date) . "-" . (intval(date("m", $date)) - 1) . "-23");
    $endDate = strtotime(date("Y", $date) . "-" . date("m", $date) . "-23");
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

    $sql = "select count(*) as num from `" . PREFIX . "_row` where time between $startDate and $endDate and user_id = $row[userid] and type > 0 order by time, type asc";
    $query2 = $db->query($sql);
    $count = $query2->fetch();

    $xtpl->assign("total", $count["num"]);
    $xtpl->parse("main.row");
  }
  
  $xtpl->parse("main");
  return $xtpl->text();
}
