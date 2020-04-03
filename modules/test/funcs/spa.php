<?php

/**
* @Project PETCOFFEE 
* @Youkiery (youkiery@gmail.com)
* @Copyright (C) 2019
* @Createdate 13-11-2019 16:00
*/
if (!defined('NV_IS_MOD_QUANLY')) {
  die('Stop!!!');
}
define('MODULE', 'spa');

$spa_option = array(
  "wash_dog" => "Tắm chó",
  "wash_cat" => "Tắm mèo",
  "wash_white" => "Tắm trắng",
  "cut_fur" => "Cắt lông",
  "shave_foot" => "Cạo lông chân",
  "shave_fur" => "Cạo ông",
  "cut_claw" => "Cắt, dũa móng",
  "cut_curly" => "Cắt lông rối",
  "wash_ear" => "Vệ sinh tai",
  "wash_mouth" => "Vệ sinh răng miệng",
  "paint_footear" => "Nhuộm chân, tai",
  "paint_all" => "Nhuộm toàn thân",
  "pin_ear" => "Bấm lỗ tai",
  "cut_ear" => "Cắt lông tai",
  "dismell" => "Vắt tuyết hôi"
);

$allow = checkPermission(MODULE, $user_info['userid']);

if (!$allow) {
	preventOutsiter($allow);
}

$action = $nv_Request->get_string("action", "get/post", "");
if (!empty($action)) {
  $result = array("status" => 0);
  switch ($action) {
    case "refresh":
      $result["status"] = 1;
      $result["html"] = spaList();
    break;
    case "complete":
      $id = $nv_Request->get_string("id", "get/post", "");

      $sql = "update `" . VAC_PREFIX . "_spa` set done = " . time() . " where id = $id";
      if ($db->query($sql)) {
        $result["status"] = 1;
        $result["html"] = spaList();
      }
    break;
    case "paid":
      $id = $nv_Request->get_string("id", "get/post", "");

      $sql = "update `" . VAC_PREFIX . "_spa` set payment = 1, done = " . time() . " where id = $id";
      if ($db->query($sql)) {
        $result["status"] = 1;
        $result["html"] = spaList();
      }
    break;
    case "custom":
      $name = $nv_Request->get_string("name", "get/post", "");
      $phone = $nv_Request->get_string("phone", "get/post", "");
      $address = $nv_Request->get_string("address", "get/post", "");

      if (!(empty($name) || empty($phone))) {
        $sql = "select * from `" . VAC_PREFIX . "_customer` where phone = '$phone'";
        $query = $db->query($sql);
        if ($query->fetch()) {
          $result["notify"] = $lang_module["phone_existed"];
        }
        else {
          $sql = "insert into `" . VAC_PREFIX . "_customer` (name, phone, address) values('$name', '$phone', '$address')";
          $query = $db->query($sql);
          if ($query) {
            $result["status"] = 1;
            $result["id"] = $db->lastInsertId();
            $result["notify"] = $lang_module["saved"];
          }
          else {
            $result["notify"] = $lang_module["error"];
          }
        }
      }
      else {
        $result["notify"] = $lang_module["empty"];
      }
    break;
    case 'getcustomer':
      $key = $nv_Request->get_string("key", "post", "");
      $xtpl = new XTemplate("suggest.tpl", PATH2);

      $sql = "select * from `" . VAC_PREFIX . "_customer` where name like '%$key%' or phone like '%$key%' limit 50";
      $customer_query = $db->query($sql);
      $result["html"] = "Không có kết quả trùng khớp";
      while ($customer = $customer_query->fetch()) {
        $xtpl->assign("id", $customer["id"]);
        $xtpl->assign("name", $customer["name"]);
        $xtpl->assign("phone", $customer["phone"]);
        $xtpl->assign("name2", $customer["name"]);
        $xtpl->assign("phone2", $customer["phone"]);
        $xtpl->parse("main");
      }
      $result["status"] = 1;
      $result["html"] = $xtpl->text();
    break;
    case 'get_detail':
      $id = $nv_Request->get_int("id", "get/post", 0);

      $sql = "select * from `" . VAC_PREFIX . "_spa` where id = " . $id;
      $spa_query = $db->query($sql);
      $spa = $spa_query->fetch();

      $selected = array();
      foreach ($spa_option as $key => $value) {
        $selected[] = array('id' => $key, 'value' => $spa[$key]);
      }

      $customer = checkRow('customer', $spa['customerid']);

      $result['status'] = 1;
      $result['data'] = array(
        'doctor' => $spa['doctor'],
        'note' => $spa['note'],
        'selected' => $selected,
        'customer' => $customer['name'],
        'phone' => $customer['phone'],
        'image' => $spa['image'],
        'time' => date('d/m/Y', $spa['time'])
      );
    break;
    case 'insert-spa':
      $data = $nv_Request->get_array("data", "post");
      $image = $nv_Request->get_string("image", "post", '');

      $name = array();
      foreach ($data['selected'] as $key => $value) {
        $name[] = $key;
      }

      $sql = "insert into `" . VAC_PREFIX . "_spa` (customerid, doctorid, doctor, weight, note, time, " . implode(", ", $name) . ", image) values($data[customer], $data[doctor], $data[doctor], 0, '$data[note]', '" . time() . "', " . implode(", ", $data['selected']) . ", '$image')";
      if ($db->query($sql)) {
        $result["status"] = 1;
        $result["html"] = spaList();
      }
    break;
    case 'update-spa':
      $id = $nv_Request->get_int("id", "post");
      $data = $nv_Request->get_array("data", "post");

      $xtra = array();
      foreach ($data['selected'] as $key => $value) {
        $xtra []= "$key = $value";
      }

      $sql = "update `" . VAC_PREFIX . "_spa` set doctor = $data[doctor], note = '$data[note]', ". implode(', ', $xtra) ." where id = $id";
      if ($db->query($sql)) {
        $result["status"] = 1;
        $result["html"] = spaList();
      }
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH2);
$xtpl->assign("lang", $lang_module);

if ($allow > 1) $xtpl->parse('main.manager');

$xtpl->assign("modal", spaModal());
$xtpl->assign("content", spaList());

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
