<?php

/**
 * @Project Thanhxuanpet 0.1
 * @Author Đường Vũ Huyên <handcore3rd@gmail.com>
 * @Copyright (C) 2021 Thanhxuanpet
 * @License Nope
 * @Createdate 22/01/2021 14:15
 */

if (!defined('NV_SYSTEM')) {
  die('Stop!!!');
}

define('NV_IS_TX', true);
define('NV_IS_MOD_USER', true);
define('VIEW', NV_ROOTDIR . '/modules/daklak-view/');
define('MODEL', NV_ROOTDIR . '/modules/daklak-model/');

include_once(MODEL . '/core.php');
include_once(MODEL . '/product.php');

$product = new Product();