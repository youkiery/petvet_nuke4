<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_FORM')) {
	die('Stop!!!');
}

$page_title = "Nhập hồ sơ một chiều";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'insert':
			$id = $nv_Request->get_string('id', 'get/post', '');
			$form = $nv_Request->get_string('form', 'get/post', '');
			$data = $nv_Request->get_array('data', 'get/post', '');
			$result['notify'] = 'Nhập sai thông tin, hoặc thông tin lỗi';

			switch ($form) {
				case '1':
					if (!(empty($data['code']) || empty($data['sender']) || empty($data['receive']) || empty($data['resend']) || empty($data['state']) || empty($data['receiver']) || empty($data['ireceive']) || empty($data['iresend']) || empty($data['form']) || empty($data['number']) || empty($data['exam']))) {
						$sender = checkRemindRow($data['sender'], 1);
						$receiver = checkRemindRow($data['receiver'], 1);
						if ($id) {
							$sql = 'update `'. PREFIX .'_row` set code = "'. $data['code'] .'", sender = ' . $sender . ', receive = ' . totime($data['receive']) . ', resend = ' . totime($data['resend']) . ', stateIndex = '. $data['state']['index'] .', stateValue = "'. $data['state']['value'] .'", receiver = ' . $receiver . ', ireceive = '. totime($data['ireceive']) . ', iresend = '. totime($data['ireceive']) . ', form = "'. implode(', ', $data['form']) .'", number = ' . $data['number'] .', exam = "' . implode(', ', $data['exam']) . '" where id = ' . $id;
							$query = $db->query($sql);
							$result['id'] = $id;
						}
						else {
							$sql = 'insert into `'. PREFIX .'_row` (code, sender, receive, resend, stateIndex, stateValue, receiver, ireceive, iresend, form, number, exam) values("'. $data['code'] .'", '. $sender .', ' . totime($data['receive']) . ', ' . totime($data['resend']) . ', '. $data['state']['index'] .', "'. $data['state']['value'] . '", ' . $receiver . ', '. totime($data['ireceive']) . ',  '. totime($data['ireceive']) . ', "'. implode(', ', $data['form']) .'", ' . $data['number'] .', "' . implode(', ', $data['exam']) . '")';
							$query = $db->query($sql);
							$result['id'] = $db->lastInsertId();
						}
						if ($query) {
							$result['status'] = 1;
							$result['notify'] = 'Đã lưu mẫu';
						}
					}	
				break;
				case '2':
					$isenderEmploy = checkRemindRow($data['isenderEmploy'], 1);
					$isenderUnit = checkRemindRow($data['isenderUnit'], 2);
					$ireceiverEmploy = checkRemindRow($data['ireceiverEmploy'], 1);
					$ireceiverUnit = checkRemindRow($data['ireceiverUnit'], 2);

					$sql = 'update `'. PREFIX .'_row` set xcode = "'. implode(', ', $data['xcode']) .'", isenderEmploy = '. $isenderEmploy .' ,  isenderUnit = '. $isenderUnit .', ireceiverEmploy = '. $ireceiverEmploy .', ireceiverUnit = '. $ireceiverUnit .', typeIndex = '. $data['type']['index'] .', typeValue = "'. $data['type']['value'] .'", sample = "'. $data['sample'] .'", number = '. $data['number'] .', status = '. $data['number'] .', sampleCode = "'. implode(', ', $data['sampleCode']) .'", xstatus = '. $data['xstatus']['index'] .', quality = "'. $data['quality'] .'", exam = "'. implode(', ', $data['exam']) .'" where id = ' . $id;
					$query = $db->query($sql);
					if ($query) {
						$result['notify'] = 'Đã cập nhật mẫu';
						$result['status'] = 1;
						$result['id'] = $id;
					}
				break;
				case '3':
				case '4':
				// receiveTime, receiveHour, receiveMinute, address, phone, sampleReceive, sampleReceiver, ireceive, ireceiver, examDate, result
					$receiveTime = totime($data['receiveTime']);
					$sampleReceive = totime($data['sampleReceive']);
					$ireceive = totime($data['ireceive']);
					$examDate = totime($data['examDate']);
					$sql = 'update `'. PREFIX .'_row` set xcode = "'. implode(', ', $data['xcode']) .'", receiveTime = '.$receiveTime.', receiveHour = '.$data['receiveHour'].', receiveMinute = '.$data['receiveMinute'].', phone = "'.$data['phone'].'", sampleReceive = "'.$sampleReceive.'", sampleReceiver = "'.$data['sampleReceiver'].'", ireceive = '.$ireceive.', ireceiver = "'.$data['ireceiver'].'", examDate = "'.$examDate.'", result = "'.$data['result'].'", page = "'. implode(', ', $data['page']) .'", no = "'. implode(', ', $data['no']) .'", customer = "'. $data['customer'] .'", typeIndex = '. $data['type']['index'] .', typeValue = "'. $data['type']['value'] .'", number = '. $data['number'] .', sample = "'. $data['sample'] .'", status = "'. $data['status'] .'", sampleCode = "'. implode(', ', $data['sampleCode']) .'", exam = "'. implode(', ', $data['exam']) .'", method = "'. implode(', ', $data['method']) .'", other = "'. $data['other'] .'", result = "'. $data['result'] .'" where id = ' . $id;
					$query = $db->query($sql);
					if ($query) {
						$result['notify'] = 'Đã cập nhật mẫu';
						$result['status'] = 1;
						$result['id'] = $id;
					}
				break;
			}
		break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("main.tpl", PATH);

$method = getMethod();
$methodHtml = '';
foreach ($method as $row) {
	$methodHtml .= '<option value="'. $row['symbol'] .'">'. $row['name'] .'</option>';
}

for ($i = 0; $i < 60; $i++) { 
	$xtpl->assign('value', $i);
	$xtpl->parse('main.minute');
	if ($i < 24) {
		$xtpl->parse('main.hour');
	}
}

$xtpl->assign("methodOption", $methodHtml);
$xtpl->assign("method", json_encode($method));
$xtpl->assign("remind", json_encode(getRemind()));
$xtpl->assign("relation", json_encode(getRelation()));

$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

