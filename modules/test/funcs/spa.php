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

checkUserPermit(OVERCLOCK);

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
$weight_option = array(
  1 => "1 - 5 kg",
  "6 - 10 kg",
  "11 - 20 kg",
  "21 - 30 kg",
  "31 - 40 kg",
  "41 - 50 kg",
  "51 - 60 kg",
  "61 - 70 kg",
  "71 - 80 kg",
  "81 - 90 kg",
  "91 - 100 kg",
  "> 100 kg"
);

$action = $nv_Request->get_string("action", "post", "");
if (!empty($action)) {
  $result = array("status" => 0);
  switch ($action) {
    case "refresh":
      $result["status"] = 1;
      $result["list"] = spa_list();
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
        $xtpl->assign("id", $customer["id"]);
        $xtpl->assign("name", $customer["name"]);
        $xtpl->assign("phone", $customer["phone"]);
        $xtpl->assign("name2", $customer["name"]);
        $xtpl->assign("phone2", $customer["phone"]);
        $xtpl->parse("main");
      }
      $result["status"] = 1;
      $result["list"] = $xtpl->text();
      break;
    case 'get_detail':
      $id = $nv_Request->get_int("id", "post", 0);

      $sql = "select * from `" . VAC_PREFIX . "_spa` where id = " . $id;
      $spa_query = $db->query($sql);
      $spa = $spa_query->fetch();

      $option_data = [];

      foreach ($spa_option as $option => $name) {
        $option_data[$option] = $spa[$option];
      }

      $sql = "select * from `" . VAC_PREFIX . "_doctor` where id = " . $spa["doctorid"];
      $query = $db->query($sql);
      $doctor = $query->fetch();

      $result["status"] = 1;
      $result["data"] = $option_data;
      $result["weight"] = $weight_option[$spa["weight"]];
      $result["done"] = $spa["done"];
      $result["payment"] = $spa["payment"];
      $result["note"] = $spa["note"];
      $result["doctor"] = $doctor["name"];
      $result["from"] = date("d/m/Y H:i:s", $spa["time"]);
      break;
    case 'insert':
      $customer = $nv_Request->get_string("customer", "post", "");
      $phone = $nv_Request->get_string("phone", "post", "");
      $doctor = $nv_Request->get_int("doctor", "post", 1);
      $check = $nv_Request->get_array("check", "post");
      $weight = $nv_Request->get_string("weight", "post", "");
      $note = $nv_Request->get_string("note", "post");
      $image = $nv_Request->get_string("image", "post", '');

      $id = array();
      $checking = array();
      foreach ($check as $key => $value) {
        $id[] = $value["id"];
        $checking[] = $value["checking"];
      }

      $sql = 'select * from `' . VAC_PREFIX . '_customer` where phone = "' . $phone . '"';
      $query = $db->query($sql);
      if (empty($data = $query->fetch())) {
        $sql = 'insert into `' . VAC_PREFIX . '_customer` (name, phone) values("' . $phone . '", "' . $customer . '")';
        $db->query($sql);
        $data['id'] = $db->lastInsertId();
      } else {
        $sql = 'update `' . VAC_PREFIX . '_customer` set name = "' . $customer . '" where phone = "' . $phone . '"';
        $db->query($sql);
      }

      $sql = "insert into `" . VAC_PREFIX . "_spa` (customerid, doctorid, doctor, weight, note, time, " . implode(", ", $id) . ", image) values($data[id], $doctor, $doctor, $weight, '$note', '" . time() . "', " . implode(", ", $checking) . ", '$image')";
      if ($db->query($sql)) {
        $result["status"] = 1;
        $result["list"] = spa_list();
      }
      break;
    case 'update':
      $id = $nv_Request->get_int("id", "post");
      $check = $nv_Request->get_array("check", "post");
      $note = $nv_Request->get_string("note", "post", "");
      $image = $nv_Request->get_string("image", "post", "");

      $val_list = array();
      foreach ($check as $key => $value) {
        $val_list[] = $value["id"] . " = " . $value['checking'];
      }
      $sql = "update `" . VAC_PREFIX . "_spa` set note = '$note', " . implode(", ", $val_list) . " where id = $id";
      $query = $db->query($sql);
      if ($query) {
        updateImagev2($image, $id, VAC_PREFIX . '_spa');
        $result["status"] = 1;
        $result["list"] = spa_list();
      }
      break;
    case 'confirm':
      $id = $nv_Request->get_int("id", "post", 0);

      $sql = "update `" . VAC_PREFIX . "_spa` set done = " . time() . " where id = " . $id;
      $db->query($sql);

      $result['list'] = spa_list();
      $result['status'] = 1;
      break;
    case "payment":
      $id = $nv_Request->get_int("id", "post", 0);

      $sql = "update `" . VAC_PREFIX . "_spa` set payment = 1, done = " . time() . " where id = $id";
      $query = $db->query($sql);
      $result["status"] = 1;
      $result["list"] = spa_list();
      break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH2);
$xtpl->assign("lang", $lang_module);
$xtpl->assign("content", spa_list());
$xtpl->assign("modal", spaModal());

$xtpl->parse("main");
$contents = $xtpl->text("main");

include(NV_ROOTDIR . "/includes/header.php");
echo nv_site_theme($contents);
include(NV_ROOTDIR . "/includes/footer.php");
