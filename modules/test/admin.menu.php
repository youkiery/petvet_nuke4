<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 07/30/2013 10:27
 */

if (!defined('NV_ADMIN')) {
    die('Stop!!!');
}

$submenu['customer'] = $lang_module["customer_title"];
$submenu['patient'] = $lang_module["patient_title3"];
$submenu['disease'] = $lang_module["disease_title"];
$submenu['doctor'] = $lang_module["doctor_title"];
$submenu['sieuam'] = $lang_module["tieude_usg"];
$submenu['treat'] = $lang_module["treat_title"];
$submenu['vaccine'] = $lang_module["vaccine_title"];
$submenu['spa'] = $lang_module["spa_title"];
$submenu['drug'] = $lang_module["drug_title"];
$submenu['redrug'] = $lang_module["redrug_title"];
$submenu['schedule'] = $lang_module["schedule_title"];
$submenu['config'] = $lang_module["doctor_config"];

$allow_func = array('main', "disease", "patient", "customer", "doctor", "vaccine", "sieuam", "treat", "spa", "drug", "redrug", "schedule", "config"); 
