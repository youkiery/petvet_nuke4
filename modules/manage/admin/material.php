<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }
$page_title = "Quản lý vật tư, hóa chất";
// $excel = $nv_Request->get_int('excel', 'get');
// if ($nv_Request->get_int('excel', 'get')) {
  //   header('location: /excel-output.xlsx');
  // }
$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    // case 'excel':
    //   $xco = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AK', 'AM', 'AN', 'AO', 'AP', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY', 'AZ');
    //   $title = array('STT', 'Tài sản', 'Quy cách', 'ĐVT', 'Số lượng', 'Năm sử dụng', 'Nguồn cung cấp', 'Ghi chú');

    //   include NV_ROOTDIR . '/PHPExcel/IOFactory.php';
    //   $fileType = 'Excel2007'; 
    //   $objPHPExcel = PHPExcel_IOFactory::load(NV_ROOTDIR . '/excel.xlsx');
    
    //   $query = $db->query('select * from `'. PREFIX .'depart`');
    //   $i = 1;
    //   while ($depart = $query->fetch()) {
    //     $device_query = $db->query('select * from `'. PREFIX .'device` where depart like \'%"'. $depart['id'] .'"%\' limit 1');
    //     if ($device_query->fetch()) {
    //       $device_query = $db->query('select * from `'. PREFIX .'device` where depart like \'%"'. $depart['id'] .'"%\'');
    //       $j = 0;
    //       $objPHPExcel
    //       ->setActiveSheetIndex(0)
    //       ->setCellValue($xco['0'] . $i, 'DANH MUC TÀI SẢN KIỂM KÊ PHÒNG '. $depart['name'] .' NĂM ' . date('Y', time()));
    //       $i += 2;
 
    //       foreach ($title as $value) {
    //         $objPHPExcel
    //         ->setActiveSheetIndex(0)
    //         ->setCellValue($xco[$j++] . $i, $value);
    //       }
    //       $i++;

    //       $index = 1;
    //       $count = 0;
    //       while ($device = $device_query->fetch()) {
    //         $j = 0;
    //         $count += $device['number'];
    //         $objPHPExcel
    //         ->setActiveSheetIndex(0)
    //         ->setCellValue($xco[$j++] . $i, $index++)
    //         ->setCellValue($xco[$j++] . $i, $device['name'])
    //         ->setCellValue($xco[$j++] . $i, $device['intro'])
    //         ->setCellValue($xco[$j++] . $i, $device['unit'])
    //         ->setCellValue($xco[$j++] . $i, $device['number'])
    //         ->setCellValue($xco[$j++] . $i, $device['year'])
    //         ->setCellValue($xco[$j++] . $i, $device['source'])
    //         ->setCellValue($xco[$j++] . $i++, $device['description']);
    //       }
    //       $objPHPExcel
    //       ->setActiveSheetIndex(0)
    //       ->setCellValue($xco[0] . $i, 'Tổng cộng: ')
    //       ->setCellValue($xco[4] . $i++, $count);
    //       $i += 2;
    //     }
    //   }
    //   $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, $fileType);
    //   $objWriter->save(NV_ROOTDIR . '/excel-output.xlsx');
    //   $objPHPExcel->disconnectWorksheets();
    //   unset($objWriter, $objPHPExcel);
    // break;
    case 'insert-material':
      $data = $nv_Request->get_array('data', 'post');

      if (!strlen($data['name'])) {
        $result['notify'] = 'Tên thiết bị trống';
      }
      else if (checkMaterialName($data['name'])) {
        $result['notify'] = 'Trùng tên thiết bị';
      }
      else {
        // insert
        $sql = 'insert into `'. PREFIX .'material` (name, type, unit, description) values("'. $data['name'] .'", "'. $data['type'] .'", "'. $data['unit'] .'", "'. $data['description'] .'")';
        // die($sql);
        // if ($query = $db->query($sql)) {
        //   $id = $db->lastInsertId();
        //   $sql = 'insert into `'. PREFIX .'item_detail` (item_id, number, date, status) values ('. $id .', '. $data['number'] .', '. strtotime(date('Y/m/d')) .', "'. $data['status'] .'")';
          if ($db->query($sql)) {
            $result['status'] = 1;
            $result['notify'] = 'Đã thêm';
            $result['id'] = $db->lastInsertId();
          }
        // }
      }
    break;
    case 'filter':
      $result['status'] = 1;
      $result['html'] = deviceList();
    break;
    case 'insert-import':
      $data = $nv_Request->get_array('data', 'post');

      if (!($count = count($data))) {
        $result['notify'] = 'Chưa có hàng hóa nhập';
      }
      else {
        // insert
        $query = $db->query('insert into `'. PREFIX .'import` (import_date, note) values('. time().', "")');
        if ($query) {
          $total = 0;
          $id = $db->lastInsertId();
          // check item, status, expiry
          foreach ($data as $row) {
            $row['date'] = totimev2($row['date']);
            if (!($item_id = checkItemId($row['id'], $row['date'], $row['status']))) {
              $result['notify'] = 'Lỗi hệ thống';
            }
            else {
              // die('insert into `'. PREFIX .'import_detail` (import_id, item_id, number, note) values('. $id .', '. $item_id .', '. $row['number'] .', "")');
              $query = $db->query('insert into `'. PREFIX .'import_detail` (import_id, item_id, number, note) values('. $id .', '. $item_id .', '. $row['number'] .', "")');
              if ($query) {
                $total ++;
              }
            }
          }
          if ($total > 0) {
            $result['status'] = 1;
            $result['html'] = importList();
            if ($count == $total) {
              $result['notify'] = 'Đã lưu nhập thiết bị';
            }
            else {
              $result['notify'] = "Đã lưu $total/$count";
            }
          }

        }
      }
    break;
    case 'edit-import':
      $data = $nv_Request->get_array('data', 'post');

      if (!($count = count($data))) {
        $result['notify'] = 'Chưa có hàng hóa nhập';
      }
      else {
        // update
        $query = $db->query('insert into `'. PREFIX .'import` (import_date, note) values('. time().', "")');
        if ($query) {
          $total = 0;
          $id = $db->lastInsertId();
          // check item, status, expiry
          foreach ($data as $row) {
            $row['date'] = totimev2($row['date']);
            if (!($item_id = checkItemId($row['id'], $row['date'], $row['status']))) {
              $result['notify'] = 'Lỗi hệ thống';
            }
            else {
              // die('insert into `'. PREFIX .'import_detail` (import_id, item_id, number, note) values('. $id .', '. $item_id .', '. $row['number'] .', "")');
              $query = $db->query('insert into `'. PREFIX .'import_detail` (import_id, item_id, number, note) values('. $id .', '. $item_id .', '. $row['number'] .', "")');
              if ($query) {
                $total ++;
              }
            }
          }
          if ($total > 0) {
            $result['status'] = 1;
            $result['html'] = importList();
            if ($count == $total) {
              $result['notify'] = 'Đã lưu nhập thiết bị';
            }
            else {
              $result['notify'] = "Đã lưu $total/$count";
            }
          }

        }
      }
    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/material");

$xtpl->assign('content', materialList());
$xtpl->assign('material_modal', materialModal());
$xtpl->assign('import_modal', importModal());
$xtpl->assign('import_modal_insert', importModalInsert());
$xtpl->assign('export_modal', exportModal());
$xtpl->assign('material', json_encode(getMaterialDataList(), JSON_UNESCAPED_UNICODE));
// $xtpl->assign('remove_modal', removeModal());
// $xtpl->assign('remove_all_modal', removeAllModal());
// $xtpl->assign('today', date('d/m/Y', time()));
// $xtpl->assign('remind', json_encode(getRemind(), JSON_UNESCAPED_UNICODE));
// $xtpl->assign('remindv2', json_encode(getRemindv2(), JSON_UNESCAPED_UNICODE));
// $xtpl->assign('depart_modal', departmodal());
// $xtpl->assign('item', json_encode(getItemDataList(), JSON_UNESCAPED_UNICODE));
// $xtpl->assign('import', importModal());
// $xtpl->assign('import_insert', importInsertModal());

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
