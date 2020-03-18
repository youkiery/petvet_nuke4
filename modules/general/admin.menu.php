<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_ADMIN')) die('Stop!!!');

// $submenu['category'] = 'Danh sách loại hàng';
// $submenu['item'] = 'Danh sách sản phẩm';
// $submenu['exp'] = 'Quản lý hạn sử dụng';
$submenu['price'] = 'Quản lý giá sỉ';
$submenu['blood'] = 'Quản lý xét nghiệm máu';
$submenu['remind'] = 'Quản lý gợi ý';
$submenu['config'] = 'Phân quyền';

$allow_func = array('main', 'price', 'blood', 'config', 'remind'); 
