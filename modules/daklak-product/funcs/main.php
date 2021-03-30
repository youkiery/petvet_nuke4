<?php

/**
 * @Project Thanhxuanpet 0.1
 * @Author Đường Vũ Huyên <handcore3rd@gmail.com>
 * @Copyright (C) 2021 Thanhxuanpet
 * @License Nope
 * @Createdate 22/01/2021 14:15
 */

if (!defined('NV_IS_TX')) die('Stop!!!');

$filter = array(
  'page' => $nv_Request->get_string('page', 'get', 1),
  'limit' => $nv_Request->get_string('limit', 'get', 1),
  'keyword' => $nv_Request->get_string('keyword', 'get', ''),
  'catid' => $nv_Request->get_string('catid', 'get', '0')
);

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'get-update':
      $id = $nv_Request->$nv_Request->get_string('id', 'post', 0);

      $data = $product->getById($id);

      $result['status'] = 1;
      $result['data'] = array(
        'code' => $data['code'],
        'name' => $data['name'],
        'limitup' => $data['limitup'],
        'limitdown' => $data['limitdown'],
        'image' => $data['image']
      );
      break;
  }
}

$xtpl = new XTemplate("/product/main.tpl", VIEW);
$xtpl->assign('content', $product->content($filter));

$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
