<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) die('Stop!!!');

$filter = array(
  'keyword' => $nv_Request->get_string('keyword', 'get', ''),
  'category' => $nv_Request->get_int('category', 'get', 0),
  'page' => $nv_Request->get_int('page', 'get', 1),
  'limit' => $nv_Request->get_int('limit', 'get', 20)
);

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
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);

$xtpl->assign('module_name', $module_name);
$xtpl->assign('op', $op);
$xtpl->assign('keyword', $filter['keyword']);
$xtpl->assign('category_option', priceCategoryOption($filter['category']));
$xtpl->assign('content', priceContent($filter));

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';