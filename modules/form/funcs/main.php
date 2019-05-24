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
		case 'summaryFilter':
			$from = $nv_Request->get_string('from', 'get/post', '');
			$end = $nv_Request->get_string('end', 'get/post', '');

			$from = totime($from);
			$end = totime($end);

			$result['status'] = 1;
			$result['html'] = summaryContent($from, $end);
		break;
		case 'removeRemind':
			$id = $nv_Request->get_string('id', 'get/post', '');

			if (!(empty($id) || empty(getRemindId($id)))) {
				$sql = 'delete from `'.PREFIX.'_remind` where id = '. $id;
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['notify'] = 'Đã xóa';
					$result['remind'] = json_encode(getRemind());
				}
			}
		break;
		case 'insertMethod':
			$name = $nv_Request->get_string('name', 'get/post', '');
			$symbol = $nv_Request->get_string('symbol', 'get/post', '');

			if (!(empty($name) || empty($symbol) || checkMethod($name))) {
				$sql = 'insert into `'. PREFIX .'_method` (name, symbol) values("'.$name.'", "'.$symbol.'")';
				if ($db->query($sql)) {
					$method = getMethod();
					$methodHtml = '';
					foreach ($method as $index => $row) {
						$methodHtml .= '<option value="'. $row['symbol'] .'" class="'.$index.'">'. $row['name'] .'</option>';
					}
					$result['html'] = $methodHtml;
					$result['status'] = 1;
					$result['notify'] = 'Đã thêm phương pháp';
				}
			}
			else {
				$result['notify'] = 'Phương pháp đã tồn tại';
			}
		break;
		case 'filter':
			$page = $nv_Request->get_string('page', 'get/post', 1);
			$limit = $nv_Request->get_string('limit', 'get/post', 1);
			// $printer = explode(', ',$nv_Request->get_string('printer', 'get/post', ''));
			$printer = $nv_Request->get_string('printer', 'get/post', '');
			$keyword = $nv_Request->get_string('keyword', 'get/post', 1);

			$result['status'] = 1;
			$result['html'] = formList($keyword, $page, $limit, $printer);
		break;
		case 'preview':
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
				// $result['form']['samplereceiver'] = getRemindId($result['form']['samplereceiver']);
				// var_dump($result); die();
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
				$result['form']['note'] = str_replace('<br />', '', $result['form']['note']);

				$result['form']['type']['index'] = 0;
				$result['form']['type']['value'] = '';
				if (!empty($result['form']['typeIndex'])) {
					$result['form']['type']['index'] = $result['form']['typeIndex'];
					$result['form']['type']['value'] = $result['form']['typeValue'];
				}

				$result['form']['state']['index'] = 0;
				$result['form']['state']['value'] = '';
				if (!empty($result['form']['typeIndex'])) {
					$result['form']['state']['index'] = $result['form']['stateIndex'];
					$result['form']['state']['value'] = $result['form']['stateValue'];
				}
				
				if ($action == 'preview') {
					$result = $result['form'];
					if (!empty($result['form'])) {
						$result['form'] = explode(', ', $result['form']);
					}
					if (!empty($result['exam'])) {
						$result['exam'] = explode(', ', $result['exam']);
					}
					if (!empty($result['method'])) {
						$result['method'] = explode(', ', $result['method']);
					}
				}
				$result['status'] = 1;
			}
		break;
		case 'remove':
			$id = $nv_Request->get_string('id', 'get/post', '');
			$page = $nv_Request->get_string('page', 'get/post', 1);
			$limit = $nv_Request->get_string('limit', 'get/post', 1);
			// $printer = explode(', ',$nv_Request->get_string('printer', 'get/post', ''));
			$printer = $nv_Request->get_string('printer', 'get/post', '');
			$keyword = $nv_Request->get_string('keyword', 'get/post', 1);

			if (!empty($id)) {
				$sql = 'delete from `'. PREFIX .'_row` where id = ' . $id;
				$query = $db->query($sql);

				if ($query) {
					$result['status'] = 1;
					$result['notify'] = 'Đã xóa mẫu đơn';
					$result['html'] = formList($keyword, $page, $limit, $printer);
				}
			}
		break;
		case 'insert':
			$id = $nv_Request->get_string('id', 'get/post', '');
			$form = $nv_Request->get_string('form', 'get/post', '');
			$data = $nv_Request->get_array('data', 'get/post', '');

			$page = $nv_Request->get_string('page', 'get/post', 1);
			$limit = $nv_Request->get_string('limit', 'get/post', 1);
			// $printer = explode(', ',$nv_Request->get_string('printer', 'get/post', ''));
			$printer = $nv_Request->get_string('printer', 'get/post', '');
			$keyword = $nv_Request->get_string('keyword', 'get/post', 1);

			$result['notify'] = 'Nhập sai thông tin, hoặc thông tin lỗi';
			if (!checkIsMod($user_info['userid'])) {
				$result['notify'] = 'Tài khoản không có quyền truy cập';
			}
			else {
				switch ($form) {
					case '1': 
						if (!(empty($data['code']) || empty($data['sender']) || empty($data['receive']) || empty($data['resend']) || empty($data['state']) || empty($data['receiver']) || empty($data['ireceive']) || empty($data['iresend']) || empty($data['forms']) || empty($data['number']) || empty($data['exams']))) {
							$sender = checkRemindRow($data['sender'], 2);
							$receiver = checkRemindRow($data['receiver'], 1);
							foreach ($data['exams'] as $key => $value) {
								checkRemindRow($value, 3);
							}
							if ($id) {
								$sql = 'update `'. PREFIX .'_row` set code = "'. $data['code'] .'", sender = ' . $sender . ', receive = ' . totime($data['receive']) . ', resend = ' . totime($data['resend']) . ', stateIndex = '. $data['state']['index'] .', stateValue = "'. $data['state']['value'] .'", receiver = ' . $receiver . ', ireceive = '. totime($data['ireceive']) . ', iresend = '. totime($data['ireceive']) . ', form = "'. implode(', ', $data['forms']) .'", number = ' . $data['number'] .', exam = "' . implode(', ', $data['exams']) . '", sample = "'. $data['sample'] .'", status = "'. $data['status'] .'", sampleCode = "'. $data['samplecode'] .'", method = "'. implode(', ', $data['methods']) .'", typeIndex = '. $data['type']['index'] .', typeValue = "'. $data['type']['value'] .'" where id = ' . $id;
								$query = $db->query($sql);
								$result['id'] = $id;
							}
							else {
								$sql = 'insert into `'. PREFIX .'_row` (code, sender, receive, resend, stateIndex, stateValue, receiver, ireceive, iresend, form, number, exam, sample, status, sampleCode, method, typeIndex, typeValue, time, endedCopy, endedHour, endedMinute) values("'. $data['code'] .'", '. $sender .', ' . totime($data['receive']) . ', ' . totime($data['resend']) . ', '. $data['state']['index'] .', "'. $data['state']['value'] . '", ' . $receiver . ', '. totime($data['ireceive']) . ',  '. totime($data['ireceive']) . ', "'. implode(', ', $data['forms']) .'", ' . $data['number'] .', "' . implode(', ', $data['exams']) . '", "'. $data['sample'] .'", "'. $data['status'] .'", "'. $data['samplecode'] .'", "'. implode(', ', $data['methods']) .'", '. $data['type']['index'] .', "'. $data['type']['value'] .'", '. time() .', '. $data['endedcopy'] .', '. $data['endedhour'] .', '. $data['endedminute'] .')';
								$query = $db->query($sql);
								$result['id'] = $db->lastInsertId();
							}
							if ($query) {
								checkPrinter($result['id'], $form);
								$result['status'] = 1;
								$result['notify'] = 'Đã lưu mẫu';
								$result['html'] = formList($keyword, $page, $limit, $printer);
								$result['remind'] = json_encode(getRemind());
							}
						}	
					break;
					case '2':
						if ($key = precheck($data)) {
							$result['notify'] = 'Nhập thiếu thông tin: ' . $key;
						}
						else {
							$data['receive'] = totime($data['receive']);
							$data['isenderemploy'] = checkRemindRow($data['isenderemploy'], 1);
							$data['isenderunit'] = checkRemindRow($data['isenderunit'], 2);
							$data['ireceiveremploy'] = checkRemindRow($data['ireceiveremploy'], 1);
							$data['ireceiverunit'] = checkRemindRow($data['ireceiverunit'], 2);
							foreach ($data['exams'] as $key => $value) {
								checkRemindRow($value, 3);
							}
		
							$sql = 'update `'. PREFIX .'_row` set xcode = "'. implode(', ', $data['xcode']) .'", isenderEmploy = '. $data['isenderemploy'] .' ,  isenderUnit = '. $data['isenderunit'] .', ireceiverEmploy = '. $data['ireceiveremploy'] .', ireceiverUnit = '. $data['ireceiverunit'] .', receiveHour = '.$data['receivehour'].', receiveMinute = '.$data['receiveminute'].', typeIndex = '. $data['type']['index'] .', typeValue = "'. $data['type']['value'] .'", sample = "'. $data['sample'] .'", number = '. $data['number'] .', status = "'. $data['status'] .'", sampleCode = "'. $data['samplecode'] .'", xstatus = '. $data['xstatus']['index'] .', quality = "'. $data['quality'] .'", exam = "'. implode(', ', $data['exams']) .'", method = "'. implode(', ', $data['methods']) .'", endedCopy = '. $data['endedcopy'] .', endedHour = '. $data['endedhour'] .', endedMinute = '. $data['endedminute'] .', receive = '. $data['receive'] .' where id = ' . $id;
							$query = $db->query($sql);
							if ($query) {
								checkPrinter($id, $form);
								$result['notify'] = 'Đã cập nhật mẫu';
								$result['status'] = 1;
								$result['id'] = $id;
								$result['html'] = formList($keyword, $page, $limit, $printer);
								$result['remind'] = json_encode(getRemind());
							}
						}
					break;
					case '3':
						if ($key = precheck($data)) {
							$result['notify'] = 'Nhập thiếu thông tin: ' . $key;
						}
						else {
							$receive = totime($data['receive']);
							$resend = totime($data['resend']);
							$sampleReceive = totime($data['samplereceive']);
							$examDate = totime($data['examdate']);
							$data['result'] = nl2br($data['result']);
							$data['note'] = nl2br($data['note']);
							$sampleReceive = totime($data['samplereceive']);
							$sampleReceiver = checkRemindRow($data['samplereceiver'], 5);
							checkRemindRow($data['customer'], 4);
							checkRemindRow($data['address'], 5);
							foreach ($data['exams'] as $key => $value) {
								checkRemindRow($value, 3);
							}
							$sql = 'update `'. PREFIX .'_row` set xcode = "'. implode(', ', $data['xcode']) .'", page = "'. implode(', ', $data['page']) .'", no = "'. implode(', ', $data['no']) .'", customer = "'. $data['customer'] .'", typeIndex = '. $data['type']['index'] .', typeValue = "'. $data['type']['value'] .'", number = '. $data['number'] .', sample = "'. $data['sample'] .'", sampleCode = "'. $data['samplecode'] .'", exam = "'. implode(', ', $data['exams']) .'", method = "'. implode(', ', $data['methods']) .'", other = "'. $data['other'] .'", receive = '. $receive .', resend = '. $resend .', phone = "'.$data['phone'].'", sampleReceive = '.$sampleReceive.', sampleReceiver = '.$sampleReceiver.', address = "'. $data['address'] .'", examDate = '.$examDate.', result = "'.$data['result'].'", note = "'.$data['note'].'" where id = ' . $id;
							$query = $db->query($sql);
							if ($query) {
								checkPrinter($id, $form);
								$result['notify'] = 'Đã cập nhật mẫu';
								$result['status'] = 1;
								$result['id'] = $id;
								$result['html'] = formList($keyword, $page, $limit, $printer);
								$result['remind'] = json_encode(getRemind());
							}
						}
					break;
					case '4':
						if ($key = precheck($data)) {
							$result['notify'] = 'Nhập thiếu thông tin: ' . $key;
						}
						else {
							$sampleReceive = totime($data['samplereceive']);
							$receive = totime($data['receive']);
							$ireceive = totime($data['ireceive']);
							$examDate = totime($data['examdate']);
							$data['result'] = nl2br($data['result']);
							$note = nl2br($data['note']);
							checkRemindRow($data['address'], 5);
							checkRemindRow($data['customer'], 4);
							foreach ($data['exams'] as $key => $value) {
								checkRemindRow($value, 3);
							}
							$sql = 'update `'. PREFIX .'_row` set xcode = "'. implode(', ', $data['xcode']) .'", receiveHour = '.$data['receivehour'].', receiveMinute = '.$data['receiveminute'].', phone = "'.$data['phone'].'", sampleReceive = "'.$sampleReceive.'", address = "'.$data['address'].'", sampleReceiver = "'.$data['samplereceiver'].'", ireceive = '.$ireceive.', ireceiver = "'.$data['ireceiver'].'", examDate = "'.$examDate.'", result = "'.$data['result'].'", customer = "'. $data['customer'] .'", typeIndex = '. $data['type']['index'] .', typeValue = "'. $data['type']['value'] .'", number = '. $data['number'] .', status = "'. $data['status'] .'", sampleCode = "'. $data['samplecode'] .'", receive = '. $data['receive'] .', note = "'. $note .'" where id = ' . $id;
							$query = $db->query($sql);
							if ($query) {
								checkPrinter($id, $form);
								$result['notify'] = 'Đã cập nhật mẫu';
								$result['status'] = 1;
								$result['id'] = $id;
								$result['html'] = formList($keyword, $page, $limit, $printer);
								$result['remind'] = json_encode(getRemind());
							}
						}
					break;
					case '5':
						if ($key = precheck($data)) {
							$result['notify'] = 'Nhập thiếu thông tin: ' . $key;
						}
						else {
							$iresend = totime($data['iresend']);
							$ireceive = totime($data['ireceive']);
							$note = nl2br($data['note']);
							checkRemindRow($data['address'], 5);
							checkRemindRow($data['customer'], 4);
							foreach ($data['exams'] as $key => $value) {
								checkRemindRow($value, 3);
							}
							$sql = 'update `'. PREFIX .'_row` set address = "'.$data['address'].'", ireceive = '.$ireceive.',  customer = "'. $data['customer'] .'", number = '. $data['number'] .', sampleCode = "'. $data['sampleCode'] .'", note = "'. $note .'", iresend = '. $iresend .', code = "'. $data['code'] .'", sample = "'. $data['sample'] .'", target = "'. $data['target'].'", exam = "'. implode(', ', $data['exams']) .'", method = "'. implode(', ', $data['methods']) .'", receiveDis = "'. $data['receiveDis'] .'", receiveLeader = "'. $data['receiveLeader'] .'" where id = ' . $id;
							$query = $db->query($sql);
							if ($query) {
								checkPrinter($id, $form);
								$result['notify'] = 'Đã cập nhật mẫu';
								$result['status'] = 1;
								$result['id'] = $id;
								$result['html'] = formList($keyword, $page, $limit, $printer);
								$result['remind'] = json_encode(getRemind());
							}
						}
					break;
				}
			}
		break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("main.tpl", PATH);

