<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES <contact@vinades.vn>
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 12/31/2009 2:29
 */

if (! defined('NV_ADMIN') or ! defined('NV_MAINFILE') or ! defined('NV_IS_MODADMIN')) {
    die('Stop!!!');
}

define( 'NV_IS_QUANLY_ADMIN', true );
define('PATH', NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file); 
require NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php';
require NV_ROOTDIR . '/modules/' . $module_file . '/theme.php';

function admin_schedule() {
  global $db, $global_config, $module_file, $lang_module, $db_config;
  $xtpl = new XTemplate("schedule-list.tpl", NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file);
  $xtpl->assign("lang", $lang_module);
  $today = strtotime(date("Y-m-d"));

  $sql = "select * from `" . VAC_PREFIX . "_schedule` where time >= $today order by time";
  $query = $db->query($sql);
  while ($schedule = $query->fetch()) {
    $sql = "select * from `" . $db_config["prefix"] . "_users` where userid = $schedule[userid]";
    $user_query = $db->query($sql);
    $user = $user_query->fetch();

    $xtpl->assign("id", $schedule["id"]);
    $xtpl->assign("user", $user["first_name"]);
    $xtpl->assign("restday", date("d/m/Y", $schedule["time"]));
    $xtpl->parse("main");
  }

  return $xtpl->text();
}
