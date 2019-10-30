<?php

/**
 * @Project NUKEVIET 4.x
 * @Author Frogsis
 * @Createdate Tue, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'insert':
      $id = $nv_Request->get_string('id', 'post', '');
      $date = $nv_Request->get_string('date', 'post', '');

      if (!checkItemId($id)) {
        $result['notify'] = 'Hàng hoá không tồn tại';
      }
      else {
        $query = $db->query('insert into `'. PREFIX .'row` (rid, exp_time, update_time) values('. $id .', "'. totime($date) .'", "'. time() .'")');
        if ($query) {
          $result['status'] = 1;
          $result['notify'] = 'Đã thêm';
          $result['list'] = expIdList();
          $result['html'] = expList();
        }
      }
    break;
    case 'update':
      $id = $nv_Request->get_int('id', 'post', '');
      $rid = $nv_Request->get_int('rid', 'post', '');
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
        $query = $db->query('update `'. PREFIX .'row` set rid = "'. $rid .'", exp_time = "'. totime($date) .'", update_time = '. time() .' where id = ' . $id);
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
