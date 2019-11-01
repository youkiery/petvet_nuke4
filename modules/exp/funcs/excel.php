<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) die('Stop!!!');

$action = $nv_Request->get_string('action', 'post', '');

if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
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
      $result['error'] = implode('<br>', $error);
      $result['notify'] = 'Đã thêm ' . $inserted . ' trên tổng ' . $count . ' dòng';
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/modules/" . $module_file . "/template/excel");
$xtpl->assign('module_name', $module_name);

$xtpl->parse('main');
$contents = $xtpl->text();

$page_title = $lang_module['add_document'];

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';