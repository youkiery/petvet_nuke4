<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 10/03/2010 10:51
 */

if (!defined('NV_SYSTEM')) {
    die('Stop!!!');
}

define('NV_IS_MOD_QUANLY', true); 
define('PATH', NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file); 
define('PATH2', NV_ROOTDIR . "/modules/" . $module_file . '/template/user/' . $op); 
require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';
// kiểm tra phân quyền

$opType = array('main' => 1, 'confirm' => 1, 'list' => 1, 'vac_list' => 1, 'sieuam' => 2, 'danhsachsieuam' => 2, 'sieuam-birth' => 2, 'themsieuam' => 2, 'xacnhansieuam' => 2, 'luubenh' => 3, 'danhsachluubenh' => 3, 'themluubenh' => 3, 'spa' => 4, 'redrug' => 5, 'heal' => 6, 'heal_drug' => 6);

$check = false;
if (!empty($user_info) && !empty($user_info['userid'])) {
  $sql = 'select * from `' . $db_config['prefix'] . '_users` where userid = ' . $user_info['userid'];
  $query = $db->query($sql);
  $user = $query->fetch();
  $group = explode(',', $user['in_groups']);
  if (!(in_array('1', $group) || in_array('2', $group))) {
    if ($op !== 'proces' && !empty($opType[$op])) {
      $sql = 'select * from `pet_test_heal_manager` where groupid in (' . implode(',', $user_info['in_groups']) . ') and type = ' . $opType[$op];
      $query = $db->query($sql);
  
      if (empty($query->fetch())) {
        $check = true;
        $contents = '<p style="padding: 10px;">Tài khoản chưa có quyền truy cập nội dung này</p>';
      }
      else if ($op == 'heal' || $op == 'heal_drug') {
          
      }
      else {
        $today = strtotime(date('Y/m/d'));
        $time = time();
        $fromTime = $today + $vacconfigv2['hour_from'] * 60 * 60 + $vacconfigv2['minute_from'] * 60;
        $endTime = $today + $vacconfigv2['hour_end'] * 60 * 60 + $vacconfigv2['minute_end'] * 60;

        if ($time < $fromTime || $time > $endTime) {
          $check = true;
          $contents = '<p style="padding: 10px;">Đã quá thời gian làm việc, xin vui lòng quay lại sau</p>';
        }
      }
    }
  } 
} 
else {
  $check = true;
  $contents = '<p style="padding: 10px;">Chỉ có thành viên được phân quyền mới có thể thấy được mục này</p>';
}

if ($check) {
  include ( NV_ROOTDIR . "/includes/header.php" );
  echo nv_site_theme($contents);
  include ( NV_ROOTDIR . "/includes/footer.php" );
  die();
}

