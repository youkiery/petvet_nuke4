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

function collectList($startDate, $endDate) {
  global $db, $db_config;
  $xtpl = new XTemplate("collect_list.tpl", PATH);
  $endDate = totime($endDate);
  $startDate = totime($startDate);

  $sql = "select userid, first_name, last_name from `" . $db_config["prefix"] . "_users`";
  $query = $db->query($sql);

  $user = array();
  while ($row = $query->fetch()) {
    $user[$row["userid"]] = $row;
  }

  $sql = "select * from `" . PREFIX . "_row` where (time between $startDate and $endDate) and type = 0 order by time desc";
  $query = $db->query($sql);

  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign("index", $index ++);
    // die(var_dump($user));
    $xtpl->assign("driver", $user[$row["driver_id"]]["last_name"] . " " . $user[$row["driver_id"]]["first_name"]);
    $xtpl->assign("km", $row["clock_to"] - $row["clock_from"]);
    $xtpl->assign("date", date("d/m H:i", $row["time"]));
    $xtpl->assign("start", $row["clock_from"]);
    $xtpl->assign("end", $row["clock_to"]);
    $xtpl->assign("destination", $row["destination"]);
    $xtpl->parse("main.row");
  }

  $xtpl->parse("main");
  return $xtpl->text("main");
}

function payList($startDate, $endDate, $dateType) {
  global $db, $db_config;
  $xtpl = new XTemplate("pay_list.tpl", PATH);
  $startDate = totime($startDate);
  $endDate = totime($endDate);


  $sql = "select userid, first_name, last_name from `" . $db_config["prefix"] . "_users`";
  $query = $db->query($sql);

  $user = array();
  while ($row = $query->fetch()) {
    $user[$row["userid"]] = $row;
  }

  $sql = "select * from `" . PREFIX . "_row` where (time between $startDate and $endDate) and type = 1 order by time desc";
  $query = $db->query($sql);

  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign("index", $index ++);
    $xtpl->assign("date", date("d/m H:i", $row["time"]));
    $xtpl->assign("driver", $user[$row["driver_id"]]["last_name"] . " " . $user[$row["driver_id"]]["first_name"]);
    $xtpl->assign("money", number_format($row["amount"]) . "đ");
    $xtpl->parse("main.row");
  }

  $xtpl->parse("main");
  return $xtpl->text("main");
}

function user_list($reversal, $type) {
  global $db, $db_config;

  $file = "driver-list";
  if ($type) {
    $file = "doctor-list";
  }

  $xtpl = new XTemplate("$file.tpl", PATH);

  if ($reversal) {
    $sql = "select userid, username, last_name, first_name from `" . $db_config["prefix"] . "_users` where userid not in (select user_id from `" . PREFIX . "_user` where type = $type)";
  }
  else {
    $sql = "select a.userid, a.username, a.last_name, a.first_name from `" . $db_config["prefix"] . "_users` a inner join (select * from `" . PREFIX . "_user` where type = $type) b on a.userid = b.user_id";
  }

  $query = $db->query($sql);
  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign("index", $index ++);
    $xtpl->assign("id", $row["userid"]);
    $xtpl->assign("username", $row["username"]);
    $xtpl->assign("name", $row["last_name"] . " " . $row["first_name"]);
    if ($reversal) {
      $xtpl->parse("main.row.insert");
    }
    else {
      $xtpl->parse("main.row.remove");
    }
    $xtpl->parse("main.row");
  }

  $xtpl->parse("main");
  return $xtpl->text("main");
}

