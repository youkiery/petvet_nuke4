<?php
/**
 * @Project NUKEVIET-MUSIC
 * @Author Phan Tan Dung
 * @Copyright (C) 2011
 * @Createdate 26/01/2011 10:26 AM
 */

// $sql = "select * from `" . VAC_PREFIX . "_usg`";
// $query = $db->query($sql);
// while ($row = $query->fetch()) {
// 	echo $row["birthday"] . ", " . $row["firstvac"] . "<br>";
// 	if ($row["birthday"] > 0) {
// 		$first_vac = $row["birthday"] + 60 * 60 * 24 * 15;
// 		$sql = "update `" . VAC_PREFIX . "_usg` set firstvac = $first_vac where id = $row[id]";
// 		$db->query($sql);
// 	}
// }

// die();
if (!defined('NV_IS_MOD_QUANLY')) die('Stop!!!');
$action = $nv_Request->get_string("action", "get/post", "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'change_custom':
		$id = $nv_Request->get_string('cid', 'post/get', "");
		$name = $nv_Request->get_string('name', 'post/get', "");
		$phone = $nv_Request->get_string('phone', 'post/get', "");
		$address = $nv_Request->get_string('address', 'post/get', "");

		if (!empty($name) && !empty($phone)) {
				$sql = "update `" . VAC_PREFIX . "_customer` set name = '$name', phone = '$phone', address = '$address' where id = $id";
				$query = $db->query($sql);
				if ($query) {
					$result["status"] = 1;
					$result["notify"] = $lang_module["saved"];
					$result["list"] = user_usg();
				}
		}
		break;
		case 'get_miscustom':
			$id = $nv_Request->get_string('id', 'post/get', "");

			if (!empty($id)) {
				$sql = "select a.* from `" . VAC_PREFIX . "_customer` a inner join `" . VAC_PREFIX . "_pet` b on a.id = b.customerid inner join `" . VAC_PREFIX . "_usg` c on b.id = c.petid where c.id = '$id'";
				$query = $db->query($sql);
				$custom = $query->fetch();
				if ($custom) {
					$result["status"] = 1;
					$result["id"] = $custom["id"];
					$result["name"] = $custom["name"];
					$result["phone"] = $custom["phone"];
					$result["address"] = $custom["address"];
				}
			}
		break;

		case 'miscustom':
			$id = $nv_Request->get_string("vacid", "get/post", "");
			if (!empty($id)) {
				$sql = "select * from `" . VAC_PREFIX . "_usg` where id = $id";
				$usg_query = $db->query($sql);
				$usg = $usg_query->fetch();

				$sql = "select * from `" . VAC_PREFIX . "_pet` where id = $usg[petid]";
				$pet_query = $db->query($sql);
				$pet = array();
				$customerid = 0;
				while ($row = $pet_query->fetch()) {
					$customerid = $row["customerid"];
					$pet[] = $row["id"];
				}
				$pet = implode(", ", $pet);

				$sql = "delete from `" . VAC_PREFIX . "_customer` where id = $customerid";
				$custom_query = $db->query($sql);

				$sql = "delete from `" . VAC_PREFIX . "_spa` where customerid = $customerid";
				$spa_query = $db->query($sql);
				
				if (!empty($pet)) {
					$sql = "delete from `" . VAC_PREFIX . "_pet` where id in ($pet)";
					$pet_query = $db->query($sql);
					
					$sql = "delete from `" . VAC_PREFIX . "_vaccine` where petid in ($pet)";
					$vac_query = $db->query($sql);
					
					$sql = "delete from `" . VAC_PREFIX . "_usg` where petid in ($pet)";
					$usg_query = $db->query($sql);
					
					$sql = "select * from `" . VAC_PREFIX . "_treat` where id = $id";
					$treat_query = $db->query($sql);
					$treat = array();
					while ($row = $treat_query->fetch()) {
						$treat[] = $row;
					}
					$treat = implode(", ", $treat);

					$sql = "delete from `" . VAC_PREFIX . "_treat` where petid in ($pet)";
					$treat_query = $db->query($sql);

					if (!empty($treat)) {
						$sql = "delete from `" . VAC_PREFIX . "_treating` where treatid in ($treat)";
						$treat_query = $db->query($sql);
					}
				}
				
				if ($custom_query) {
					$result["status"] = 1;
					$result["list"] = user_vaccine();
				}
			}
			break;
		case 'deadend':
			$id = $nv_Request->get_string("vacid", "get/post", "");
			if (!empty($id)) {
				$sql = "select * from `" . VAC_PREFIX . "_usg` where id = $id";
				$usg_query = $db->query($sql);
				$usg = $usg_query->fetch();

				$sql = "select * from `" . VAC_PREFIX . "_pet` where id = $usg[petid]";
				$pet_query = $db->query($sql);
				$pet = array();
				while ($row = $pet_query->fetch()) {
					$pet[] = $row["id"];
				}
				$pet = implode(", ", $pet);

				if (!empty($pet)) {
					$sql = "delete from `" . VAC_PREFIX . "_pet` where id in ($pet)";
					$pet_query = $db->query($sql);
					
					$sql = "delete from `" . VAC_PREFIX . "_vaccine` where petid in ($pet)";
					$vac_query = $db->query($sql);
					
					$sql = "delete from `" . VAC_PREFIX . "_usg` where petid in ($pet)";
					$usg_query = $db->query($sql);
					
					$sql = "select * from `" . VAC_PREFIX . "_treat` where id = $id";
					$treat_query = $db->query($sql);
					$treat = array();
					while ($row = $treat_query->fetch()) {
						$treat[] = $row;
					}
					$treat = implode(", ", $treat);

					$sql = "delete from `" . VAC_PREFIX . "_treat` where petid in ($pet)";
					$treat_query = $db->query($sql);

					if (!empty($treat)) {
						$sql = "delete from `" . VAC_PREFIX . "_treating` where treatid in ($treat)";
						$treat_query = $db->query($sql);
					}
					if ($pet_query) {
						$result["status"] = 1;
						$result["list"] = user_vaccine();
					}
				}
			}
		break;
	}
	echo json_encode($result);
	die();
}
quagio();
// initial
$xtpl = new XTemplate("sieuam-danhsach.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
$page_title = $lang_module["tieude_usg_danhsach"];
$xtpl->assign("lang", $lang_module);	
$xtpl->assign("nv", $module_name);
$xtpl->assign("op", $op);
$link = "/index.php?" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=";
// $vaccine_config = get_user_config();
// keyword
$keyword = $nv_Request->get_string('key', 'get', '');
// filter
$filter = $nv_Request->get_int('key', 'get/post', 0);
$xtpl->assign("keyword", $keyword);
// page
$page = $nv_Request->get_string("page", "get/post", "");
$xtpl->assign("page", $page);

// // page
// $page = $nv_Request->get_int('page', 'get', 1);
// if ($page < 0) {
// 	$page = 1;
// }
// limit 
// $limit_option = array(10, 20, 30, 40, 50, 75, 100); 
// if (!empty($_SESSION["usg_limit"]) && $_SESSION["usg_limit"] > 0) {
// 	$limit = $_SESSION["usg_limit"];
// }
// else {
// 	$limit = $vaccine_config["usg_f"];
// 	$_SESSION["usg_limit"] = $limit;
// }

// foreach ($limit_option as $value) {
// 	$xtpl->assign("limitname", $value);
// 	$xtpl->assign("limitvalue", $value);
// 	if ($value == $limit) {
// 		$xtpl->assign("lcheck", "selected");
// 	}
// 	else {
// 		$xtpl->assign("lcheck", "");
// 	}
// 	$xtpl->parse("main.limit");
// }
// status

// if (!empty($_SESSION["usg_filter"]) && $_SESSION["usg_filter"] > 0 && !(strpos($_SESSION["usg_filter"], "0") == false || strpos($_SESSION["usg_filter"], "1") == false || strpos($_SESSION["usg_filter"], "2") == false)) {
// 	$filter = $_SESSION["usg_filter"];
// }
// else {
// 	$filter = $vaccine_config["usg_s"];
// 	$_SESSION["usg_filter"] = $filter;
// }

// $filter_array = str_split($filter);

foreach ($lang_module["usgstatusname"] as $key => $value) {
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

// content
$xtpl->assign("content", user_usg());
// // nav 
// $nav = user_usg_nav();
// $xtpl->assign("nav", $nav);
// doctor
$sql = "select * from " . VAC_PREFIX . "_doctor";
$query = $db->query($sql);
while ($doctor_row = $query->fetch()) {
	$xtpl->assign("doctorid", $doctor_row["id"]);
	$xtpl->assign("doctorname", $doctor_row["name"]);
	$xtpl->parse("main.doctor");
}
// main
$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme( $contents );
include ( NV_ROOTDIR . "/includes/footer.php" );
