<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_MAINFILE')) { die('Stop!!!'); }
define('PREFIX', $db_config['prefix'] . '_' . $module_name . '_');
define('BLOCK', NV_ROOTDIR . '/modules/' . $module_file . '/template/block/');
$remind_title = array('blood' => 'Xét nghiệm máu');

function checkCode($code) {
  global $db;

  $query = $db->query('select * from `'. PREFIX .'item` where code = "'. $code .'"');
  if ($query->fetch()) return 1;
  return 0;
}

function checkCategory($category) {
  global $db;

  $query = $db->query('select * from `'. PREFIX .'category` where name = "'. $category .'"');
  if ($row = $query->fetch()) return $row['id'];
  $db->query('insert into `'. PREFIX .'category` (name, active) values("'. $category .'", 1)');
  return $db->lastInsertId();
}

function categoryName($categoryid) {
  global $db;

  $query = $db->query('select * from `'. PREFIX .'category` where id = '. $categoryid);
  if ($row = $query->fetch()) return $row['name'];
  return 0;
}

function insertItem($data, $brand) {
  global $db;

  if ($brand) $xtra = $data['number'] . ', 0';
  else $xtra = '0, ' . $data['number'];

  $db->query('insert into `'. PREFIX .'item` (code, name, category, number, number2, bound, active, time) values("'. $data['code'] .'", "'. $data['name'] .'", '. $data['category'] .', '. $xtra .', 0, 1, '. time() .')');
  return $db->lastInsertId();
}

function updateItem($data) {
  global $db;

  $db->query('update `'. PREFIX .'item` set number = '. $data['number'] .', category = '. $data['category'] .' where code = "'. $data['code'] .'"');
  return true;
}

function checkLastBlood() {
  global $db, $db_config;

  $query = $db->query('select * from `'. $db_config['prefix'] .'_config` where config_name = "blood_number"');
  if (!empty($row = $query->fetch())) {
    return $row['config_value'];
  }
  $db->query('insert into `'. $db_config['prefix'] .'_config` (lang, module, config_name, config_value) values ("sys", "site", "blood_number", "1")');
  return 1;
}

function totime($time) {
  if (preg_match("/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/", $time, $m)) {
    $time = mktime(0, 0, 0, $m[2], $m[1], $m[3]);
    if (!$time) {
      $time = time();
    }
  }
  else {
    $time = time();
  }
  return $time;
}

function convert($str) {
  $str = mb_strtolower($str);
  $str = preg_replace("/(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)/", 'a', $str);
  $str = preg_replace("/(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)/", 'e', $str);
  $str = preg_replace("/(ì|í|ị|ỉ|ĩ)/", 'i', $str);
  $str = preg_replace("/(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)/", 'o', $str);
  $str = preg_replace("/(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)/", 'u', $str);
  $str = preg_replace("/(ỳ|ý|ỵ|ỷ|ỹ)/", 'y', $str);
  $str = preg_replace("/(đ)/", 'd', $str);
  return $str;
}

function loadModal($file_name) {
  $xtpl = new XTemplate($file_name . '.tpl', PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function getDoctorList() {
  global $db, $db_config;

  $list = array();
  $query = $db->query('select a.userid, a.first_name from `'. $db_config['prefix'] .'_rider_user` b inner join `'. $db_config['prefix'] .'_users` a on a.userid = b.user_id where b.type = 1');
  while ($row = $query->fetch()) {
    $list[$row['userid']] = $row['first_name'];
  }
  return $list;
}

function bloodStatistic() {
  global $db, $db_config, $module_name, $nv_Request;
  $filter = $nv_Request->get_array('filter', 'post');
  $total = array('import' => 0, 'number' => 0, 'count' => 0, 'real' => 0);

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
      $filter['from'] = $time - 60 * 60 * 24 * 15;
      $filter['end'] = $time + 60 * 60 * 24 * 15;
    break;
    default:
      $filter['from'] = totime($filter['from']);
      $filter['end'] = totime($filter['end']);
  }
  
  $xtpl = new XTemplate("statistic-list.tpl", BLOCK);
  $xtpl->assign('from', date('d/m/Y', $filter['from']));
  $xtpl->assign('end', date('d/m/Y', $filter['end']));
  $doctor = getDoctorList();

  $sql = 'select * from `'. PREFIX .'blood_row` where (time between '. $filter['from'] .' and '. $filter['end'] .')';
  $query = $db->query($sql);
  $data = array();
  while ($row = $query->fetch()) {
    if (empty($data[$row['doctor']])) {
      $data[$row['doctor']]= array(
        'number' => 0,
        'real' => 0,
        'count' => 0
      );
    }
    $total['count'] ++;
    $total['number'] += $row['number'];
    $total['real'] += ($row['start'] - $row['end']);
    $data[$row['doctor']]['count'] ++;
    $data[$row['doctor']]['number'] += $row['number'];
    $data[$row['doctor']]['real'] += ($row['start'] - $row['end']);
  }

  if (count($data)) {
    foreach ($data as $doctorid => $counter) {
      $xtpl->assign('doctor', $doctor[$doctorid]);
      $xtpl->assign('number', $counter['number']);
      $xtpl->assign('real', $counter['real']);
      $xtpl->assign('count', $counter['count']);
      $xtpl->parse('main.row');
    }
  }
  else {
    $xtpl->parse('main.non');
  }

  $sql = 'select * from `'. PREFIX .'blood_import` where (time between '. $filter['from'] .' and '. $filter['end'] .')';
  $query = $db->query($sql);
  while ($row = $query->fetch()) {
    $total['import'] += $row['number']; // tổng tiền nhập
  }
  $xtpl->assign('import', number_format($total['import'] * 1000, 0, '', ',') . ' VNĐ');
  $xtpl->assign('count', $total['count']);
  $xtpl->assign('number', $total['number']);
  $xtpl->assign('real', $total['real']);

  $xtpl->parse('main');
  return $xtpl->text();
}

function parseFilter($filter) {
  if (empty($filter['page'])) $filter['page']  = 1;
  if (empty($filter['limit'])) $filter['limit']  = 10;
  return $filter;
}
