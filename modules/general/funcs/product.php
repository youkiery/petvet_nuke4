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
    case 'filter':
      $result['status'] = 1;
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);
$xtpl->assign('module_name', $module_name);
$brand = $nv_Request->get_int('brand', 'get', 0);

$sql = 'select * from `'. PREFIX .'brand`';
$query = $db->query($sql);

while ($row = $query->fetch()) {
    $xtpl->assign('brand_id', $row['id']);
    $xtpl->assign('brand_name', $row['name']);
    $xtpl->parse('main.content.main_brand');
    $xtpl->parse('main.content.sub_brand');
}


$xtpl->assign('content', productList());
$xtpl->parse('main.content');


// $sql = 'select * from `'. PREFIX .'brand` where id = ' . $brand;
// $query = $db->query($sql);
// if (!empty($query->fetch())) {
//     // Đã chọn chi nhánh, hiển thị nội dung
//     // $xtpl->assign('modal', productModal());
//     $xtpl->assign('content', productList());
//     $xtpl->parse('main.content');
// }
// else {
//     // chưa chọn chi nhánh
//     $sql = 'select * from `'. PREFIX .'brand`';
//     $query = $db->query($sql);
    
//     while ($row = $query->fetch()) {
//         $xtpl->assign('brand_id', $row['id']);
//         $xtpl->assign('brand_name', $row['id']);
//         $xtpl->parse('main.brand.box');
//     }
//     $xtpl->parse('main.brand');
// }

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
