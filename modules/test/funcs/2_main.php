<?php

/**
 * @Project Petcoffee-technical
 * @Author Chistua
 * @Copyright (C) 2019
 * @Createdate 18/03/2019
 */

if (!defined('NV_IS_PETMAN')) {
  die('Stop!!!');
}
$xtpl = new XTemplate("2_main.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);

$xtpl->assign("lang", $lang_module);
$xtpl->assign("vaccine_remind", vaccine_remind());
// $xtpl->assign("usg_remind", usg_remind());
// $xtpl->assign("birth_remind", birth_remind());
// $xtpl->assign("drug_remind", drug_remind());

$xtpl->parse("main");

$contents = $xtpl->text("main");
include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
