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

$page_title = "Vetvn.com - Nâng niu thú cưng Việt Nam";

$xtpl = new XTemplate("main.tpl", "modules/". $module_name ."/template");
$userinfo = getUserInfo();

if (!empty($userinfo)) {
  if ($userinfo['center']) {
    $xtpl->parse("main.log_center");
  }
  else {
    $xtpl->parse("main.log");
  }
}
else {
  $xtpl->parse("main.nolog");
}

$xtpl->assign('module_file', $module_file);
$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/". $module_name ."/layout/header.php");
echo $contents;
include ("modules/". $module_name ."/layout/footer.php");

