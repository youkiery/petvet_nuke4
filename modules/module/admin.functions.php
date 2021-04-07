<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (! defined('NV_ADMIN') or ! defined('NV_MAINFILE') or ! defined('NV_IS_MODADMIN')) {
  die('Stop!!!');
}

define('NV_IS_ADMIN_MODULE', true);
define("PATH", NV_ROOTDIR . "/modules/" . $module_file . '/template/admin/' . $op);
define("PREFIX", $db_config['prefix'] . "_" . $module_name);

function modal() {
  $xtpl = new XTemplate('modal.tpl', PATH);
  // $xtpl->assign('c')
  $xtpl->parse('main');
  return $xtpl->text();
}
