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

$submenu['user'] = "Quản lý người dùng";
$submenu['pet'] = "Quản lý thú cưng";
$submenu['request'] = "Yêu cầu tiêm phòng";

$allow_func = array('main', 'user', 'pet', 'request'); 
