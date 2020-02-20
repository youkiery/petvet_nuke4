<?php
/**
* @Project NUKEVIET-MUSIC
* @Phan Tan Dung (phantandung92@gmail.com)
* @Copyright (C) 2011
* @Createdate 26-01-2011 14:43
*/

if (!defined('NV_IS_MOD_QUANLY')) die('Stop!!!');
quagio();

$xtpl = new XTemplate("main.tpl", PATH2);
$xtpl->assign("lang", $lang_module);
$sort_type = array("Ngày dự sinh giảm dần", "Ngày dự sinh tăng dần", "ngày siêu âm giảm dần", "Ngày siêu âm tăng dần");
$order = array("order by calltime desc", "order by calltime asc", "order by cometime desc", "order by cometime asc");
$filter_type = array("25", "50", "100", "200", "Tất cả");
$result = array("status" => 0, "data" => "");
$check = false;
$type_list = array(1 => 'Danh sách gần sinh', 'Danh sách đã sinh', 'Danh sách tiêm phòng', 'Danh sách quản lý');

$type = $nv_Request -> get_int('type', 'get', 1);
$filter = $nv_Request -> get_int('filter', 'get', 25);
$page = $nv_Request -> get_int('page', 'get', 1);
$status = $nv_Request -> get_int('status', 'get', 0);
$sort = $nv_Request -> get_string('sort', 'get', '');
// $from = $nv_Request -> get_string('from', 'get', '');
// $to = $nv_Request -> get_string('end', 'get', '');
$keyword = $nv_Request -> get_string('keyword', 'get', '');
// $filter_data = array('status' => $status, 'type' => $type, 'sort' => $sort, 'keyword' => $keyword, 'filter' => $filter, 'from' => $from, 'end' => $to);
$filter_data = array('status' => $status, 'type' => $type, 'sort' => $sort, 'keyword' => $keyword, 'filter' => $filter);
$id = $nv_Request->get_string('id', 'post', "");
// $tick = 0;
// if (empty($from)) $tick += 1;
// if (empty($to)) $tick += 2;

// Hiển thị danh sách tab
if (empty($status)) $status = 0;
if (empty($type_list[$type])) $type = 1;
if (!empty($user_info['in_groups']) && count($user_info['in_groups'])) {
	$sql = 'select * from `'. VAC_PREFIX .'_heal_manager` where type = 7 and groupid in ('. implode(', ', $user_info['in_groups']) .')';
	$query = $db->query($sql);
	$row = $query->fetch();
	if (empty($row)) {
		unset($type_list[4]);
	}
}

$link = $link . "?" . http_build_query($filter_data);

$xtpl->assign('select_type', $type);
$xtpl->assign('select_status', $status);
foreach ($type_list as $key => $value) {
	if ($key == $type) $xtpl->assign('type_button', 'btn-info');
	else $xtpl->assign('type_button', 'btn-default');
	$xtpl->assign('type', $key);
	$filter_data['status'] = 0;
	$filter_data['type'] = $key;
	$filter_data['page'] = 1;
	$xtpl->assign('type_link', "?" . http_build_query($filter_data));
	$xtpl->assign('type_name', $value);
	$xtpl->parse('main.type');
}
$filter_data['page'] = $page;
$filter_data['type'] = $type;
$filter_data['status'] = $status;

$xtpl->assign("keyword", $keyword);
$xtpl->assign("nv", $module_name);
$xtpl->assign("op", "sieuam");

$today = date("d/m/Y", NV_CURRENTTIME);
$dusinh = $vacconfigv2["expect"];
if (empty($dusinh)) {
	$dusinh = 21 * 24 * 60 * 60;
}

if (empty($page)) {
	$page = 1;
}

$xtpl->assign("now", $today);
$xtpl->assign("recall_date", date('d/m/Y', time() + 60 * 60 * 24 * 21));
$xtpl->assign("dusinh", date("d/m/Y", strtotime($today) + $dusinh));

if (empty($sort)) $sort = 0;

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

