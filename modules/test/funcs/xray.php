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

if (!empty($action)) {
  $result = array('status' => 1);
  switch ($action) {
    case 'insert-xray':
      $data = $nv_Request->get_array('data', 'post');
      $data['cometime'] = totime($data['cometime']);

      $sql = 'INSERT INTO `' . VAC_PREFIX . '_xray` (petid, doctorid, cometime, insult, ctime) VALUES (' . $data['pet'] . ', ' . $data['doctor'] . ', ' . $data['cometime'] . ', 0, ' . time() . ')';
      $db->query($sql);
      $id = $db->lastInsertId();

      $sql = 'INSERT INTO `' . VAC_PREFIX . '_xray_row` (xrayid, temperate, eye, other, treating, image, time, `condition`, doctor) VALUES (' . $id . ', "' . $data['temperate'] . '", "' . $data['eye'] . '", "' . $data['other'] . '", "' . $data['treating'] . '", "", ' . $data['cometime'] . ', ' . $data['condition'] . ', ' . $data['doctor'] . ')';
      $db->query($sql);

      $result['status'] = 1;
      $result['html'] = xrayContent();
      break;
    case 'edit':
      $id = $nv_Request->get_int('id', 'post', 0);
      $type = $nv_Request->get_int('type', 'post', 0);
      $data = $nv_Request->get_array('data', 'post');

      foreach ($data as $xray) {
        // nếu chưa có id thì insert
        if (!$xray['id']) {
          $sql = 'INSERT INTO `' . VAC_PREFIX . '_xray_row` (xrayid, temperate, eye, other, treating, image, time, `condition`, doctor) VALUES (' . $id . ', "' . $xray['temperate'] . '", "' . $xray['eye'] . '", "' . $xray['other'] . '", "' . $xray['treating'] . '", "'. implode(',', $xray['image']) .'", ' . $xray['time'] . ', ' . $xray['condition'] . ', ' . $xray['doctor'] . ')';
        }
        else {
          $sql = 'update `' . VAC_PREFIX . '_xray_row` set temperate = "' . $xray['temperate'] . '", eye = "' . $xray['eye'] . '", other = "' . $xray['other'] . '", treating = "' . $xray['treating'] . '", image = "'. implode(',', $xray['image']) .'" time = ' . $xray['time'] . ', `condition` = ' . $xray['condition'] . ', doctor = ' . $xray['doctor'] . ' where id = ' . $xray['id'];
        }
        $db->query($sql);
      }
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
