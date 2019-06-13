<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_FORM')) {
	die('Stop!!!');
}

$page_title = "Nhập hồ sơ một chiều";

$xtpl = new XTemplate("test.tpl", PATH);



// $xtpl->parse("main.sample.standard.result");
// $xtpl->parse("main.sample.standard");
// $xtpl->parse("main.sample.standard.result");
// $xtpl->parse("main.sample.standard");
// $xtpl->parse("main.sample.standard.result");
// $xtpl->parse("main.sample.standard.result");
$xtpl->parse("main.sample.standard.result");
$xtpl->parse("main.sample.standard");
$xtpl->parse("main.sample");
$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

