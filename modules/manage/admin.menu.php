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
$submenu['depart'] = 'Quản lý phòng ban';
$submenu['device'] = 'Quản lý thiết bị';
$submenu['material'] = 'Quản lý vật tư, hóa chất';
// $submenu['config'] = 'Cấu hình';

$allow_func = array('main', 'device', 'material', 'config', 'depart'); 
