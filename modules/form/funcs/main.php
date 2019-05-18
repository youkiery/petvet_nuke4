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
		case 'filter':
			$page = $nv_Request->get_string('page', 'get/post', 1);
			$limit = $nv_Request->get_string('limit', 'get/post', 1);
			$keyword = $nv_Request->get_string('keyword', 'get/post', 1);

			$result['status'] = 1;
			$result['html'] = formList($keyword, $page, $limit);
		break;
		case 'getForm':
			$id = $nv_Request->get_string('id', 'get/post', '');

			$sql = 'select * from `'. PREFIX .'_row` where id = ' . $id;
			$query = $db->query($sql);

			$result['form'] = $query->fetch();
			if (empty($result['form'])) {
				$result['notify'] = 'Có lỗi xảy ra';
			}
			else {
				$result['form']['receiver'] = getRemindId($result['form']['receiver']);
				$result['form']['sender'] = getRemindId($result['form']['sender']);

				$result['form']['ireceiveremploy'] = getRemindId($result['form']['ireceiveremploy']);
				$result['form']['ireceiverunit'] = getRemindId($result['form']['ireceiverunit']);
				$result['form']['isenderemploy'] = getRemindId($result['form']['isenderemploy']);
				$result['form']['isenderunit'] = getRemindId($result['form']['isenderunit']);

				$result['form']['receive'] = date('d/m/Y', $result['form']['receive']);
				$result['form']['resend'] = date('d/m/Y', $result['form']['resend']);
				$result['form']['ireceive'] = date('d/m/Y', $result['form']['ireceive']);
				$result['form']['iresend'] = date('d/m/Y', $result['form']['iresend']);
				$result['form']['receivetime'] = date('d/m/Y', $result['form']['receivetime']);
				$result['form']['samplereceive'] = date('d/m/Y', $result['form']['samplereceive']);
				$result['form']['sampletime'] = date('d/m/Y', $result['form']['sampletime']);
				$result['form']['examdate'] = date('d/m/Y', $result['form']['examdate']);
				// $result['form']['target'] = str_replace('<br />', '\r\n', $result['form']['target']);

				$result['form']['printer'] = checkPrinter($result['form']);
				$result['status'] = 1;
			}
		break;
		case 'remove':
			$id = $nv_Request->get_string('id', 'get/post', '');
			$page = $nv_Request->get_string('page', 'get/post', 1);
			$limit = $nv_Request->get_string('limit', 'get/post', 1);
			$keyword = $nv_Request->get_string('keyword', 'get/post', 1);

			if (!empty($id)) {
				$sql = 'delete from `'. PREFIX .'_row` where id = ' . $id;
				$query = $db->query($sql);

				if ($query) {
					$result['status'] = 1;
					$result['notify'] = 'Đã xóa mẫu đơn';
					$result['html'] = formList($keyword, $page, $limit);
				}
			}
		break;
		case 'insert':
			$id = $nv_Request->get_string('id', 'get/post', '');
			$form = $nv_Request->get_string('form', 'get/post', '');
			$data = $nv_Request->get_array('data', 'get/post', '');

			$page = $nv_Request->get_string('page', 'get/post', 1);
			$limit = $nv_Request->get_string('limit', 'get/post', 1);
			$keyword = $nv_Request->get_string('keyword', 'get/post', 1);

			$result['notify'] = 'Nhập sai thông tin, hoặc thông tin lỗi';
			switch ($form) {
				case '1':
					if (!(empty($data['code']) || empty($data['sender']) || empty($data['receive']) || empty($data['resend']) || empty($data['state']) || empty($data['receiver']) || empty($data['ireceive']) || empty($data['iresend']) || empty($data['forms']) || empty($data['number']) || empty($data['exams']))) {
						$sender = checkRemindRow($data['sender'], 1);
						$receiver = checkRemindRow($data['receiver'], 1);
						if ($id) {
							$sql = 'update `'. PREFIX .'_row` set code = "'. $data['code'] .'", sender = ' . $sender . ', receive = ' . totime($data['receive']) . ', resend = ' . totime($data['resend']) . ', stateIndex = '. $data['state']['index'] .', stateValue = "'. $data['state']['value'] .'", receiver = ' . $receiver . ', ireceive = '. totime($data['ireceive']) . ', iresend = '. totime($data['ireceive']) . ', form = "'. implode(', ', $data['forms']) .'", number = ' . $data['number'] .', exam = "' . implode(', ', $data['exams']) . '", sample = "'. $data['sample'] .'", status = "'. $data['status'] .'", sampleCode = "'. $data['sampleCode'] .'", method = "'. implode(', ', $data['methods']) .'", typeIndex = '. $data['type']['index'] .', typeValue = "'. $data['type']['value'] .'" where id = ' . $id;
							$query = $db->query($sql);
							$result['id'] = $id;
						}
						else {
							$sql = 'insert into `'. PREFIX .'_row` (code, sender, receive, resend, stateIndex, stateValue, receiver, ireceive, iresend, form, number, exam, sample, status, sampleCode, method, typeIndex, typeValue, time) values("'. $data['code'] .'", '. $sender .', ' . totime($data['receive']) . ', ' . totime($data['resend']) . ', '. $data['state']['index'] .', "'. $data['state']['value'] . '", ' . $receiver . ', '. totime($data['ireceive']) . ',  '. totime($data['ireceive']) . ', "'. implode(', ', $data['forms']) .'", ' . $data['number'] .', "' . implode(', ', $data['exams']) . '", "'. $data['sample'] .'", "'. $data['status'] .'", "'. $data['sampleCode'] .'", "'. implode(', ', $data['methods']) .'", '. $data['type']['index'] .', "'. $data['type']['value'] .'", '. time() .')';
							$query = $db->query($sql);
							$result['id'] = $db->lastInsertId();
						}
						if ($query) {
							$result['status'] = 1;
							$result['notify'] = 'Đã lưu mẫu';
							$result['html'] = formList($keyword, $page, $limit);
						}
					}	
				break;
				case '2':
					$isenderEmploy = checkRemindRow($data['isenderEmploy'], 1);
					$isenderUnit = checkRemindRow($data['isenderUnit'], 2);
					$ireceiverEmploy = checkRemindRow($data['ireceiverEmploy'], 1);
					$ireceiverUnit = checkRemindRow($data['ireceiverUnit'], 2);
					$receiveTime = totime($receiveTime);
// , receiveTime, receiveHour, receiveMinute

					$sql = 'update `'. PREFIX .'_row` set xcode = "'. implode(', ', $data['xcode']) .'", isenderEmploy = '. $isenderEmploy .' ,  isenderUnit = '. $isenderUnit .', ireceiverEmploy = '. $ireceiverEmploy .', ireceiverUnit = '. $ireceiverUnit .', receiveTime = '.$receiveTime.', receiveHour = '.$data['receiveHour'].', receiveMinute = '.$data['receiveMinute'].', typeIndex = '. $data['type']['index'] .', typeValue = "'. $data['type']['value'] .'", sample = "'. $data['sample'] .'", number = '. $data['number'] .', status = "'. $data['status'] .'", sampleCode = "'. implode(', ', $data['sampleCode']) .'", xstatus = '. $data['xstatus']['index'] .', quality = "'. $data['quality'] .'", exam = "'. implode(', ', $data['exams']) .'", method = "'. implode(', ', $data['methods']) .'" where id = ' . $id;
					$query = $db->query($sql);
					if ($query) {
						$result['notify'] = 'Đã cập nhật mẫu';
						$result['status'] = 1;
						$result['id'] = $id;
						$result['html'] = formList($keyword, $page, $limit);
					}
				break;
				case '3':
				case '4':
					$receiveTime = totime($data['receiveTime']);
					$sampleReceive = totime($data['sampleReceive']);
					$ireceive = totime($data['ireceive']);
					$examDate = totime($data['examDate']);
					$sampleTime = totime($data['sampleTime']);
					$data['result'] = nl2br($data['result']);
					$target = nl2br($data['target']);
					$sql = 'update `'. PREFIX .'_row` set xcode = "'. implode(', ', $data['xcode']) .'", receiveTime = '.$receiveTime.', receiveHour = '.$data['receiveHour'].', receiveMinute = '.$data['receiveMinute'].', phone = "'.$data['phone'].'", sampleReceive = "'.$sampleReceive.'", sampleTime = "'.$sampleTime.'", address = "'.$data['address'].'", sampleReceiver = "'.$data['sampleReceiver'].'", ireceive = '.$ireceive.', ireceiver = "'.$data['ireceiver'].'", examDate = "'.$examDate.'", result = "'.$data['result'].'", page = "'. implode(', ', $data['page']) .'", no = "'. implode(', ', $data['no']) .'", customer = "'. $data['customer'] .'", typeIndex = '. $data['type']['index'] .', typeValue = "'. $data['type']['value'] .'", number = '. $data['number'] .', sample = "'. $data['sample'] .'", status = "'. $data['status'] .'", sampleCode = "'. implode(', ', $data['sampleCode']) .'", exam = "'. implode(', ', $data['exams']) .'", method = "'. implode(', ', $data['methods']) .'", other = "'. $data['other'] .'", result = "'. $data['result'] .'", target = "'.$target.'" where id = ' . $id;
					$query = $db->query($sql);
					if ($query) {
						$result['notify'] = 'Đã cập nhật mẫu';
						$result['status'] = 1;
						$result['id'] = $id;
						$result['html'] = formList($keyword, $page, $limit);
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
foreach ($method as $index => $row) {
	$methodHtml .= '<option value="'. $row['symbol'] .'" class="'.$index.'">'. $row['name'] .'</option>';
}

for ($i = 0; $i < 60; $i++) { 
	$xtpl->assign('value', $i);
	$xtpl->parse('main.minute');
	if ($i < 24) {
		$xtpl->parse('main.hour');
	}
}

$xtpl->assign("methodOption", $methodHtml);
$xtpl->assign('content', formList());
$xtpl->assign("method", json_encode($method));
$xtpl->assign("remind", json_encode(getRemind()));
$xtpl->assign("relation", json_encode(getRelation()));

$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

