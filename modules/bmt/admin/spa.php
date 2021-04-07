<?php

/**
* @Project PETCOFFEE 
* @Youkiery (youkiery@gmail.com)
* @Copyright (C) 2019
* @Createdate 13-11-2019 16:00
*/

if (!defined('NV_IS_QUANLY_ADMIN')) die('Stop!!!');
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

$action = $nv_Request->get_string("action", "get/post", "");
if (!empty($action)) {
  $result = array("status" => 0, "notify" => "");
  switch ($action) {
    case 'getcustomer':
      $key = $nv_Request->get_string("key", "get/post", "");
        $xtpl = new XTemplate("spa-suggest.tpl", NV_ROOTDIR . "/themes/" . $global_config['module_theme'] . "/modules/" . $module_file);

        $sql = "select * from `" . VAC_PREFIX . "_customer` where name like '%$key%' or phone like '%$key%' limit 50";
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
        $result["list"] = $xtpl->text();
    break;
    case 'get_detail':
      $id = $nv_Request->get_int("id", "get/post", 0);
      if (!empty($id)) {
        $xtpl = new XTemplate("spa-check.tpl", NV_ROOTDIR . "/themes/" . $global_config['module_theme'] . "/modules/" . $module_file);
        $index = 1;

        $sql = "select * from `" . VAC_PREFIX . "_spa` where id = " . $id;
        $spa_query = $db->query($sql);
        $result["list"] = "";

        $spa = $spa_query->fetch();
        foreach ($spa_option as $key => $value) {
          $tick = "";
          if ($spa[$key] > 0) {
            $tick = "checked";
          }
  
          $xtpl->assign("c_id", $key);
          $xtpl->assign("c_index", $index);
          $xtpl->assign("c_content", $value);
          $xtpl->assign("c_check", $tick);
          $xtpl->parse("main");
          $index ++;
        }

        $sql = "select * from `" . VAC_PREFIX . "_doctor` where id = " . $spa["doctorid"];
        $query = $db->query($sql);
        $doctor = $query->fetch();

        $result["list"] = $xtpl->text();
        $result["done"] = $spa["done"];
        $result["note"] = $spa["note"];
        $result["doctor"] = $doctor["name"];
        $result["from"] = date("d/m/Y H:i:s", $spa["time"]);
      }
    break;
    case 'insert':
      $customer = $nv_Request->get_string("customer", "get/post", "");
      $doctor = $nv_Request->get_int("doctor", "get/post", 1);
      $check = $nv_Request->get_array("check", "get/post");
      $note = $nv_Request->get_string("note", "get/post");
      if (!empty($customer) && !empty($check)) {
        $id = array();
        $checking = array();
        foreach ($check as $key => $value) {
          $id[] = $value["id"];
          if ($value["checking"] == "true") {
            $checking[] = 1;
          }
          else {
            $checking[] = 0;
          }
        }
        $sql = "insert into `" . VAC_PREFIX . "_spa` (customerid, doctorid, note, time, " . implode(", ", $id) . ") values($customer, $doctor, '$note', '" . time() . "', " . implode(", ", $checking) . ")";
        $query = $db->query($sql);
        if ($query) {
          $result["status"] = 1;
          $result["list"] = admin_spa();
          $result["notify"] = $lang_module["saved"];
        }
      }
    break;
    case 'update':
      $customer = $nv_Request->get_string("customer", "get/post", "");
      $check = $nv_Request->get_array("check", "get/post");
      $note = $nv_Request->get_string("note", "get/post");
      if (!empty($customer) && !empty($check)) {
        $val_list = array();
        foreach ($check as $key => $value) {
          $val = $value["id"] . " = ";
          if ($value["checking"] == "true") {
            $val .= "1";
          }
          else {
            $val .= "0";
          }
          $val_list[] = $val;
        }
        $sql = "update `" . VAC_PREFIX . "_spa` set note = '$note', " . implode(", ", $val_list) . " where id = $customer";
        $query = $db->query($sql);
        if ($query) {
          $result["status"] = 1;
          $result["list"] = spa_list();
          $result["notify"] = $lang_module["saved"];
        }
      }
    break;
    case 'remove':
      $id = $nv_Request->get_string("id", "get/post", "");
      if (!empty($id)) {
        $sql = "delete from `" . VAC_PREFIX . "_spa` where id = $id";
        $query = $db->query($sql);
        if ($query) {
          $result["status"] = 1;
          $result["list"] = admin_spa();
          $result["notify"] = $lang_module["saved"];
        }
      }
    break;
    case 'confirm':
    $customer = $nv_Request->get_string("customer", "get/post", "");
    $check = $nv_Request->get_array("check", "get/post");
    $note = $nv_Request->get_string("note", "get/post");
    if (!empty($customer) && !empty($check)) {
      $val_list = array();
      foreach ($check as $key => $value) {
        $val = $value["id"] . " = ";
        if ($value["checking"] == "true") {
          $val .= "1";
        }
        else {
          $val .= "0";
        }
        $val_list[] = $val;
      }

      $sql = "select * from `" . VAC_PREFIX . "_spa` where id = " . $customer;
      $spa_query = $db->query($sql);
      if ($spa_query) {
        $sql = "update `" . VAC_PREFIX . "_spa` set done = " . time() . ", note = '$note', " . implode(", ", $val_list) . "  where id = " . $customer;
        $spa_query = $db->query($sql);
        $result["status"] = 1;
        if ($spa_query) {
          $result["list"] = spa_list();
          $result["notify"] = $lang_module["saved"];
        }
        else {
          $result["notify"] = "Dường như có lỗi xảy ra";
        }
      }
      else {
        $result["list"] = spa_list();
      }
    }
    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("spa.tpl", NV_ROOTDIR . "/themes/" . $global_config['module_theme'] . "/modules/" . $module_file);
$xtpl->assign("lang", $lang_module);
$page_title = $lang_module["main_title"];

$sql = "select * from `" . VAC_PREFIX . "_doctor`";
$doctor_query = $db->query($sql);
while ($doctor = $doctor_query->fetch()) {
  $xtpl->assign("doctor_value", $doctor["id"]);
  $xtpl->assign("doctor_name", $doctor["name"]);
  $xtpl->parse("main.doctor");
}

$xtpl2 = new XTemplate("spa-check.tpl", NV_ROOTDIR . "/themes/" . $global_config['module_theme'] . "/modules/" . $module_file);
$index = 1;

foreach ($spa_option as $key => $value) {
  $xtpl2->assign("c_index", $index);
  $xtpl2->assign("c_content", $value);
  $xtpl2->assign("c_id", $key);
  $xtpl2->parse("main");
  $index ++;
}
$xtpl->assign("insert_content", $xtpl2->text());
$xtpl->assign("content", admin_spa());

$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_admin_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
