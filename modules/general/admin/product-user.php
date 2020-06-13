<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }

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

$xtpl = new XTemplate("user.tpl", PATH);
$xtpl->assign("link", '/admin/index.php?nv='. $module_name . '&op='. $op);
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");