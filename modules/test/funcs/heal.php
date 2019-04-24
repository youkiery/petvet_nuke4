<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 19-04-2019 11:00
 */

if (!defined('NV_IS_MOD_QUANLY')) {
  die('Stop!!!');
}

quagio();
define('INI_PAGE', 1);
// define('INI_INSULT', 0);
define('INI_LIMIT', 10);
define('INI_COME', strtotime(date('Y-m-d')) - 60 * 60 * 24 * 15);
define('INI_CALL', strtotime(date('Y-m-d')) + 60 * 60 * 24 * 15);

$action = $nv_Request->get_string('action', 'post/get', '');
if (!empty($action)) {
	$result = array('status' => 0);
  switch ($action) {
		// case 'get-customer':
		// 	$result['status'] = 1;
		// 	$result['customer'] = getCustomerData();
		// break;
		case 'customer-suggest':
			$keyword = $nv_Request->get_string('keyword', 'get/post', '');

			$result['status'] = 1;
			$result['customer'] = getCustomerSuggestList($keyword);
		break;
		case 'filter':
			$page = $nv_Request->get_string('page', 'get/post', '');
			$limit = $nv_Request->get_string('insult', 'get/post', '');
			$cometime = $nv_Request->get_string('cometime', 'get/post', '');
			$calltime = $nv_Request->get_string('calltime', 'get/post', '');
			$pet = $nv_Request->get_int('pet', 'get/post', 0);
			$customer = $nv_Request->get_int('customer', 'get/post', 0);

			$cometime = totime($cometime);
			$calltime = totime($calltime);

			$html = healList($page, $limit, $cometime, $calltime, $customer, $pet);
			if (!empty($html)) {
				$result['status'] = 1;
				$result['html'] = $html;
			}
		break;
		case 'get_edit':
			$id = $nv_Request->get_int('id', 'get/post', 0);

			$data = getHealId($id);
			if (!empty($data)) {
				$result = $data;
				$result['status'] = 1;
			}
		break;
		case 'edit':
			$id = $nv_Request->get_int('id', 'get/post', 0);
			$petid = $nv_Request->get_int('petid', 'get/post', 0);
			$status = $nv_Request->get_int('status', 'get/post', 0);
			$age = $nv_Request->get_int('age', 'get/post', 0);
			$weight = $nv_Request->get_int('weight', 'get/post', 0);
			$species = $nv_Request->get_int('species', 'get/post', 0);
			$system = $nv_Request->get_array('system', 'get/post', '');
			$oriental = $nv_Request->get_string('oriental', 'get/post', '');
			$appear = $nv_Request->get_string('appear', 'get/post', '');
			$exam = $nv_Request->get_string('exam', 'get/post', '');
			$usg = $nv_Request->get_string('usg', 'get/post', '');
			$xray = $nv_Request->get_string('xray', 'get/post', '');
			$drug = $nv_Request->get_array('drug', 'get/post', '');

			$page = $nv_Request->get_string('page', 'get/post', '');
			$limit = $nv_Request->get_string('insult', 'get/post', '');
			$cometime = $nv_Request->get_string('cometime', 'get/post', '');
			$calltime = $nv_Request->get_string('calltime', 'get/post', '');
			$pet = $nv_Request->get_int('pet', 'get/post', 0);
			$customer = $nv_Request->get_int('customer', 'get/post', 0);

			$cometime = totime($cometime);
			$calltime = totime($calltime);

			if (!(empty($id))) {
				$sql = 'update `'. VAC_PREFIX .'_pet` set status = '. $status .', age = '. $age .', weight = '. $weight .', species = '. $species .' where id = ' . $petid;
				$db->query($sql);

				$sql = 'update `'. VAC_PREFIX .'_heal` set oriental = "'. $oriental .'", appear = "'. $appear .'", exam = "'. $exam .'", usg = "'. $usg .'", xray = "'. $xray .'" where id = ' . $id;
				$db->query($sql);

				$sql = 'delete from `'. VAC_PREFIX .'_system` where healid = ' . $id;
				$db->query($sql);
				foreach ($system as $key => $value) {
					if (!empty($value)) {
						$sql = 'insert into `'. VAC_PREFIX .'_system` (healid, systemid) values('.$id.', '.$value.')';
						$db->query($sql);
					}
				}

				$sql = 'delete from `'. VAC_PREFIX .'_medicine` where healid = ' . $id;
				$db->query($sql);
				foreach ($drug as $key => $value) {
					if (!empty($value)) {
						$sql = 'insert into `'. VAC_PREFIX .'_medicine` (healid, medicineid, quanlity) values('.$id.', '.$key.', '.$value.')';
						$db->query($sql);
					}
				}

				$result['status'] = 1;
				$result['html'] = healList($page, $limit, $cometime, $calltime, $customer, $pet);
			}
		break;
		case 'insert':
			$id = $nv_Request->get_int('id', 'get/post', 0);
			$petid = $nv_Request->get_int('petid', 'get/post', 0);
			$status = $nv_Request->get_int('status', 'get/post', 0);
			$age = $nv_Request->get_int('age', 'get/post', 0);
			$weight = $nv_Request->get_int('weight', 'get/post', 0);
			$species = $nv_Request->get_int('species', 'get/post', 0);
			$system = $nv_Request->get_array('system', 'get/post', '');
			$oriental = $nv_Request->get_string('oriental', 'get/post', '');
			$appear = $nv_Request->get_string('appear', 'get/post', '');
			$exam = $nv_Request->get_string('exam', 'get/post', '');
			$usg = $nv_Request->get_string('usg', 'get/post', '');
			$xray = $nv_Request->get_string('xray', 'get/post', '');
			$drug = $nv_Request->get_array('drug', 'get/post', '');

			$page = $nv_Request->get_string('page', 'get/post', '');
			$limit = $nv_Request->get_string('insult', 'get/post', '');
			$cometime = $nv_Request->get_string('cometime', 'get/post', '');
			$calltime = $nv_Request->get_string('calltime', 'get/post', '');
			$pet = $nv_Request->get_int('pet', 'get/post', 0);
			$customer = $nv_Request->get_int('customer', 'get/post', 0);

			$cometime = totime($cometime);
			$calltime = totime($calltime);

			$sql = 'update `'. VAC_PREFIX .'_pet` set status = '. $status .', age = '. $age .', weight = '. $weight .', species = '. $species .' where id = ' . $petid;
			$db->query($sql);

			$sql = 'insert into `'. VAC_PREFIX .'_heal` (petid, appear, oriental, exam, usg, xray, time) values ('.$petid.', "'.$appear.'", "'.$oriental.'", "'.$exam.'", "'.$usg.'", "'.$xray.'", '. time() .')';
			$db->query($sql);
			$id = $db->lastInsertId();

			$sql = 'delete from `'. VAC_PREFIX .'_system` where healid = ' . $id;
			$db->query($sql);
			foreach ($system as $key => $value) {
				if (!empty($value)) {
					$sql = 'insert into `'. VAC_PREFIX .'_system` (healid, systemid) values('.$id.', '.$value.')';
					$db->query($sql);
				}
			}

			$sql = 'delete from `'. VAC_PREFIX .'_medicine` where healid = ' . $id;
			$db->query($sql);
			foreach ($drug as $key => $value) {
				if ($value) {
					$sql = 'insert into `'. VAC_PREFIX .'_medicine` (healid, medicineid, quanlity) values('.$id.', '.$key.', '.$value.')';
				 $db->query($sql);
				}
			}
			$result['status'] = 1;
			$html = healList($page, $limit, $cometime, $calltime, $customer, $pet);
			$result['html'] = healList($page, $limit, $cometime, $calltime, $customer, $pet);
		break;
		case 'remove':
			$id = $nv_Request->get_int('id', 'get/post', 0);

			$page = $nv_Request->get_string('page', 'get/post', '');
			$limit = $nv_Request->get_string('insult', 'get/post', '');
			$cometime = $nv_Request->get_string('cometime', 'get/post', '');
			$calltime = $nv_Request->get_string('calltime', 'get/post', '');

			$cometime = totime($cometime);
			$calltime = totime($calltime);

			if (!empty($id)) {
				$sql = 'delete from `'. VAC_PREFIX .'_heal` where id = ' . $id;
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['html'] = healList($page, $limit, $cometime, $calltime, $customer, $pet);
				}
			}
		break;
	}

  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("heal.tpl", PATH);

$system = getSystemList();
$drug = getMedicineList();

foreach ($system as $key => $row) {
	$xtpl->assign('systemid', $key);
	$xtpl->assign('system', $row['name']);
	$xtpl->parse('main.system');
}

$xtpl->assign('content', healList(INI_PAGE, INI_LIMIT, INI_COME, INI_CALL));
$xtpl->assign('dbdata', getCustomerSuggestList(''));
$xtpl->assign('system', json_encode($system));
$xtpl->assign('drug', json_encode($drug));
$xtpl->assign('cometime', date('d/m/Y', INI_COME));
$xtpl->assign('calltime', date('d/m/Y', INI_CALL));
$xtpl->parse("main");

$contents = $xtpl->text();
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
