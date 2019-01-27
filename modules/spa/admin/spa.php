<?php

/**
* @Project PETCOFFEE 
* @Youkiery (youkiery@gmail.com)
* @Copyright (C) 2019
* @Createdate 13-11-2019 16:00
*/

if (!defined('NV_IS_SPA_ADMIN')) die('Stop!!!');
$page_title = $lang_module["main_title"];
$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file);
$xtpl->assign("lang", $lang_module);
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");
?>