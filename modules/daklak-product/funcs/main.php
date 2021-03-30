<?php

/**
 * @Project Thanhxuanpet 0.1
 * @Author Đường Vũ Huyên <handcore3rd@gmail.com>
 * @Copyright (C) 2021 Thanhxuanpet
 * @License Nope
 * @Createdate 22/01/2021 14:15
 */

if (!defined('NV_IS_TX')) die('Stop!!!');

// $xtpl = new XTemplate("main.tpl", PATH);
// $xtpl->assign('module_name', $module_name);
// $xtpl->assign('modal', $customer->modal());
// $xtpl->assign('content', $customer->content());

// $xtpl->parse("main");
// $contents = $xtpl->text("main");

$contents = '';

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
