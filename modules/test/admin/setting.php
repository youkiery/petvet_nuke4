<?php
/**
* @Project NUKEVIET-MUSIC
* @Phan Tan Dung (phantandung92@gmail.com)
* @Copyright (C) 2011
* @Createdate 26-01-2011 14:43
*/

if (!defined('NV_IS_QUANLY_ADMIN')) die('Stop!!!');

$filter = array(
	'type' => $nv_Request->get_string('type', 'get', '')
);

$action = $nv_Request->get_string('action', 'post/get', "");
if($action) {
	$result = array("status" => 0);
	switch ($action) {
        case '1':
            // do nothing
        break;
		case 'employ-filter':
			$id = $nv_Request->get_int('id', 'post', '');
			$name = $nv_Request->get_string('name', 'post', '');
	  
			$result['status'] = 1;
			$result['html'] = employContentId($id, $name);
		  break;
		case 'insert-employ':
			$id = $nv_Request->get_int('id', 'post', '');
			$name = $nv_Request->get_string('name', 'post', '');
	  
			$sql = 'select * from `'. VAC_PREFIX .'_setting` where userid = '. $id .' and module = "'. $filter['type'].'"';
			$query = $db->query($sql);
			if (empty($row = $query->fetch())) {
			  $sql = 'insert into `'. VAC_PREFIX .'_setting` (userid, module, type) values('. $id .', "'. $filter['type'] .'", 1)';
			  $db->query($sql);
			}
			$result['status'] = 1;
			$result['html'] = settingContent();
			$result['html2'] = employContentId($id, $name);
		break;
		case 'change-employ':
			$id = $nv_Request->get_int('id', 'post', '');
			$type = $nv_Request->get_int('type', 'post', '');
	  
			$sql = 'update `'. VAC_PREFIX .'_setting` set type = ' . $type . ' where module = "'. $filter['type'] .'" and userid = ' . $id;
			$db->query($sql);
			$result['status'] = 1;
			$result['html'] = settingContent();
		break;
		case 'remove-employ':
			$id = $nv_Request->get_int('id', 'post', '');
	  
			$sql = 'delete from `'. VAC_PREFIX .'_setting` where module = "'. $filter['type'] .'" and userid = ' . $id;
			$db->query($sql);
			$result['status'] = 1;
			$result['html'] = settingContent();
		break;
	}
	echo json_encode($result);
	die();
}

$func = array('kaizen' => 'Kaizen', 'spa' => 'SPA', 'vaccine' => 'Vaccine');

$xtpl = new XTemplate("main.tpl", PATH2);
$xtpl->assign('module_name', $module_name);
$xtpl->assign('op', $op);

foreach ($func as $key => $value) {
	$xtpl->assign('id', $key);
	$xtpl->assign('name', $value);
	$xtpl->assign('type', 'btn-default');
	if ($key == $filter['type']) $xtpl->assign('type', 'btn-info');
	$xtpl->parse('main.option');
}

$xtpl->assign('type_default', 'btn-default');
if ($func[$filter['type']]) {
	$xtpl->parse('main.insert');
	$xtpl->assign('content', settingContent());
} 
else {
	$xtpl->assign('type_default', 'btn-info');
	// $xtpl->assign('content', settingSystemContent());
}

$xtpl->assign("modal", settingModal());
$xtpl->parse("main");
$contents = $xtpl->text();

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");
