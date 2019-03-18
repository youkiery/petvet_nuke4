<?php

/**
 * @Project NUKEVIET-MUSIC
 * @Author Phan Tan Dung
 * @Copyright (C) 2011
 * @Createdate 26/01/2011 10:26 AM
 */

if (!defined('NV_IS_MOD_QUANLY')) {
  die('Stop!!!');
}
$action = $nv_Request->get_string('action', 'post', '');
$ret = array("status" => 0, "data" => array());

if (!empty($action)) {
  switch ($action) {
    case 'change_data':
      $page = $nv_Request->get_int('page', 'post/get', 0);
      $keyword = $nv_Request->get_string('keyword', 'post/get', "");
      $id = $nv_Request->get_int('id', 'post/get', 0);
      if ($page < 1) {
        $page = 1;
      }

      $ret["data"]["html"] = user_vaccine();
    break;
    case 'filter':
      $page = $nv_Request->get_int('page', 'post/get', 0);
      $keyword = $nv_Request->get_string('keyword', 'post/get', "");
      $filter = $nv_Request->get_string('filter', 'post/get', "");
      if ($page < 1) {
        $page = 1;
      }
      if (empty($filter)) {
        $filter = 0;
      }
      else {
        $filter = implode(",", str_split($filter));
      }

      $ret["data"]["html"] = user_vaccine($page, $keyword, $filter);
    break;
    case 'getcustomer':
      $customer = $nv_Request->get_string('customer', 'post', '');
      $phone = $nv_Request->get_string('phone', 'post', '');

      $ret["data"] = getcustomer($customer, $phone);
      if (count($ret["data"])) {
        $ret["status"] = 2;
      }
      break;
    case 'getrecall':
      $vacid = $nv_Request->get_string('vacid', 'post', '');
      $sql = "select * from `" . VAC_PREFIX . "_vaccine` where id = $vacid";
      $result = $db->query($sql);
      $check = true;
      $row = $result->fetch();

      $sql = "select * from `" . VAC_PREFIX . "_doctor`";
      $result = $db->query($sql);
      $doctor = "";
      while ($row2 = $result->fetch()) {
        $select = "";
        if ($row2["id"] == $row["doctorid"]) {
          $select = "selected";
        }
        $doctor .= "<option value='$row2[id]'>$row2[name]</option>";
      }
      if ($row["recall"]) {
        $row["calltime"] = date("d/m/Y", $row["calltime"]);
      }
      else {
        $time = $vacconfigv2["recall"];
        if (empty($time)) {
          $time = 30 * 24 * 60 * 60;
        }
        $calltime = $row["calltime"] + $time;
        $row["calltime"] = date("d/m/Y", $calltime);
      }
      $row["calltime"];
      $row["doctor"] = $doctor;
      $ret["status"] = 1;
      $ret["data"] = $row;
      break;
    case 'save':
      $recall = $nv_Request->get_string('recall', 'post', '');
      $doctor = $nv_Request->get_string('doctor', 'post', '');
      $vacid = $nv_Request->get_string('vacid', 'post', '');
      $diseaseid = $nv_Request->get_string('diseaseid', 'post', '');
      $petid = $nv_Request->get_string('petid', 'post', '');

      if (!(empty($petid) || empty($recall) || empty($doctor) || empty($vacid)) && $diseaseid >= 0) {
        $cometime = time();
        $calltime = totime($recall);

        $sql = "select * from `" . VAC_PREFIX . "_vaccine` where petid = $petid and diseaseid = $diseaseid and (calltime = $calltime or cometime = $cometime)";
        $query = $db->query($sql);
        $vaccine = $query->fetch();

        if (empty($vaccine["id"])) {
          $sql = "update `" . VAC_PREFIX . "_vaccine` set status = 2, recall = $calltime, doctorid = $doctor where id = $vacid;";

          if ($db->query($sql)) {
            $sql = "insert into `" . VAC_PREFIX . "_vaccine` (petid, diseaseid, cometime, calltime, status, note, recall, doctorid, ctime) values ($petid, $diseaseid, $cometime, $calltime, 0, '', 0, 0, " . time() . ");";
            if ($db->query($sql)) {
              $ret["status"] = 1;
              $ret["data"]["html"] = user_vaccine();
              // $ret["data"]["vaccine"] = $lang_module["confirm_value"][4];
              // $ret["data"]["color"] = "gray";
            }
          }
        }
        else {
          $ret["status"] = 1;
          $ret["data"]["html"] = user_vaccine();
        }
      }
      break;
    case 'getpet':
      $customerid = $nv_Request->get_string('customerid', 'post', '');
      $sql = "select * from `" . VAC_PREFIX . "_pet` where customerid = $customerid";

      $result = $db->query($sql);
      while ($row = $result->fetch()) {
        $ret["data"][] = $row;
        $ret["status"] = 2;
      }
      break;
    case 'addcustomer':
      $customer = $nv_Request->get_string('customer', 'post', '');
      $phone = $nv_Request->get_string('phone', 'post', '');
      $address = $nv_Request->get_string('address', 'post', '');

      if (!(empty($customer) || empty($phone))) {
        $sql = "select * from `" . VAC_PREFIX . "_customer` where phone = '$phone'";
        $result = $db->query($sql);
        if (!$result->rowCount()) {
          $sql = "insert into `" . VAC_PREFIX . "_customer` (name, phone, address) values ('$customer', '$phone', '$address');";
          
          $query = $db->query($sql);
          $id = $db->lastInsertId();
          if ($id) {
            $ret["status"] = 2;
            $ret["data"][] = array("id" => $id);
          }
        } else {
          $ret["status"] = 1;
        }
      }
      break;
    case 'addpet':
      $customerid = $nv_Request->get_string('customerid', 'post', '');
      $petname = $nv_Request->get_string('petname', 'post', '');

      if (!empty($customerid)) {
        if (!empty($petname)) {
          $sql = "select * from `" . VAC_PREFIX . "_pet` where name = '$petname' and customerid = $customerid";
          $result = $db->query($sql);
          if (!$result->rowCount()) {
            $sql = "insert into `" . VAC_PREFIX . "_pet` (name  , customerid) values ('$petname', $customerid);";
            
          $query = $db->query($sql);
          $id = $db->lastInsertId();
            if ($id) {
              $ret["status"] = 2;
              $ret["data"] = array("id" => $id, "name" => $petname, "customerid" => $customerid);
            }
          } else {
            $ret["status"] = 1;
          }
        } else {
          $ret["status"] = 3;
        }
      } else {
        $ret["status"] = 4;
      }
      break;
    case 'insertvac':
      $petid = $nv_Request->get_string('petid', 'post', '');
      $customer = $nv_Request->get_string('customer', 'post', '');
      $phone = $nv_Request->get_string('phone', 'post', '');
      $address = $nv_Request->get_string('address', 'post', '');
      $diseaseid = $nv_Request->get_string('diseaseid', 'post', '');
      $doctorid = $nv_Request->get_string('doctorid', 'post', '');
      $cometime = $nv_Request->get_string('cometime', 'post', '');
      $calltime = $nv_Request->get_string('calltime', 'post', '');
      $note = $nv_Request->get_string('note', 'post', '');

      if (!(empty($petid) || empty($diseaseid) || empty($cometime) || empty($calltime))) {
        $sql = "select * from `" . VAC_PREFIX . "_pet` where id = $petid";
        $result = $db->query($sql);
        if ($result->rowCount()) {
          $cometime = totime($cometime);
          $calltime = totime($calltime);

          $sql = "select * from " . VAC_PREFIX . "_vaccine where petid = $petid order by id desc limit 0, 1";
          $query = $db->query($sql);
          $row = $query->fetch();
          if ($row) {
            $sql = "update " . VAC_PREFIX . "_vaccine set status = 2, recall = $calltime where id = $row[id]";
            $db->query($sql);
          }
          
          $sql = "insert into `" . VAC_PREFIX . "_vaccine` (petid, cometime, calltime, doctorid, note, status, diseaseid, recall, ctime) values ($petid, $cometime, $calltime, $doctorid, '$note', 0, $diseaseid, 0, " . time() . ");";
          $query = $db->query($sql);
          $id = $db->lastInsertId();

          if ($id) {
            if (!empty($phone)) {
              $sql = "update `" . VAC_PREFIX . "_customer` set name = '$customer', address = '$address' where phone = '$phone'";
              $db->query($sql);
            }

            $ret["status"] = 2;
          } else {
            $ret["status"] = 5;
          }
        } else {
          $ret["status"] = 3;
        }
      }
      break;
    case "filter":
      $fromtime = $nv_Request->get_string('fromtime', 'post', '');
      $time_amount = $nv_Request->get_string('time_amount', 'post', '');
      $sort = $nv_Request->get_string('sort', 'post', '');
      $ret = array("status" => 0, "data" => array());

      if (!(empty($fromtime) || empty($time_amount) || empty($sort))) {
        $_SESSION["vac_filter"]["sort"] = $sort;
        $_SESSION["vac_filter"]["time_amount"] = $time_amount;
        $ret["status"] = 1;
        $ret["data"] = filter(NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file, $lang_module, $fromtime, $time_amount, $sort);
      }
      break;
    case "editNote":
      $note = $nv_Request->get_string('note', 'post', '');
      $id = $nv_Request->get_string('id', 'post', '');
      $ret = array("status" => 0, "data" => array());

      if (!(empty($id))) {
        $sql = "update `" . VAC_PREFIX . "_vaccine` set note = '$note' where id = $id";
        $result = $db->query($sql);
        if ($result) {
          $ret["data"] = $sql;
          $ret["status"] = 1;
        }
      }
      break;
  }
  echo json_encode($ret);
  die();
}

