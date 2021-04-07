<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }

$link = '/admin/index.php?nv='. $module_name . '&op='. $op;
$action = $nv_Request->get_string('action', 'post', '');
$filter = array(
  'page' => $nv_Request->get_int('page', 'get', 1),
  'limit' => $nv_Request->get_int('limit', 'get', 10)
);

$sub = $nv_Request->get_string('sub', 'get', '');
$sub_op = array('tag', 'user');
if (in_array($sub, $sub_op)) {
  include_once(NV_ROOTDIR . '/modules/'. $module_file .'/admin/product-'. $sub . '.php');
  exit();
}

if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'filter':
      $filter = $nv_Request->get_array('filter', 'post');

      $result['status'] = 1;
      $result['html'] = remindList($filter);
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);
$xtpl->assign("link", $link);
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");