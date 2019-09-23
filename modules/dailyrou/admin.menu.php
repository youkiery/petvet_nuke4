<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_ADMIN')) {
    die('Stop!!!');
}

$submenu['manager'] = "Người quản lý chấm công";
$submenu['except'] = "Người ngoại lệ";
$submenu['penety'] = "Nghỉ phạt";

$allow_func = array('main', 'manager', 'except', 'penety'); 
