<?php
/**
* @Project NUKEVIET-MUSIC
* @Phan Tan Dung (phantandung92@gmail.com)
* @Copyright (C) 2011
* @Createdate 26-01-2011 14:43
*/
if (!defined('NV_IS_QUANLY_ADMIN')) die('Stop!!!');
$link = NV_BASE_ADMINURL . "index.php?" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=";
$fs_option = array("1" => "Tên thú cưng A-Z", "2" => "Tên thú cưng Z-A", "3" => "Tên A-Z", "4" => "Tên Z-A");
$ff_option = array("25", "50", "100", "500", "1000");

$petid = $nv_Request->get_string('petid', 'get', "");
$action = $nv_Request->get_string('action', 'post/get', "");
if($action) {
	switch ($action) {
		case "addvac":
			$petid = $nv_Request->get_string('petid', 'post/get', '');
			$diseaseid = $nv_Request->get_string('diseaseid', 'post/get', '');
			$cometime = $nv_Request->get_string('cometime', 'post/get', '');
			$calltime = $nv_Request->get_string('calltime', 'post/get', '');
			$doctor  = $nv_Request->get_string('doctor ', 'post/get', '');
			
				if(!(empty($petid) || empty($diseaseid) || empty($cometime) || empty($calltime) || empty($_POST["doctor"]))) {
					$doctor = $_POST["doctor"];
				$cometime = strtotime($cometime);
				$calltime = strtotime($calltime);
				$sql = "insert into `" . VAC_PREFIX . "_vaccine` (petid, cometime, calltime, doctorid, recall, note, status, diseaseid) values ($petid, $cometime, $calltime, $doctor, 0, '', 0, $diseaseid);";
				$id = $db->insert_id($sql);
				if($id){
					$row = array("id" => $id, "cometime" => date("d/m/Y", $cometime), "calltime" => date("d/m/Y", $calltime), "confirm" => $lang_module["confirm_value"][0]);
					echo json_encode($row);
				}
			}
		break;
		case "remove":
			$id = $nv_Request->get_string('id', 'post/get', '');
			if(!empty($id)) {
				$sql = "delete from `" . VAC_PREFIX . "_customer` where id = $id";
				if($db->query($sql)) echo 1;
			}
		break;
		case "removevac":
			$id = $nv_Request->get_string('id', 'post/get', '');
			if(!empty($id)) {
				$sql = "delete from `" . VAC_PREFIX . "_vaccine` where id = $id";
				if($db->query($sql)) echo 1;
			}
		break;
		case "update":
			$id = $nv_Request->get_string('id', 'post/get', '');
			$name = $nv_Request -> get_string('customer', 'post/get', '');
			$phone = $nv_Request -> get_string('phone', 'post/get', '');
			if(!(empty($id) || empty($name) || empty($phone))) {
				$sql = "update `" . VAC_PREFIX . "_customer` set name = '$name', phone = '$phone' where id = $id";
				if($db->query($sql)) {
					$row = array("id" => $id, "name" => $name, "phone" => $phone, "note" => $note);
					echo json_encode($row);
				}
			}
		break;
	} 

	die();
}

