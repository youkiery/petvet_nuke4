<?php
/**
* @Project NUKEVIET-MUSIC
* @Phan Tan Dung (phantandung92@gmail.com)
* @Copyright (C) 2011
* @Createdate 26-01-2011 14:43
*/
if ( ! defined( 'NV_IS_MOD_QUANLY' ) ) die( 'Stop!!!' );
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
					$result["list"] = user_vaccine();
				}
		}
		break;
		case 'get_miscustom':
			$id = $nv_Request->get_string('id', 'post/get', "");

			if (!empty($id)) {
				$sql = "select a.* from `" . VAC_PREFIX . "_customer` a inner join `" . VAC_PREFIX . "_pet` b on a.id = b.customerid inner join `" . VAC_PREFIX . "_vaccine` c on b.id = c.petid where c.id = '$id'";
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
				$sql = "select * from `" . VAC_PREFIX . "_vaccine` where id = $id";
				$vac_query = $db->query($sql);
				$vac = $vac_query->fetch();

				$sql = "select * from `" . VAC_PREFIX . "_pet` where id = $vac[petid]";
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
				$sql = "select * from `" . VAC_PREFIX . "_vaccine` where id = $id";
				$vac_query = $db->query($sql);
				$vac = $vac_query->fetch();

				$sql = "select * from `" . VAC_PREFIX . "_pet` where id = $vac[petid]";
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
$xtpl = new XTemplate("list.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
$page_title = $lang_module["main_title"];
$xtpl->assign("lang", $lang_module);
$xtpl->assign("nv", $module_name);
$xtpl->assign("op", $op);
// page
$page = $nv_Request->get_string('page', 'get', '');
$xtpl->assign("page", $page);
// keyword
$keyword = $nv_Request->get_string('keyword', 'get', '');
$xtpl->assign("keyword", $keyword);
// // status
// if (!empty($_SESSION["vac_filter"]) && $_SESSION["vac_filter"] > 0 && !(strpos($_SESSION["vac_filter"], "0") == false || strpos($_SESSION["vac_filter"], "1") == false || strpos($_SESSION["vac_filter"], "2") == false)) {
// 	$filter = $_SESSION["vac_filter"];
// }
// else {
// 	$filter = $vaccine_config["vac_s"];
// 	$_SESSION["vac_filter"] = $filter;
// }

// $filter_array = str_split($filter);

foreach ($lang_module["vacstatusname"] as $key => $value) {
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
// doctor
$sql = "select * from " . VAC_PREFIX . "_doctor";
$query = $db->query($sql);
while($row = $query->fetch()) {
  $xtpl->assign("doctorid", $row["id"]);
  $xtpl->assign("doctorname", $row["name"]);
  $xtpl->parse("main.doctor");
}

$xtpl->assign("content", user_vaccine());

$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme( $contents );
include ( NV_ROOTDIR . "/includes/footer.php" );
