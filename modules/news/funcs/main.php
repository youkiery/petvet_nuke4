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

$page_title = "autoload";

$xtpl = new XTemplate("main.tpl", "modules/news/template");
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

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/news//layout/header.php");
echo $contents;
include ("modules/news//layout/footer.php");

