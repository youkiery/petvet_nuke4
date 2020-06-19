<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 10/03/2010 10:51
 */

if (!defined('NV_SYSTEM')) {
  die('Stop!!!');
}

define('NV_IS_MOD_QUANLY', true);
define('PATH', NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
define('PATH2', NV_ROOTDIR . "/modules/" . $module_file . '/template/user/' . $op);
require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';
// kiểm tra phân quyền

$opType = array('main' => 1, 'confirm' => 1, 'list' => 1, 'vac_list' => 1, 'sieuam' => 2, 'danhsachsieuam' => 2, 'sieuam-birth' => 2, 'themsieuam' => 2, 'xacnhansieuam' => 2, 'luubenh' => 3, 'danhsachluubenh' => 3, 'themluubenh' => 3, 'spa' => 4, 'redrug' => 5, 'heal' => 6, 'heal_drug' => 6);

$check = false;
if (!empty($user_info) && !empty($user_info['userid'])) {
  $sql = 'select * from `' . $db_config['prefix'] . '_users` where userid = ' . $user_info['userid'];
  $query = $db->query($sql);
  $user = $query->fetch();
  $group = explode(',', $user['in_groups']);
  if (!(in_array('1', $group) || in_array('2', $group))) {
    if ($op !== 'proces' && !empty($opType[$op])) {
      $sql = 'select * from `pet_test_heal_manager` where groupid in (' . implode(',', $user_info['in_groups']) . ') and type = ' . $opType[$op];
      $query = $db->query($sql);

      if (empty($query->fetch())) {
        $check = true;
        $contents = '<p style="padding: 10px;">Tài khoản chưa có quyền truy cập nội dung này</p>';
      } else if ($op == 'heal' || $op == 'heal_drug' || $op == 'spa') {
      } else {
        $today = strtotime(date('Y/m/d'));
        $time = time();
        $fromTime = $today + $vacconfigv2['hour_from'] * 60 * 60 + $vacconfigv2['minute_from'] * 60;
        $endTime = $today + $vacconfigv2['hour_end'] * 60 * 60 + $vacconfigv2['minute_end'] * 60;

        if ($time < $fromTime || $time > $endTime) {
          $check = true;
          $contents = '<p style="padding: 10px;">Đã quá thời gian làm việc, xin vui lòng quay lại sau</p>';
        }
      }
    }
  }
} else {
  $check = true;
  $contents = '<p style="padding: 10px;">Chỉ có thành viên được phân quyền mới có thể thấy được mục này</p>';
}

if ($check) {
  include(NV_ROOTDIR . "/includes/header.php");
  echo nv_site_theme($contents);
  include(NV_ROOTDIR . "/includes/footer.php");
  die();
}

function usgModal($lang_module)
{
  global $sort_type, $filter_type, $filter_data;
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $doctor = getDoctorList();
  $xtpl->assign('keyword', $filter_data['keyword']);
  $xtpl->assign('filter' . $filter_data['filter'], 'selected');
  $xtpl->assign('lang', $lang_module);
  $xtpl->assign('now', date('d/m/Y', time()));
  $xtpl->assign('expecttime', date('d/m/Y', time() + 60 * 60 * 24 * 25));

  $diseases = getDiseaseList();
  foreach ($diseases as $key => $value) {
    $xtpl->assign("id", $value["id"]);
    $xtpl->assign("name", $value["name"]);
    $xtpl->parse("main.disease");
    $xtpl->parse("main.disease2");
  }

  foreach ($doctor as $data) {
    $xtpl->assign('doctor_value', $data['id']);
    $xtpl->assign('doctor_name', $data['name']);
    $xtpl->parse('main.doctor');
    $xtpl->parse('main.doctor2');
    $xtpl->parse('main.doctor3');
    $xtpl->parse('main.doctor4');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function usgCurrentList($filter)
{
  switch ($filter['type']) {
    case 2:
      // danh sách đã sinh
      return usgBirthList($filter);
      break;
    case 3:
      // danh sách tiêm phòng
      return usgVaccineList($filter);
      break;
    case 4:
      // danh sách quản lý
      return usgManageList($filter);
      // closed
      break;
    default:
      // mạc định danh sách gần sinh
      return usgRecallList($filter);
  }
}

function usgRecallList($filter)
{
  global $db, $module_name, $op, $vacconfigv2, $lang_module;

  $status_list = array('Chưa gọi', 'Đã gọi');
  $xtpl = new XTemplate("recall-list.tpl", PATH2);
  $xtpl->assign('lang', $lang_module);
  $index = 1;
  $time = time() + $vacconfigv2['filter'];
  $overtime = time();

  $sql = 'select a.id, a.usgtime, a.expecttime, a.expectnumber, a.doctorid, b.id as petid, b.name as petname, c.name as customer, c.phone from `' . VAC_PREFIX . '_usg2` a inner join `' . VAC_PREFIX . '_pet` b on a.petid = b.id inner join `' . VAC_PREFIX . '_customer` c on b.customerid = c.id where expecttime < ' . $time . ' and a.status = ' . $filter['status'] . ' order by expecttime asc';
  $query = $db->query($sql);

  $status = $filter['status'];
  $recall = array(0 => 'left', 'right');
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('customer', $row['customer']);
    $xtpl->assign('phone', $row['phone']);
    $xtpl->assign('expectnumber', $row['expectnumber']);
    $xtpl->assign('expecttime', date('d/m/Y', $row['expecttime']));
    if ($row['expecttime'] < $overtime) $xtpl->assign('bgcolor', 'orange');
    else $xtpl->assign('bgcolor', '');
    if ($filter['allow'] > 1) {
      $xtpl->parse('main.row.note');
      $xtpl->parse('main.row.' . $recall[$status]);
    }
    $xtpl->parse('main.row');
  }
  for ($i = 0; $i < 2; $i++) {
    $filter['status'] = $i;
    if ($status == $i) $xtpl->assign('recall_select', 'btn-info');
    else $xtpl->assign('recall_select', 'btn-default');
    $xtpl->assign('recall_link', '/' . $module_name . '/' . $op . '/?' . http_build_query($filter));
    $xtpl->assign('recall_name', $status_list[$i]);
    $xtpl->parse('main.button');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function usgBirthList($filter)
{
  global $db, $module_name, $op, $vacconfigv2;

  $xtpl = new XTemplate("birth-list.tpl", PATH2);
  $index = 1;
  $time = time() + $vacconfigv2['filter'];
  $overtime = time();

  $sql = 'select a.id, a.usgtime, a.birthtime, a.number, b.id as petid, b.name as petname, c.name as customer, c.phone from `' . VAC_PREFIX . '_usg2` a inner join `' . VAC_PREFIX . '_pet` b on a.petid = b.id inner join `' . VAC_PREFIX . '_customer` c on b.customerid = c.id where birthtime < ' . $time . ' and a.status = 2 order by birthtime asc';
  $query = $db->query($sql);
  if ($filter['allow'] > 1) $xtpl->parse('main.manager');

  $recall = array(0 => 'left', 'right');
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('customer', $row['customer']);
    $xtpl->assign('phone', $row['phone']);
    $xtpl->assign('number', $row['number']);
    $xtpl->assign('birthtime', date('d/m/Y', $row['birthtime']));
    if ($row['birthtime'] < $overtime) $xtpl->assign('bgcolor', 'orange');
    else $xtpl->assign('bgcolor', '');
    if ($filter['allow'] > 1) $xtpl->parse('main.row.manager2');
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function usgVaccineList($filter)
{
  global $db, $module_name, $op, $vacconfigv2;

  $xtpl = new XTemplate("vaccine-list.tpl", PATH2);
  $index = 1;
  $time = time() + $vacconfigv2['filter'];

  $sql = 'select a.id, a.usgtime, a.vaccinetime, a.number, b.id as petid, b.name as petname, c.name as customer, c.phone from `' . VAC_PREFIX . '_usg2` a inner join `' . VAC_PREFIX . '_pet` b on a.petid = b.id inner join `' . VAC_PREFIX . '_customer` c on b.customerid = c.id where vaccinetime < ' . $time . ' and a.status = 3 order by vaccinetime asc';
  $query = $db->query($sql);

  $recall = array(0 => 'left', 'right');
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('customer', $row['customer']);
    $xtpl->assign('phone', $row['phone']);
    $xtpl->assign('number', $row['number']);
    if ($row['vaccinetime']) $xtpl->assign('vaccinetime', date('d/m/Y', $row['vaccinetime']));
    else $xtpl->assign('vaccinetime', 'Không tiêm phòng');
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function usgManageList($filter)
{
  global $db, $lang_module, $module_name, $op;
  $xtpl = new XTemplate("manage-list.tpl", PATH2);
  $xtpl->assign("lang", $lang_module);
  $usg_status = array(0 => 'Chưa gọi', 'Đã gọi', 'Đã sinh', 'Đã tiêm', 'Đã tái chủng');

  $sql = 'select count(*) as count from `' . VAC_PREFIX . '_usg2` a inner join `' . VAC_PREFIX . '_pet` b on a.petid = b.id inner join `' . VAC_PREFIX . '_customer` c on b.customerid = c.id';
  $query = $db->query($sql);
  $num = $query->fetch()['count'];

  $sql = 'select a.id, a.usgtime, a.vaccinetime, a.expecttime, a.status, b.id as petid, b.name as petname, c.name as customer, c.phone from `' . VAC_PREFIX . '_usg2` a inner join `' . VAC_PREFIX . '_pet` b on a.petid = b.id inner join `' . VAC_PREFIX . '_customer` c on b.customerid = c.id order by id desc limit 20 offset ' . ($filter['page'] - 1) * 20;

  $query = $db->query($sql);

  $index = ($filter['page'] - 1) * 20 + 1;
  while ($row = $query->fetch()) {
    $xtpl->assign("index", $index++);
    $xtpl->assign("id", $row["id"]);
    $xtpl->assign("customer", $row["customer"]);
    $xtpl->assign("phone", $row["phone"]);
    $xtpl->assign("expecttime", date('d/m/Y', $row["expecttime"]));
    $xtpl->assign("recall", $usg_status[$row['status']]);
    $xtpl->parse("main.row");
  }

  $xtpl->assign("nav_link", nav_generater("/index.php?nv=$module_name&op=$op&type=4&keyword=$filter[keyword]", $num, $filter['page'], 20));

  $xtpl->parse("main");
  return $xtpl->text("main");
}

function vaccineModal()
{
  global $db, $lang_module, $vacconfigv2;
  $xtpl = new XTemplate('modal.tpl', PATH2);
  $xtpl->assign('lang', $lang_module);
  $sql = "select * from " . VAC_PREFIX . "_doctor";
  $query = $db->query($sql);

  $xtpl->assign("now", date('d/m/Y'));
  $xtpl->assign("calltime", date('d/m/Y', time() + $vacconfigv2['recall']));
  while ($row = $query->fetch()) {
    $xtpl->assign("doctorid", $row["id"]);
    $xtpl->assign("doctorname", $row["name"]);
    $xtpl->parse("main.doctor");
    $xtpl->parse("main.doctor2");
  }

  $diseases = getDiseaseList();
  foreach ($diseases as $key => $value) {
    $xtpl->assign("disease_id", $value["id"]);
    $xtpl->assign("disease_name", $value["name"]);
    $xtpl->parse("main.option");
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function vaccineList($vaclist, $overdate = 0, $search = 0)
{
  global $db, $module_info, $module_file, $lang_module, $nv_Request, $vacconfigv2, $filter;
  // initial
  $xtpl = new XTemplate("list.tpl", PATH2);
  $xtpl->assign("lang", $lang_module);
  $now = strtotime(date("Y-m-d"));
  $color = array('1' => 'yellow', '2' => 'green', '3' => 'gray');
  $diseases = getDiseaseData();

  $xtpl->assign('brickcolor', '');
  if ($overdate) {
    $xtpl->assign('brickcolor', 'orange');
  }

  foreach ($vaclist as $row) {
    $pet = selectPetId($row['petid']);
    $customer = selectCustomerId($pet['customerid']);

    $xtpl->assign("petname", $pet["name"]);
    $xtpl->assign("petid", $row["petid"]);
    $xtpl->assign("vacid", $row["id"]);
    $xtpl->assign("customer", $customer["name"]);
    $xtpl->assign("phone", $customer["phone"]);
    $xtpl->assign("diseaseid", $row["diseaseid"]);
    $xtpl->assign("disease", $diseases[$row["diseaseid"]]);
    $xtpl->assign("note", $row["note"]);
    $xtpl->assign("confirm", $lang_module["confirm_" . $row["status"]]);
    if ($search) {
      $xtpl->parse('main.row.note');
    } else {
      if ($filter['allow'] > 1) {
        $xtpl->parse('main.row.note2');
        if ($filter['status'] < 2) {
          $xtpl->parse('main.row.right');
        }
        if ($filter['status'] == 1) {
          $xtpl->parse('main.row.left');
        }
      }
    }

    $xtpl->assign("color", "red");
    if (!empty($color[$row['status']])) {
      $xtpl->assign("color", $color[$row['status']]);
    }
    $xtpl->assign("cometime", date("d/m/Y", $row["cometime"]));
    if ($filter['status'] == 2) {
      $xtpl->assign("calltime", date("d/m/Y", $row["recall"]));
    } else {
      $xtpl->assign("calltime", date("d/m/Y", $row["calltime"]));
    }
    $xtpl->parse("main.row");
  }
  $xtpl->parse("main");
  return $xtpl->text();
}

function vaccineSearchAll()
{
  global $db, $filter;
  $sql = "select a.id, a.note, a.recall, b.id as petid, b.name as petname, c.id as customerid, c.name as customer, c.phone as phone, cometime, calltime, ctime, a.status, diseaseid, dd.name as disease from " . VAC_PREFIX . "_vaccine a inner join " . VAC_PREFIX . "_pet b on a.petid = b.id inner join " . VAC_PREFIX . "_customer c on b.customerid = c.id inner join " . VAC_PREFIX . "_disease dd on a.diseaseid = dd.id where (c.name like '%$filter[keyword]%' or c.phone like '%$filter[keyword]%')  order by calltime desc limit 50";
  $query = $db->query($sql);
  $list = fetchall($db, $query);
  return vaccineList($list, 0, 1);
}

function vaccineContent($keyword = '')
{
  global $db, $vacconfigv2, $filter;
  // initial
  $today = strtotime(date("Y-m-d"));
  $list = array();

  switch ($filter['page']) {
    case 1:
      // lọc thêm hôm nay
      $end = $today + 60 * 60 * 24 - 1;
      $where = "where ctime between $today and $end and a.status = $filter[status]";
      break;
    case 2:
      // lọc tái chủng hôm nay
      $end = $today + 60 * 60 * 24 - 1;
      $where = "where calltime between $today and $end and a.status = $filter[status]";
      break;
    default:
      // filter time
      $time = $vacconfigv2["filter"];
      if (empty($time)) {
        $time = 60 * 60 * 24 * 14;
      }
      $from = $today;
      $end = $today + $time - 1;
      $where = "where calltime between $from and $end and a.status = $filter[status]";
  }

  $sql = "select a.id, a.note, a.recall, b.id as petid, b.name as petname, c.id as customerid, c.name as customer, c.phone as phone, cometime, calltime, ctime, a.status, diseaseid, dd.name as disease from " . VAC_PREFIX . "_vaccine a inner join " . VAC_PREFIX . "_pet b on a.petid = b.id inner join " . VAC_PREFIX . "_customer c on b.customerid = c.id inner join " . VAC_PREFIX . "_disease dd on a.diseaseid = dd.id $where order by calltime";
  $query = $db->query($sql);
  $list = fetchall($db, $query);
  // nếu status = chưa gọi hoặc đã gọi, hiển thị quá hạn
  if ($filter['status'] < 2) {
    $sql = "select a.id, a.note, a.recall, b.id as petid, b.name as petname, c.id as customerid, c.name as customer, c.phone as phone, cometime, calltime, ctime, a.status, diseaseid, dd.name as disease from " . VAC_PREFIX . "_vaccine a inner join " . VAC_PREFIX . "_pet b on a.petid = b.id inner join " . VAC_PREFIX . "_customer c on b.customerid = c.id inner join " . VAC_PREFIX . "_disease dd on a.diseaseid = dd.id where calltime < " . $today . " && a.status = $filter[status] order by calltime desc limit 50";
    // die($sql);
    $query = $db->query($sql);
    $list2 = fetchall($db, $query);
    if (count($list2)) return vaccineList($list2, 1) . vaccineList($list);
  }
  return vaccineList($list);
}

function petOption($id)
{
  global $db;

  $sql = "select * from `" . VAC_PREFIX . "_pet` where customerid = " . $id;
  $query = $db->query($sql);
  $xtpl = new XTemplate('option.tpl', PATH2);
  while ($row = $query->fetch()) {
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('value', $row['id']);
    $xtpl->parse('main');
  }
  return $xtpl->text();
}

function checkPermission($module, $userid)
{
  global $db, $db_config, $module_name;

  if (!empty($userid)) {
    $sql = 'select * from `' . $db_config['prefix'] . '_' . $module_name . '_setting` where module = "' . $module . '" and userid = ' . $userid;
    $query = $db->query($sql);
    $setting = $query->fetch();
    if (!empty($setting)) {
      return $setting['type'];
    }
  }
  return 0;
}

function kaizenList($userid)
{
  global $db, $db_config, $user_info, $filter, $module_name, $op;

  $index = 1;
  $start = $filter['limit'] * ($filter['page'] - 1);
  $xtpl = new XTemplate("list.tpl", PATH2);
  $user = getUserList();

  $xtra = '';
  if ($filter['allow'] < 2) {
    $xtpl->assign('time_cell', 3);
    $xtra = 'where userid = ' . $userid;
  } else {
    $xtpl->assign('time_cell', 2);
  }

  $sql = 'select count(id) as count from `' . VAC_PREFIX . '_kaizen` ' . $xtra;
  $query = $db->query($sql);
  $count = $query->fetch()['count'];

  $sql = 'select * from `' . VAC_PREFIX . '_kaizen` ' . $xtra . ' order by edit_time desc limit ' . $filter['limit'] . ' offset ' . ($filter['limit'] * ($filter['page'] - 1));
  $query = $db->query($sql);
  $check = false;

  while ($row = $query->fetch()) {
    $check = true;
    $xtpl->assign('index', ($start + $index++));
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('user', $user[$row['userid']]['first_name']);
    $xtpl->assign('time', date('d/m/Y H:i', $row['edit_time']));
    $xtpl->assign('problem', $row['problem']);
    $xtpl->assign('solution', $row['solution']);
    $xtpl->assign('result', $row['result']);
    if ($filter['allow'] > 1) {
      $xtpl->parse('main.inbox.row.manager');
      $xtpl->parse('main.inbox.row.manager2');
    }
    $xtpl->parse('main.inbox.row');
  }

  if ($check) {
    $xtpl->parse('main.inbox');
  } else {
    $xtpl->parse('main.empty');
  }

  $xtpl->assign('count', $count);
  $xtpl->assign('nav', nav_generater("/index.php?nv=$module_name&op=$op", $count, $filter['page'], $filter['limit']));

  $xtpl->parse('main');
  return $xtpl->text();
}

function getUser($userid)
{
  global $db, $db_config;

  $sql = 'select userid, first_name, last_name from `' . $db_config['prefix'] . '_users` where userid = ' . $userid;
  $query = $db->query($sql);

  if ($row = $query->fetch()) {
    return $row;
  }
  return array('userid' => 0, 'first_name' => '', 'last_name' => '');
}

function getRowList($userid = 0, $page = 1, $limit = 10)
{
  global $db, $nv_Request, $db_config;

  $sql = 'select count(id) as count from `' . VAC_PREFIX . '_kaizen` where userid = ' . $userid;
  $query = $db->query($sql);
  $count = $query->fetch();
  $sql = 'select * from `' . VAC_PREFIX . '_kaizen` where userid = ' . $userid . ' order by edit_time desc limit ' . $limit . ' offset ' . ($limit * ($page - 1));
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $list[] = $row;
  }
  return array('count' => $count['count'], 'data' => $list);
}

function kaizenModal()
{
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $xtpl->parse('main');
  return $xtpl->text();
}

function spaModal()
{
  global $lang_module, $spa_option, $allow;
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $xtpl->assign('lang', $lang_module);

  $doctor_list = getdoctorlist();
  foreach ($doctor_list as $doctor) {
    $xtpl->assign("doctor_value", $doctor["id"]);
    $xtpl->assign("doctor_name", $doctor["name"]);
    $xtpl->parse("main.doctor");
  }

  foreach ($spa_option as $id => $option) {
    $xtpl->assign("id", $id);
    $xtpl->assign("name", $option);
    $xtpl->parse("main.box");
  }

  if ($allow > 1) $xtpl->parse('main.manager');
  $xtpl->parse('main');
  return $xtpl->text();
}

function spaList()
{
  global $db, $lang_module, $global_config, $module_file, $allow;
  $xtpl = new XTemplate("list.tpl", PATH2);
  $xtpl->assign("lang", $lang_module);
  $xtpl->assign("link", "/themes/" . $global_config["site_theme"] . "/images/" . $module_file . "/payment.gif");
  $status = array("Chưa xong", "Đã xong");
  $from = strtotime(date("Y-m-d"));
  $end = $from + 60 * 60 * 24;
  $index = 1;

  $doctor = getdoctorlist();
  $doctor[0]['name'] = 'Chưa chọn';

  $sql = "select * from `" . VAC_PREFIX . "_spa` where time between $from and $end order by id";
  $query = $db->query($sql);
  while ($row = $query->fetch()) {
    $sql = "select * from `" . VAC_PREFIX . "_customer` where id = " . $row["customerid"];
    $customer_query = $db->query($sql);
    $customer = $customer_query->fetch();
    $xtpl->assign("index", $index++);
    if ($row["done"] > 0) $xtpl->assign("spa_end", date("H:i:s", $row["done"]));
    else $xtpl->assign("spa_end", 'Chưa xong');

    $xtpl->assign("id", $row["id"]);
    $xtpl->assign("customer_name", $customer["name"]);
    $xtpl->assign("customer_number", $customer["phone"]);
    $xtpl->assign("spa_from", date("H:i:s", $row["time"]));
    $xtpl->assign("image", $row["image"]);
    if ($allow > 1 && !$row['done']) $xtpl->parse('main.row.complete');
    if ($row['payment']) $xtpl->parse('main.row.confirm');
    else if ($allow > 1) $xtpl->parse('main.row.paid');
    $xtpl->parse("main.row");
  }
  $xtpl->parse("main");
  $text = $xtpl->text();
  return $text;
}

function xrayModal()
{
  global $lang_module, $db, $status_option;
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $xtpl->assign("lang", $lang_module);

  $today = date("d/m/Y", NV_CURRENTTIME);
  // echo $thongbao; die();

  $xtpl->assign("now", $today);

  $sql = "select * from " .  VAC_PREFIX . "_doctor";
  $result = $db->query($sql);

  while ($row = $result->fetch()) {
    $xtpl->assign("doctor_value", $row["id"]);
    $xtpl->assign("doctor_name", $row["name"]);
    $xtpl->parse("main.doctor");
  }

  // var_dump($status_option);

  foreach ($status_option as $key => $value) {
    // echo $value;
    $xtpl->assign("status_value", $key);
    $xtpl->assign("status_name", $value);
    $xtpl->parse("main.status");
  }
  // die();

  $xtpl->parse('main');
  return $xtpl->text();
}

function xrayContent()
{
  global $url, $filter, $status_option, $db;
  $xtpl = new XTemplate("content.tpl", PATH2);

  $sql = "select count(id) as count from `" . VAC_PREFIX . "_xray`";
  $query = $db->query($sql);
  $number = $query->fetch()['count'];

  $sql = "select * from `" . VAC_PREFIX . "_xray` order by cometime desc limit $filter[limit] offset ". ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);

  while ($xray = $query->fetch()) {
    $pet = getPetById($xray['petid']);
    $customer = selectCustomerId($pet['customerid']);
    $xray_treat = getXrayTreat($xray['id']);
    $last_treat = $xray_treat[count($xray_treat) - 1];
    $xtpl->assign('id', $xray['id']);
    $xtpl->assign('customer', $customer['name']);
    $xtpl->assign('phone', $customer['phone']);
    $xtpl->assign('cometime', date('d/m/Y', $xray['cometime']));
    $xtpl->assign('condition', $status_option[$last_treat['condition']]);
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', nav_generater($url . '?', $number, $filter['page'], $filter['limit']));

  $xtpl->parse('main');
  return $xtpl->text();
}