$page_default = true;

if (!empty($array_op[0])) {
  $page = $array_op[0];
  $page_allowed = array(
    "list", "search", "confirm"
  );
  if (in_array($page, $page_allowed)) {
    $page_default = false;
    include_once ( NV_ROOTDIR . "/modules/" . $module_file . "/funcs/$page.php" );
  }
}
if ($page_default) {
  $page_title = $module_info['custom_title'];
  $key_words = $module_info['keywords'];

  $xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
  $xtpl->assign("lang", $lang_module);
  $xtpl->assign("now", date("d/m/Y", NV_CURRENTTIME));
  // note: nexttime take from config
  $time = $vacconfigv2["recall"];
  if (empty($time)) {
    $time = 30 * 24 * 60 * 60;
  }

  $xtpl->assign("calltime", date("d/m/Y", NV_CURRENTTIME + $time));

  $sql = "select * from " . VAC_PREFIX . "_doctor";
  $query = $db->query($sql);
  while ($row = $query->fetch()) {
    $xtpl->assign("doctorid", $row["id"]);
    $xtpl->assign("doctorname", $row["name"]);
    $xtpl->parse("main.doctor");
  }
  $diseases = getDiseaseList();
  foreach ($diseases as $key => $value) {
    $xtpl->assign("disease_id", $value["id"]);
    $xtpl->assign("disease_name", $value["name"]);
    $xtpl->parse("main.option");
  }
}
$xtpl->parse("main");
$contents = $xtpl->text("main");
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
?>