$action = $nv_Request->get_string('action', 'post', "");
if ($action) {
	$result = array("status" => 0, "data" => array());
	switch ($action) {
		case 'update-usg':
			$id = $nv_Request->get_int('id', 'post', 0);
			$data = $nv_Request->get_array('data', 'post');
			if ($data['cometime']) $data['cometime'] = totime($data['cometime']);
			if ($data['calltime']) $data['calltime'] = totime($data['calltime']);
			if ($data['recall']) $data['recall'] = totime($data['recall']);
			if ($data['birthday']) $data['birthday'] = totime($data['birthday']);
			if ($data['firstvac']) $data['firstvac'] = totime($data['firstvac']);

			$sql = 'update `'. VAC_PREFIX .'_usg` set cometime = "'. $data['cometime'] .'", calltime = "'. $data['calltime'] .'", doctorid = "'. $data['doctorid'] .'", note = "'. $data['note'] .'", image = "'. $data['image'] .'", birth = "'. $data['birth'] .'", expectbirth = "'. $data['expectbirth'] .'", recall = "'. $data['recall'] .'", vaccine = "'. $data['vaccine'] .'", birthday = "'. $data['birthday'] .'", firstvac = "'. $data['firstvac'] .'" where id = ' . $id;
			if ($db->query($sql)) {
				$resut['status'] = 1;
			}
		break;
		case 'get-update':
			$id = $nv_Request->get_string('id', 'post', "");
			if (!empty($id)) {
				$sql = "select * from " .  VAC_PREFIX . "_usg where id = $id";
				$query = $db->query($sql);

				if ($query) {
					$row = $query->fetch();
					$sql = "select * from " .  VAC_PREFIX . "_pet where id = $row[petid]";
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
					// var_dump($result);die();
				}
			}
		break;
		case 'edit-note':
			$note = $nv_Request->get_string('note', 'post', '');
			$id = $nv_Request->get_int('id', 'post', '');

			$sql = 'update `'. VAC_PREFIX .'_usg` set note = "'. $note .'" where id = ' . $id;
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
			
			$sql = 'select * from `'. VAC_PREFIX .'_usg` where id = ' . $data['id'];
			$query = $db->query($sql);
			$usg = $query->fetch();

			$mod = $usg['status'] + ($data['type'] ? 1 : -1);

			if (!empty($status_list[$mod])) {
				$sql = 'update `'. VAC_PREFIX .'_usg` set status = ' . $mod . ' where id = ' . $data['id'];
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['html'] = usgRecallList();
				}
			}
		break;
		case 'change-vaccine-status':
			$data = $nv_Request->get_array('data', 'post');
			$status_list = array(0 => "Chưa Gọi", "Đã Gọi", "Đã Tiêm");
			
			$sql = 'select * from `'. VAC_PREFIX .'_usg` where id = ' . $data['id'];
			$query = $db->query($sql);
			$usg = $query->fetch();

			$mod = $usg['vaccine'] + ($data['type'] ? 1 : -1);
			
			if (!empty($status_list[$mod])) {
				$sql = 'update `'. VAC_PREFIX .'_usg` set vaccine = ' . $mod . ' where id = ' . $data['id'];
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

			$sql = 'select * from `'. VAC_PREFIX .'_usg` where id = ' . $data['id'];
			$query = $db->query($sql);
			$usg = $query->fetch();

			$sql = 'select * from `'. VAC_PREFIX .'_pet` where id = ' . $usg['petid'];
			$query = $db->query($sql);
			$pet = $query->fetch();
			
			$sql = "insert into `". VAC_PREFIX ."_pet` values(null, '$data[petname]', $pet[customerid], 0, 0, 0, 0)";
			$sql2 = "insert into `". VAC_PREFIX ."_vaccine` values(null, '$pet[id]', $data[disease], ". time() .", ". totime($data['recall']) .", '', 0, 0, $data[doctor], ". time() .")";
			$sql3 = 'update `'. VAC_PREFIX .'_usg` set vaccine = 4 where id = ' . $data['id'];

			if ($db->query($sql) && $db->query($sql2) && $db->query($sql3)) {
				$result['status'] = 1;
				$result['html'] = usgVaccineList();
			}
		break;
		case 'remove-usg':
			$id = $nv_Request->get_int('id', 'post', 0);
			if (!empty($id)) {
				$sql = "delete from " .  VAC_PREFIX . "_usg where id = $id";
			
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['html'] = usgManageList();
				}
			}
		break;
		case 'usg_info':
			$id = $nv_Request->get_string('id', 'post', "");
			if (!empty($id)) {
				$sql = "select * from " .  VAC_PREFIX . "_usg where id = $id";
				$query = $db->query($sql);

				if ($query) {
					$row = $query->fetch();
					$sql = "select * from " .  VAC_PREFIX . "_pet where id = $row[petid]";
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
		case 'update_usg':
			$id = $nv_Request->get_string('id', 'post', "");
			$cometime = $nv_Request->get_string('cometime', 'post', "");
			$calltime = $nv_Request->get_string('calltime', 'post', "");
			$doctorid = $nv_Request->get_string('doctorid', 'post', "");
			$birth = $nv_Request->get_string('birth', 'post', "");
			$exbirth = $nv_Request->get_string('exbirth', 'post', "");
			$recall = $nv_Request->get_string('recall', 'post', "");
			$vaccine = $nv_Request->get_int('vaccine', 'post', 0);
			$note = $nv_Request->get_string('note', 'post', "");
			$image = $nv_Request->get_string('image', 'post', "");
			$customer = $nv_Request->get_string('customer', 'post', "");

			$firstvac = $nv_Request->get_string('firstvac', 'post', "");
			$birthday = $nv_Request->get_string('birthday', 'post', "");
			if (!(empty($id) || empty($cometime) || empty($calltime) || empty($doctorid))) {
				$cometime = totime($cometime);
				$calltime = totime($calltime);
				$sql = "select * from `" . VAC_PREFIX . "_usg` where id = $id";
				$query = $db->query($sql);
				$usg = $query->fetch();
				// var_dump($usg);
				$today = strtotime(date("Y-m-d"));
				if (empty($firstvac)) {
					$firstvac = $today;
				}
				else {
					$firstvac = totime($firstvac);
				}
				if (empty($birthday)) {
					$birthday = $today;
				}
				else {
					$birthday = totime($birthday);
				}
				if ($usg["vaccine"] >= 2) {
					$vaccine = 2;
				}
				if ($vaccine == 2) {
					if ($recall == 0) {
						$recall = strtotime(date("Y-m-d"));
					}
					else {
						$recall = totime($recall);
					}
					if ($usg["childid"] == 0 && $customer > 0) {
						$sql = "insert into " . VAC_PREFIX . "_pet (name, customerid) values('" . date("d/m/Y", $calltime) . "', $customer)";
						$query = $db->query($sql);
						$pet_id = $db->lastInsertId();
	
						if ($pet_id > 0) {
							$sql = "update `" . VAC_PREFIX . "_usg` set childid = $pet_id, firstvac = $firstvac, birthday = $birthday, cbtime = " . time() . " where id = $id";
							$query = $db->query($sql);
						}
							
						$sql = "insert into `" . VAC_PREFIX . "_vaccine` (petid, diseaseid, cometime, calltime, status, note, recall, doctorid, ctime) values ($pet_id, 0, $firstvac, $recall, 0, '', 0, $doctorid, " . time() . ");";
						$query = $db->query($sql);
					}
				}
				if ($recall == 0) {
					$recall = 0;
				}
				$sql = "update " .  VAC_PREFIX . "_usg set cometime = $cometime, calltime = $calltime, doctorid = $doctorid, note = '$note', image = '$image', birth = $birth, expectbirth = $exbirth, recall = $recall, vaccine = $vaccine, firstvac = $firstvac, birthday = $birthday  where id = $id";
				$query = $db->query($sql);
				if ($query) {
					$result["status"] = 1;
				}
			}
		break;
		case 'insert-usg':
			// var_dump($_POST);
			if ( ! ( empty($petid) || empty($doctorid) || empty($cometime) || empty($calltime) ) ) {
				$sql = "select id from `" . VAC_PREFIX . "_pet` where id = $petid";
				$query = $db->query($sql);
			
				if ($query->rowCount()) {
					$cometime = totime($cometime);
					$calltime = totime($calltime);
					$sql = "INSERT INTO `" . VAC_PREFIX . "_usg` (`petid`, `doctorid`, `cometime`, `calltime`, `image`, `status`, `expectbirth`, `note`, `ctime`) VALUES ($petid, $doctorid, $cometime, $calltime, '$image', 0, $exbirth, '$note', " . time() . ")";
					$query = $db->query($sql);
					$insert_id = $db->lastInsertId();
			
					if ($insert_id) {
				  if (!empty($phone)) {
					$sql = "update `" . VAC_PREFIX . "_customer` set name = '$customer', address = '$address' where phone = '$phone'";
					$db->query($sql);
				  }
						$result["status"] = 1;
						$result["data"] = $lang_module["themsatc"];
					}
				}
			}
			
			if (!$result["status"]) {
				$result["data"] = $lang_module["themsatb"];
			}
		break;			
	}
	echo json_encode($result);
	die();
}

switch ($type) {
	case 1:
		$xtpl->assign("content", usgRecallList());
		break;
	case 2:
		$xtpl->assign("content", usgVaccineList());
		break;
	default:
		// xxx: nếu không có quyền truy cập báo lại
		if (!empty($type_list[3])) {
			$xtpl->assign("content", usgManageList());
		}
		else {
			$xtpl->assign("content", 'Danh sách không có quyền truy cập');
		}
		break;
}

$xtpl->assign("modal", usgModal($lang_module));
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_site_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");
