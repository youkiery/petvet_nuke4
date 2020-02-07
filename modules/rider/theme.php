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
define("PATH2", NV_ROOTDIR . "/modules/" . $module_file . '/template/user/' . $op);

function collectList($startDate, $endDate) {
  global $db, $db_config, $nv_Request;

  $page = $nv_Request->get_int('page', 'post/get', '');
  $limit = $nv_Request->get_int('limit', 'post/get', '');

  if (empty($page) || $page < 0) $page = 1;
  if (empty($limit) || $limit < 0) $limit = 10;
  $start = $limit * ($page - 1);

  $xtpl = new XTemplate("collect_list.tpl", PATH);
  $endDate = totime($endDate);
  $startDate = totime($startDate);

  $sql = "select userid, first_name, last_name from `" . $db_config["prefix"] . "_users`";
  $query = $db->query($sql);

  $user = array();
  while ($row = $query->fetch()) {
    $user[$row["userid"]] = $row;
  }

  $sql = "select count(id) as count from `" . PREFIX . "_row` where (time between $startDate and $endDate) and type = 0";
  $query = $db->query($sql);
  $count = $query->fetch();

  $sql = "select * from `" . PREFIX . "_row` where (time between $startDate and $endDate) and type = 0 order by time desc limit " . $limit . ' offset ' . $start;
  $query = $db->query($sql);

  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign("index", $start + ($index ++));
    $xtpl->assign("id", $row['id']);
    // die(var_dump($user));
    $xtpl->assign("driver", $user[$row["driver_id"]]["last_name"] . " " . $user[$row["driver_id"]]["first_name"]);
    $xtpl->assign("km", number_format($row["clock_to"] - $row["clock_from"], 1, ".", ","));
    $xtpl->assign("date", date("d/m H:i", $row["time"]));
    $xtpl->assign("start", $row["clock_from"]);
    $xtpl->assign("price", number_format($row["price"], 0, '', ','));
    $xtpl->assign("end", $row["clock_to"]);
    $xtpl->assign("destination", $row["destination"]);
    $xtpl->parse("main.row");
  }

  $xtpl->assign("count", $count['count']);
  $xtpl->assign("nav", navList($count['count'], $page, $limit));
  $xtpl->parse("main");
  return $xtpl->text("main");
}

function payList($startDate, $endDate, $dateType) {
  global $db, $db_config, $nv_Request;
  $xtpl = new XTemplate("pay_list.tpl", PATH);
  $startDate = totime($startDate);
  $endDate = totime($endDate);

  $page = $nv_Request->get_int('page', 'post/get', '');
  $limit = $nv_Request->get_int('limit', 'post/get', '');

  if (empty($page) || $page < 0) $page = 1;
  if (empty($limit) || $limit < 0) $limit = 10;
  $start = $limit * ($page - 1);

  $sql = "select userid, first_name, last_name from `" . $db_config["prefix"] . "_users`";
  $query = $db->query($sql);

  $user = array();
  while ($row = $query->fetch()) {
    $user[$row["userid"]] = $row;
  }

  $sql = "select count(id) as count from `" . PREFIX . "_row` where (time between $startDate and $endDate) and type = 1";
  $query = $db->query($sql);
  $count = $query->fetch();

  $sql = "select * from `" . PREFIX . "_row` where (time between $startDate and $endDate) and type = 1 order by time desc limit " . $limit . ' offset ' . $start;
  $query = $db->query($sql);

  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign("index", $start + ($index ++));
    $xtpl->assign("id", $row['id']);
    $xtpl->assign("date", date("d/m H:i", $row["time"]));
    $xtpl->assign("driver", $user[$row["driver_id"]]["last_name"] . " " . $user[$row["driver_id"]]["first_name"]);
    $xtpl->assign("money", number_format($row["amount"]) . "đ");
    $xtpl->parse("main.row");
  }

  $xtpl->assign("count", $count['count']);
  $xtpl->assign("nav", navList($count['count'], $page, $limit));
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

function riderList($type, $startDate, $endDate) {
  global $db, $db_config;

  $file = "collect_list";
  if ($type) {
    $type = 1;
    $file = "pay_list";
  }
  $endDate = totime($endDate);
  $startDate = totime($startDate);
  $xtpl = new XTemplate("$file.tpl", PATH);

  $sql = "select userid, first_name, last_name from `" . $db_config["prefix"] . "_users`";
  $query = $db->query($sql);

  $user = array();
  while ($row = $query->fetch()) {
    $user[$row["userid"]] = $row;
  }

  $sql = "select * from `" . PREFIX . "_row` where (time between $startDate and $endDate) and type = $type order by time desc";
  $query = $db->query($sql);

  $index = 1;
  if ($type) {
    while ($row = $query->fetch()) {
      $xtpl->assign("index", $index ++);
      $xtpl->assign("id", $row["id"]);
      $xtpl->assign("driver", $user[$row["driver_id"]]["last_name"] . " " . $user[$row["driver_id"]]["first_name"]);
      $xtpl->assign("km", number_format($row["clock_to"] - $row["clock_from"], 1, ".", ","));
      $xtpl->assign("date", date("d/m H:i", $row["time"]));
      $xtpl->assign("start", $row["clock_from"]);
      $xtpl->assign("end", $row["clock_to"]);
      $xtpl->assign("destination", $row["destination"]);
      $xtpl->parse("main.row");
    }
  }
  else {
    while ($row = $query->fetch()) {
      $xtpl->assign("index", $index ++);
      $xtpl->assign("id", $row["id"]);
      $xtpl->assign("date", date("d/m H:i", $row["time"]));
      $xtpl->assign("driver", $user[$row["driver_id"]]["last_name"] . " " . $user[$row["driver_id"]]["first_name"]);
      $xtpl->assign("money", number_format($row["amount"]) . "đ");
      $xtpl->parse("main.row");
    }
  }

  $xtpl->parse("main");
  return $xtpl->text();
}

