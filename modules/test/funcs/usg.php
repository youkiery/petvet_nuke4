<?php

/**
 * @Project NUKEVIET-MUSIC
 * @Phan Tan Dung (phantandung92@gmail.com)
 * @Copyright (C) 2011
 * @Createdate 26-01-2011 14:43
 */
if (!defined('NV_IS_MOD_QUANLY')) die('Stop!!!');
define('MODULE', 'usg');
quagio();

// $sql = 'select * from `'. VAC_PREFIX .'_usg` order by id desc limit 100';
// $query = $db->query($sql);

// while ($row = $query->fetch()) {
//   $sql = "select * from `". VAC_PREFIX ."_usg2` where id = $row[id]";
//   $query2 = $db->query($sql);
//   if (empty($query2->fetch())) {
//     // insert
//     $sql = "insert into `". VAC_PREFIX ."_usg2` (id, petid, doctorid, usgtime, expecttime, expectnumber, birthtime, number, vaccinetime, image, status, note, time) values ($row[id], $row[petid], $row[doctorid], $row[cometime], $row[calltime], $row[expectbirth], $row[birthday], $row[birth], $row[firstvac], '$row[image]', $row[status], '$row[note]', $row[ctime])";
//     $db->query($sql);
//   }
//   else {
//     // update
//   }
// }

$filter = array(
  'page' => $nv_Request->get_int('page', 'get', 1),
  'keyword' => $nv_Request->get_string('keyword', 'get', ''),
  'order' => $nv_Request->get_int('order', 'get', 0),
  'type' => $nv_Request->get_int('type', 'get', 1),
  'status' => $nv_Request->get_int('status', 'get', 0),
  'allow' => checkPermission(MODULE, $user_info['userid'])
);

if (!$filter['allow']) {
	preventOutsiter();
}

