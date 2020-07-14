<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_QUANLY')) die('Stop!!!');

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'get-edit':
        $id = $nv_Request->get_int('id', 'post');

        $sql = 'select * from `'. VAC_PREFIX .'_market` where id = ' . $id;
        $query = $db->query($sql);
        
        if (!empty($row = $query->fetch())) {
            $result['status'] = 1;
            $result['data'] = $row;
        }
    break;
    case 'insert':
        $data = $nv_Request->get_array('data', 'post');

        $sql = 'insert into `'. VAC_PREFIX .'_market` (doctor, name, unit, address, price) values(0, "'. $data['name'] .'", "'. $data['unit'] .'", "'. $data['address'] .'", "'. $data['price'] .'")';

        if ($db->query($sql)) {
            $result['status'] = 1;
            $result['id'] = $db->lastInsertId();
        }
    break;
    case 'edit':
        $id = $nv_Request->get_int('id', 'post');
        $data = $nv_Request->get_array('data', 'post');

        $sql = 'update `'. VAC_PREFIX .'_market` set name = "'. $data['name'] .'", unit = "'. $data['unit'] .'", address = "'. $data['address'] .'", price = "'. $data['price'] .'" where id = ' . $id;

        if ($db->query($sql)) {
            $result['status'] = 1;
        }
    break;
    case 'remove':
        $id = $nv_Request->get_int('id', 'post');

        $sql = 'delete from `'. VAC_PREFIX .'_market` where id = ' . $id;
        if ($db->query($sql)) {
            $result['status'] = 1;
        }
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH2);

$data = array();
$sql = 'select * from `'. VAC_PREFIX .'_market`';
$query = $db->query($sql);
while ($row = $query->fetch()) {
    $data[]= $row;
}

// lấy dữ liệu phân quyền, chỉ quản trị mới nhất 
if (!empty($user_info) && !empty($user_info['level'])) {
    $xtpl->assign('admin', '1');
} 

$xtpl->assign('modal', marketModal());
// $xtpl->assign('content', marketContent());
$xtpl->assign('data', json_encode($data, JSON_UNESCAPED_UNICODE));
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
