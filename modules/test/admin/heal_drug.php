<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_QUANLY_ADMIN')) {
	die('Stop!!!');
}

$page_title = "Quản lý thuốc & tra cứu ";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'insert-disease':
			$name = $nv_Request->get_string('name', 'post/get', '');

			if (!empty($name)) {
				$sql = 'select * from `'. VAC_PREFIX .'_heal_disease` where name ="'.$name.'"';
				$query = $db->query($sql);

				if (empty($query->fetch())) {
					$sql = 'insert into `'. VAC_PREFIX .'_heal_disease` (name) values("'.$name.'")';
					$query = $db->query($sql);
					$id = $db->lastInsertId();

					if ($query) {
						$result['status'] = 1;
						$result['id'] = $id;
						$drug = getDrugList();
						$result['disease'] = diseaseList();
						$result['html'] = adminDrugList($drug, $keyword);
						$result['notify'] = 'Đã thêm bệnh vào danh sách';
					}
				}
			}
		break;
    case 'insert':
			$code = $nv_Request->get_string('code', 'post/get', '');
			$name = $nv_Request->get_string('name', 'post/get', '');
			$unit = $nv_Request->get_string('unit', 'post/get', '');
			$keyword = $nv_Request->get_string('keyword', 'post/get', '');
			$result['notify'] = 'Chưa nhập tên thuốc hoặc tên bệnh trùng';

			if (!empty($name)) {
				$sql = 'select * from `'. VAC_PREFIX .'_heal_medicine` where name ="'.$name.'"';
				$query = $db->query($sql);

				if (empty($query->fetch())) {
					$sql = 'insert into `'. VAC_PREFIX .'_heal_medicine` (name, unit, code, effect, effective, system, limits, note) values("'.$name.'", "'.$unit.'", "'.$code.'", "", "", "", "", "")';
					$query = $db->query($sql);
					$id = $db->lastInsertId();

					if ($query) {
						$result['status'] = 1;
						$result['id'] = $id;
						$drug = getDrugList();
						$result['drug'] = $drug;
						$result['html'] = adminDrugList($drug, $keyword);
						$result['notify'] = 'Đã thêm bệnh vào danh sách';
					}
				}
			}
		break;
		case 'edit':
			$id = $nv_Request->get_string('id', 'post/get', '');
			$code = $nv_Request->get_string('code', 'post/get', '');
			$name = $nv_Request->get_string('name', 'post/get', '');
			$unit = $nv_Request->get_string('unit', 'post/get', '');
			$system = $nv_Request->get_array('system', 'post/get', '');
			$limit = $nv_Request->get_string('limit', 'post/get', '');
			$effect = $nv_Request->get_string('effect', 'post/get', '');
			$effective = $nv_Request->get_array('effective', 'post/get', '');
			$disease = $nv_Request->get_array('disease', 'post/get', '');
			$note = $nv_Request->get_string('note', 'post/get', '');			
			$keyword = $nv_Request->get_string('keyword', 'post/get', '');
			
			$sql = 'update `'. VAC_PREFIX .'_heal_medicine` set name = "'.$name.'", code = "'.$code.'", unit = "'.$unit.'", system = "'.(implode(',', $system)).'", limits = "'.$limit.'", effect = "'.$effect.'", effective = "'.(passbyParam($effective)).'", disease = "'.(passbyParam($disease)).'", note = "'.$note.'" where id = ' . $id;
			$query = $db->query($sql);

			if ($query) {
				$result['status'] = 1;
				$drug = getDrugList();
				$result['drug'] = $drug;
				$result['html'] = adminDrugList($drug, $keyword);
				$result['notify'] = 'Đã cập nhật thuốc';
			}
		break;
		case 'remove':
			$id = $nv_Request->get_string('id', 'post/get', '');
			$keyword = $nv_Request->get_string('keyword', 'post/get', '');
			
			$sql = 'delete from `'. VAC_PREFIX .'_heal_medicine` where id = ' . $id;
			$query = $db->query($sql);

			if ($query) {
				$result['status'] = 1;
				$drug = getDrugList();
				$result['drug'] = $drug;
				$result['html'] = adminDrugList($drug, $keyword);
				$result['notify'] = 'Đã cập nhật thuốc';
			}
		break;
		// case 'filter':
		// 	$name = $nv_Request->get_string('name', 'post/get', '');
		// 	$effect = $nv_Request->get_string('effect', 'post/get', '');
		// 	$system = $nv_Request->get_string('system', 'post/get', '');
		// 	$disease = $nv_Request->get_string('disease', 'post/get', '');


		// break;
	}

	echo json_encode($result);
	die();
}

$system = getSystemList();
$disease = diseaseList();
$drug = getDrugList();

$xtpl = new XTemplate("heal_drug.tpl", PATH);

$systemList = '';
$systemList2 = '';
foreach ($system as $key => $row) {
	$systemList .= '<div class="item-suggest sa" id="sa'.$row['id'].'" tag="1"> '.$row['name'].' <input type="checkbox" class="right s" id="s'.$row['id'].'" tag="1"> </div>';
	$systemList2 .= '<li onclick="putSystem('.$row['id'].')"><a href="#">'.$row['name'].'</a></li>';
}

$diseaseList = '';
$diseaseList2 = '';
$diseaseList3 = '';
foreach ($disease as $key => $name) {
	$diseaseList .= '<div class="suggest_item" onclick="selectDisease('. $key .')">'.$name.'</div>';
	$diseaseList2 .= '<div class="suggest_item" onclick="selectEffective('. $key .')">'.$name.'</div>';
	$diseaseList3 .= '<div class="suggest_item" onclick="putDisease('. $key .')">'.$name.'</div>';
}

$xtpl->assign('content1', adminDrugList($drug));
$xtpl->assign('system_list', $systemList);
$xtpl->assign('system_list2', $systemList2);
$xtpl->assign('system', json_encode($system));
$xtpl->assign('diseaseList', $diseaseList);
$xtpl->assign('diseaseList2', $diseaseList2);
$xtpl->assign('diseaseList3', $diseaseList3);
$xtpl->assign('disease', json_encode($disease));
$xtpl->assign('drug', json_encode($drug));

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_admin_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

