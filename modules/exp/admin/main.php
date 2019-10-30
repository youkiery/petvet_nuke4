<?php

/**
 * @Project NUKEVIET 4.x
 * @Author Frogsis
 * @Createdate Tue, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'filter':
      $result['status'] = 1;
      $result['html'] = outdateList();
    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/main");
$xtpl->assign('content', outdateList());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
