<?php

/**
 * @Project WORK SCHEDULES 4.X
 * @Author PHAN TAN DUNG (phantandung92@gmail.com)
 * @Copyright (C) 2016 PHAN TAN DUNG. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Sat, 11 Jun 2016 23:45:51 GMT
 */
if (!defined('NV_SYSTEM')) die('Stop!!!');
define('NV_MOD_WORK_SCHEDULES', true);
define("PATH", NV_ROOTDIR . '/modules/' . $module_file .'/template/user/'. $op);
require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';

// Các trường dữ liệu
// $array_field_config = array();
// $result_field = $db->query('SELECT * FROM ' . NV_PREFIXLANG . '_' . $module_data . '_field ORDER BY weight ASC');
// while ($row_field = $result_field->fetch()) {
//     $language = unserialize($row_field['language']);
//     $row_field['title'] = (isset($language[NV_LANG_DATA])) ? $language[NV_LANG_DATA][0] : $row['field'];
//     $row_field['description'] = (isset($language[NV_LANG_DATA])) ? nv_htmlspecialchars($language[NV_LANG_DATA][1]) : '';
//     if (!empty($row_field['field_choices'])) {
//         $row_field['field_choices'] = unserialize($row_field['field_choices']);
//     } elseif (!empty($row_field['sql_choices'])) {
//         $row_field['sql_choices'] = explode('|', $row_field['sql_choices']);
//         $query = 'SELECT ' . $row_field['sql_choices'][2] . ', ' . $row_field['sql_choices'][3] . ' FROM ' . $row_field['sql_choices'][1];
//         $result = $db->query($query);
//         $weight = 0;
//         while (list($key, $val) = $result->fetch(3)) {
//             $row_field['field_choices'][$key] = $val;
//         }
//     }
//     $array_field_config[$row_field['field']] = $row_field;
// }


// if (defined('NV_IS_SPADMIN')) {
//     define('NV_IS_MANAGER_ADMIN', true);
// } elseif (defined('NV_IS_USER') and !empty($module_info['admins']) and !empty($user_info['userid']) and in_array($user_info['userid'], explode(',', $module_info['admins']))) {
//     define('NV_IS_MANAGER_ADMIN', true);
// }

function mainModal() {
  global $lang_module, $filter, $manager;
  $xtpl = new XTemplate('modal.tpl', PATH);
  if (empty($filter['start'])) $start = time();
  else $start = $filter['start'];
  if (empty($filter['end'])) $end = time() + 60 * 60 * 24 * 7;
  else $end = $filter['end'];

  if ($manager) $xtpl->parse('main.manager');

  $xtpl->assign('manager_content', managerContent());
  $xtpl->assign('starttime', date('d/m/Y', $start));
  $xtpl->assign('endtime', date('d/m/Y', $end));
  $xtpl->assign('lang', $lang_module);
  $xtpl->parse('main');
  return $xtpl->text();
}

function mainContent() {
  global $db, $useridlist, $filter, $manager, $user_info;
  $xtpl = new XTemplate('list.tpl', PATH);

  $xtra = array();

  if ($manager) {
    $timecheck = 0;
    if ($filter['start']) $timecheck += 1;
    if ($filter['end']) $timecheck += 2;
  
    switch ($timecheck) {
      case 0: 
        // không chứa thời gian
      break;
      case 1: 
        // chỉ có ngày bắt đầu
        $xtra []= '(last_time >= '. $filter['start'] .')';
      break;
      case 2: 
        // chỉ có ngày kết thúc
        $xtra []= '(last_time <= '. $filter['end'] .')';
      break;
      case 3: 
        // có cả 2 thờigian
        $xtra []= '(last_time between '. $filter['start'] .' and '. $filter['end'] .')';
      break;
    }
  
    if (count($filter['user'])) $xtra []= 'userid in ('. implode(',', $useridlist) .')';
    else $xtra = '';
  }
  else {
    $xtra []= 'userid = ' . $user_info['userid'];
  }

  if ($filter['done']) $xtra []= 'process < 100';
  if (count($xtra)) $xtra = ' where ' . implode(' and ', $xtra);

  $sql = 'select count(*) as count from `'. PREFIX .'_row`' . $xtra;
  $query = $db->query($sql);
  $number = $query->fetch()['count'];

  $sql = 'select * from `'. PREFIX .'_row` '. $xtra .'  order by calltime desc limit ' . $filter['limit'] . ' offset '. $filter['limit'] * ($filter['page'] - 1);
  $query = $db->query($sql);
  $today = time();
  while ($row = $query->fetch()) {
    $user = getUserById($row['userid']);
    $xtpl->assign('color', '');
    if ($row['process'] === 100) $xtpl->assign('color', 'green');
    else if ($today > $row['calltime']) $xtpl->assign('color', 'red');
    $xtpl->assign('start', date('d/m/Y', $row['cometime']));
    $xtpl->assign('end', date('d/m/Y', $row['calltime']));
    $xtpl->assign('content', $row['content']);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('user', $user['first_name']);
    $xtpl->assign('calltime', date('d/m/Y', $row['calltime']));
    $xtpl->assign('process', $row['process']);
    $xtpl->assign('note', $row['note']);
    if (!empty($row['note'])) $xtpl->parse('main.row.note');
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', nav_generater($filter['url'], $number, $filter['page'], $filter['limit']));

  $xtpl->parse('main');
  return $xtpl->text();
}

function managerContent() {
  global $db;
  $xtpl = new XTemplate('manager-list.tpl', PATH);
  $rev = array(1 => 2, 1);
  $employ = getWorkEmploy();

  foreach ($employ as $employdata) {
    $userdata = getUserById($employdata['id']);
    $xtpl->assign('userid', $employdata['id']);
    $xtpl->assign('name', $employdata['name']);
    $xtpl->assign('username', $userdata['username']);
    $xtpl->assign('rev_role', $rev[$employdata['role']]);
    if ($employdata['role'] > 1) $xtpl->assign('btn_manager', 'btn-info');
    else $xtpl->assign('btn_manager', 'btn-default');
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}
