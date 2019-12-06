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
    case 'insert-all':
      $data = $nv_Request->get_array('data', 'post');
      $count = 0;
      $total = count($data);

      foreach ($data as $row) {
        if (!checkCode($row['code'])) {
          $row['category'] = checkCategory($row['category']);
          if (insertItem($row)) $count ++;
        }
      }

      $result['status'] = 1;
      $result['html'] = itemList();
      $result['notify'] = "Đã thêm $count trên $total sản phẩm";
    break;
    case 'update-all':
      $data = $nv_Request->get_array('data', 'post');
      $count = 0;
      $total = count($data);

      foreach ($data as $row) {
        $row['category'] = checkCategory($row['category']);
        if (updateItem($row)) $count ++;
      }

      $result['status'] = 1;
      $result['html'] = itemList();
      $result['notify'] = "Đã thêm $count trên $total sản phẩm";
    break;
    case 'filter':
      $result['status'] = 1;
      $result['html'] = itemList();
    break;
    case 'lowitem-filter':
      $result['status'] = 1;
      $result['html'] = lowitemitemList();
    break;
    case 'update-item':
      $id = $nv_Request->get_int('id', 'post');
      $data = $nv_Request->get_array('data', 'post');

      if ($db->query('update `'. PREFIX .'item` set name = "'. $data['name'] .'", number = '. $data['number'] .', bound = '. $data['bound'] .' where id = ' . $id)) {
        $result['status'] = 1;
        $result['notify'] = 'Đã cập nhật';
      }
    break;
    case 'remove-item':
      $id = $nv_Request->get_int('id', 'post');

      if ($db->query('delete from `'. PREFIX .'item` where id = ' . $id)) {
        $result['status'] = 1;
        $result['html'] = itemList();
        $result['notify'] = 'Đã xóa';
      }
    break;
    case 'remove-all-item':
      $list = $nv_Request->get_array('list', 'post');
      $count = 0;
      $total = count($list);

      foreach ($list as $id) {
        if ($db->query('delete from `'. PREFIX .'item` where id = ' . $id)) $count ++;
      }
      $result['status'] = 1;
      $result['html'] = itemList();
      $result['notify'] = "Đã xóa $count trên $total sản phẩm";
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);

$item = array();

$query = $db->query('select * from `'. PREFIX .'item` where active = 1');
while ($row = $query->fetch()) {
  $item[] = $row['code'];
}

$query = $db->query('select * from `'. PREFIX .'category` order by name');

while ($row = $query->fetch()) {
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->parse('main.category');
}

$xtpl->assign('item', json_encode($item));

$xtpl->assign('excel_modal', excelModal());
$xtpl->assign('category_modal', categoryModal());
$xtpl->assign('item_modal', itemModal());
$xtpl->assign('lowitem_modal', lowitemModal());
$xtpl->assign('remove_modal', removeModal());

$xtpl->assign('content', itemList());

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
