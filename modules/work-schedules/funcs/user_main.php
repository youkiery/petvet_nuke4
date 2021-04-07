<?php

/**
 * @Project WORK SCHEDULES 4.X
 * @Author PHAN TAN DUNG (phantandung92@gmail.com)
 * @Copyright (C) 2016 PHAN TAN DUNG. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Sat, 11 Jun 2016 23:45:51 GMT
 */

if (!defined('NV_MOD_WORK_SCHEDULES')) {
  die('Stop!!!');
}
$action = $nv_Request->get_string("action", "get/post", "");
if (!empty($action)) {
  $result = array("status" => 0, "notify" => $lang_module["error"]);
  switch ($action) {
    case 'change_process':
      break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate('user_main.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
$xtpl->assign("lang", $lang_module);

$xtpl->assign("content", user_main_list());
$xtpl->parse("main");
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
