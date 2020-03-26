<?php
/**
* @Project NUKEVIET-MUSIC
* @Phan Tan Dung (phantandung92@gmail.com)
* @Copyright (C) 2011
* @Createdate 26-01-2011 14:43
*/

if (!defined('NV_IS_QUANLY_ADMIN')) die('Stop!!!');

$drugs = drug_list();

$array_value2 = $nv_Request -> get_typed_array('d_name', 'post/get', 'string');
if(!empty($array_value2)) {
	$update_s = array();
	$array_value = array();

	foreach ($array_value2 as $key => $value) {
		if ($value) {
			$array_value[] = $value;
		}
	}

	$origin = count($drugs);
	$update = count($array_value);

	for ($i = 0; $i < $origin; $i++) { 
		$update_s[$i] = "delete from `" . VAC_PREFIX . "_drug` where id = " . ($i + 1);
	}

	if ($update > $origin) {
		$index = 0;
		for ($i = 0; $i < $origin; $i++) { 
			$index = $i + 1;
			$update_s[$i] = "update `" . VAC_PREFIX . "_drug` set name = '" . $array_value[$i] . "' where id = " . ($index);
		}
		for (; $i < $update; $i ++) { 
			$index = $i + 1;
			$update_s[$i] = "insert `" . VAC_PREFIX . "_drug` (id, name) values ($index, '" . $array_value[$i] . "')";
		}
	}
	else {
		$length = $update;
		$index = 1;
		for ($i = 0; $i < $update; $i++) { 
			$index = $i + 1;
			$update_s[$i] = "update `" . VAC_PREFIX . "_drug` set name = '" . $array_value[$i] . "' where id = " . ($index);
		}
	}

	foreach ($update_s as $key => $value) {
		// echo $value . "<br>";
		$db->query($value);
	}
	// die();
	echo $lang_module["saved"];
	die();
}

$page_title = $lang_module["disease_title"];

$xtpl = new XTemplate("drug.tpl", NV_ROOTDIR . "/themes/" . $global_config['module_theme'] . "/modules/" . $module_file);
$xtpl->assign("lang", $lang_module);
$xtpl->assign("content", admin_drug());

$drugs = drug_list();
$id = 1;
if (count($drugs) > 0) {
	$id = $drugs[count($drugs) - 1]["id"];
}
$xtpl->assign("id", $id);

$xtpl->parse("main");

$contents = $xtpl->text("main");


include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");

function admin_drug() {
	global $global_config, $module_file, $lang_module, $db;
	$xtpl = new XTemplate("drug-list.tpl", NV_ROOTDIR . "/themes/" . $global_config['module_theme'] . "/modules/" . $module_file);
	$xtpl->assign("lang", $lang_module);

	$drugs = drug_list();
	foreach ($drugs as $drug) {
		$xtpl->assign("id", $drug["id"]);
		$xtpl->assign("name", $drug["name"]);
		$xtpl->parse("main");
	}
	return $xtpl->text("main");
}

function drug_list() {
	global $db;
	$sql = "select * from `" . VAC_PREFIX . "_drug` order by id";
	$query = $db->query($sql);
	$drugs = array();
	$index = 1;
	while ($drug = $query->fetch()) {
		$drugs[$index] = $drug;
		$index ++;
	}
	return $drugs;
}
