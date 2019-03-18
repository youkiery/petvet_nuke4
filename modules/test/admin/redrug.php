<?php

/**
* @Project PETCOFFEE 
* @Youkiery (youkiery@gmail.com)
* @Copyright (C) 2019
* @Createdate 13-11-2019 16:00
*/
if (!defined('NV_IS_QUANLY_ADMIN')) {
  die('Stop!!!');
}

$action = $nv_Request->get_string("action", "get/post", "");
if (!empty($action)) {
  $result = array("status" => 0, "notify" => $lang_module["error"]);
  switch ($action) {
    case 'remove':
    $id = $nv_Request->get_string('id', 'post', '');

    if (!(empty($id))) {
      $sql = "delete from `" . VAC_PREFIX . "_redrug` where id = $id";
      if ($db->query($sql)) {
        $result["status"] = 1;
        $result["notify"] = $lang_module["saved"];
        $result["list"] = admin_redrug();
      }
    }
    break;
    case 'getedit':
    $id = $nv_Request->get_string('id', 'post', '');

    if (!(empty($id))) {
      $sql = "select * from `" . VAC_PREFIX . "_redrug` where id = $id";
      $query = $db->query($sql);
      $redrug = $query->fetch();

      if ($redrug) {
        $drug_s = "";

        $sql = "select * from `" . VAC_PREFIX . "_drug`";
        $query = $db->query($sql);
        while ($drug = $query->fetch()) {
          $select = "";
          if ($drug["id"] == $redrug["drugid"]) {
            $select = "selected";
          }
          $drug_s .= "<option value='" . $drug["id"] . "' " . $select . ">" . $drug["name"] . "</option>";
        }
        
        $result["status"] = 1;
        $result["drug"] = $drug_s;
        $result["cometime"] = date("d/m/Y", $redrug["cometime"]);
        $result["calltime"] = date("d/m/Y", $redrug["calltime"]);
        $result["note"] = $redrug["note"];
      }
    }
    break;
    case 'recall':
    $id = $nv_Request->get_string('id', 'post', '');
    $recall = $nv_Request->get_string('recall', 'post', '');
    $note = $nv_Request->get_string('note', 'post', '');
    $drug = $nv_Request->get_string('drug', 'post', '');

    if (!(empty($id) || empty($recall) || empty($drug))) {
      $cometime = time();
      $calltime = totime($recall);

      $sql = "select * from `" . VAC_PREFIX . "_redrug` where id = $id order by id desc limit 1";
      $query = $db->query($sql);
      $redrug = $query->fetch();
      
      if ($redrug) {
        $sql = "insert into `" . VAC_PREFIX . "_redrug` (drugid, customerid, cometime, calltime, note, ctime) values ($drug, $redrug[customerid], $cometime, $calltime, '$note', " . time() . ");";
        if ($db->query($sql)) {
          $sql = "update `" . VAC_PREFIX . "_redrug` set status = 2 where id = $redrug[id];";
          $db->query($sql);
  
          $result["status"] = 1;
          $result["list"] = admin_redrug();
          $result["notify"] = $lang_module["saved"];
        }
      }
    }
    break;
    case 'getrecall':
    $id = $nv_Request->get_string('id', 'post', '');
    if (!empty($id)) {
      $check = true;
      $sql = "select * from `" . VAC_PREFIX . "_redrug` where id = $id";
      $query = $db->query($sql);
      $redrug = $query->fetch();

      if ($redrug["recall"]) {
        $recall = $redrug["recall"];
      }
      else {
        $time = $vacconfigv2["drug"];
        if (empty($time)) {
          $time = 3 * 30 * 24 * 60 * 60;
        }
  
        $recall = time() + $time;
      }
  
      $sql = "select * from `" . VAC_PREFIX . "_drug`";
      $drug_query = $db->query($sql);
      $drug_s = "";
      while ($drug = $drug_query->fetch()) {
        $select = "";
        if ($drug["id"] == $redrug["drugid"]) {
          $select = "selected";
        }
        $drug_s .= "<option value='$drug[id]' $select>$drug[name]</option>";
      }
      if ($recall && $drug_s) {
        $result["status"] = 1;
        $result["recall"] = date("d/m/Y", $recall);
        $result["drug"] = $drug_s;
      }
    }
    break;
    case "change":
      $result["html"] = admin_redrug();
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
      $key = $nv_Request->get_string("key", "get/post", "");
        $xtpl = new XTemplate("spa-suggest.tpl", NV_ROOTDIR . "/themes/" . $global_config['site_theme'] . "/modules/" . $module_file);

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
    case 'insert':
      $customer = $nv_Request->get_string("customer", "get/post", "");
      $drug = $nv_Request->get_int("drug", "get/post", 1);
      $drugcome = $nv_Request->get_string("drugcome", "get/post", "");
      $drugcall = $nv_Request->get_string("drugcall", "get/post", "");
      $note = $nv_Request->get_string("note", "get/post");
      if (!(empty($customer) || empty($drug) || empty($drugcome) || empty($drugcall))) {
        $drugcome = totime($drugcome);
        $drugcall = totime($drugcall);
        $sql = "insert into `" . VAC_PREFIX . "_redrug` (customerid, drugid, cometime, calltime, note, ctime) values($customer, $drug, '$drugcome', '$drugcall', '$note', '" . time() . "')";
        $query = $db->query($sql);
        if ($query) {
          $result["status"] = 1;
          $result["list"] = admin_redrug();
          $result["notify"] = $lang_module["saved"];
        }
      }
    break;
    case 'update':
      $customer = $nv_Request->get_string("customer", "get/post", "");
      $check = $nv_Request->get_array("check", "get/post");
      $note = $nv_Request->get_string("note", "get/post");
      $doctor = $nv_Request->get_int("doctor", "get/post", 1);
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
        $sql = "update `" . VAC_PREFIX . "_spa` set note = '$note', doctor = " . $doctor . ", " . implode(", ", $val_list) . " where id = $customer";
        $query = $db->query($sql);
        if ($query) {
          $result["status"] = 1;
          $result["list"] = spa_list();
          $result["notify"] = $lang_module["saved"];
        }
      }
    break;
    case "editNote":
    $note = $nv_Request->get_string('note', 'post', '');
    $id = $nv_Request->get_string('id', 'post', '');

    if (!(empty($id))) {
      $sql = "update `" . VAC_PREFIX . "_redrug` set note = '$note' where id = $id";
      $query = $db->query($sql);
      if ($query) {
        $result["status"] = 1;
        $result["notify"] = $lang_module["saved"];
      }
    }
    break;
    case "confirm":
      $id = $nv_Request->get_string('id', 'get/post', '');
      $target = $nv_Request->get_string('target', 'get/post', '');

      if(!empty($id)) {
        if ($target == "up") {
          $mod = 1;
        } else {
          $mod = -1;
        }

        $sql = "select * from `" . VAC_PREFIX . "_redrug` where id = $id";
        $query = $db->query($sql);
        $redrug = $query->fetch();

        $cid = $redrug["status"] += $mod;
        if (!empty($lang_module["redrugstatus"][$cid])) {
          $sql = "update `" . VAC_PREFIX . "_redrug` set status = $cid where id = $id";
          $query = $db->query($sql);

          if ($query) {
            $result["status"] = 1;
            $result["notify"] = $lang_module["saved"];
            $result["list"] = admin_redrug();
          }
        }
      }

    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("redrug.tpl", NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file);
$xtpl->assign("lang", $lang_module);
$xtpl->assign("nv", $module_name);
$xtpl->assign("op", $op);

$page = $nv_Request->get_string("page", "get/post", "");
$xtpl->assign("page", $page);

foreach ($lang_module["redrugstatus"] as $key => $value) {
	if (!$key) {
		$check = "btn-info";
	}
	else {
		$check = "";
	}
	$xtpl->assign("check", $check);
	$xtpl->assign("ipd", $key);
	$xtpl->assign("vsname", $value);
	$xtpl->parse("main.filter");
}

$today = strtotime(date("Y-m-d"));

$drug = 60 * 60 * 24 * 30;
if (!empty($vacconfigv2["redrug"])) {
  $drug = $vacconfigv2["redrug"];
}
$xtpl->assign("today", date("d/m/Y", $today));
$xtpl->assign("recall", date("d/m/Y", $today + $drug));

$sql = "select * from `" . VAC_PREFIX . "_drug`";
$drug_query = $db->query($sql);
while ($drug = $drug_query->fetch()) {
  $xtpl->assign("drug_value", $drug["id"]);
  $xtpl->assign("drug_name", $drug["name"]);
  $xtpl->parse("main.drug");
}


// $xtpl2 = new XTemplate("spa-check.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
// $index = 1;

// foreach ($spa_option as $key => $value) {
//   $xtpl2->assign("c_index", $index);
//   $xtpl2->assign("c_content", $value);
//   $xtpl2->assign("c_id", $key);
//   $xtpl2->parse("main");
//   $index ++;
// }
// $xtpl->assign("insert_content", $xtpl2->text());
$xtpl->assign("content", admin_redrug());

$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_admin_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
?>
