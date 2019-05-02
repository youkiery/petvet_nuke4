<?php
/**
* @Project NUKEVIET-MUSIC
* @Phan Tan Dung (phantandung92@gmail.com)
* @Copyright (C) 2011
* @Createdate 26-01-2011 14:43
*/


if (!defined('NV_IS_QUANLY_ADMIN')) die('Stop!!!');
$link = NV_BASE_ADMINURL . "index.php?" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=";
$module = array(1 => 'Vaccine', 'Siêu âm', 'Lưu bệnh', 'Spa', 'Thuốc', 'Hồ sơ điều trị');

$action = $nv_Request->get_string('action', 'post/get', "");
if($action) {
	$result = array("status" => 0, "data" => array());
	switch ($action) {
    case 'update':
      $list = $nv_Request->get_array('list', 'post', '');

      if (!empty($list)) {
        $sql = 'delete from `'.VAC_PREFIX.'_heal_manager`';
        $db->query($sql);
        foreach ($list as $key => $group) {
          foreach ($group as $modulekey => $allow) {
            $sql = 'insert into `'.VAC_PREFIX.'_heal_manager` (groupid, type, allow) values('.$key.', '.$modulekey.', '.$allow.')';
            $db->query($sql);
          }
        }
        $result['status'] = 1;
        $result['notify'] = 'Đã cập nhật';
        $result['html'] = permissionContent($module);
      }
    break;
  }
	echo json_encode($result);
  die();
}

$xtpl = new XTemplate("permission.tpl", PATH);

$xtpl->assign('content', permissionContent($module));

$xtpl->parse("main");

$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");
