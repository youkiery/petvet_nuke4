<?php

/**
 * @Project NUKEVIET 4.x
 * @Author Frogsis
 * @Createdate Tue, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_MAINFILE')) { die('Stop!!!'); }
define('PREFIX', $db_config['prefix'] . '_' . $module_name . '_');
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/theme.php');
