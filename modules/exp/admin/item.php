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
      $name = $nv_Request->get_string('name', 'post', '');

      if (empty($name)) {
        $result['notify'] = 'Tên hàng không được để trống';
      }
      else if (checkItemName($name)) {
        $result['notify'] = 'Trùng tên hàng';
      }
      else {
        $query = $db->query('insert into `'. PREFIX .'item` (name, update_time) values("'. $name .'", "'. time() .'")');
        if ($query) {
          $result['status'] = 1;
          $result['notify'] = 'Đã thêm';
          $result['html'] = itemList();
        }
      }
    break;
    case 'update':
      $id = $nv_Request->get_int('id', 'post', '');
      $name = $nv_Request->get_string('name', 'post', '');

      if (empty($name)) {
        $result['notify'] = 'Tên hàng không được để trống';
      }
      else if (checkItemName($name)) {
        $result['notify'] = 'Trùng tên hàng';
      }
      else {
        $query = $db->query('update `'. PREFIX .'item` set name = "'. $name .'", update_time = '. time() .' where id = ' . $id);
        if ($query) {
          $result['status'] = 1;
          $result['notify'] = 'Đã lưu';
          $result['html'] = itemList();
        }
      }
    break;
    case 'remove':
      $id = $nv_Request->get_int('id', 'post', '');

      if (!checkItemById($id)) {
        $result['notify'] = 'Hàng hóa không tồn tại';
      }
      else {
        $query = $db->query('delete from `'. PREFIX .'item` id = ' . $id);
        if ($query) {
          $result['status'] = 1;
          $result['notify'] = 'Đã xóa';
        }
      }
    break;
    case 'filter':
      $result['status'] = 1;
      $result['html'] = itemList();
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/item");
$xtpl->assign('content', itemList());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
