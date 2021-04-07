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
        $result['notify'] = 'Loại hàng không được để trống';
      }
      else if (checkCategoryName($name)) {
        $result['notify'] = 'Trùng loại hàng';
      }
      else {
        $query = $db->query('insert into `'. PREFIX .'category` (name, update_time) values("'. $name .'", "'. time() .'")');
        if ($query) {
          $result['status'] = 1;
          $result['notify'] = 'Đã thêm';
          $result['html'] = categoryList();
        }
      }
    break;
    case 'update':
      $id = $nv_Request->get_int('id', 'post', '');
      $name = $nv_Request->get_string('name', 'post', '');

      if (empty($name)) {
        $result['notify'] = 'Loại hàng không được để trống';
      }
      else if (checkCategoryName($name)) {
        $result['notify'] = 'Trùng loại hàng';
      }
      else {
        $query = $db->query('update `'. PREFIX .'category` set name = "'. $name .'", update_time = '. time() .' where id = ' . $id);
        if ($query) {
          $result['status'] = 1;
          $result['notify'] = 'Đã lưu';
          $result['html'] = categoryList();
        }
      }
    break;
    case 'remove':
      $id = $nv_Request->get_int('id', 'post', '');

      if (!checkCategoryId($id)) {
        $result['notify'] = 'Loại hàng không tồn tại';
      }
      else {
        $query = $db->query('delete from `'. PREFIX .'category` id = ' . $id);
        if ($query) {
          $result['status'] = 1;
          $result['notify'] = 'Đã xóa';
          $result['html'] = categoryList();
        }
      }
    break;
    case 'filter':
      $result['status'] = 1;
      $result['html'] = categoryList();
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/category");
$xtpl->assign('content', categoryList());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
