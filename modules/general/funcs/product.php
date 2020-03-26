<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) die('Stop!!!');

$filter = array(
  'page' => $nv_Request->get_int('page', 'get', 1),
  'limit' => $nv_Request->get_int('limit', 'get', 20),
  'keyword' => $nv_Request->get_string('keyword', 'get', ''),
  'category' => $nv_Request->get_int('category', 'get', 0),
);
$http = array(
  'keyword' => $filter['keyword'],
  'category' => $filter['category']
);

$url = '/index.php?nv=' . $module_name . '&op=' . $op .'&' . http_build_query($http);

// $x = array("SHOP", "SHOP>>Balo, giỏ xách", "SHOP>>Bình xịt", "SHOP>>Cát vệ sinh", "SHOP>>Dầu tắm", "SHOP>>Đồ chơi", "SHOP>>Đồ chơi - vật dụng", "SHOP>>Giỏ-nệm-ổ", "SHOP>>Khay vệ sinh", "SHOP>>Nhà, chuồng", "SHOP>>Thức ăn", "SHOP>>Thuốc bán", "SHOP>>Thuốc bán>>thuốc sát trung", "SHOP>>Tô - chén", "SHOP>>Vòng-cổ-khớp", "SHOP>>Xích-dắt-yếm");
// foreach ($x as $a) {
//   $sql = 'insert into `'. PREFIX .'product_category` (name) values("'. $a .'")';
//   $db->query($sql);
// }
// die();

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'insert':
      $data = $nv_Request->get_array('data', 'post');

      foreach ($data as $item) {
        $sql = 'insert into `'. PREFIX .'product` (code, name, category, price, least, image, contact, parent, exchange, active) values("'. $item['code'] .'", "'. $item['name'] .'", 0, "'. $item['price'] .'", 10, "'. $item['image'] .'", 0, 0, 0, 1)';
        $db->query($sql);
      }
      $result['status'] = 1;
    break;
    case 'remove':
      $list = $nv_Request->get_array('list', 'post');
      
      foreach ($list as $id) {
        $sql = 'delete from `'. PREFIX .'product` where id = ' . $id;
        $db->query($sql);
      }
      $result['status'] = 1;
      $result['notify'] = 'Đã xóa sản phẩm';
      $result['html'] = productList($url, $filter);
    break;
    case 'change-category':
      $list = $nv_Request->get_array('list', 'post');
      $category = $nv_Request->get_int('category', 'post');

      foreach ($list as $id) {
        $sql = 'update `'. PREFIX .'product` set category = '. $category .' where id = ' . $id;
        $db->query($sql);
      }
      $result['status'] = 1;
      $result['notify'] = 'Đã lưu thông tin sản phẩm';
      $result['html'] = productList($url, $filter);
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);
$xtpl->assign('nv', $module_name);
$xtpl->assign('op', $op);
$xtpl->assign('keyword', $filter['keyword']);
$xtpl->assign('check' . $filter['limit'], 'selected');

// $sql = 'select * from `'. PREFIX .'product`';
// $query = $db->query($sql);
// $list = array();

// while ($row = $query->fetch()) {
//   $list[$row['code']] = 1;
// }

$sql = 'select * from `'. PREFIX .'product_category`';
$query = $db->query($sql);

while($row = $query->fetch()) {
  $xtpl->assign('id', $row['id']);
  $xtpl->assign('name', $row['name']);
  $xtpl->assign('check', '');
  if ($filter['category'] == $row['id']) $xtpl->assign('check', 'selected');
  $xtpl->parse('main.category');
}

$xtpl->assign('content', productList($url, $filter));

$xtpl->assign('modal', productModal());
$xtpl->assign('list', json_encode($list));

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
