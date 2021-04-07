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
    case 'insert':
      $id = $nv_Request->get_string('id', 'post', '');
      $number = $nv_Request->get_int('number', 'post', 1);
      $date = $nv_Request->get_string('date', 'post', '');

      if (!checkItemId($id)) {
        $result['notify'] = 'Hàng hoá không tồn tại';
      }
      else {
        $query = $db->query('insert into `'. PREFIX .'row` (rid, exp_time, number, update_time) values('. $id .', "'. totime($date) .'", '. $number .', "'. time() .'")');
        if ($query) {
          $result['status'] = 1;
          $result['notify'] = 'Đã thêm';
          $result['list'] = expIdList();
          $result['html'] = expList();
        }
      }
    break;
    case 'update':
      $id = $nv_Request->get_int('id', 'post', 0);
      $rid = $nv_Request->get_int('rid', 'post', 0);
      $number = $nv_Request->get_int('number', 'post', 0);
      $name = $nv_Request->get_string('name', 'post', '');
      $date = $nv_Request->get_string('date', 'post', '');

      if (empty($name)) {
        $result['notify'] = 'Tên hàng không được để trống';
      }
      else if (checkItemName($name, $rid)) {
        $result['notify'] = 'Trùng tên hàng';
      }
      else if (!checkItemId($rid)) {
        $result['notify'] = 'Hàng hoá không tồn tại';
      }
      else {
        // die('update `'. PREFIX .'row` set rid = "'. $rid .'", number = '. $number .', exp_time = "'. totime($date) .'", update_time = '. time() .' where id = ' . $id);
        $query = $db->query('update `'. PREFIX .'row` set rid = "'. $rid .'", number = '. $number .', exp_time = "'. totime($date) .'", update_time = '. time() .' where id = ' . $id);
        if ($query) {
          $result['status'] = 1;
          $result['notify'] = 'Đã lưu';
        }
      }
    break;
    case 'remove':
      $id = $nv_Request->get_int('id', 'post', '');

      $query = $db->query('delete from `'. PREFIX .'row` where id = ' . $id);
      if ($query) {
        $result['status'] = 1;
        $result['notify'] = 'Đã xóa';
        $result['list'] = expIdList();
        $result['html'] = expList();
      }
    break;
    case 'filter':
      $result['status'] = 1;
      $result['list'] = expIdList();
      $result['html'] = expList();
    break;
    case 'get-update-number':
      $result['status'] = 1;
      $result['html'] = expContent();
    break;
    case 'update-number':
      $list = $nv_Request->get_array('list', 'post');
      $count = 0;
      $total = 0;

      if (count($list)) {
        foreach ($list as $id => $number) {
          $total++;
          // die('update `'. PREFIX .'row` set number = '. $number .' where id = ' . $id);
          $query = $db->query('update `'. PREFIX .'row` set number = '. $number .' where id = ' . $id);
          if ($query) {
            $count++;
          }
        }
      }
      $result['status'] = 1;
      $result['notify'] = 'Đã cập nhật ' . $count . ' trên tổng số ' . $total;
      $result['html'] = expList();
    break;
    case 'check':
      $data = $nv_Request->get_array('data', 'post', '');
      $error = array();
      $inserted = 0;
      $count = 1;

      foreach ($data as $row) {
        if (empty($row[0])) {
          $error[] = 'Dòng ' . $count . ': tên trống';
        }
        else {
          if (!checkItemName($row[0])) {
            // insert item
            // echo 'insert into `'. PREFIX .'item` (name, update_time) values("'. $row[0] .'", "'. time() .'")<br>';
            $query = $db->query('insert into `'. PREFIX .'item` (name, update_time) values("'. $row[0] .'", "'. time() .'")');

            if ($query) {
              $id = $db->lastInsertId();
            }
          }
          else {
            $id = getItemName($row[0])['id'];
          }
          // insert row
          if (empty($id) || empty(getItemId($id))) {
            $error[] = 'Dòng ' . $count . ': Lỗi thêm hàng hóa (' . $row[1] . ')';
          }
          else {
            // echo 'insert into `'. PREFIX .'row` (rid, exp_time, update_time) values("'. $id .'", "'. totime($row[1]) .'", "'. time() .'")<br>';
            $query = $db->query('insert into `'. PREFIX .'row` (rid, exp_time, number, update_time) values("'. $id .'", "'. totime($row[2]) .'", '. $row[1] .', "'. time() .'")');
            if ($query) {
              $inserted ++;
            }
          }
        }
        $count++;
      }
      $count--;
      $result['status'] = 1;
      $result['html'] = expList();
      $result['error'] = implode('<br>', $error);
      $result['notify'] = 'Đã thêm ' . $inserted . ' trên tổng ' . $count . ' dòng';
    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/exp");
$xtpl->assign('today', date('d/m/Y'));
$xtpl->assign('items', json_encode(expIdList()));
$xtpl->assign('item', getItemList());
$xtpl->assign('content', expList());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
