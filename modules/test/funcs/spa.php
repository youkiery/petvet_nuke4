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
  $result = array("status" => 0, "notify" => $lang_module["error"]);
  switch ($action) {
    case "refresh":
      $result["list"] = spa_list();
    break;
    case "payment":
      $id = $nv_Request->get_string("id", "post", "");
      if (!empty($id)) {
        $sql = "update `" . VAC_PREFIX . "_spa` set payment = 1, done = " . time() . " where id = $id";
        $query = $db->query($sql);
        if ($query) {
          $result["status"] = 1;
          $result["notify"] = $lang_module["saved"];
          $result["list"] = spa_list();
        }
        else {
          $result["notify"] = $lang_module["error"];
        }
      }
    break;
    case "custom":
      $name = $nv_Request->get_string("name", "post", "");
      $phone = $nv_Request->get_string("phone", "post", "");
      $address = $nv_Request->get_string("address", "post", "");

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
      $id = $nv_Request->get_int("id", "post", 0);
      if (!empty($id)) {
        $xtpl = new XTemplate("check.tpl", PATH2);
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
        $result["payment"] = $spa["payment"];
        $result["note"] = $spa["note"];
        $result["doctor"] = $doctor["name"];
        $result["weight"] = $spa['weight'];
        $result["doctorid"] = $spa['doctorid'];
        $result["from"] = date("d/m/Y H:i:s", $spa["time"]);
      }
    break;
    case 'insert':
      $customer = $nv_Request->get_string("customer", "post", "");
      $doctor = $nv_Request->get_int("doctor", "post", 1);
      $doctor2 = $nv_Request->get_int("doctor2", "post", 1);
      $check = $nv_Request->get_array("check", "post");
      $weight = $nv_Request->get_string("weight", "post", "");
      $note = $nv_Request->get_string("note", "post");
      $image = $nv_Request->get_string("image", "post", '');
      
      if (!empty($customer) && !empty($check) && !empty($weight_option[$weight])) {
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
        $sql = "insert into `" . VAC_PREFIX . "_spa` (customerid, doctorid, doctor, weight, note, time, " . implode(", ", $id) . ", image) values($customer, $doctor, $doctor2, $weight, '$note', '" . time() . "', " . implode(", ", $checking) . ", '$image')";
        $query = $db->query($sql);
        if ($query) {
          $result["status"] = 1;
          $result["list"] = spa_list();
          $result["notify"] = $lang_module["saved"];
        }
      }
    break;
    case 'update':
      $customer = $nv_Request->get_string("customer", "post", "");
      $check = $nv_Request->get_array("check", "post");
      $weight = $nv_Request->get_string("weight", "post", "");
      $note = $nv_Request->get_string("note", "post", "");
      $image = $nv_Request->get_string("image", "post", "");
      $doctor = $nv_Request->get_int("doctor", "post", 1);
      if (!empty($customer) && !empty($check) && !empty($doctor) && !empty($weight_option[$weight])) {
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
        $sql = "update `" . VAC_PREFIX . "_spa` set note = '$note', doctor = " . $doctor . ", weight = " . $weight . ", " . implode(", ", $val_list) . " where id = $customer";
        $query = $db->query($sql);
        if ($query) {
          updateImagev2($image, $customer, VAC_PREFIX . 'spa');
          $result["status"] = 1;
          $result["list"] = spa_list();
          $result["notify"] = $lang_module["saved"];
        }
      }
    break;
    case 'confirm':
    $customer = $nv_Request->get_string("customer", "post", "");
    $check = $nv_Request->get_array("check", "post");
    $note = $nv_Request->get_string("note", "post");
    $doctor = $nv_Request->get_int("doctor", "post", 1);
    if (!empty($customer) && !empty($check) && !empty($doctor)) {
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
      $spa = $spa_query->fetch();
      if ($spa) {
        $sql = "update `" . VAC_PREFIX . "_spa` set done = " . time() . ", note = '$note', doctor = " . $doctor . ", " . implode(", ", $val_list) . "  where id = " . $customer;
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

$xtpl = new XTemplate("main.tpl", PATH2);
$xtpl->assign("lang", $lang_module);

$list = getdoctorlist3();
foreach ($list as $doctor) {
  $xtpl->assign("doctor_value", $doctor["userid"]);
  $xtpl->assign("doctor_name", $doctor["fullname"]);
  $xtpl->parse("main.doctor");
  $xtpl->parse("main.doctor2");
  $xtpl->parse("main.doctor3");
}

foreach ($weight_option as $key => $value) {
  $xtpl->assign("weight_value", $key);
  $xtpl->assign("weight_name", $value);
  $xtpl->parse("main.weight");
  $xtpl->parse("main.weight2");
}

$xtpl2 = new XTemplate("check.tpl", PATH2);
$index = 1;

foreach ($spa_option as $key => $value) {
  $xtpl2->assign("c_index", $index);
  $xtpl2->assign("c_content", $value);
  $xtpl2->assign("c_id", $key);
  $xtpl2->parse("main");
  $index ++;
}
$xtpl->assign("insert_content", $xtpl2->text());
$xtpl->assign("content", spa_list());

$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
?>
