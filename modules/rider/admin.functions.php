<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (! defined('NV_ADMIN') or ! defined('NV_MAINFILE') or ! defined('NV_IS_MODADMIN')) {
  die('Stop!!!');
}

define('NV_IS_ADMIN_RIDER', true);
define("PATH", NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file);

require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';
require NV_ROOTDIR . '/modules/' . $module_file . '/theme.php';


function statistic($filter = array()) {
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
      $filter['from'] = $filter['from'] - 60 * 60 * 24 * 30;
    break;
    case 2:
      $filter['from'] = totime($filter['from']);
      $filter['end'] = $filter['end'] + 60 * 60 * 24 * 30;
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
  
  $xtpl = new XTemplate("statistic-list.tpl", PATH);
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
