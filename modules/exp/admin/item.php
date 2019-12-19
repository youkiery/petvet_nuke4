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
      $number = $nv_Request->get_int('number', 'post', 0);
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
        $query = $db->query('insert into `'. PREFIX .'item` (name, code, number, cate_id, update_time) values("'. $name .'", "'. $code .'", "'. $number .'", '. $cate_id .', "'. time() .'")');
        if ($query) {
          $result['status'] = 1;
          $result['notify'] = 'Đã thêm';
          $result['html'] = itemList();
        }
      }
    break;
    case 'update':
      $id = $nv_Request->get_int('id', 'post', 0);
      $code = $nv_Request->get_string('code', 'post', '');
      $name = $nv_Request->get_string('name', 'post', '');
      $number = $nv_Request->get_int('number', 'post', 0);

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
        $query = $db->query('update `'. PREFIX .'item` set name = "'. $name .'", code = "'. $code .'", number = '. $number .', update_time = '. time() .' where id = ' . $id);  
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
        $query = $db->query('delete from `'. PREFIX .'item` where id = ' . $id);
        if ($query) {
          $result['status'] = 1;
          $result['html'] = itemList();
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
    case 'check':
      $data = $nv_Request->get_array('data', 'post', '');
      $error = array();
      $inserted = 0;
      $edited = 0;
      $count = 1;

      foreach ($data as $row) {
        if (empty($row[0])) {
          $error[] = 'Dòng ' . $count . ': mã trống';
        }
        else if (empty($row[1])) {
          $error[] = 'Dòng ' . $count . ': tên trống';
        }
        else {
          if (checkItemCode($row[1])) {
            // update
            // die('update `'. PREFIX .'item` set name = "'. $row[1] .'", number = '. $row['2'] .' where code = "'. $row[0] .'"');
            $query = $db->query('update `'. PREFIX .'item` set number = '. $row['2'] .', update_time = '. time() .' where code = "'. $row[0] .'"');
            if ($query) {
              $inserted++;
            }
          }
          else if (checkItemName($row[1])) {
            $error[] = 'Dòng ' . $count . ': tên trùng';
          }
          else {
            // insert 
            $query = $db->query('insert into `'. PREFIX .'item` (name, code, number, cate_id, update_time) values("'. $row['1'] .'", "'. $row['0'] .'", "'. $row['2'] .'", 0, '. time() .')');
            if ($query) {
              $inserted++;
            }
          }
        }
        $count++;
      }
      $count--;
      $result['status'] = 1;
      $result['html'] = expList();
      $result['error'] = implode('<br>', $error);
      $result['notify'] = 'Đã thêm/chỉnh sửa ' . $inserted . ' trên tổng ' . $count . ' dòng';
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