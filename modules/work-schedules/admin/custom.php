<?php

/**
 * @Project WORK SCHEDULES 4.X
 * @Author PHAN TAN DUNG (phantandung92@gmail.com)
 * @Copyright (C) 2016 PHAN TAN DUNG. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Sat, 11 Jun 2016 23:45:51 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) {
    die('Stop!!!');
}

$action = $nv_Request->get_string('action', 'post');
if (!empty($action)) {
  switch ($action) {
    case 'add':
      $name = $nv_Request->get_string('name', 'post');
      $number = $nv_Request->get_string('number', 'post');
      $address = $nv_Request->get_string('address', 'post');
      if (!empty($name)) {
        $sql = ""
      }
    break;
    case 'edit':

    break;
  }
}

// $query = 'SELECT COUNT(*) FROM ' . NV_MOD_TABLE . '_field WHERE fid=' . $fid;
// $numrows = $db->query($query)->fetchColumn();

$xtpl = new XTemplate('custom.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);

$xtpl->assign('lang', $lang_module);
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
