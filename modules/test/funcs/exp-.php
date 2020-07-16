<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_QUANLY')) die('Stop!!!');

$filter = array(
  'from' => $nv_Request->get_string('from', 'get', ''),
  'to' => $nv_Request->get_string('to', 'get', ''),
  'time' => $nv_Request->get_int('time', 'get', 90),
  'list' => $nv_Request->get_string('list', 'get', ''),
  'keyword' => $nv_Request->get_string('keyword', 'get', '')
);

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'filter':
      $result['status'] = 1;
      $result['html'] = outdateList();
    break;
    case 'done':
      $id = $nv_Request->get_string('id', 'post', 0);

      if (empty(getRowId($id))) {
        $result['notify'] = 'Không tồn tại';
      }
      else {
        if ($db->query('update `'. PREFIX .'row` set number = 0 where id = ' . $id)) {
          $result['status'] = 1;
          $result['html'] = outdateList();
          $result['notify'] = 'Đã cập nhật';
        }
      }
    break;
    case 'done-check':
      $list = $nv_Request->get_array('list', 'post');

      if (!count($list)) {
        $result['notify'] = 'Chọn 1 mục trước khi xác nhận';
      }
      else {
        $total = 0;
        $count = 0;
        foreach ($list as $id) {
          if ($db->query('update `'. PREFIX .'row` set number = 0 where id = ' . $id)) {
            $count ++;
          }
        }
        $total ++;
        $result['status'] = 1;
        $result['html'] = outdateList();
        $result['notify'] = 'Đã cập nhật ' . $count . ' trên tổng số ' . $total;
      }
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH2);
$xtpl->assign('module_name', $module_name);
$category = getCategoryList();
foreach ($category as $row) {
  $xtpl->assign('id', $row['id']);
  $xtpl->assign('name', $row['name']);
  $xtpl->parse('main.category');
}
$xtpl->assign('content', outdateList());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
