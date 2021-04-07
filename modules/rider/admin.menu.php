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

$submenu['driver'] = "Danh sách người lái";
$submenu['doctor'] = "Danh sách bác sĩ";
$submenu['statistic'] = "Thống kê";

$allow_func = array('main', "driver", "doctor", "statistic"); 
