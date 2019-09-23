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

define('NV_IS_ADMIN_DAILY', true);
define("PATH", NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file);

require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';
require NV_ROOTDIR . '/modules/' . $module_file . '/theme.php';

// function penetyList($filter = array('page' => 1, 'limit' => 10, 'date' => '')) {
function penetyList($filter = array('page' => 1, 'limit' => 10, 'from' => '', 'end' => '')) {
  global $db, $db_config;

  // if (empty($filter['date'])) $filter['date'] = date('d/m/Y');
  // $filter['date'] = totime($filter['date']);

  // $filter['from'] = date ('N', $filter['date']) == 1 ? strtotime(date('Y/m/d', $filter['date'])) : strtotime ('last monday', $filter['date']);
  // $filter['end'] = date('N', $filter['date']) == 7 ? strtotime(date('Y/m/d', $filter['date'])) : strtotime ('next sunday', $filter['date']);
  $check = 0;
  if (empty($filter['from'])) $check += 1;
  if (empty($filter['end'])) $check += 2;
  $xtra = '';

  switch ($check) {
    case 0:
      $filter['from'] = totime($filter['from']) + 60 * 60 * 24 - 1;
      $filter['end'] = totime($filter['end']);
      $xtra .= ' where time between ' . $filter['from'] . ' and '. $filter['end'];
      break;
    case 1:
      $filter['from'] = totime($filter['from']) + 60 * 60 * 24 - 1;
      $xtra .= ' where time <= ' . $filter['end'];
      break;
    case 2:
      $filter['from'] = totime($filter['from']);
      $xtra .= ' where time >= ' . $filter['from'];
      break;
  }

  $xtpl = new XTemplate("penety-list.tpl", PATH);

  $sql = 'select count(*) as count from `'. PREFIX .'_penety`'. $xtra;
  $query = $db->query($sql);
  $count = $query->fetch()['count'];
  $xtpl->assign('nav', navList($count, $filter['page'], $filter['limit'], 'goPage'));

  $sql = 'select a.*, b.first_name from `'. PREFIX .'_penety` a inner join `'. $db_config['prefix'] .'_users` b on a.userid = b.userid '. $xtra .' limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;

  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index ++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('user', $row['first_name']);
    $xtpl->assign('time', date('d/m/Y', $row['time']));
    $xtpl->assign('type', 'Buổi sáng');
    if ($row['type'] == 3) {
      $xtpl->assign('type', 'Buổi chiều');
    }
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}