$action = $nv_Request->get_string('action', 'post', "");
if ($action) {
  $result = array("status" => 0, "data" => array());
  switch ($action) {
    case 'get-update':
      $id = $nv_Request->get_string('id', 'post', "");

      $sql = 'select * from `'. VAC_PREFIX .'_usg2` where id = ' . $id;
      $query = $db->query($sql);
      $usg = $query->fetch();
      $usg['usgtime'] = ($usg['usgtime'] ? date('d/m/Y', $usg['usgtime']) : '');
      $usg['expecttime'] = ($usg['expecttime'] ? date('d/m/Y', $usg['expecttime']) : '');
      $usg['birthtime'] = ($usg['birthtime'] ? date('d/m/Y', $usg['birthtime']) : '');
      $usg['vaccinetime'] = ($usg['vaccinetime'] ? date('d/m/Y', $usg['vaccinetime']) : '');

      $result['status'] = 1;
      $result['data'] = $usg;
    break;
    case 'edit-note':
      $note = $nv_Request->get_string('note', 'post', '');
      $id = $nv_Request->get_int('id', 'post', '');

      $sql = 'update `' . VAC_PREFIX . '_usg` set note = "' . $note . '" where id = ' . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
      }
      break;
    case 'overflow':
      $data = $nv_Request->get_array('data', 'post');
      $result['status'] = 1;
      $result['html'] = overflowList($data);
      break;
    case 'change-status':
      $data = $nv_Request->get_array('data', 'post');
      $status_list = array(0 => "Chưa Gọi", "Đã Gọi", "Đã Siêu Âm");

      $sql = 'select * from `' . VAC_PREFIX . '_usg` where id = ' . $data['id'];
      $query = $db->query($sql);
      $usg = $query->fetch();

      $mod = $usg['status'] + ($data['type'] ? 1 : -1);

      if (!empty($status_list[$mod])) {
        $sql = 'update `' . VAC_PREFIX . '_usg` set status = ' . $mod . ' where id = ' . $data['id'];
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = usgRecallList();
        }
      }
      break;
    case 'change-vaccine-status':
      $data = $nv_Request->get_array('data', 'post');
      $status_list = array(0 => "Chưa Gọi", "Đã Gọi", "Đã Tiêm");

      $sql = 'select * from `' . VAC_PREFIX . '_usg` where id = ' . $data['id'];
      $query = $db->query($sql);
      $usg = $query->fetch();

      $mod = $usg['vaccine'] + ($data['type'] ? 1 : -1);

      if (!empty($status_list[$mod])) {
        $sql = 'update `' . VAC_PREFIX . '_usg` set vaccine = ' . $mod . ' where id = ' . $data['id'];
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = usgVaccineList();
        }
      }
      break;
    case 'recall':
      $data = $nv_Request->get_array('data', 'post');
      $recall = $data['recall'] + 60 * 60 * 24 * 30;

      $sql = "update `" . VAC_PREFIX . "_usg` set birth = $data[birth], birthday = " . totime($data['recall']) . ", firstvac = $recall, doctorid = $data[doctor], status = 4, cbtime = " . time() . " where id = $data[id]";
      // die($sql);
      // $sql = 'update `'. VAC_PREFIX .'_usg` set status = 4, birth = '. $data['birth'] .', birthday = ' . totime($data['recall']) . ', recall = '. $recall .', cbtime = '. time() .' where id = ' . $data['id'];

      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = usgRecallList();
      }
      break;
    case 'birth-recall':
      $data = $nv_Request->get_array('data', 'post');

      $sql = 'select * from `' . VAC_PREFIX . '_usg` where id = ' . $data['id'];
      $query = $db->query($sql);
      $usg = $query->fetch();

      $sql = 'select * from `' . VAC_PREFIX . '_pet` where id = ' . $usg['petid'];
      $query = $db->query($sql);
      $pet = $query->fetch();

      $sql = "insert into `" . VAC_PREFIX . "_pet` values(null, '$data[petname]', $pet[customerid], 0, 0, 0, 0)";
      $sql2 = "insert into `" . VAC_PREFIX . "_vaccine` values(null, '$pet[id]', $data[disease], " . time() . ", " . totime($data['recall']) . ", '', 0, 0, $data[doctor], " . time() . ")";
      $sql3 = 'update `' . VAC_PREFIX . '_usg` set vaccine = 4 where id = ' . $data['id'];

      if ($db->query($sql) && $db->query($sql2) && $db->query($sql3)) {
        $result['status'] = 1;
        $result['html'] = usgVaccineList();
      }
      break;
    case 'remove-usg':
      $id = $nv_Request->get_int('id', 'post', 0);
      if (!empty($id)) {
        $sql = "delete from " . VAC_PREFIX . "_usg where id = $id";

        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = usgManageList();
        }
      }
      break;
    case 'usg_info':
      $id = $nv_Request->get_string('id', 'post', "");
      if (!empty($id)) {
        $sql = "select * from " . VAC_PREFIX . "_usg where id = $id";
        $query = $db->query($sql);

        if ($query) {
          $row = $query->fetch();
          $sql = "select * from " . VAC_PREFIX . "_pet where id = $row[petid]";
          $query = $db->query($sql);
          $row2 = $query->fetch();
          $result["status"] = 1;
          $recall = 0;
          if ($row["recall"]) {
            $recall = date("d/m/Y", $row["recall"]);
          }
          $vaccine = "";
          foreach ($lang_module["confirm_value"] as $key => $value) {
            $select = "";
            if ($row["vaccine"] == $key) {
              $select = "selected";
            }
            $vaccine .= "<option value='$key' $select>$value</option>";
          }
          $birthday = "";
          $firstvac = "";
          if ($row["birthday"] > 0) {
            $birthday = date("d/m/Y", $row["birthday"]);
          }
          if ($row["firstvac"] > 0) {
            $firstvac = date("d/m/Y", $row["firstvac"]);
          }
          $result["data"] = array("calltime" => date("d/m/Y", $row["calltime"]), "cometime" => date("d/m/Y", $row["cometime"]), "doctorid" => $row["doctorid"], "note" => $row["note"], "image" => $row["image"], "customerid" => $row2["customerid"], "petid" => $row["petid"], "birth" => $row["birth"], "exbirth" => $row["expectbirth"], "recall" => $recall, "vaccine" => $vaccine, "vacid" => $row["vaccine"], "firstvac" => $firstvac, "birthday" => $birthday);
        }
      }
      break;
    case 'update-usg':
      $id = $nv_Request->get_string('id', 'post', "");
      $data = $nv_Request->get_array('data', 'post');

      $sql = 'update `'. VAC_PREFIX .'_usg2` set usgtime = "'. totime($data['usgtime']) .'", expecttime = "'. totime($data['expecttime']) .'", expectnumber = "'. $data['expectnumber'] .'", birthtime = "'. totime($data['birthtime']) .'", number = "'. $data['number'] .'", vaccinetime = "'. totime($data['vaccinetime']) .'", doctorid = "'. $data['doctorid'] .'", note = "'. $data['note'] .'" where id = ' . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = usgCurrentList($filter);
      }
    break;
    case 'insert-usg':
      $data = $nv_Request->get_array('data', 'post');
      // var_dump($_POST);
      $sql = "select id from `" . VAC_PREFIX . "_pet` where id = $data[pet]";
      $query = $db->query($sql);

      if (!empty($query->rowCount())) {
        $usgtime = totime($data['usgtime']);
        $expecttime = totime($data['expecttime']);
        $sql = "INSERT INTO `" . VAC_PREFIX . "_usg2` (petid, doctorid, usgtime, expecttime, expectnumber, vaccinetime, image, status, note, time) VALUES ($data[pet], $data[doctor], $usgtime, $expecttime, $data[expectnumber], 0, '', 0, '$data[note]', " . time() . ")";
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = usgCurrentList($filter);
        }
      }
      break;
    case 'change-recall':
      $id = $nv_Request->get_int('id', 'post');
      $type = $nv_Request->get_int('type', 'post');

      $sql = 'update `' . VAC_PREFIX . '_usg2` set status = ' . $type . ' where id = ' . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = usgCurrentList($filter);
      }
      break;
    case 'birth':
      $id = $nv_Request->get_int('id', 'post');
      $number = $nv_Request->get_int('number', 'post', 0);
      $time = $nv_Request->get_string('time', 'post', 0);

  	  $sql = 'update `' . VAC_PREFIX . '_usg2` set number = ' . $number . ', birthtime = ' . totime($time) . ', status = 2 where id = ' . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = usgCurrentList($filter);
      }
      break;
    case 'vaccine':
      $id = $nv_Request->get_int('id', 'post');
      $disease = $nv_Request->get_string('disease', 'post', 0);
      $doctor = $nv_Request->get_string('doctor', 'post', 0);
      $time = $nv_Request->get_string('time', 'post', 0);

      // kiểm tra thú cưng tồn tại
      $sql = "select b.id from `" . VAC_PREFIX . "_usg2` a inner join `" . VAC_PREFIX . "_pet` b on a.id = $id and a.petid = b.id";
      $query = $db->query($sql);

      if ($row = $query->fetch()) {
        $time = totime($time);

  		$sql = "insert into `" . VAC_PREFIX . "_vaccine` (petid, cometime, calltime, doctorid, note, status, diseaseid, recall, ctime) values ($row[id], " . time() . ", $time, $doctor, '', 0, $disease, 0, " . time() . ");";
	  	$sql2 = "update `" . VAC_PREFIX . "_usg2` set status = 3, vaccinetime = ". $time ." where id = $id";
        if ($db->query($sql) && $db->query($sql2)) {
          $result['status'] = 1;
          $result['html'] = usgCurrentList($filter);
        }
      }
      break;
    case 'reject':
      $id = $nv_Request->get_int('id', 'post');

  	  $sql = "update `" . VAC_PREFIX . "_usg2` set status = 3 where id = " . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = usgCurrentList($filter);
      }
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH2);
$xtpl->assign('module_name', $module_name);
$xtpl->assign('op', $op);
$filter_param = $filter;
unset($filter_param['type']);
$xtpl->assign('filter_param', '&' . http_build_query($filter_param));
// Hiển thị tab được chọn
for ($i = 1; $i <= 4; $i++) {
  if ($i == $filter['type'])
    $xtpl->assign('type_button' . $i, 'btn-info');
  else
    $xtpl->assign('type_button' . $i, 'btn-default');
}

// Hiển thị tab quản lý
if ($filter['allow'] > 1) {
  $xtpl->parse('main.manager');
  $xtpl->parse('main.manager2');
}

$xtpl->assign('content', usgCurrentList($filter));

$xtpl->assign("modal", usgModal($lang_module));
$xtpl->parse("main");
$contents = $xtpl->text("main");
include (NV_ROOTDIR . "/includes/header.php");
echo nv_site_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");
