<?php
/**
* @Project NUKEVIET-MUSIC
* @Phan Tan Dung (phantandung92@gmail.com)
* @Copyright (C) 2011
* @Createdate 26-01-2011 14:43
*/

if (!defined('NV_IS_QUANLY_ADMIN')) die('Stop!!!');

$action = $nv_Request->get_string('action', 'post/get', "");
if($action) {
	$result = array("status" => 0);
	switch ($action) {
        case '1':
            // do nothing
        break;
	} 
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("main.tpl", PATH2);
$xtpl->assign("modal", settingModal());
$xtpl->parse("main");
$contents = $xtpl->text();

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");
