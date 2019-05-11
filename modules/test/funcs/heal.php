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


define('INI_PAGE', 1);
// define('INI_INSULT', 0);
define('INI_LIMIT', 10);
define('INI_COME', strtotime(date('Y-m-d')) - 60 * 60 * 24 * 15);
define('INI_CALL', strtotime(date('Y-m-d')) + 60 * 60 * 24 * 15);
define('INI_CUSTOMER', 0);
define('INI_PET', 0);
define('INI_STATUS', 0);

$action = $nv_Request->get_string('action', 'post/get', '');
if (!empty($action)) {
	$result = array('status' => 0);
  switch ($action) {
		// case 'get-customer':
		// 	$result['status'] = 1;
		// 	$result['customer'] = getCustomerData();
		// break;
		case 'addSpecies':
			$name = $nv_Request->get_string('name', 'post', '');
			$result['notify'] = 'loại thú cưng, ' . $name . ', đã tồn tại';

			if (!empty($name) && !checkSpecies($name)) {
				if ($id = insertSpecies($name)) {
					$result['html'] = selectSpeciesId($id);
					$result['notify'] = 'Đã thêm loại thú cưng, ' . $name;
					$result['status'] = 1;
				}
			}
		break;
		case 'filter-by':
			$cometime = $nv_Request->get_string('cometime', 'post', '');
			$calltime = $nv_Request->get_string('calltime', 'post', '');
			$customer = $nv_Request->get_int('customer', 'post', 0);
			$pet = $nv_Request->get_int('pet', 'post', 0);
			$gdoctor = $nv_Request->get_int('gdoctor', 'post', 0);

			$result['status'] = 1;
			$result['html'] = healFilter($cometime, $calltime, $customer, $pet, $gdoctor);
		break;
		case 'add-customer':
			$name = $nv_Request->get_string('name', 'post', '');
			$phone = $nv_Request->get_string('phone', 'post', '');

			if (!(empty($name) || empty($phone))) {
				$sql = "insert into `" . VAC_PREFIX . "_customer` (name, phone, address) values ('$name', '$phone', '$address');";
				$query = $db->query($sql);
				$id = $db->lastInsertId();

				$sql = 'select * from `'. VAC_PREFIX .'_customer` where id = ' . $id;
				$query = $db->query($sql);
				$user = $query->fetch();

				$result['status'] = 1;
				$result['id'] = $id;
				$result['notify'] = 'Đã thêm khách hàng';
				$result['customer'] = array($user);
			}
		break;
		case 'add-pet':
			$name = $nv_Request->get_string('name', 'post', '');
			$customerid = $nv_Request->get_string('customerid', 'post', '');

			$sql = 'select * from `'. VAC_PREFIX .'_customer` where id = ' . $customerid;
			$query = $db->query($sql);
			$user = $query->fetch();

			if (!(empty($user))) {
				$sql = "insert into `" . VAC_PREFIX . "_pet` (name, customerid, weight, age, species) values ('$name', '$customerid', 0, 0, 0);";
				$query = $db->query($sql);
				$id = $db->lastInsertId();

				$sql = 'select * from `'. VAC_PREFIX .'_pet` where customerid = ' . $customerid . ' order by id desc';
				$query = $db->query($sql);
				$pet = $query->fetch();
				$pet['species'] = selectSpeciesId($pet['id']);
				$user['pet'] = array($pet);

				$result['status'] = 1;
				$result['id'] = $id;
				$result['notify'] = 'Đã thêm thú cưng';
				$result['customer'] = array($user);
			}
		break;
		case 'customer-suggest':
			$keyword = $nv_Request->get_string('keyword', 'get/post', '');

			$result['status'] = 1;
			$result['customer'] = json_encode(getCustomerSuggestList($keyword));
		break;
		case 'filter':
			$page = $nv_Request->get_string('page', 'get/post', '');
			$limit = $nv_Request->get_string('limit', 'get/post', '');
			$cometime = $nv_Request->get_string('cometime', 'get/post', '');
			$calltime = $nv_Request->get_string('calltime', 'get/post', '');
			$pet = $nv_Request->get_int('pet', 'get/post', 0);
			$customer = $nv_Request->get_int('customer', 'get/post', 0);
			$status = $nv_Request->get_int('status', 'get/post', 0);
			
			$gdoctor = $nv_Request->get_int('gdoctor', 'get/post', 0);

			$html = healList($page, $limit, $customer, $pet, $status, $gdoctor);
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
			$note = $nv_Request->get_string('note', 'get/post', '');
			$insult = $nv_Request->get_string('insult', 'get/post', '');
			$drug = $nv_Request->get_array('drug', 'get/post', '');

			$page = $nv_Request->get_string('page', 'get/post', '');
			$limit = $nv_Request->get_string('limit', 'get/post', '');
			$cometime = $nv_Request->get_string('cometime', 'get/post', '');
			$calltime = $nv_Request->get_string('calltime', 'get/post', '');
			$pet = $nv_Request->get_int('pet', 'get/post', 0);
			$customer = $nv_Request->get_int('customer', 'get/post', 0);
			$fstatus = $nv_Request->get_int('fstatus', 'get/post', 0);

			$doctorid = $nv_Request->get_int('doctorid', 'get/post', 0);
			$gdoctor = $nv_Request->get_int('gdoctor', 'get/post', 0);

			if (!(empty($id))) {
				$sql = 'update `'. VAC_PREFIX .'_pet` set status = '. $status .', age = '. $age .', weight = '. $weight .', species = '. $species .' where id = ' . $petid;
				$db->query($sql);

				if ($status == 0) {
					$sql = 'select * from `'. VAC_PREFIX .'_heal_insult` where healid = ' . $id;
					$query = $db->query($sql);
					if ($row = $query->fetch) {
						$sql = 'update `'. VAC_PREFIX .'_heal_insult` set insult = '. $insult .' where healid = ' . $id;
						$db->query($sql);
					}
					else {
						$sql = 'insert into `'. VAC_PREFIX .'_heal_insult` (healid, insult) values('.$id.', '.$insult.')';
						$db->query($sql);
					}
				} 

				$sql = 'update `'. VAC_PREFIX .'_heal` set doctorid = '. $doctorid .', oriental = "'. $oriental .'", appear = "'. $appear .'", exam = "'. $exam .'", usg = "'. $usg .'", xray = "'. $xray .'", note = "'.$note.'" where id = ' . $id;
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
				$result['html'] = healList($page, $limit, $customer, $pet, $fstatus, $gdoctor);
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
			$note = $nv_Request->get_string('note', 'get/post', '');
			$insult = $nv_Request->get_string('insult', 'get/post', '');
			$drug = $nv_Request->get_array('drug', 'get/post', '');

			$page = $nv_Request->get_string('page', 'get/post', '');
			$limit = $nv_Request->get_string('limit', 'get/post', '');
			$cometime = $nv_Request->get_string('cometime', 'get/post', '');
			$calltime = $nv_Request->get_string('calltime', 'get/post', '');
			$pet = $nv_Request->get_int('pet', 'get/post', 0);
			$customer = $nv_Request->get_int('customer', 'get/post', 0);
			$fstatus = $nv_Request->get_int('fstatus', 'get/post', 0);

			$doctorid = $nv_Request->get_int('doctorid', 'get/post', 0);
			$gdoctor = $nv_Request->get_int('gdoctor', 'get/post', 0);

			$sql = 'update `'. VAC_PREFIX .'_pet` set status = '. $status .', age = '. $age .', weight = '. $weight .', species = '. $species .' where id = ' . $petid;
			$db->query($sql);

			$sql = 'insert into `'. VAC_PREFIX .'_heal` (petid, doctorid, appear, oriental, exam, usg, xray, note, time) values ('.$petid.', '. $doctorid .', "'.$appear.'", "'.$oriental.'", "'.$exam.'", "'.$usg.'", "'.$xray.'", "'.$note.'", '. time() .')';
			$db->query($sql);
			$id = $db->lastInsertId();

			if ($id && empty($status)) {
				$sql = 'insert into `'. VAC_PREFIX .'_heal_insult` (healid, insult) values('.$id.', '.$insult.')';
				$db->query($sql);
			}

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
			$result['html'] = healList($page, $limit, $customer, $pet, $fstatus, $gdoctor);
		break;
		case 'remove':
			$id = $nv_Request->get_int('id', 'get/post', 0);

			$page = $nv_Request->get_string('page', 'get/post', '');
			$limit = $nv_Request->get_string('limit', 'get/post', '');
			$cometime = $nv_Request->get_string('cometime', 'get/post', '');
			$calltime = $nv_Request->get_string('calltime', 'get/post', '');
			$status = $nv_Request->get_int('status', 'get/post', 0);

			$doctorid = $nv_Request->get_int('doctorid', 'get/post', 0);
			$gdoctor = $nv_Request->get_int('gdoctor', 'get/post', 0);

			if (!empty($id)) {
				$sql = 'delete from `'. VAC_PREFIX .'_heal` where id = ' . $id;
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['html'] = healList($page, $limit, $customer, $pet, $status, $gdoctor);
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

$html = '';
foreach ($drug as $key => $row) {
	$html .= '<div class="item-suggest" onclick="selectDrug('.$key.',\''.$row['unit'].'\')"> ' . $row['name'] . ' </div> ';
}
$xtpl->assign('drug_suggest', $html);

$customer = getCustomerSuggestList('');
$html = '';
foreach ($customer as $key => $row) {
	$html .= '<div class="item-suggest" onclick="parsePet('.$key.', 0)">' . $row['name'] . '<div class="right"> '. $row["phone"] .' </div> </div>';
}
$xtpl->assign('customer_suggest', $html);

foreach ($system as $key => $row) {
	$xtpl->assign('systemid', $key);
	$xtpl->assign('system', $row['name']);
	$xtpl->parse('main.system');
}

if (!empty($user_info) && !empty($user_info['userid'])) {
	$sql = 'SELECT * FROM `pet_users` where userid in (select user_id from `pet_rider_user` where user_id = '.$user_info['userid'].' and type = 1 and permission = 1)';
	$query = $db->query($sql);

	if (!empty($query->fetch())) {
		$sql = 'select * from `' . $db_config['prefix'] . '_users` where userid in (select user_id from `' . $db_config['prefix'] . '_rider_user` where type = 1)';
		$query = $db->query($sql);
		
		while ($doctor = $query->fetch()) {
			$xtpl->assign('name', $doctor['first_name']);
			$xtpl->assign('value', $doctor['userid']);
			$xtpl->parse('main.manager.doctor');
		}
		$gdoctor = 0;
		$xtpl->parse('main.manager');
	}
	else {
		$xtpl->assign('doctorid', $user_info['userid']);
		$gdoctor = $user_info['userid'];
	}
}

$xtpl->assign('content', healList(INI_PAGE, INI_LIMIT, INI_CUSTOMER, INI_PET, INI_STATUS, $gdoctor));

$xtpl->assign('dbdata', json_encode($customer));
$xtpl->assign('system', json_encode($system));
$xtpl->assign('drug', json_encode($drug));
$xtpl->assign('species', selectSpeciesId());
$xtpl->assign('cometime', date('d/m/Y', INI_COME));
$xtpl->assign('calltime', date('d/m/Y', INI_CALL));
$xtpl->parse("main");

$contents = $xtpl->text();
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