function riderModal() {
  global $db, $db_config, $user_info;
  $xtpl = new XTemplate('modal.tpl', PATH2);
  $sql = "select * from `" . PREFIX . "_config` where user_id = 0 and name = 'clock'";
  $query = $db->query($sql);
  $clock = $query->fetch();
  if (!$clock) {
    $clock = 0;
  }
  
  $xtpl->assign("clock", $clock["value"] . '.0');

  $sql = "select userid, username, first_name, last_name from `" . $db_config["prefix"] . "_users` a inner join `". PREFIX ."_user` b on a.userid = b.user_id where type = 1";
  $query = $db->query($sql);
  
  while ($row = $query->fetch()) {
    $xtpl->assign("collect_doctor_check", '');
    if (!empty($user_info) && $user_info['userid'] == $row['userid']) {
      $xtpl->assign("collect_doctor_check", 'selected');
    }
    $xtpl->assign("driver_id", $row["userid"]);
    $xtpl->assign("driver_name", $row["last_name"] . " " . $row["first_name"]);
    $xtpl->parse("main.collect_doctor");
  }
  $xtpl->assign("statistic_content", riderStatistic());
  $xtpl->parse('main');
  return $xtpl->text();
}

function riderStatistic($filter = array()) {
    global $db, $db_config, $module_name;
  
    $check = 0;
    if (empty($filter['from'])) {
      $check += 1;
    }
    if (empty($filter['end'])) {
      $check += 2;
    }
  
    switch ($check) {
      case 1:
        $filter['end'] = totime($filter['end']);
        $filter['from'] = $filter['end'] - 60 * 60 * 24 * 30;
      break;
      case 2:
        $filter['from'] = totime($filter['from']);
        $filter['end'] = $filter['from'] + 60 * 60 * 24 * 30;
      break;
      case 3:
        $time = strtotime(date('Y/m/d'));
        // $time = strtotime(date('8/8/2019'));
        $filter['from'] = $time - 60 * 60 * 24 * 15;
        $filter['end'] = $time + 60 * 60 * 24 * 15;
      break;
      default:
        $filter['from'] = totime($filter['from']);
        $filter['end'] = totime($filter['end']);
    }
    
    $xtpl = new XTemplate("statistic-list.tpl", PATH2);
    $xtpl->assign('from', date('d/m/Y', $filter['from']));
    $xtpl->assign('end', date('d/m/Y', $filter['end']));
  
    // $sql = "select a.*, c.last_name from `" . $db_config["prefix"] . "_" . $module_name . "_row` a inner join `" . $db_config["prefix"] . "_" . $module_name . "_user` b on a.driver_id = b.user_id and b.type = 0 and  inner join `" . $db_config["prefix"] . "_users` c on b.user_id = c.userid";
    $sql = "select b.user_id, c.first_name from `" . $db_config["prefix"] . "_" . $module_name . "_user` b inner join `" . $db_config["prefix"] . "_users` c on b.user_id = c.userid and type = 0";
    $query = $db->query($sql);
    $total = 0;
  
    while (!empty($row = $query->fetch())) {
      $count = 0;
      $desti = 0;
      $price = 0;
  
      $xtpl->assign('rider', $row['first_name']);
  
      $sql = "select * from `" . $db_config["prefix"] . "_" . $module_name . "_row` where driver_id = ". $row['user_id'] ." and type = 0 and time between ". $filter['from'] ." and ". $filter['end'];
      $query2 = $db->query($sql);
  
      while ($row2 = $query2->fetch()) {
        $count ++;
        $desti += $row2['clock_to'] - $row2['clock_from'];
        $price += $row2['price'];
        $total += $row2['price'];
      }
  
      $xtpl->assign('count', $count);
      $xtpl->assign('desti', $desti);
      $xtpl->assign('price', number_format($price, 0, '', ',') . ' VND');
      $xtpl->parse('main.row');
    }
    $xtpl->assign('total', number_format($total, 0, '', ',') . ' VND');
  
    $sql = "select * from `" . $db_config["prefix"] . "_" . $module_name . "_row` where type = 1 and time between ". $filter['from'] ." and ". $filter['end'];
    $query = $db->query($sql);
    $total = 0;
    while ($row = $query->fetch()) {
      $total += $row['amount'];
    }
    $xtpl->assign('total2', number_format($total, 0, '', ',') . ' VND');
  
    $xtpl->parse('main');
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
