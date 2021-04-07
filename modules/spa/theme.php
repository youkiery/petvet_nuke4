<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2017 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 04/18/2017 09:47
 */

if (!defined('SPA_PREFIX')) {
    die('Stop!!!');
}

include_once(NV_ROOTDIR . "/modules/" . $module_file . "/modal/spa.php");
$spa = new Spa();
include_once(NV_ROOTDIR . "/modules/" . $module_file . "/modal/doctor.php");
$doctor = new Doctor();
include_once(NV_ROOTDIR . "/modules/" . $module_file . "/modal/customer.php");
$customer = new Customer();

function spa_list($data_content, $compare_id, $html_pages = '') {
    global $spa, $doctor, $customer, $pet, $module_info, $lang_module, $module_file;
    $xtpl = new XTemplate('main-list.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);
    $index = 1;
    $spa_list = $spa->get_list();
    $doctor_list = $doctor->get_list();
    $xtpl->assign('lang', $lang_module);

    foreach ($spa_list as $spa_data) {
        $customer = $customer->get_by_id($spa_data["id"]);
        $xtpl->assign("index", $index);
        $xtpl->assign("doctor", $doctor_list[$spa_data["doctorid"]]);
        $xtpl->assign("customer_name", $customer["name"]);
        $xtpl->assign("customer_number", $customer["phone"]);
        $xtpl->assign("status", $lang_module["spa_status"][$spa_data["status"]]);

        $index ++;
    }

    $xtpl->parse('main');
    return $xtpl->text('main');
    return 1;
}
