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

$page_title = "Nhập hồ sơ một cửa";
$sampleType = array(0 => 'Nguyên con', 'Huyết thanh', 'Máu', 'Phủ tạng', 'Swab');
$xco = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AK', 'AM', 'AN', 'AO', 'AP', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY', 'AZ');
$yco = array('index' => 'STT','set' => 'Kết quả xét nghiệm','code' => 'Số phiếu','sender' => 'Tên đơn vị','receive' => 'Ngày nhận mẫu','resend' => 'Ngày hẹn trả kết quả','status' => 'Hình thức nhận','ireceiver' => 'Người nhận hồ sơ','ireceive' => 'Ngày nhận hồ sơ','iresend' => 'Ngay trả hồ sơ','number' => 'Số lượng mẫu','sampletype' => 'Loại mẫu','sample' => 'Loài vật lấy mẫu','xcode' => 'Số ĐKXN','isenderunit' => 'Bộ phận giao mẫu','ireceiverunit' => 'Bộ phận nhận mẫu','examdate' => 'Ngày phân tích','xresender' => 'Người phụ trách bộ phận xét nghiệm','xexam' => 'Bộ phận xét nghiệm','examsample' => 'Lượng mẫu xét nghiệm','receiver' => 'Người lấy mẫu','samplereceive' => 'Thời gian lấy mẫu','senderemploy' => 'Khách hàng','xaddress' => 'Địa chỉ','ownermail' => 'Email','ownerphone' => 'Điện thoại','owner' => 'Chủ hộ','sampleplace' => 'Nơi lấy mẫu','target' => 'Mục đích','receivedis' => 'Nơi nhận','receiveleader' => 'Người phụ trách', 'ownaddress' => 'Địa chỉ', 'ownmobile' => 'Số điện thoại');

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$teriorname = array('endedcopy' => 'Bản copy', 'endedhour' => 'Giờ kết thúc', 'endedminute' => 'Phút kết thúc', 'code' => 'Mã phiếu', 'sender' => 'Người gửi', 'receive' => 'Người nhận', 'resend' => 'Ngày hẹn trả', 'state' => 'Hình thức nhận', 'receiver' => 'Người nhận', 'ireceive' => 'Ngày nhận', 'iresend' => 'Ngày hẹn trả', 'form' => 'Tên hồ sơ', 'number' => 'Số lượng mẫu', 'sample' => 'Loài được lấy mẫu', 'type' => 'Loại mẫu', 'samplecode' => 'Ký hiệu mẫu', 'exam' => 'Yêu cầu xét nghiệm', 'method' => 'Phương pháp', 'address' => 'Địa chỉ', 'phone' => 'Số điện thoại', 'samplereceive' => 'Ngày lấy mẫu', 'samplereceiver' => 'Người lấy mẫu', 'examdate' => 'Ngày xét nghiệm', 'result' => 'Kết quả', 'xcode' => 'Số ĐKXN', 'page' => 'Số trang', 'no' => 'Liên', 'customer' => 'Khách hàng', 'other' => 'Yêu cầu khác', 'receivehour' => 'Giờ nhận', 'receiveminute' => 'Phút nhận', 'isenderemploy' => 'Người gửi', 'isenderunit' => 'Đơn vị gửi', 'ireceiveremploy' => 'Người nhận', 'ireceiverunit' => 'Đơn vị nhận', 'status' => 'Tình trạng mẫu', 'xstatus' => 'Hình thức bảo quản', 'quality' => 'Chất lượng mẫu', 'ireceiver' => 'Người nhận', 'note' => 'Ghi chú', 'target' => 'Mục đích xét nghiệm', 'receivedis' => 'Nơi nhận', 'receiveleader' => 'Người phụ trách', 'xaddress' => 'Địa chỉ khách hàng', 'sampleplace' => 'Nơi lấy mẫu', 'owner' => 'Chủ hộ', 'xphone' => 'Số điện thoại', 'xnote' => 'Ghi chú', 'numberword' => 'Ghi chú (chữ)', 'fax' => 'Fax', 'xsender' => 'Người giao mẫu', 'xsend' => 'Ngày giao mẫu', 'xreceiver' => 'Người nhận mẫu', 'xreceive' => 'Ngày nhận mẫu', 'xresend' => 'Ngày giao kết quả', 'xresender' => 'Người phụ trách', 'ig' => 'Thông tin mẫu', 'vnote' => 'Ghi chú', 'samplecode5' => 'Ký hiệu mẫu', 'examsample' => 'Số lượng mẫu xét nghiệm', 'ownermail' => 'Email', 'ownerphone' => 'Số điện thoại', 'page2' => 'Số trang', 'page3' => 'Số trang', 'page4' => 'Số trang', 'date' => 'Ngày tháng', 'org' => 'Tên tổ chức', 'address' => 'Địa chỉ', 'phone' => 'Điện thoại', 'mail' => 'email', 'content' => 'Nội dung công việc', 'type' => 'Loại mẫu', 'sample' => 'Loại động vật', 'mcode' => 'Số phiếu', 'reformer' => 'Người đề nghị');

  function getPrice($name) {
    global $db;
    if (empty($name)) {
      $sql = 'select * from pet_formt_notires_row where match(name) against("'. $name .'" in boolean mode) limit 1';
    }
    else {
      $sql = 'select * from pet_formt_notires_row where match(name) against(\''. $name .'\' in boolean mode) limit 1';
    }
    $query = $db->query($sql);
    if ($row = $query->fetch()) {
      return $row['price'];
    }

    return 0;
  }

	$result = array("status" => 0);
	switch ($action) {
    case 'excel':
      $list = $nv_Request->get_array('list', 'post');

      include 'PHPExcel/IOFactory.php';
      $fileType = 'Excel2007'; 
      $objPHPExcel = PHPExcel_IOFactory::load('excel/thong-bao.xlsx');
      $x = 2;
      $index = 1;
      $sql = 'select * from `'. PREFIX .'_notires` where rid in ('. implode(', ', $list) .')';
      $query = $db->query($sql);
      while ($row = $query->fetch()) {
        $objPHPExcel
        ->setActiveSheetIndex(0)
        ->setCellValue("A" . $x, $index++);
        $irow = json_decode($row['data']);
        foreach ($irow->{data} as $val) {
          $total = $val->{number} * $val->{price};
          $objPHPExcel
          ->setActiveSheetIndex(0)
          ->setCellValue("B" . $x, $val->{result})
          ->setCellValue("C" . $x, $val->{serotype})
          ->setCellValue("D" . $x, $val->{number})
          ->setCellValue("E" . $x, number_format($val->{price}, 0, '', ','))
          ->setCellValue("F" . $x, number_format($total, 0, '', ','))
          ->setCellValue("G" . $x, $irow->{datetime});
          $x++;
        }
      }

      $time = time(); 
      $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, $fileType);
      $objWriter->save('excel/thong-bao-out-'. $time .'.xlsx');
      $objPHPExcel->disconnectWorksheets();
      unset($objWriter, $objPHPExcel);
      $result['status'] = 1;
      $result['time'] = $time;
      // header('location: /excel/thong-bao-out.xlsx');
    break;
    case 'save':
      $data = $nv_Request->get_array('data', 'post');

      foreach ($data as $id => $res) {
        $sql = 'select * from `'. PREFIX .'_notires` where rid = ' . $id;
        $query = $db->query($sql);
        if (!empty($query->fetch())) {
          $sql = 'update `'. PREFIX .'_notires` set data = \'' . json_encode($res, JSON_UNESCAPED_UNICODE) . '\' where rid = ' . $id;
        }
        else {
          $sql = 'insert into `'. PREFIX .'_notires` (rid, data) values('. $id .', \'' . json_encode($res, JSON_UNESCAPED_UNICODE) . '\')';
        }
        $db->query($sql);
      }
      $result['status'] = 1;
    break;
    case 'print-x':
      $list = $nv_Request->get_array('list', 'post');

  		$xtpl = new XTemplate('lp1-print.tpl', PATH);
      $sql = 'select * from `'. PREFIX .'_notires` where rid not in ('. implode(', ', $list) .')';
      $query = $db->query($sql);

      if (!empty($query->fetch())) {
        $result['status'] = 1;
        $result['notify'] = 'Chọn lưu trước khi in';
      }
      else {
        $index = 1;
        foreach ($list as $id) {
          $sql = 'select * from `'. PREFIX .'_notires` where rid = ' . $id;
          $query = $db->query($sql);
          if ($row = $query->fetch()) {
            $ig = json_decode($row['data']);
            $xtpl->assign('row', count($ig));
            $xtpl->assign('index', $index++);
            $xtpl->assign('type', 1);
            $xtpl->assign('datetime', $ig['datetime']);
            $xtpl->parse('main.row.index');
            $xtpl->parse('main.row.datetime');
            foreach ($ig->{data} as $val) {
              $xtpl->assign('result', $val->{result});
              $xtpl->assign('serotype', $val->{serotype});
              $xtpl->assign('price', $val->{price});
              $xtpl->assign('number', number_format($val->{number}, 0, ',', ''));
              $xtpl->assign('total', number_format($val->{number} * $val->{price}, 0, ',', ''));
              $xtpl->parse('main.row');
            }
          }
        }
      }
      $xtpl->parse('main');
      $result['status'] = 1;
      $result['html'] = $xtpl->text();
    break;
    case 'print':
      $list = $nv_Request->get_array('list', 'post');

  		$xtpl = new XTemplate('lp1-form.tpl', PATH);
      $sql = 'select * from `'. PREFIX .'_notires_cash`';
      $query = $db->query($sql);
      $select = '<option>0</option>';

      while ($row = $query->fetch()) {
        $select .= '
          <option value="'. $row['price'] .'">
            '. $row['code'] .'
          </option>';
      }
      $xtpl->assign('select', $select);

      $gindex = 1;
      $index = 1;
      //   var_dump($list);die();
      foreach ($list as $id) {
        $sql = 'select * from `'. PREFIX .'_notires` where rid = '. $id;
        $query = $db->query($sql);

        $xtpl->assign('id', $id);
        if (!empty($row = $query->fetch())) {
          $data = json_decode($row['data']);
          $xtpl->assign('datetime', $data->{datetime});
          $xtpl->assign('row', count($data->{data}));
          $xtpl->assign('gindex', $gindex++);
          $xtpl->parse('main.row.col');
          $xtpl->parse('main.row.col2');
          foreach ($data->{data} as $val) {
            $xtpl->assign('index', $index++);
            $xtpl->assign('result', $val->{result});
            $xtpl->assign('price', number_format($val->{price}, 0, '', ','));
            $xtpl->assign('serotype', $val->{serotype});
            $xtpl->assign('number', $val->{number});
            $xtpl->assign('total', number_format($val->{number} * $val->{price}, 0, '', ','));
            $xtpl->parse('main.row');
          }
        }
        else {
          $sql = 'select * from `'. PREFIX .'_secretary` where rid = '. $id;
          $query = $db->query($sql);

          if (!empty($row = $query->fetch())) {
            $ig = json_decode($row['ig']);
            $xtpl->assign('datetime', $row['mcode'] . '/THTY-5 ngày ' . date('d/m/Y', $row['date']));
            $count = 0;
            foreach ($ig as $name => $number) {
              $count ++;
            }
            $xtpl->assign('row', $count);
            $xtpl->assign('gindex', $gindex++);
            $xtpl->parse('main.row.col');
            $xtpl->parse('main.row.col2');
            foreach ($ig as $name => $number) {
              $price = getPrice($name);
              $xtpl->assign('index', $index++);
              $xtpl->assign('result', $name);
              $xtpl->assign('price', number_format($price, 0, '', ','));
              $xtpl->assign('serotype', '');
              $xtpl->assign('number', $number);
              $xtpl->assign('total', number_format($number * $price, 0, '', ','));
              $xtpl->parse('main.row');
            }
          }
          else {
            $sql = 'select mcode, ig, xresend from `'. PREFIX .'_row` where id = ' . $id;
            $query = $db->query($sql);

            if (!empty($row = $query->fetch())) {

              $ig = json_decode($row['ig']);
              $tempData = array();
              foreach ($ig as $sample) {
                foreach ($sample->{'mainer'} as $mainer) {
                  foreach ($mainer->{'note'} as $note) {
                    if (empty($tempData[$note->{'note'}])) {
                      $tempData[$note->{'note'}] = 0;
                    }
                    $tempData[$note->{'note'}] += $sample->{'number'};
                  }
                }
              }
              $ig = $tempData;

              $xtpl->assign('datetime', $row['mcode'] . '/THTY-5 ngày ' . date('d/m/Y', $row['xresend']));
              
              $xtpl->assign('row', count($ig));
              $xtpl->assign('gindex', $gindex++);
              $xtpl->assign('type', 3);
              $xtpl->parse('main.row.col');
              $xtpl->parse('main.row.col2');
              foreach ($ig as $name => $number) {
                $price = getPrice($name);
                $xtpl->assign('index', $index++);
                $xtpl->assign('result', $name);
                $xtpl->assign('price', number_format($price, 0, '', ','));
                $xtpl->assign('serotype', '');
                $xtpl->assign('number', $number);
                $xtpl->assign('total', number_format($number * $price, 0, '', ','));
                $xtpl->parse('main.row');
                // $ig_row;
              }
            }
          }
        }
      }
      
      $xtpl->parse('main');
      $result['status'] = 1;
      $result['html'] = $xtpl->text();
    break;
    case 'select-all':
      $filter = $nv_Request->get_array('filter', 'post');

      $today = time();
      if (empty($filter['end'])) {
        $filter['end'] = date('d/m/Y', $today);
      }

      if (empty($filter['from'])) {
        $filter['from'] = date('d/m/Y', $today - 60 * 60 * 24 * 30);
      }

      $filter['from'] = totime($filter['from']);
      $filter['end'] = totime($filter['end'] + 60 * 60 * 24 * - 1);

      $exsql = '';
      if ($filter['pay'] > 0) {
        $filter['pay'] --;

        if ($filter['pay'] > 0) {
          $exsql .= ' and id in (select rid from `'. PREFIX .'_secretary` where pay = 1)';
        }
        else {
          $exsql .= ' and id not in (select rid from `'. PREFIX .'_secretary` where pay = 1)';
        }
      }

      $sql = 'select id from `'. PREFIX .'_row` where mcode like "%'. $filter['keyword'] .'%" and sample like "%'. $filter['sample'] .'%" and sender like "%'. $filter['unit'] .'%" and exam like "%'. $filter['exam'] .'%" and xcode like "%'. $filter['xcode'] .'%" and owner like "%'. $filter['owner'] .'%" and printer = 5 and (time between '. $filter['from'] .' and '. $filter['end'] .') '. $exsql;
      $query = $db->query($sql);
      $list = array();
      while ($row = $query->fetch()) {
        $list[] = strval($row['id']);
      }

      $result['status'] = 1;
      $result['list'] = json_encode($list);
    break;
    case 'change-pay':
      $list = $nv_Request->get_array('list', 'post');
      $type = $nv_Request->get_int('type', 'post');
      $filter = $nv_Request->get_array('filter', 'post');

      foreach ($list as $id) {
        $sql = 'select * from `'. PREFIX .'_secretary` where rid = ' . $id;
        $query = $db->query($sql);
        $row = $query->fetch();

        if (empty($row)) {
          $sql = 'select * from `'. PREFIX .'_row` where id = ' . $id;
          $query = $db->query($sql);
          $row2 = $query->fetch();

        	$ig = json_decode($row2['ig']);
					foreach ($ig as $sample) {
						foreach ($sample->{'mainer'} as $mainer) {
							foreach ($mainer->{'note'} as $note) {
								if (empty($tempData[$note->{'note'}])) {
									$tempData[$note->{'note'}] = 0;
								}
								$tempData[$note->{'note'}] += $sample->{'number'};
							}
						}
					}
					$ig = json_encode($tempData, JSON_UNESCAPED_UNICODE);

          $sql = 'insert into `'. PREFIX .'_secretary` (date, org, address, phone, fax, mail, content, type, sample, xcode, ig, mcode, reformer, rid, pay) values('. $row2['xresend'] .', "'. $row2['sender'] .'", "'. $row2['xaddress'] .'", "'. $row2['ownerphone'] .'", "'. $row2['fax'] .'", "'. $row2['ownermail'] .'", "'. $row2['target'] .'", '. $row2['typeindex'] .', "'. $row2['sample'] .'", "'. $row2['xcode'] .'", \''. $ig .'\', "", "'. $row2['reformer'] .'", '. $id .', '. $type .')';
        }
        else {
          $sql = 'update `'. PREFIX .'_secretary` set pay = '. $type . ' where rid = ' . $id;
        }
        $db->query($sql);
      }
      
      if ($html = secretaryList($filter)) {
        $result['status'] = 1;
        $result['notify'] = 'Cập nhật thành công';
        $result['html'] = $html;
      }
    break;
		case 'editSecret':
			$id = $nv_Request->get_string('id', 'get/post', 0);

			if (!empty($id)) {
				$sql = 'select * from `'. PREFIX .'_secretary` where rid = ' . $id;
				$query = $db->query($sql);
				$xtpl = new XTemplate('secretary.tpl', PATH);
				if (!empty($row = $query->fetch())) {
					$xtpl->assign('date', date('d/m/Y', $row['date']));
					$xtpl->assign('org', $row['org']);
					$xtpl->assign('address', $row['address']);
					$xtpl->assign('fax', $row['fax']);
					$xtpl->assign('phone', $row['phone']);
					$xtpl->assign('mail', $row['mail']);
					$xtpl->assign('content', $row['content']);
					$xtpl->assign('type', $row['type']);
					$xtpl->assign('pay' . $row['pay'], 'checked');
					$xtpl->assign('owner', $row['owner']);
					$xtpl->assign('ownaddress', $row['ownaddress']);
					$xtpl->assign('ownphone', $row['ownphone']);
					$result['ig'] = $row['ig'];
				}
				else {
					$sql = 'select * from `'. PREFIX .'_row` where id = ' . $id;
					$query = $db->query($sql);
					$row = $query->fetch();
					$xtpl->assign('date', date('d/m/Y', $row['xresend']));
					$xtpl->assign('org', $row['sender']);
					$xtpl->assign('address', $row['xaddress']);	
					$xtpl->assign('phone', $row['ownerphone']);
					$xtpl->assign('mail', $row['ownermail']);
					$xtpl->assign('content', $row['target']);
					$xtpl->assign('owner', $row['owner']);
					$xtpl->assign('ownaddress', $row['sampleplace']);
					$xtpl->assign('ownmobile', '');
					$xtpl->assign('type', (!empty($sampleType[$row['typeindex']] ? $sampleType[$row['typeindex']] : $row['typevalue'])));
					$xtpl->assign('pay0', 'checked');
					$tempData = array();
					$ig = json_decode($row['ig']);
					foreach ($ig as $sample) {
						foreach ($sample->{'mainer'} as $mainer) {
							foreach ($mainer->{'note'} as $note) {
								if (empty($tempData[$note->{'note'}])) {
									$tempData[$note->{'note'}] = 0;
								}
								$tempData[$note->{'note'}] += $sample->{'number'};
							}
						}
					}
					$result['ig'] = json_encode($tempData);
				}
				$xtpl->assign('sample', $row['sample']);
				$xcode = explode(',', $row['xcode']);
				$xtpl->assign('xcode0', $xcode[0]);
				$xtpl->assign('xcode1', $xcode[1]);
				$xtpl->assign('xcode2', $xcode[2]);
				$xtpl->assign('mcode', $row['mcode']);
				$xtpl->assign('reformer', $row['reformer']);
				$permission = getUserType($user_info['userid']);
				if ($permission == 1 || $permission == 5) {
					$xtpl->parse('main.secretary');
				}
				$xtpl->parse('main');
				$result['status'] = 1;
				$result['html'] = $xtpl->text();
			}
		break;
		case 'secretary':
			$id = $nv_Request->get_string('id', 'get/post', 0);
			$data = $nv_Request->get_array('data', 'get/post', 0);

			if ($key = precheck($data)) {
				$result['notify'] = 'Nhập thiếu thông tin: ' . $teriorname[$key];
			}
			else {
				$sql = 'select * from `'. PREFIX .'_row` where id = ' . $id;
				$query = $db->query($sql);

				$rowd = $query->fetch();

				$sql = 'select * from `'. PREFIX .'_secretary` where rid = ' . $id;
				$query = $db->query($sql);

				foreach ($data['ig'] as $igKey => $igVal) {
					checkRemindv2($igKey, 'examsx');
				}
				checkRemindv2($data['reformer'], 'reformer');

				$permission = getUserType($user_info['userid']);

				if (!empty($row = $query->fetch())) {
					// update
					$temp = array();
					foreach ($data as $dataKey => $dataRow) {
						if ($dataKey == 'pay') {
							if ($permission == 1 || $permission == 5) {
								$temp[] = $dataKey . ' = "'. $dataRow .'"';
							}
						}
						else if ($dataKey == 'date') {
							$temp[] = $dataKey . ' = "'. totime($dataRow) .'"';
						}
						else if ($dataKey == 'ig') {
							$temp[] = $dataKey . ' = \''. json_encode($dataRow, JSON_UNESCAPED_UNICODE) .'\'';
						}
						else {
							$temp[] = $dataKey . ' = "'. $dataRow .'"';
						}
					}
					$sql = 'update `'. PREFIX .'_secretary` set ' . implode(', ', $temp) . ' where id = ' . $row['id'];
				}
				else {
					// insert
					$temp = array();
					$temp2 = array();
					foreach ($data as $dataKey => $dataRow) {
						if ($dataKey == 'date') {
							$temp2[] = totime($dataRow);
						}
						else if ($dataKey == 'ig') {
							$temp2[] = '\''. json_encode($dataRow) .'\'';
						}
						else {
							$temp2[] = '"'. $dataRow .'"';
						}
						$temp[] = $dataKey;
					}
					$sql = 'insert `'. PREFIX .'_secretary` ('. implode(', ', $temp) .', rid) values (' . implode(', ', $temp2) . ', '. $id .')';
				}
        // die($sql);
				if ($db->query($sql)) {
					$result['notify'] = 'Đã cập nhật thành công';
					$result['remind'] = json_encode(getRemindv2());
					$result['status'] = 1;
				}
			}
		break;
		case 'secretaryfilter':
			$filter = $nv_Request->get_array('filter', 'get/post');

			$result['status'] = 1;
			$result['html'] = secretaryList($filter);
		break;
	}
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("lp1.tpl", PATH);

