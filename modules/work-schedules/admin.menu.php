<?php

/**
 * @Project WORK SCHEDULES 4.X
 * @Author PHAN TAN DUNG (phantandung92@gmail.com)
 * @Copyright (C) 2016 PHAN TAN DUNG. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Sat, 11 Jun 2016 23:45:51 GMT
 */

if (!defined('NV_ADMIN')) {
    die('Stop!!!');
}
    
$submenu['depart'] = $lang_module['depart_manage'];
$submenu['employ'] = $lang_module['employ_manage'];
$submenu['customer'] = $lang_module['customer_manage'];
$submenu['work'] = $lang_module['work_manage'];
$submenu['configv2'] = $lang_module['config_manage'];
$submenu['config'] = $lang_module['config'];
$submenu['fields'] = $lang_module['field'];
$submenu['custom'] = $lang_module['custom'];
$submenu['config-sys'] = $lang_module['cfgSYS'];

$allow_func = array('main', 'depart', 'depart-employ', 'employ', 'customer', 'work', 'configv2', 'config', 'fields', 'config-sys', 'custom');
