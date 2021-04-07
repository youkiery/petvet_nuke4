<?php

/**
 * @Project Thanhxuanpet 0.1
 * @Author Võ Anh Dư <vodaityr@gmail.com>
 * @Copyright (C) 2021 Thanhxuanpet
 * @License Nope
 * @Createdate 22/01/2021 14:15
 */

if (!defined('NV_IS_TX')) die('Stop!!!');

$page = $nv_Request->get_string('page', 'get', '1');
$limit = $nv_Request->get_string('limit', 'get', '10');
$filter = array();

$action = $nv_Request->get_string('action', 'post');
if (!empty($action)) {
  $result = array('status' => 0, 'messenger' => 'Có lỗi xảy ra');
  switch ($action) {
    case 'insert_customer':
      $data = $nv_Request->get_array('data', 'post');

      if (empty($data['phone'])) $result['messenger'] = 'Số điện thoại trống';
      else if ($msg = $customer->insert($data)) {
        $result['status'] = 1;
        $result['messenger'] = $msg;
        $result['html'] = $customer->content();
      }
      break;
    case 'remove_customer':
      $id = $nv_Request->get_string('id', 'post');

      $result['status'] = 1;
      $result['messenger'] = $customer->remove($id);
      $result['html'] = $customer->content($filter, $page, $limit);
      break;
  }
  echo json_encode($result);
  die();
}

// menu dạng tab ngang
// hiển thị danh sách nhân viên
// hiển thị danh sách khách hàng
// hiển thị danh sách thú cưng
// chỉ quản lý mới có thể xem
// quản lý thường chỉ có thể thêm, xóa nhân viên, chỉnh sửa thông tin khách hàng
$xtpl = new XTemplate("main.tpl", PATH);
$xtpl->assign('module_name', $module_name);
$xtpl->assign('modal', $customer->modal());
$xtpl->assign('content', $customer->content());

$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