if (!empty($petid)) {
	$page_title = $lang_module["patient_title1"];
	$patient = getPatientDetail($petid);
	$xtpl = new XTemplate("patient1.tpl", NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file);
	$xtpl->assign("lang", $lang_module);
	$xtpl->assign("id", $petid);
	$xtpl->assign("petname", $patient["petname"]);
	$xtpl->assign("customer", $patient["customer"]);
	$xtpl->assign("phone", $patient["phone"]);
	$xtpl->assign("time", date("Y-m-d"));
	$xtpl->assign("time2", date("Y-m-d", (NV_CURRENTTIME + 30 * 24 * 60 * 60)));

	$sql = "select * from " . VAC_PREFIX . "_doctor";
	$query = $db->query($sql);
	while ($row = $query->fetch()) {
		$xtpl->assign("doctorid", $row["id"]);
		$xtpl->assign("doctorname", $row["name"]);
		$xtpl->parse("main.doctor");
	}

	$diseases = getDiseaseList();
	// var_dump($diseases);
	// die();
	foreach ($diseases as $key => $value) {
		$xtpl->assign("diseaseid", $value["id"]);
		$xtpl->assign("diseasename", $value["name"]);
		$xtpl->parse("main.option");
	}
	// var_dump($patient);
	// die();

	foreach ($patient["data"] as $key => $patient_data) {
		$cometime = date("d/m/Y", $patient_data["cometime"]);
		$calltime = date("d/m/Y", $patient_data["calltime"]);
		if (empty($patient_data["status"]) || $patient_data["status"] < 0 || $patient_data["status"] >= count($lang_module["confirm_value"])) $patient_data["status"] = 0;
		$confirm = $lang_module["confirm_value"][$patient_data["status"]];
		$xtpl->assign("index", $patient_data["id"]);
		// var_dump($patient_data);
		// die();
		$xtpl->assign("diseaseid", $patient_data["diseaseid"]);
		// $xtpl->assign("disease", $patient_data["disease"]);
		$xtpl->assign("disease", $patient_data["disease"]);
		$xtpl->assign("cometime", $cometime);
		$xtpl->assign("calltime", $calltime);
		$xtpl->assign("confirm", $confirm);
		$xtpl->parse("main.vac");
	}
}
else {
	$page_title = $lang_module["patient_title3"];
	$xtpl = new XTemplate("patient3.tpl", NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file);
	$xtpl->assign("lang", $lang_module);

	$keyword = $nv_Request->get_string('key', 'get', "");
	$sort = $nv_Request->get_string('sort', 'get', "");
	$filter = $nv_Request->get_string('filter', 'get', "");
	$page = $nv_Request->get_string('page', 'get', "");
	$xtpl->assign("nv", $module_name);
	$xtpl->assign("op", $op);
		$xtpl->assign("keyword", $keyword);

	if (empty($sort)) $sort = 1;
	if (empty($filter)) $filter = 25;
	if (empty($page)) $page = 1;
	$patients = getPatientsList($keyword, $sort, $filter, $page);

	foreach ($fs_option as $key => $value) {
		$xtpl->assign("fs_name", $value);
		$xtpl->assign("fs_value", $key);
		// echo $key;
		// if ($key == 2) {
		// 	die();
		// }
		if ($sort == $key) $xtpl->assign("fs_select", "selected");
		else $xtpl->assign("fs_select", "");
		$xtpl->parse("main.fs_option");
	}
	
	foreach ($ff_option as $key => $value) {
		$xtpl->assign("ff_name", $value);
		$xtpl->assign("ff_value", $value);
		if ($filter == $value) $xtpl->assign("ff_select", "selected");
		else $xtpl->assign("ff_select", "");
		$xtpl->parse("main.ff_option");
	}

	$url = $link . $op . "&sort=$sort&filter=$filter";
	if(!empty($key)) {
		$url .= "&key=$keyword";
	}
    // echo strval($filter_text);
    // die();
    // var_dump( $patients["info"] ); die();
	$xtpl->assign("filter_count", sprintf ( $lang_module ['filter_result'], $patients["info"] ));
	
	$xtpl->assign("nav_link", nv_generate_page_shop($url, $patients["info"], $filter, $page));

	$index = ($page - 1) * $filter + 1;
	foreach ($patients["data"] as $key => $patient_data) {
	    $xtpl->assign("index", $index);
		$xtpl->assign("id", $patient_data["id"]);
		$xtpl->assign("petname", $patient_data["petname"]);
		$xtpl->assign("detail_link", $link  . "patient&petid=" . $patient_data["id"]);
		$xtpl->assign("detail_link2", $link  . "customer&customerid=" . $patient_data["customerid"]);
		$xtpl->assign("customer", $patient_data["customer"]);
		$xtpl->assign("phone", $patient_data["phone"]);
		$xtpl->parse("main.patient");
		$index ++;
	}
}

$xtpl->parse("main");

$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");
?>
