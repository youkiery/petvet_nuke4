<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) { die('Stop!!!'); }
$page_title = "Quản lý vật tư, hóa chất";
$excel = $nv_Request->get_int('excel', 'get');
if ($nv_Request->get_int('excel', 'get')) {
  header('location: /excel-output.xlsx?time=' . time());
}
$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'report-excel':
      $xco = array(1 => 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AK', 'AM', 'AN', 'AO', 'AP', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY', 'AZ');
      $title = array('STT', 'Ngày nhập', 'Ngày xuất', 'Nhập', 'Xuất', 'Tồn', 'Ghi chú');
    //   // Tìm kiếm số lượng tồn kho trước 1 thời điểm

      include NV_ROOTDIR . '/PHPExcel/IOFactory.php';
      $fileType = 'Excel2007'; 
      $objPHPExcel = PHPExcel_IOFactory::load(NV_ROOTDIR . '/assets/excel-material-template.xlsx');

      $i = 1;
      $j = 1;
      foreach ($title as $key => $value) {
        $objPHPExcel
        ->setActiveSheetIndex(0)
        ->setCellValue($xco[$j++] . $i, $value);
      }
    
      $id = $nv_Request->get_int('id', 'post');
      $filter = $nv_Request->get_array('filter', 'post');
      if (empty($filter['start'])) $filter['start'] = strtotime(date('Y/m/d', time() - (date('d') - 1) * 60 * 60 * 24));
      else $filter['start'] = totime($filter['start']);
      if (empty($filter['end'])) $filter['end'] = strtotime(date('Y/m/d')) + 60 * 60 * 24 - 1;
      else $filter['end'] = totime($filter['end']) + 60 * 60 * 24 - 1;
    
      $sql = 'select * from ((select a.number, b.export_date as time, 0 as type, a.note from `'. PREFIX .'export_detail` a inner join `'. PREFIX .'export` b on a.item_id = '. $id .' and a.export_id = b.id) union (select a.number, b.import_date as time, 1 as type, a.note from `'. PREFIX .'import_detail` a inner join `'. PREFIX .'import` b on a.item_id = '. $id .' and a.import_id = b.id)) as a where time between '. $filter['start'] .' and '. $filter['end'] .' order by time desc';
      $query = $db->query($sql);
      
      $summary = array('import' => 0, 'export' => 0);
      $i = 4;
      $index = 1;
      while ($row = $query->fetch()) {
        $j = 1;
        $a = ''; $b = ''; $c = ''; $d = '';
        if ($row['type'] == 0) {
          $summary['export'] += $row['number'];
          $b = date('d/m/Y', $row['time']);
          $d = $row['number'];
        }
        else {
          $summary['import'] += $row['number'];
          $a = date('d/m/Y', $row['time']);
          $c = $row['number'];
        }

        $objPHPExcel
        ->setActiveSheetIndex(0)
        ->setCellValue($xco[$j++] . $i, $index++)
        ->setCellValue($xco[$j++] . $i, $a)
        ->setCellValue($xco[$j++] . $i, $b)
        ->setCellValue($xco[$j++] . $i, $c)
        ->setCellValue($xco[$j++] . $i, $d)
        ->setCellValue($xco[$j++] . $i, $row['note']);
        $i++;
      }

      $objPHPExcel
      ->setActiveSheetIndex(0)
      ->setCellValue($xco[4] . 2, $summary['import'])
      ->setCellValue($xco[5] . 2, $summary['export'])
      ->setCellValue($xco[6] . 2, $summary['import'] - $summary['export']);

      // $sql = 'select * from '
    //   $filter = $nv_Request->get_array('filter', 'post');
    //   if (empty($filter['start'])) $filter['start'] = strtotime(date('Y/m/d', time() - (date('d') - 1) * 60 * 60 * 24));
    //   else $filter['start'] = totime($filter['start']);
    //   if (empty($filter['end'])) $filter['end'] = strtotime(date('Y/m/d')) + 60 * 60 * 24 - 1;
    //   else $filter['end'] = totime($filter['end']) + 60 * 60 * 24 - 1;
    
    //   $sql = 'select * from ((select a.number, b.export_date as time, 0 as type from `'. PREFIX .'export_detail` a inner join `'. PREFIX .'export` b on a.item_id = '. $id .' and a.export_id = b.id) union (select a.number, b.import_date as time, 1 as type from `'. PREFIX .'import_detail` a inner join `'. PREFIX .'import` b on a.item_id = '. $id .' and a.import_id = b.id)) as a order by time asc';
    //   $query = $db->query($sql);
    //   $i = 1; $j = 0;
    //   $index = 1;

    //   foreach ($title as $value) {
    //     $objPHPExcel
    //     ->setActiveSheetIndex(0)
    //     ->setCellValue($xco[$j++] . $i, $value);
    //   }

    //   while ($row = $query->fetch()) {
    //     $j = 0;
    //     $i ++;

    //     // $objPHPExcel
    //     // ->setActiveSheetIndex(0)
    //     // ->setCellValue($xco[$j++] . $i, $index ++)
    //     // ->setCellValue($xco[$j++] . $i, $index +);
    //   }

    //   $objPHPExcel
    //   ->setActiveSheetIndex(0)
    //   ->setCellValue($xco[$j++] . $i, $value);

      $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, $fileType);
      $objWriter->save(NV_ROOTDIR . '/assets/excel-material.xlsx');
      $objPHPExcel->disconnectWorksheets();
      unset($objWriter, $objPHPExcel);
      $result['status'] = 1;
    break;
    case 'insert-material':
      $data = $nv_Request->get_array('data', 'post');

      if (!strlen($data['name'])) {
        $result['notify'] = 'Tên vật tư trống';
      }
      else if (checkMaterialName($data['name'])) {
        $result['notify'] = 'Trùng tên vật tư';
      }
      else {
        // insert
        $sql = 'insert into `'. PREFIX .'material` (name, type, number, unit, description) values("'. $data['name'] .'", "'. $data['type'] .'", "'. $data['number'] .'", "'. $data['unit'] .'", "'. $data['description'] .'")';
        // die($sql);
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['notify'] = 'Đã thêm';
          $result['html'] = materialList();
          $result['id'] = $db->lastInsertId();
          $result['json'] = array('id' => $db->lastInsertId(), 'name' => $data['name'], 'type' => $data['type'], 'unit' => $data['unit'], 'description' => $data['description']);
        }
      }
    break;
    case 'filter':
      $result['status'] = 1;
      $result['html'] = deviceList();
    break;
    case 'insert-import':
      $data = $nv_Request->get_array('data', 'post');

      if (!($total = count($data))) {
        $result['notify'] = 'Chưa có hàng hóa nhập';
      }
      else {
        // insert
        $query = $db->query('insert into `'. PREFIX .'import` (import_date, note) values('. time().', "")');
        if ($query) {
          $count = 0;
          $id = $db->lastInsertId();
          // check item, status, expiry
          foreach ($data as $row) {
            $row['date'] = totimev2($row['date']);
            $sql = 'insert into `'. PREFIX .'import_detail` (import_id, item_id, number, date, note) values('. $id .', '. $row['id'] .', '. $row['number'] .', '. $row['date'] .', "'. $row['status'] .'")';
            $sql2 = 'update `'. PREFIX .'material` set number = number + '. $row['number'] .' where id = ' . $row['id'];
            if ($db->query($sql) && $db->query($sql2)) {
              $count ++;
            }
          }
          if ($total > 0) {
            $result['status'] = 1;
            $result['html'] = importList();
            $result['html2'] = materialList();
            if ($count == $total) {
              $result['notify'] = 'Đã lưu nhập thiết bị';
            }
            else {
              $result['notify'] = "Đã lưu $count/$total";
            }
          }

        }
      }
    break;
    // case 'edit-import':
    //   $data = $nv_Request->get_array('data', 'post');

    //   if (!($count = count($data))) {
    //     $result['notify'] = 'Chưa có hàng hóa nhập';
    //   }
    //   else {
    //     $query = $db->query('insert into `'. PREFIX .'import` (import_date, note) values('. time().', "")');
    //     if ($query) {
    //       $total = 0;
    //       $id = $db->lastInsertId();
    //       foreach ($data as $row) {
    //         $row['date'] = totimev2($row['date']);
    //         if (!($item_id = checkItemId($row['id'], $row['date'], $row['status']))) {
    //           $result['notify'] = 'Lỗi hệ thống';
    //         }
    //         else {
    //           $sql = 'insert into `'. PREFIX .'import_detail` (import_id, item_id, number, note) values('. $id .', '. $item_id .', '. $row['number'] .', "")';
    //           if ($query) {
    //             $total ++;
    //           }
    //         }
    //       }
    //       if ($total > 0) {
    //         $result['status'] = 1;
    //         $result['html'] = importList();
    //         if ($count == $total) {
    //           $result['notify'] = 'Đã lưu nhập thiết bị';
    //         }
    //         else {
    //           $result['notify'] = "Đã lưu $total/$count";
    //         }
    //       }

    //     }
    //   }
    // break;
    case 'remove-import':
      $id = $nv_Request->get_int('id', 'post', 0);

      // ktb: lấy số lượng nhập, giảm số lượng kho
      $query = $db->query('select * from `'. PREFIX .'import_detail` where import_id = ' . $id);
      $count = 0;
      $total = 0;
      while ($row = $query->fetch()) {
        if ($db->query('update `'.  PREFIX .'material` set number = number - '. $row['number'] .' where id = ' . $row['item_id'])) {
          $count ++;
        }
        $total ++;
      }

      if ($db->query('delete from `'.  PREFIX .'import` where id = ' . $id)) {
        $result['status'] = 1;
        $result['notify'] = 'Đã xóa phiếu nhập';
        $result['html'] = importList();
        $result['html2'] = materialList();
      }
    break;
    case 'get-import':
      $id = $nv_Request->get_int('id', 'post');

      $query = $db->query('select * from `'. PREFIX .'import_detail` where import_id = ' . $id);
      $list = array();
      $item = getMaterialDataList();
      while ($row = $query->fetch()) {
        $index = checkItemIndex($item, $row['item_id']);
        
        if ($itemData = getItemDatav2($row['item_id'])) {
          $list[] = array(
            'index' => $index,
            'id' => $itemData['id'],
            'date' => $row['date'] ? date('d/m/Y', $row['date']) : '',
            'number' => $row['number'],
            'status' => $itemData['description']
          );
        }
      }

      $result['status'] = 1;
      $result['import'] = $list;
    break;
    case 'insert-export':
      $data = $nv_Request->get_array('data', 'post');

      if (!($total = count($data))) {
        $result['notify'] = 'Chưa có hàng hóa nhập';
      }
      else {
        // insert
        $query = $db->query('insert into `'. PREFIX .'export` (export_date, note) values('. time().', "")');
        if ($query) {
          $count = 0;
          $id = $db->lastInsertId();
          // check item, status, expiry
          foreach ($data as $row) {
            $row['date'] = totimev2($row['date']);
            $sql = 'insert into `'. PREFIX .'export_detail` (export_id, item_id, number, note) values('. $id .', '. $row['id'] .', '. $row['number'] .', "'. $row['status'] .'")';
            $sql2 = 'update `'. PREFIX .'material` set number = number - '. $row['number'] .' where id = ' . $row['id'];
            if ($db->query($sql) && $db->query($sql2)) {
              $count ++;
            }
          }
          if ($total > 0) {
            $result['status'] = 1;
            $result['html'] = exportList();
            $result['html2'] = materialList();
            if ($count == $total) {
              $result['notify'] = 'Đã lưu phiếu xuất thiết bị';
            }
            else {
              $result['notify'] = "Đã lưu $count/$total";
            }
          }

        }
      }
    break;
    case 'remove-export':
      $id = $nv_Request->get_int('id', 'post', 0);

      // ktb: lấy số lượng nhập, giảm số lượng kho
      $query = $db->query('select * from `'. PREFIX .'export_detail` where export_id = ' . $id);
      $count = 0;
      $total = 0;
      while ($row = $query->fetch()) {
        if ($db->query('update `'.  PREFIX .'material` set number = number + '. $row['number'] .' where id = ' . $row['item_id'])) {
          $count ++;
        }
        $total ++;
      }

      if ($db->query('delete from `'.  PREFIX .'export` where id = ' . $id)) {
        $result['status'] = 1;
        $result['notify'] = 'Đã xóa phiếu nhập';
        $result['html'] = exportList();
        $result['html2'] = materialList();
      }
    break;
    case 'filter-report':
      $result['status'] = 1;
      $result['html'] = reportList();
    break;
    case 'report':
      $result['status'] = 1;
      $result['html'] = reportDetail();
    break;
    case 'overlow':
      $result['status'] = 1;
      $result['html'] = materialOverlowList();
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);
$xtpl->assign('content', materialList());
$xtpl->assign('modal', materialModal());
$xtpl->assign('material', json_encode(getMaterialDataList(), JSON_UNESCAPED_UNICODE));

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