function usgModal($lang_module) {
  global $sort_type, $filter_type, $filter_data;
  $xtpl = new XTemplate("modal.tpl", PATH2);
  $doctor = getDoctorList();
  $xtpl->assign('keyword', $filter_data['keyword']);
  $xtpl->assign('filter' . $filter_data['filter'], 'selected');
  $xtpl->assign('overflow_content', overflowList());
  // $xtpl->assign('from', $filter_data['from']);
  // $xtpl->assign('end', $filter_data['end']);
  $xtpl->assign('lang', $lang_module);
  $xtpl->assign('now', date('d/m/Y', time()));
  $xtpl->assign('expecttime', date('d/m/Y', time() + 60 * 60 * 24 * 25));

  $diseases = getDiseaseList();
  foreach ($diseases as $key => $value) {
    $xtpl->assign("id", $value["id"]);
    $xtpl->assign("name", $value["name"]);
    $xtpl->parse("main.disease");
    $xtpl->parse("main.disease2");
  }
  
  foreach ($doctor as $data) {
    $xtpl->assign('doctor_value', $data['id']);
    $xtpl->assign('doctor_name', $data['name']);
    $xtpl->parse('main.doctor');
    $xtpl->parse('main.doctor2');
    $xtpl->parse('main.doctor3');
    $xtpl->parse('main.doctor4');
  }

  foreach ($sort_type as $key => $sort_name) {
    $xtpl->assign("sort_name", $sort_name);
    $xtpl->assign("sort_value", $key);
    if ($key == $sort) $xtpl->assign("sort_check", "selected");
    else $xtpl->assign("sort_check", "");
    $xtpl->parse("main.sort");
  }
  
  foreach ($filter_type as $filter_value) {
    $xtpl->assign("time_value", $filter_value);
    $xtpl->assign("time_name", $filter_value);
    if ($filter_value == $filter) $xtpl->assign("time_check", "selected");
    else $xtpl->assign("time_check", "");
    $xtpl->parse("main.time");
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function overflowList($data = array()) {
	global $db;
	$xtpl = new XTemplate("overflow-list.tpl", PATH2);

	$tick;
	if (empty($data['from'])) $tick += 1;
	if (empty($data['end'])) $tick += 2;
	$msg = '';
	switch ($tick) {
		case 1:
			$end = totime($data['end']) + 60 * 60 * 24 - 1;
			$time = 'and calltime < ' . $end;
			$msg = 'Danh sách trước ngày ' . date('d/m/Y', totime($data['end']));
		break;
		case 2:
			$from = totime($data['from']);
			$time = 'and calltime > ' . totime($data['from']);
			$msg = 'Danh sách sau ngày ' . date('d/m/Y', $from);
			break;
		case 3:
			$now = strtotime(date('Y/m/d'));
			$from = $now - 60 * 60 * 24 * 30;
			$end = $now + 60 * 60 * 24 - 1;
			$time = 'and (calltime between ' . $from . ' and ' . $end . ')';
			$msg = 'Danh sách từ ngày ' . date('d/m/Y', $from) . ' đến ngày ' . date('d/m/Y', totime($data['end']));
			break;
		case 0:
			$end = totime($data['end']) + 60 * 60 * 24 - 1;
			$time = 'and (calltime between ' . totime($data['from']) . ' and ' . $end . ')';
			$msg = 'Danh sách từ ngày ' . date('d/m/Y', totime($data['from'])) . ' đến ngày ' . date('d/m/Y', totime($data['end']));
			break;
	}
	$xtpl->assign('msg', $msg);

	$sql = 'select a.*, b.name as petname, c.name, c.phone from `'. VAC_PREFIX .'_usg` a inner join `'. VAC_PREFIX .'_pet` b on a.petid = b.id inner join `'. VAC_PREFIX .'_customer` c on b.customerid = c.id where a.status < 2 and (b.name like "%'. $data['keyword'].'%" or c.name like "%'. $data['keyword'].'%" or c.phone like "%'. $data['keyword'].'%") ' . $time . ' order by calltime desc';
	// die($sql);
	$query = $db->query($sql);

	$index = 1;
	while ($row = $query->fetch()) {
		$xtpl->assign('index', $index ++);
		$xtpl->assign('petname', $row['petname']);
		$xtpl->assign('name', $row['name']);
		$xtpl->assign('phone', $row['phone']);
		$xtpl->assign('recall', date('d/m/Y', $row['calltime']));
		$xtpl->parse('main.m1.row');
	}
	if ($index == 1) $xtpl->parse('main.m2');
	else $xtpl->parse('main.m1');
	$xtpl->parse('main');
	return $xtpl->text();
}

// function usgRecallList() {
// 	global $db, $filter, $lang_module, $order, $sort, $page, $status, $link, $filter_data, $vacconfigv2;
// 	$xtpl = new XTemplate("recall-list.tpl", PATH2);
// 	$xtpl->assign("lang", $lang_module);	

// 	// if (empty($status)) $status = 0;

// 	// $status_color = array("red", "yellow", "green", "gray");
// 	// $status_list = array(0 => 'Chưa Gọi', 'Đã Gọi');

// 	// $now = time();
// 	// if (empty($vacconfigv2['usg_filter'])) $vacconfigv2['usg_filter'] = 60 * 60 * 24 * 28;
// 	// $from = $now - $vacconfigv2['usg_filter'];
// 	// $end = $now + $vacconfigv2['usg_filter'];

// 	// foreach ($status_list as $statusid => $statusname) {
// 	// 	if ($status == $statusid) $xtpl->assign('recall_select', 'btn-info');
// 	// 	else $xtpl->assign('recall_select', 'btn-default');
// 	// 	$filter_data['status'] = $statusid;
// 	// 	$xtpl->assign('recall_link', "?" . http_build_query($filter_data));
// 	// 	$xtpl->assign('recall_name', $statusname);
// 	// 	$xtpl->parse('main.button');
// 	// }

// 	// $index = 1;
// 	// $where = "where (c.name like '%$filter_data[keyword]%' or c.phone like '%$filter_data[keyword]%')";
	
// 	// $xtpl->assign("bgcolor", 'redbg');
// 	// if ($status < 2) {
// 	// 	$sql = 'select a.id, a.cometime, a.calltime, a.status, a.image, a.note, a.birthday, a.birth, a.expectbirth, a.doctorid, b.id as petid, b.name as petname, c.name as customer, c.phone from `' . VAC_PREFIX . '_usg` a inner join `' . VAC_PREFIX . '_pet` b on a.status = '. $status .' and a.petid = b.id inner join `' . VAC_PREFIX . '_customer` c on b.customerid = c.id '. $where .' and calltime < '. $from .' order by a.calltime desc';
// 	// 	// die($sql);
// 	// 	$query = $db->query($sql);
// 	// 	while ($row = $query->fetch()) {
// 	// 		$xtpl->assign("index", $index ++);
// 	// 		$xtpl->assign("id", $row["id"]);
// 	// 		$xtpl->assign("status_type", $row["status"]);
// 	// 		$xtpl->assign("image", $row["image"]);
// 	// 		$xtpl->assign("petname", $row["petname"]);
// 	// 		$xtpl->assign("customer", $row["customer"]);
// 	// 		$xtpl->assign("phone", $row["phone"]);
// 	// 		$xtpl->assign("petid", $row["petid"]);
// 	// 		$xtpl->assign("note", $row["note"]);
// 	// 		$xtpl->assign("exbirth", $row["expectbirth"]);
// 	// 		$xtpl->assign("birth", $row["birth"]);
// 	// 		$xtpl->assign("sieuam", date("d/m/Y", $row["cometime"]));
// 	// 		$xtpl->assign("dusinh", date("d/m/Y", $row["calltime"]));
// 	// 		$xtpl->assign("color", $status_color[$row["status"]]);
// 	// 		if (!empty($status_color[$row["status"]])) {
// 	// 			$color = $status_color[$row["status"]];
// 	// 		}
// 	// 		else {
// 	// 			$color = $status_color[0];
// 	// 		}
// 	// 		if ($row["status"] == 2) {
// 	// 			$xtpl->assign("birth", $row["birth"]);
// 	// 			$xtpl->parse("main.list.birth");
// 	// 		}
// 	// 		$xtpl->assign("status", $lang_module["confirm_value2"][$row["status"]]);
// 	// 		$xtpl->assign("color", $color);
// 	// 		$xtpl->parse("main.list");
// 	// 		$xtpl->parse("main.row");
// 	// 	}
// 	// }

// 	// $sql = "select a.id, a.cometime, a.calltime, a.status, a.image, a.note, a.birthday, a.birth, a.expectbirth, a.doctorid, b.id as petid, b.name as petname, c.name as customer, c.phone from `" . VAC_PREFIX . "_usg` a inner join `" . VAC_PREFIX . "_pet` b on a.status = $status and a.petid = b.id inner join `" . VAC_PREFIX . "_customer` c on b.customerid = c.id $where and (calltime between $from and $end) order by a.calltime desc";
// 	// // die($sql);
// 	// $query = $db->query($sql);

// 	// $xtpl->assign("bgcolor", '');
// 	// while ($row = $query->fetch()) {
// 	// 	$xtpl->assign("index", $index ++);
// 	// 	$xtpl->assign("id", $row["id"]);
// 	// 	$xtpl->assign("status_type", $row["status"]);
// 	// 	$xtpl->assign("image", $row["image"]);
// 	// 	$xtpl->assign("petname", $row["petname"]);
// 	// 	$xtpl->assign("customer", $row["customer"]);
// 	// 	$xtpl->assign("phone", $row["phone"]);
// 	// 	$xtpl->assign("petid", $row["petid"]);
// 	// 	$xtpl->assign("note", $row["note"]);
// 	// 	$xtpl->assign("exbirth", $row["expectbirth"]);
// 	// 	$xtpl->assign("birth", $row["birth"]);
// 	// 	$xtpl->assign("sieuam", date("d/m/Y", $row["cometime"]));
// 	// 	$xtpl->assign("dusinh", date("d/m/Y", $row["calltime"]));
// 	// 	$xtpl->assign("color", $status_color[$row["status"]]);
// 	// 	if (!empty($status_color[$row["status"]])) {
// 	// 		$color = $status_color[$row["status"]];
// 	// 	}
// 	// 	else {
// 	// 		$color = $status_color[0];
// 	// 	}
// 	// 	if ($row["status"] == 2) {
// 	// 		$xtpl->assign("birth", $row["birth"]);
// 	// 		$xtpl->parse("main.list.birth");
// 	// 	}
// 	// 	$xtpl->assign("status", $lang_module["confirm_value2"][$row["status"]]);
// 	// 	$xtpl->assign("color", $color);
// 	// 	$xtpl->parse("main.list");
// 	// 	$xtpl->parse("main.row");
// 	// }

// 	$xtpl->parse("main");
// 	return $xtpl->text("main");
// }

// function usgVaccineList() {
// 	global $db, $filter, $lang_module, $order, $sort, $page, $status, $link, $filter_data, $vacconfigv2;
// 	// initial
// 	$xtpl = new XTemplate("vaccine-list.tpl", PATH2);
// 	$xtpl->assign("lang", $lang_module);

// 	$status_list = array(0 => 'Chưa Gọi', 'Đã Gọi', 'Đã tiêm');

// 	foreach ($status_list as $statusid => $statusname) {
// 		if ($status == $statusid) $xtpl->assign('recall_select', 'btn-info');
// 		else $xtpl->assign('recall_select', 'btn-default');
// 		$filter_data['status'] = $statusid;
// 		$xtpl->assign('recall_link', "?" . http_build_query($filter_data));
// 		$xtpl->assign('recall_name', $statusname);
// 		$xtpl->parse('main.button');
// 	}

// 	$now = strtotime(date("y-m-d"));
// 	$index = 1;
// 	// filter type
// 	$time = $vacconfigv2["usg_filter"];
// 	if (empty($time)) {
// 	  $time = 60 * 60 * 24 * 30;
// 	}
// 	$from = $now - $time;
// 	$end = $now + $time;
// 	// doctor
// 	$sql = "select * from " . VAC_PREFIX . "_doctor";
// 	$query = $db->query($sql);
// 	$doctor = array();
// 	while ($doctor_row = $query->fetch()) {
// 	  $doctor[$doctor_row["id"]] = $doctor_row["name"];
// 	}
  
// 	// update filter
// 	// update_usg_filter($filter, $limit);
  
// 	// filter sql

// 	$where = "where (c.name like '%$filter_data[keyword]%' or c.phone like '%$filter_data[keyword]%') and a.vaccine = $status and a.birthday > 0";
// 	// list

// 	if ($status < 2) {
// 		$sql = "select a.id, a.birthday, a.birth, a.expectbirth, a.firstvac, a.recall, a.vaccine, a.doctorid, b.id as petid, b.name as petname, c.name as customer, c.phone from `" . VAC_PREFIX . "_usg` a inner join `" . VAC_PREFIX . "_pet` b on a.petid = b.id inner join `" . VAC_PREFIX . "_customer` c on b.customerid = c.id $where and (cbtime < $from) order by birthday";
// 		$query = $db->query($sql);
	
// 		$xtpl->assign("bgcolor", "redbg");
// 		while ($usg_row = $query->fetch()) {
// 			if ($usg_row["doctorid"]) {
// 			  $usg_row["doctor"] = $doctor[$usg_row["doctorid"]];
// 			}
// 			else {
// 			  $usg_row["doctor"] = "";
// 			}
// 			$xtpl->assign("index", $index);
// 			$xtpl->assign("id", $usg_row["id"]);
// 			$xtpl->assign("confirm", $lang_module["confirm_" . $usg_row["vaccine"]]);
// 			switch ($usg_row["vaccine"]) {
// 			  case '1':
// 				$xtpl->assign("color", "yellow");
// 				break;
// 			  case '2':
// 				$xtpl->assign("color", "green");
// 				break;
// 			  case '4':
// 				$xtpl->assign("color", "gray");
// 				break;
// 			  default:
// 				$xtpl->assign("color", "red");
// 			}
		
// 			$xtpl->assign("petid", $usg_row["petid"]);
// 			$xtpl->assign("petname", $usg_row["petname"]);
// 			$xtpl->assign("customer", $usg_row["customer"]);
// 			$xtpl->assign("phone", $usg_row["phone"]);
// 			$xtpl->assign("doctor", $usg_row["doctor"]);
// 			$xtpl->assign("exbirth", $usg_row["expectbirth"]);
// 			$xtpl->assign("birth", $usg_row["birth"]);
// 			$xtpl->assign("birthday", date("d/m/Y", $usg_row["birthday"]));
// 			$xtpl->assign("vacday", date("d/m/Y", $usg_row["firstvac"]));
// 			if ($usg_row["vaccine"] > 1) {
// 			  $xtpl->parse("main.list.recall_link");
// 			}
// 			$xtpl->parse("main.list");
// 			$index ++;
// 		}
// 	}

// 	$sql = "select a.id, a.birthday, a.birth, a.expectbirth, a.firstvac, a.recall, a.vaccine, a.doctorid, b.id as petid, b.name as petname, c.name as customer, c.phone from `" . VAC_PREFIX . "_usg` a inner join `" . VAC_PREFIX . "_pet` b on a.petid = b.id inner join `" . VAC_PREFIX . "_customer` c on b.customerid = c.id $where and (cbtime between $from and $end) order by birthday";
// 	$query = $db->query($sql);
  
// 	$xtpl->assign("bgcolor", "");
// 	while ($usg_row = $query->fetch()) {
// 	  if ($usg_row["doctorid"]) {
// 		$usg_row["doctor"] = $doctor[$usg_row["doctorid"]];
// 	  }
// 	  else {
// 		$usg_row["doctor"] = "";
// 	  }
// 	  $xtpl->assign("index", $index);
// 	  $xtpl->assign("id", $usg_row["id"]);
// 	  $xtpl->assign("confirm", $lang_module["confirm_" . $usg_row["vaccine"]]);
// 	  switch ($usg_row["vaccine"]) {
// 		case '1':
// 		  $xtpl->assign("color", "yellow");
// 		  break;
// 		case '2':
// 		  $xtpl->assign("color", "green");
// 		  break;
// 		case '4':
// 		  $xtpl->assign("color", "gray");
// 		  break;
// 		default:
// 		  $xtpl->assign("color", "red");
// 	  }
  
// 	  $xtpl->assign("petid", $usg_row["petid"]);
// 	  $xtpl->assign("petname", $usg_row["petname"]);
// 	  $xtpl->assign("customer", $usg_row["customer"]);
// 	  $xtpl->assign("phone", $usg_row["phone"]);
// 	  $xtpl->assign("doctor", $usg_row["doctor"]);
// 	  $xtpl->assign("exbirth", $usg_row["expectbirth"]);
// 	  $xtpl->assign("birth", $usg_row["birth"]);
// 	  $xtpl->assign("birthday", date("d/m/Y", $usg_row["birthday"]));
// 	  $xtpl->assign("vacday", date("d/m/Y", $usg_row["firstvac"]));
// 	  if ($usg_row["vaccine"] > 1) {
// 		$xtpl->parse("main.list.recall_link");
// 	  }
// 	  $xtpl->parse("main.list");
// 	  $index ++;
// 	}
// 	$xtpl->parse("main");
// 	return $xtpl->text();
// }

function usgManageList() {
	global $db, $filter, $lang_module, $order, $sort, $page, $status, $link, $filter_data, $vacconfigv2;
	$xtpl = new XTemplate("manage-list.tpl", PATH2);
	$xtpl->assign("lang", $lang_module);

	$where = "where c.name like '%$filter_data[keyword]%' or phone like '%$filter[keyword]%' or b.name like '%$filter[keyword]%'";

	$sql = "select a.id, a.cometime, a.calltime, a.birth, a.expectbirth, a.vaccine, a.recall, b.id as petid, b.name as petname, c.id as customerid, c.name as customer, c.phone, d.name as doctor from " .  VAC_PREFIX . "_usg a inner join " .  VAC_PREFIX . "_pet b on a.petid = b.id inner join " .  VAC_PREFIX . "_customer c on b.customerid = c.id inner join " .  VAC_PREFIX . "_doctor d on a.doctorid = d.id $where $order[$sort] limit $filter offset " . ($page - 1) * $filter;
	$query = $db->query($sql);

	// echo $path; die();
	$stt = ($page - 1) * $filter + 1;
	while ($row = $query->fetch()) {
		// var_dump($row); die();
		$xtpl->assign("stt", $stt);
		$xtpl->assign("id", $row["id"]);
		$xtpl->assign("customer", $row["customer"]);
		$xtpl->assign("petname", $row["petname"]);
		$xtpl->assign("pet_link", $link . "patient&petid=" . $row["petid"]);
		$xtpl->assign("customer_link", $link . "customer&customerid=" . $row["customerid"]);
		$xtpl->assign("phone", $row["phone"]);
		$xtpl->assign("doctor", $row["doctor"]);
		$xtpl->assign("birth", $row["birth"]);
		$xtpl->assign("exbirth", $row["expectbirth"]);
		$xtpl->assign("cometime", date("d/m/Y", $row["cometime"]));
		$xtpl->assign("calltime", date("d/m/Y", $row["calltime"]));
		$recall = $row["recall"];
		if ($recall > 0 && $row["vaccine"] > 2) {
			$xtpl->assign("recall", date("d/m/Y", $recall));
			$xtpl->assign("vacname", "");
		}
		else {
			$xtpl->assign("recall", $lang_module["norecall"]);
			$xtpl->assign("vacname", " / " . $lang_module["confirm_value"][$row["vaccine"]]);
		}
		// $xtpl->assign("delete_link", "");

		$xtpl->parse("main.row");
		$stt ++;
	}

	$sql = "select count(*) as number from " .  VAC_PREFIX . "_usg a inner join " .  VAC_PREFIX . "_pet b on a.petid = b.id inner join " .  VAC_PREFIX . "_customer c on b.customerid = c.id inner join " .  VAC_PREFIX . "_doctor d on a.doctorid = d.id $where $order[$sort]";
	$query = $db->query($sql);
	$num = $query->fetch()['number'];
	$nav = nv_generate_page_shop($link, $num, $filter, $page);
	$xtpl->assign("nav_link", nv_generate_page_shop($link, $num, $filter, $page));

	$xtpl->parse("main");
	return $xtpl->text("main");
}


function usgCurrentList($filter) {
	switch ($filter['type']) {
		case 2:
			// danh sách đã sinh
			return usgBirthList($filter);
		break;
		case 3:
			// danh sách tiêm phòng
			return usgVaccineList($filter);
		break;
		case 4:
			// danh sách quản lý
			// closed
		break;
		default:
			// mạc định danh sách gần sinh
			return usgRecallList($filter);
	}
}

function usgRecallList($filter) {
	global $db, $module_name, $op, $vacconfigv2, $lang_module;

	$status_list = array('Chưa gọi', 'Đã gọi');
	$xtpl = new XTemplate("recall-list.tpl", PATH2);
	$xtpl->assign('lang', $lang_module);
	$index = 1;
	$time = time() + $vacconfigv2['filter'];
	$overtime = time();

	$sql = 'select a.id, a.usgtime, a.expecttime, a.expectnumber, a.doctorid, b.id as petid, b.name as petname, c.name as customer, c.phone from `'. VAC_PREFIX .'_usg2` a inner join `'. VAC_PREFIX .'_pet` b on a.petid = b.id inner join `'. VAC_PREFIX .'_customer` c on b.customerid = c.id where expecttime < '. $time .' and a.status = '. $filter['status'] .' order by expecttime asc';
	$query = $db->query($sql);

	$status = $filter['status'];
	$recall = array(0 => 'left', 'right');
	while ($row = $query->fetch()) {
		$xtpl->assign('index', $index++);
		$xtpl->assign('id', $row['id']);
		$xtpl->assign('customer', $row['customer']);
		$xtpl->assign('phone', $row['phone']);
		$xtpl->assign('expectnumber', $row['expectnumber']);
		$xtpl->assign('expecttime', date('d/m/Y', $row['expecttime']));
		if ($row['expecttime'] < $overtime) $xtpl->assign('bgcolor', 'orange');
		else $xtpl->assign('bgcolor', '');
		$xtpl->parse('main.row.' . $recall[$status]);
		$xtpl->parse('main.row');
	}
	for ($i = 0; $i < 2; $i++) { 
		$filter['status'] = $i;
		if ($status == $i) $xtpl->assign('recall_select', 'btn-info');
		else $xtpl->assign('recall_select', 'btn-default');
		$xtpl->assign('recall_link', '/' . $module_name . '/' . $op . '/?' . http_build_query($filter));
		$xtpl->assign('recall_name', $status_list[$i]);
		$xtpl->parse('main.button');
	}
	$xtpl->parse('main');
	return $xtpl->text();
}

function usgBirthList($filter) {
	global $db, $module_name, $op, $vacconfigv2;

	$xtpl = new XTemplate("birth-list.tpl", PATH2);
	$index = 1;
	$time = time() + $vacconfigv2['filter'];
	$overtime = time();

	$sql = 'select a.id, a.usgtime, a.birthtime, a.number, b.id as petid, b.name as petname, c.name as customer, c.phone from `'. VAC_PREFIX .'_usg2` a inner join `'. VAC_PREFIX .'_pet` b on a.petid = b.id inner join `'. VAC_PREFIX .'_customer` c on b.customerid = c.id where birthtime < '. $time .' and a.status = 2 order by birthtime asc';
	$query = $db->query($sql);

	$recall = array(0 => 'left', 'right');
	while ($row = $query->fetch()) {
		$xtpl->assign('index', $index++);
		$xtpl->assign('id', $row['id']);
		$xtpl->assign('customer', $row['customer']);
		$xtpl->assign('phone', $row['phone']);
		$xtpl->assign('number', $row['number']);
		$xtpl->assign('birthtime', date('d/m/Y', $row['birthtime']));
		if ($row['birthtime'] < $overtime) $xtpl->assign('bgcolor', 'orange');
		else $xtpl->assign('bgcolor', '');
		$xtpl->parse('main.row');
	}
	$xtpl->parse('main');
	return $xtpl->text();
}

function usgVaccineList($filter) {
	global $db, $module_name, $op, $vacconfigv2;

	$xtpl = new XTemplate("vaccine-list.tpl", PATH2);
	$index = 1;
	$time = time() + $vacconfigv2['filter'];

	$sql = 'select a.id, a.usgtime, a.vaccinetime, a.number, b.id as petid, b.name as petname, c.name as customer, c.phone from `'. VAC_PREFIX .'_usg2` a inner join `'. VAC_PREFIX .'_pet` b on a.petid = b.id inner join `'. VAC_PREFIX .'_customer` c on b.customerid = c.id where vaccinetime < '. $time .' and a.status = 3 order by vaccinetime asc';
	$query = $db->query($sql);

	$recall = array(0 => 'left', 'right');
	while ($row = $query->fetch()) {
		$xtpl->assign('index', $index++);
		$xtpl->assign('id', $row['id']);
		$xtpl->assign('customer', $row['customer']);
		$xtpl->assign('phone', $row['phone']);
		$xtpl->assign('number', $row['number']);
		if ($row['vaccinetime']) $xtpl->assign('vaccinetime', date('d/m/Y', $row['vaccinetime']));
		else $xtpl->assign('vaccinetime', 'Không tiêm phòng');
		$xtpl->parse('main.row');
	}
	$xtpl->parse('main');
	return $xtpl->text();
}
