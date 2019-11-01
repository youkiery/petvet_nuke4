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
      $code = $nv_Request->get_string('code', 'post', '');
      $cate_id = $nv_Request->get_int('cate_id', 'post', 0);

      if (empty($name)) {
        $result['notify'] = 'Tên hàng không được để trống';
      }
      else if (empty($code)) {
        $result['notify'] = 'Mã hàng không được để trống';
      }
      else if (checkItemName($name)) {
        $result['notify'] = 'Trùng tên hàng';
      }
      else if (checkItemCode($code)) {
        $result['notify'] = 'Trùng mã hàng';
      }
      else {
        $query = $db->query('insert into `'. PREFIX .'item` (name, code, cate_id, update_time) values("'. $name .'", "'. $code .'", '. $cate_id .', "'. time() .'")');
        if ($query) {
          $result['status'] = 1;
          $result['notify'] = 'Đã thêm';
          $result['html'] = itemList();
        }
      }
    break;
    case 'update':
      $id = $nv_Request->get_int('id', 'post', '');
      $code = $nv_Request->get_string('code', 'post', '');
      $name = $nv_Request->get_string('name', 'post', '');

      if (empty($name)) {
        $result['notify'] = 'Tên hàng không được để trống';
      }
      else if (checkItemName($name, $id)) {
        $result['notify'] = 'Trùng tên hàng';
      }
      else if (checkItemCode($code, $id)) {
        $result['notify'] = 'Trùng mã hàng';
      }
      else {
        $query = $db->query('update `'. PREFIX .'item` set name = "'. $name .'", code = "'. $code .'", update_time = '. time() .' where id = ' . $id);
        if ($query) {
          $result['status'] = 1;
          $result['notify'] = 'Đã lưu';
          $result['html'] = itemList();
        }
      }
    break;
    case 'remove':
      $id = $nv_Request->get_int('id', 'post', '');

      if (!checkItemId($id)) {
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
    case 'pick-category':
      $id = $nv_Request->get_int('id', 'post', '');
      $list = $nv_Request->get_string('list', 'post', '');

      $list = explode(', ', $list);
      if (count($list)) {
        if (count($list) == 1) {
          updateCategory($id, $list[0]);
        }
        else {
          foreach ($list as $item_id) {
            updateCategory($id, $item_id);
          }
        }
      }
      
      $result['status'] = 1;
      $result['html'] = itemList();
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/item");
$category = getCategoryList();
foreach ($category as $row) {
  $xtpl->assign('id', $row['id']);
  $xtpl->assign('category', $row['name']);
  $xtpl->parse('main.category');
  $xtpl->parse('main.category2');
}

$xtpl->assign('content', itemList());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
