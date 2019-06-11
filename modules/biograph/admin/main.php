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

$xtpl = new XTemplate("main.tpl", PATH);

$step = $nv_Request->get_int('s', 'get', 1);

if ($step <= 1) {
	$customer = $nv_Request->get_string('customer', 'get', '');
	$xtpl->assign('customer', $customer);
	$xtpl->parse('main.customer');
}

$xtpl->assign('customer', $customer);
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");