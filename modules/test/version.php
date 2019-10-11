<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2010 - 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Sun, 08 Apr 2012 00:00:00 GMT
 */

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE')) {
    die('Stop!!!');
}

$module_version = array(
    'name' => 'Users',
    'modfuncs' => 'overmind, main, list, sieuam, danhsachsieuam, luubenh, danhsachluubenh, sieuam-birth, spa, redrug, process, heal, heal_drug',
    'submenu' => 'main, list, sieuam, danhsachsieuam, luubenh, danhsachluubenh, sieuam-birth, spa, redrug, heal, heal_drug',
    'is_sysmod' => 1,
    'virtual' => 1,
    'version' => '4.3.04',
    'date' => 'Friday, November 16, 2018 9:59:52 AM GMT+07:00',
    'author' => 'VINADES <contact@vinades.vn>',
    'note' => ''
);