$today = time();

$xtpl->assign('module_name', $module_name);
$xtpl->assign('today', date('d/m/Y', $today));
$xtpl->assign('last_week', date('d/m/Y', $today - 60 * 60 * 24 * 30));

$today = strtotime(date('Y-m-d'));
$tomorrow = $today + 60*60*24;
$yesterday = $today - 60*60*24;
$from = $today - 60*60*24*7;
$end = $today + 60*60*24*7;

$remind = getDefault();

$defaultData = array('code' => '-19', 'xcode' => '05,19,', 'result' => 'Âm tính (-)', 'receivedis' => '- Lưu: VT, Dịch tễ, Kế toán.', 'number' => '1', 'numberword' => 'Một', 'today' => date("d/m/Y", $today), 'yesterday' => date("d/m/Y", $yesterday), 'tomorrow' => date("d/m/Y", $tomorrow), 'remind' => $remind);


$methodHtml = '';
$method = array();
$permission = getUserType($user_info['userid']);

// $permissionType = array('Bị cấm', 'Kế toán', 'Chỉ đọc', 'Nhân viên', 'Siêu nhân viên', 'Quản lý');
//                          0      , 1        , 2        , 3          , 4               ,  5

$permist = array();

switch ($permission) {
	case 1:
		$xtpl->assign('secretary_active', 'active');
		$xtpl->assign('secretary', secretaryList());
		$xtpl->parse('main.secretary2');
		$xtpl->parse('main.secretary');
	break;
	case 2:
		$xtpl->assign('content', formList());
		$xtpl->parse('main.user');
		$xtpl->parse('main.super_user2');
	break;
	case 3:
		$method = getMethod();
		$methodHtml = '';
		foreach ($method as $index => $row) {
			$methodHtml .= '<option value="'. $row['symbol'] .'" class="'.$index.'">'. $row['name'] .'</option>';
		}
		$xtpl->assign("methodOption", $methodHtml);

		for ($i = 0; $i < 60; $i++) { 
			if ($i < 10) {
				$xtpl->assign('value', '0' . $i);
			}
			else {
				$xtpl->assign('value', $i);
			}
			$xtpl->parse('main.super_user3.minute');
			$xtpl->parse('main.super_user3.minute2');
			if ($i < 24) {
				$xtpl->parse('main.super_user3.hour');
				$xtpl->parse('main.super_user3.hour2');
			}
		}

		$permist = getUserPermission($user_info['userid']);
		$permist = explode(',', $permist);
		$top = 10;
		foreach ($permist as $key) {
			$xtpl->assign('top', $top += 35);	
			$xtpl->parse('main.super_user3.p' . ($key + 1));
		}
		$xtpl->assign('top', $top += 35);	

		$xtpl->assign('content', formList());
		$xtpl->parse('main.user');
		$xtpl->parse('main.super_user');
		$xtpl->parse('main.super_user2');
		$xtpl->parse('main.super_user3');
	break;
	case 4: 
		$method = getMethod();
		$methodHtml = '';
		foreach ($method as $index => $row) {
			$methodHtml .= '<option value="'. $row['symbol'] .'" class="'.$index.'">'. $row['name'] .'</option>';
		}
		$xtpl->assign("methodOption", $methodHtml);

		for ($i = 0; $i < 60; $i++) { 
			if ($i < 10) {
				$xtpl->assign('value', '0' . $i);
			}
			else {
				$xtpl->assign('value', $i);
			}
			$xtpl->parse('main.super_user3.minute');
			$xtpl->parse('main.super_user3.minute2');
			if ($i < 24) {
				$xtpl->parse('main.super_user3.hour');
				$xtpl->parse('main.super_user3.hour2');
			}
		}

		$permist = getUserPermission($user_info['userid']);
		$permist = explode(',', $permist);
		$top = 10;
		foreach ($permist as $key) {
			$xtpl->assign('top', $top += 35);	
			$xtpl->parse('main.super_user3.p' . ($key + 1));
		}
		$xtpl->assign('top', $top += 35);	

		$xtpl->assign('content', formList());
		$xtpl->parse('main.user');
		$xtpl->parse('main.super_user');
		$xtpl->parse('main.super_user2');
		$xtpl->parse('main.super_user3');
		$xtpl->assign('secretary', secretaryList());
		$xtpl->parse('main.secretary2');
		$xtpl->parse('main.secretary');
		$xtpl->assign('printx', secretaryList2());
		$xtpl->parse('main.printx2');
		$xtpl->parse('main.printx');
	break;
	case 5: 
		$method = getMethod();
		$methodHtml = '';
		foreach ($method as $index => $row) {
			$methodHtml .= '<option value="'. $row['symbol'] .'" class="'.$index.'">'. $row['name'] .'</option>';
		}
		$xtpl->assign("methodOption", $methodHtml);

		$permist = '0,1,2,3,4';
		$permist = explode(',', $permist);

		for ($i = 0; $i < 60; $i++) { 
			if ($i < 10) {
				$xtpl->assign('value', '0' . $i);
			}
			else {
				$xtpl->assign('value', $i);
			}
			$xtpl->parse('main.super_user3.minute');
			$xtpl->parse('main.super_user3.minute2');
			if ($i < 24) {
				$xtpl->parse('main.super_user3.hour');
				$xtpl->parse('main.super_user3.hour2');
			}
		}

		$top = 10;
		foreach ($permist as $key) {
			$xtpl->assign('top', $top += 35);	
			$xtpl->parse('main.super_user3.p' . ($key + 1));
		}
		$xtpl->assign('top', $top += 35);	

		$xtpl->assign('content', formList());
		$xtpl->parse('main.user');
		$xtpl->parse('main.super_user');
		$xtpl->parse('main.super_user2');
		$xtpl->parse('main.super_user3');
		$xtpl->assign('secretary', secretaryList());
		$xtpl->parse('main.secretary2');
		$xtpl->parse('main.secretary');
		$xtpl->assign('printx', secretaryList2());
		$xtpl->parse('main.printx2');
		$xtpl->parse('main.printx');
	break;
}

$day = date('w');
$week_start = date('d/m/Y', strtotime('-'.$day.' days'));
$week_end = date('d/m/Y', strtotime('+'.(6-$day).' days'));

$xtpl->assign("excelf", $week_start);
$xtpl->assign("excelt", $week_end);

$xtpl->assign('permist', implode(',', $permist));	
$xtpl->assign('summarycontent', summaryContent($from, $end));
$xtpl->assign('summaryfrom', date('d/m/Y', $from));
$xtpl->assign('summaryend', date('d/m/Y', $end));
$xtpl->assign('today', date('d/m/Y', time()));
$xtpl->assign("method", json_encode($method));
$xtpl->assign("remind", json_encode(getRemind()));
$xtpl->assign("remindv2", json_encode(getRemindv2()));
$xtpl->assign("relation", json_encode(getRelation()));
$xtpl->assign("signer", json_encode(getSigner()));
$xtpl->assign("default", json_encode($defaultData));
$xtpl->parse("main");
$contents = $xtpl->text();
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

