<?php

/**
 * @Project NUKEVIET-MUSIC
 * @Author Phan Tan Dung
 * @Copyright (C) 2011
 * @Createdate 26/01/2011 10:26 AM
 */
if (!defined('NV_IS_MOD_QUANLY'))
  die('Stop!!!');
$action = $nv_Request->get_string('action', 'post/get', '');

$url = "/$module_name/$op";
$filter = array(
  'page' => $nv_Request->get_int('page', 'get', 1),
  'limit' => $nv_Request->get_int('limit', 'get', 10)
);

checkUserPermit(NO_OVERCLOCK);

$type = 0;
$sql = 'select * from `'. VAC_PREFIX .'_user` where userid = ' . $user_info['userid'];
$query = $db->query($sql);
$user = $query->fetch();
if (!empty($user)) {
  if ($user['manager']) $type = 1;
}

if (!empty($action)) {
  $result = array('status' => 1);
  switch ($action) {
    case 'insert-xray':
      $data = $nv_Request->get_array('data', 'post');
      $data['cometime'] = totime($data['cometime']);

      $sql = "select * from `" . VAC_PREFIX . "_customer` where phone = '$data[phone]'";
      $query = $db->query($sql);
      if (!empty($customer = $query->fetch())) {
        $data['customer'] = $customer['id'];
        $sql = "update `" . VAC_PREFIX . "_customer` set name = '$data[name]', address = '$data[address]' where phone = '$data[phone]'";
        $db->query($sql);
      } else {
        $sql = "insert into `" . VAC_PREFIX . "_customer` (name, phone, address) values ('$data[name]', '$data[phone]', '$data[address]');";
        $db->query($sql);
        $data['customer'] = $db->lastInsertId();

        $sql = "insert into `" . VAC_PREFIX . "_pet` (name, customerid) values ('Chưa đặt tên', $data[customer]);";
        $db->query($sql);
        $data['pet'] = $db->lastInsertId();
      }

      if (empty($data['pet'])) {
        // thêm thú cưng mặc định
        $sql = "insert into `" . VAC_PREFIX . "_pet` (name, customerid) values ('Chưa đặt tên', $data[customer]);";
        $db->query($sql);
        $data['pet'] = $db->lastInsertId();
      }

      $sql = 'INSERT INTO `' . VAC_PREFIX . '_xray` (petid, doctorid, cometime, insult, ctime) VALUES (' . $data['pet'] . ', ' . $data['doctor'] . ', ' . $data['cometime'] . ', 0, ' . time() . ')';
      $db->query($sql);
      $id = $db->lastInsertId();

      $sql = 'INSERT INTO `' . VAC_PREFIX . '_xray_row` (xrayid, temperate, eye, other, treating, image, time, `condition`, doctor) VALUES (' . $id . ', "' . $data['temperate'] . '", "' . $data['eye'] . '", "' . $data['other'] . '", "' . $data['treating'] . '", "", ' . $data['cometime'] . ', ' . $data['condition'] . ', ' . $data['doctor'] . ')';
      $db->query($sql);

      $result['status'] = 1;
      $result['html'] = xrayContent();
      break;
    case 'insert-treat':
      $id = $nv_Request->get_int('id', 'post', '');
      $condition = $nv_Request->get_int('condition', 'post', 0);
      $doctor = $nv_Request->get_int('doctor', 'post', 0);

      $sql = 'select * from `' . VAC_PREFIX . '_xray_row` where xrayid = ' . $id . ' order by id desc';
      $query = $db->query($sql);
      $treat = $query->fetch();

      $sql = 'INSERT INTO `' . VAC_PREFIX . '_xray_row` (xrayid, temperate, eye, other, treating, image, time, `condition`, doctor) VALUES (' . $id . ', "", "", "", "", "", ' . ($treat['time'] + 60 * 60 * 24) . ', ' . $condition . ', ' . $doctor . ')';
      $db->query($sql);

      $result['status'] = 1;
      $result['data'] = getXrayTreatId($db->lastInsertId());
      break;
    case 'edit':
      $id = $nv_Request->get_int('id', 'post', 0);
      $type = $nv_Request->get_int('type', 'post', 0);
      $xray = $nv_Request->get_array('data', 'post');
      if (empty($xray['image'])) $xray['image'] = array();

      $sql = 'update `' . VAC_PREFIX . '_xray_row` set temperate = "' . $xray['temperate'] . '", eye = "' . $xray['eye'] . '", other = "' . $xray['other'] . '", treating = "' . $xray['treating'] . '", image = "' . implode(',', $xray['image']) . '", time = ' . $xray['time'] . ', `condition` = ' . $xray['condition'] . ', doctor = ' . $xray['doctor'] . ' where id = ' . $xray['id'];
      $db->query($sql);

      $sql = 'update `' . VAC_PREFIX . '_xray` set insult = '. $type .' where id = ' . $id;
      $db->query($sql);

      $result['status'] = 1;
      $result['html'] = xrayContent();
      break;
    case 'get-info':
      $lid = $nv_Request->get_string('id', 'post', '');

      $sql = "SELECT * from `" . VAC_PREFIX . "_xray` where id = " . $lid;
      $query = $db->query($sql);
      $xray = $query->fetch();

      $xray["cometime"] = date("d/m/Y", $xray["cometime"]);
      $pet = getPetById($xray['petid']);
      $customer = selectCustomerId($pet['customerid']);
      $xray['pet'] = $pet['name'];
      $xray['name'] = $customer['name'];
      $xray['phone'] = $customer['phone'];
      $xray['list'] = getXrayTreat($xray['id']);

      $result["status"] = 1;
      $result["data"] = $xray;
      break;
      case 'get-customer':
        $key = $nv_Request->get_string("key", "post", "");
        $type = $nv_Request->get_int("type", "post", 0);
        $xtpl = new XTemplate("suggest.tpl", PATH2);
  
        $xtra = 'name like "%' . $key . '%"';
        if ($type) $xtra = 'phone like "%' . $key . '%"';
  
        $sql = "select * from `" . VAC_PREFIX . "_customer` where $xtra limit 50";
        $customer_query = $db->query($sql);
        $result["list"] = "";
        while ($customer = $customer_query->fetch()) {
          $xtpl->assign("name", $customer["name"]);
          $xtpl->assign("phone", $customer["phone"]);
          $xtpl->assign("pet", petOption($customer['id']));
          $xtpl->parse("main");
        }
        $result["status"] = 1;
        $result["list"] = $xtpl->text();
        break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH2);
$xtpl->assign("lang", $lang_module);

$xtpl->assign("modal", xrayModal());
$xtpl->assign("content", xrayContent());
$xtpl->parse("main");
$contents = $xtpl->text("main");
include(NV_ROOTDIR . "/includes/header.php");
echo nv_site_theme($contents);
include(NV_ROOTDIR . "/includes/footer.php");
