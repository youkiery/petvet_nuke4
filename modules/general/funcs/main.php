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

$xtpl->assign('item', json_encode($item));

$xtpl->assign('excel_modal', excelModal());
$xtpl->assign('category_modal', categoryModal());
$xtpl->assign('item_modal', itemModal());

$xtpl->assign('content', itemList());

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
