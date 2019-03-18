<?php

/**
 * @Project NUKEVIET-MUSIC
 * @Author Phan Tan Dung
 * @Copyright (C) 2011
 * @Createdate 26/01/2011 10:26 AM
 */
if (!defined('NV_IS_MOD_QUANLY')) die('Stop!!!');
$action = $nv_Request->get_string('action', 'get/post', '');
  if (!empty($action)) {
    $ret = array("status" => 0, "data" => array());
    switch ($action) {
      case 'change_data':
      $page = $nv_Request->get_int('page', 'post/get', 0);
      $keyword = $nv_Request->get_string('keyword', 'post/get', "");
      $id = $nv_Request->get_int('id', 'post/get', 0);
      if ($page < 1) {
        $page = 1;
      }

      $ret["data"]["html"] = user_usg();
    break;
      case 'birthfilter':
      $ret["data"]["html"] = user_birth();
      // $ret["data"]["nav"] = user_birth_nav();

      break;
      case 'filter':

      $ret["data"]["html"] = user_usg();
      // $ret["data"]["nav"] = user_usg_nav();
      break;

      case "editNote":
      $note = $nv_Request->get_string('note', 'post', '');
      $id = $nv_Request->get_string('id', 'post', '');

      if (!(empty($id))) {
        $sql = "update `" . VAC_PREFIX . "_usg` set note = '$note' where id = $id";
        $result = $db->query($sql);
        if ($result) {
          $ret["status"] = 1;
        }
      }
      break;
      case "getbirth":
        $id = $nv_Request->get_string('id', 'post', '');
        if ($id > 0) {
          $sql = "select * from `" . VAC_PREFIX . "_usg` where id = $id";
          $query = $db->query($sql);
          $usg = $query->fetch();

          $sql = "select * from `" . VAC_PREFIX . "_doctor`";
          $query = $db->query($sql);
          $doctor = "";
          while ($row = $query->fetch()) {
            $check = "";
            if ($row["id"] == $usg["doctorid"]) {
              $check = "selected";
            }
            $doctor .= "<option value='$row[id]' $check>$row[name]</option>";
          }

          if ($usg) {
            $ret["data"]["birth"] = $usg["birth"];
            if (!empty($usg["birthday"])) {
              $ret["data"]["birthday"] = date("d/m/Y", $usg["birthday"]);
            }
            else {
              $ret["data"]["birthday"] = date("d/m/Y");
            }
            $ret["data"]["doctor"] = $doctor;
            $ret["status"] = 1;
          }
        }
      break;
      case 'getbirthrecall':
        $vacid = $nv_Request->get_string('vacid', 'post', '');
        $sql = "select * from `" . VAC_PREFIX . "_usg` where id = $vacid";
        $result = $db->query($sql);
        $usg = $result->fetch();

        $sql = "select * from `" . VAC_PREFIX . "_vaccine` where petid = $usg[childid]";
        $result = $db->query($sql);
        $vaccine = $result->fetch();
  
        $sql = "select * from `" . VAC_PREFIX . "_doctor`";
        $result = $db->query($sql);
        $doctor = "";
        while ($drow = $result->fetch()) {
          $select = "";
          if (!empty($vaccine["doctorid"]) && $drow["id"] == $vaccine["doctorid"]) {
            $select = "selected";
          }
          $doctor .= "<option value='$drow[id]'>$drow[name]</option>";
        }
        if ($usg["recall"]) {
          $usg["calltime"] = date("d/m/Y", $usg["recall"]);
        }
        else {
          $calltime = strtotime(date("Y-m-d")) + 30 * 24 * 60 * 60;
          $usg["calltime"] = date("d/m/Y", $calltime);
        }
        $usg["calltime"];
        $usg["doctor"] = $doctor;
        $ret["status"] = 1;
        $ret["data"] = $usg;
        
        break;
      case "birth":
      $id = $nv_Request->get_string('id', 'post', '');
      $petid = $nv_Request->get_string('petid', 'post', '');
      $birth = $nv_Request->get_int('birth', 'post', 1);
      $doctor = $nv_Request->get_int('doctor', 'post', 1);
      $birthday = $nv_Request->get_string('birthday', 'post', '');

      if (!(empty($id) || empty($petid))) {
        if (empty($doctor)) {
          $doctor = 1;
        }
        $birthday = totime($birthday);
        if (!$birth) {
          $birth = 1;
        }
        $recall = $birthday + 60 * 60 * 24 * 60;
        $time = $vacconfigv2["exrecall"];
        if (empty($time)) {
          $time = 42 * 24 * 60 * 60;
        }
        $vacday = $birthday + $time;
        $sql = "select * from " . VAC_PREFIX . "_usg where id = $id";
        $query = $db->query($sql);
        $usg = $query->fetch();

        $sql = "select * from " . VAC_PREFIX . "_pet where id = $petid";
        $query = $db->query($sql);
        $customer = $query->fetch();

        $sql = "update `" . VAC_PREFIX . "_usg` set birth = '$birth', birthday = " . $birthday . ", firstvac = $vacday, doctorid = $doctor, status = 2, cbtime = " . time() . " where id = $id";
        $result = $db->query($sql);
        if ($usg["childid"] == 0) {
          $sql = "insert into " . VAC_PREFIX . "_pet (name, customerid) values('" . date("d/m/Y", $birthday) . "', $customer[id])";
          
          $query = $db->query($sql);
          $pet_id = $db->lastInsertId();

          if ($pet_id > 0) {
            $sql = "update `" . VAC_PREFIX . "_usg` set childid = $pet_id where id = $id";
            $query = $db->query($sql);
          }
        }
        
        if ($result && $query) {
          $ret["status"] = 1;
          $ret["data"]["html"] = user_usg();
        }
      }
      break;
      case "exbirth":
      $id = $nv_Request->get_string('id', 'post', '');
      $petid = $nv_Request->get_string('petid', 'post', '');
      $birth = $nv_Request->get_int('birth', 'post', 1);

      if (!(empty($id) || empty($petid))) {
        if (!$birth) {
          $birth = 1;
        }
        
        $sql = "update `" . VAC_PREFIX . "_usg` set expectbirth = '$birth' where id = $id";
        $result = $db->query($sql);
        
        if ($result) {
          $ret["status"] = 1;
          $ret["data"]["birth"] = $birth;
        }
      }
      break;
      case "cvsieuam":
        // confirm vaccine usg
        $value = $nv_Request->get_string('value', 'get', '');
        $vacid = $nv_Request->get_string('vacid', 'get', '');
        $act = $nv_Request->get_string('act', 'get', '');
        if(!(empty($act) || empty($value) || empty($vacid))) {
          $mod = 0;
          if ($act == "up") {
            $mod = 1;
          } else {
            $mod = -1;
          }
          if (in_array($value, $lang_module["confirm_value"])) {
            $confirmid = array_search($value, $lang_module["confirm_value"]);
            $confirmid += $mod;
            if (!empty($lang_module["confirm_value"][$confirmid])) {
              $sql = "update " .  VAC_PREFIX . "_usg set vaccine = $confirmid where id = $vacid";
              $result = $db->query($sql);
              if ($result) {
                $sql = "select * from " .  VAC_PREFIX . "_usg where id = $vacid";
                $result = $db->query($sql);
                $row = $result->fetch();
                if (empty($row["recall"]) || $row["recall"] == "0") $ret["data"]["recall"] = 0;
                else $ret["data"]["recall"] = 1;
                $ret["status"] = 1;
                $ret["data"]["html"] = user_birth();
                // $ret["data"]["nav"] = user_birth_nav();
              }
            }
          }
        }
      break;
      case 'save':
      $recall = $nv_Request->get_string('recall', 'post', '');
      $doctor = $nv_Request->get_string('doctor', 'post', '');
      $disease = $nv_Request->get_string('disease', 'post', '');
      $vacid = $nv_Request->get_string('vacid', 'post', '');
      $petid = $nv_Request->get_string('petid', 'post', '');

      if (!(empty($petid) || empty($recall) || empty($doctor) || empty($vacid) || empty($disease))) {
        $cometime = time();
        $calltime = totime($recall);

        $sql = "select * from `" . VAC_PREFIX . "_usg` where petid = $petid and (calltime = $calltime or cometime = $cometime)";
        $query = $db->query($sql);
        $usg = $query->fetch();

        if (empty($usg["id"])) {
          $sql = "update `" . VAC_PREFIX . "_usg` set vaccine = 2, firstvac = " . time() . ", recall = $recall where id = $vacid";
          // echo $sql;
          if ($db->query($sql)) {
            $sql = "insert into `" . VAC_PREFIX . "_vaccine` (petid, diseaseid, cometime, calltime, status, note, recall, doctorid, ctime) values ($petid, $disease, $cometime, $calltime, 0, '', 0, 0, " . time() . ");";
            if ($db->query($sql)) {
              $ret["status"] = 1;
              $ret["data"]["html"] = user_birth();
            }
          }
        }
      }
      break;
      case 'getusgdetail':
      $id = $nv_Request->get_int('id', 'post', 0);

      if (!empty($id)) {
        $sql = "select * from `" . VAC_PREFIX . "_usg` where id = $id";
        $usg_query = $db->query($sql);
        $usg = $usg_query->fetch();
        
        $sql = "select * from `" . VAC_PREFIX . "_pet` where id = $usg[petid]";
        $pet_query = $db->query($sql);
        $pet = $pet_query->fetch();

        $sql = "select * from `" . VAC_PREFIX . "_customer` where id = $pet[customerid]";
        $customer_query = $db->query($sql);
        $customer = $customer_query->fetch();
        
        if ($customer) {
          $ret["data"]["petname"] = $pet["name"];
          $ret["data"]["customer"] = $customer["name"];
          $ret["data"]["phone"] = $customer["phone"];
          $ret["data"]["address"] = $customer["address"];
          $ret["data"]["cometime"] = date("d/m/Y", $usg["cometime"]);
          $ret["data"]["calltime"] = date("d/m/Y", $usg["calltime"]);
          if (!$usg["image"]) {
            $usg["image"] = "/uploads/" . $module_file . "/no_image.jpg";
          }
          $ret["data"]["image"] = $usg["image"];
          $ret["status"] = 1;
        }
        else {
          $ret["error"] = "Hiện không thể nhận được thông tin sừ server";
        }
      }
      break;
    }
    echo json_encode($ret);
    die();
  }

  $xtpl = new XTemplate("sieuam.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
  $xtpl->assign("lang", $lang_module);

  $today = date("d/m/Y", NV_CURRENTTIME);
  $dusinh = $vacconfigv2["expect"];
  if (empty($dusinh)) {
    $dusinh = 15 * 24 * 60 * 60;
  }
  // echo $thongbao; die();

  $xtpl->assign("now", $today);
  $xtpl->assign("dusinh", date("d/m/Y", totime($today) + $dusinh));

  $sql = "select * from " .  VAC_PREFIX . "_doctor";
  $result = $db->query($sql);

  while ($row = $result->fetch()) {
    $xtpl->assign("doctor_value", $row["id"]);
    $xtpl->assign("doctor_name", $row["name"]);
    $xtpl->parse("main.doctor");
  }

  $xtpl->parse("main");

  $contents = $xtpl->text("main");
  include ( NV_ROOTDIR . "/includes/header.php" );
  echo nv_site_theme($contents);
  include ( NV_ROOTDIR . "/includes/footer.php" );
?>