if (checkIsMod($user_info['userid'])) {
	$method = getMethod();
	$methodHtml = '';
	foreach ($method as $index => $row) {
		$methodHtml .= '<option value="'. $row['symbol'] .'" class="'.$index.'">'. $row['name'] .'</option>';
	}
	
	for ($i = 0; $i < 60; $i++) { 
		$xtpl->assign('value', $i);
		$xtpl->parse('main.mod2.minute');
		$xtpl->parse('main.mod2.minute2');
		if ($i < 24) {
			$xtpl->parse('main.mod2.hour');
			$xtpl->parse('main.mod2.hour2');
		}
	}
	$xtpl->parse('main.mod');
	$xtpl->parse('main.mod2');
}

$today = strtotime(date('Y-m-d'));
$from = $today - 60*60*24*7;
$end = $today + 60*60*24*7;


$xtpl->assign("methodOption", $methodHtml);
$xtpl->assign('summarycontent', summaryContent($from, $end));
$xtpl->assign('summaryfrom', date('d/m/Y', $from));
$xtpl->assign('summaryend', date('d/m/Y', $end));
$xtpl->assign('content', formList());
$xtpl->assign("method", json_encode($method));
$xtpl->assign("remind", json_encode(getRemind()));
$xtpl->assign("relation", json_encode(getRelation()));

$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

