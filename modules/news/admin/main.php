<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_ADMIN_FORM')) {
	die('Stop!!!');
}

$page_title = "Quản lý chíp";

$step = $nv_Request->get_int('s', 'get', 1);

$xtpl = new XTemplate("main.tpl", PATH);
$xtpl->assign('module_file', $module_file);

$last_month = time() - 60 * 60 * 24 * 30;
// new member
$sql = 'select count(*) as count from `'. PREFIX .'_user` where time > ' . $last_month;
$count = $db->query($sql)->fetch();
$xtpl->assign('user_new', $count['count']);
// active member
$sql = 'select count(*) as count from `'. PREFIX .'_user` where active = 1';
$count = $db->query($sql)->fetch();
$xtpl->assign('user_active', $count['count']);
// total member
$sql = 'select count(*) as count from `'. PREFIX .'_user`';
$count = $db->query($sql)->fetch();
$xtpl->assign('user_total', $count['count']);

// $xtpl->assign('remind', json_encode(getRemind()));
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
include (NV_ROOTDIR . "/modules/". $module_file ."/layout/prefix.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");
