<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) die('Stop!!!');

$category = array('SHOP', 'SHOP>>Balo, giỏ xách', 'SHOP>>Bình xịt', 'SHOP>>Cát vệ sinh', 'SHOP>>Dầu tắm', 'SHOP>>Đồ chơi', 'SHOP>>Đồ chơi - vật dụng', 'SHOP>>Giỏ-nệm-ổ', 'SHOP>>Khay vệ sinh', 'SHOP>>Nhà, chuồng', 'SHOP>>Thuốc bán', 'SHOP>>Thuốc bán>>thuốc sát trung', 'SHOP>>Tô - chén', 'SHOP>>Vòng-cổ-khớp', 'SHOP>>Xích-dắt-yếm');

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'insert':
      $code = $nv_Request->get_string('code', 'post');
      $product = $nv_Request->get_array('product', 'post');

      // chọn loại hàng, nếu không tồn tại, thêm vào mục hàng
      $sql = 'select * from `'. PREFIX .'product_category` where name = "'. $product['category'] .'"';
      $query = $db->query($sql);
      if (empty($categoryData = $query->fetch())) {
        // thêm vào mục hàng
        $sql = 'insert into `'. PREFIX .'product_category` (name) values ("'. $product['category'] .'")';
        $db->query($sql);
        $categoryData = array('id' => $db->lastInsertId());
      }

      $sql = 'select * from `'. PREFIX .'product` where code = "'. $code .'"';
      $query = $db->query($sql);
      
      if (empty($productData = $query->fetch())) {
        // insert
        $sql = 'insert into `'. PREFIX .'product` (code, name, category, price, bound, image) values ("'. $code .'", "'. $product['name'] .'", '. $categoryData['id'] .', 0, 0, "'. $product['image'] .'")';
        if ($db->query($sql)) {
          $id = $db->lastInsertId();
          $sql = 'insert into `'. PREFIX .'brand_product` (productid, brandid, number) values('. $id .', 1, '. $product['number'].')';
          $sql2 = 'insert into `'. PREFIX .'brand_product` (productid, brandid, number) values('. $id .', 2, '. $product['number2'].')';
          if ($db->query($sql) && $db->query($sql2)) {
            $result['status'] = 1;
          }
        } 
      }
      else {
        // update
        $sql = 'update `'. PREFIX .'product` set name = "'. $product['name'] .'", category = '. $categoryData['id'] .', image = "'. $product['image'] .'" where id = ' . $productData['id'];
        $sql2 = 'update `'. PREFIX .'brand_product` set number = ' . $product['number'] . ' where productid = ' . $productData['id'] . ' and brandid = 1';
        $sql3 = 'update `'. PREFIX .'brand_product` set number = ' . $product['number2'] . ' where productid = ' . $productData['id'] . ' and brandid = 2';
        if ($db->query($sql) && $db->query($sql2) && $db->query($sql3)) {
          $result['status'] = 1;
        }
      }

      $result['status'] = 1;
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);
$xtpl->assign('module_name', $module_name);
$brand = $nv_Request->get_int('brand', 'get', 0);

// $sql = 'select * from `'. PREFIX .'brand`';
// $query = $db->query($sql);

// while ($row = $query->fetch()) {
//     $xtpl->assign('brand_id', $row['id']);
//     $xtpl->assign('brand_name', $row['name']);
//     $xtpl->parse('main.content.main_brand');
//     $xtpl->parse('main.content.sub_brand');
// }

$xtpl->assign('modal', productModal());
// $xtpl->assign('content', productList());
$xtpl->parse('main.content');

$page_title = 'Lọc danh sách hàng hóa';

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
