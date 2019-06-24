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

$xtpl = new XTemplate("main.tpl", "modules/biograph/template");

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/biograph/layout/header.php");
echo $contents;
include ("modules/biograph/layout/footer.php");

