<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'insert-item':
      $data = $nv_Request->get_array('data', 'post');

      if (!strlen($data['name'])) {
        $result['notify'] = 'Tên thiết bị trống';
      }
      else if (checkItemName($data['name'])) {
        $result['notify'] = 'Trùng tên thiết bị';
      }
      else {
        // insert
        $sql = 'insert into `'. PREFIX .'item` (name, unit, company, description) values("'. $data['name'] .'", "'. $data['unit'] .'", "'. checkCompany($data['company']) .'", "'. $data['description'] .'")';
        if ($query = $db->query($sql)) {
          $id = $db->lastInsertId();
          $sql = 'insert into `'. PREFIX .'item_detail` (item_id, number, date, status) values ('. $id .', '. $data['number'] .', '. strtotime(date('Y/m/d')) .', "'. $data['status'] .'")';
          if ($db->query($sql)) {
            $result['status'] = 1;
            $result['notify'] = 'Đã thêm';
            $result['id'] = $db->lastInsertId();
          }
        }
      }
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
    case 'get-import':
      $id = $nv_Request->get_int('id', 'post');

      $query = $db->query('select * from `'. PREFIX .'import_detail` where import_id = ' . $id);
      $list = array();
      $item = getItemDataList();
      while ($row = $query->fetch()) {
        $index = checkItemIndex($item, $row['item_id']);
        
        if ($itemData = getItemDatav2($row['item_id'])) {
          $list[] = array(
            'index' => $index,
            'id' => $itemData['id'],
            'date' => $itemData['date'] ? date('d/m/Y', $itemData['date']) : '',
            'number' => $row['number'],
            'status' => $itemData['status']
          );
        }
      }
      $result['status'] = 1;
      $result['import'] = $list;
    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/device");

$xtpl2 = new XTemplate("item-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/device");
$xtpl2->parse('main');
$xtpl->assign('item_modal', $xtpl2->text());
$xtpl->assign('item', json_encode(getItemDataList(), JSON_UNESCAPED_UNICODE));
$xtpl->assign('today', date('d/m/Y', time()));
$xtpl->assign('content', itemList());
$xtpl->assign('import', importModal());
$xtpl->assign('import_insert', importInsertModal());

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
