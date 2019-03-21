<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2017 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 04/18/2017 09:47
 */

if (!defined('VAC_PREFIX')) {
  die('Stop!!!');
}

function vaccineRemind($keyword, $fromtime, $totime) {
  global $db, $nv_Request, $module_info, $module_file, $lang_module, $vacconfigv2; 
  $xtpl = new XTemplate("overmind_vaccine.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
  // $sql = "select a.id, a.calltime, c.phone, c.name as customer from `" . VAC_PREFIX . "_vaccine` a inner join `" . VAC_PREFIX . "_pet` b on a.petid = b.id inner join `" . VAC_PREFIX . "_customer` c on b.customerid = c.id where (b.name like '%?%' or c.name like '%?%' or c.phone like '%?%') and a.calltime between ? and ?";
  // $stmt = $db->prepare($sql);
  // $stmt->execute(array($keyword, $keyword, $keyword, $fromtime, $totime));

  $sql = "select a.id, a.calltime, c.phone, c.name as customer from `" . VAC_PREFIX . "_vaccine` a inner join `" . VAC_PREFIX . "_pet` b on a.petid = b.id inner join `" . VAC_PREFIX . "_customer` c on b.customerid = c.id where (b.name like '%$keyword%' or c.name like '%$keyword%' or c.phone like '%$keyword%') and a.calltime between $fromtime and $totime";
  $query = $db->query($sql);

  $index = 1;
  // while ($row = $stmt->fetch()) {
  while ($row = $query->fetch()) {
    $calltime = date("d/m/Y", $row["calltime"]);
    $xtpl->assign("index", $index ++);
    $xtpl->assign("id", $row["id"]);
    $xtpl->assign("customer", $row["customer"]);
    $xtpl->assign("phone", $row["phone"]);
    $xtpl->assign("calltime", $calltime);
    $xtpl->parse("main.row");
  }
  $xtpl->parse("main");
  return $xtpl->text();
}

// include_once(NV_ROOTDIR . "/modules/" . $module_file . "/modal/spa.php");
// $spa = new Spa();
// include_once(NV_ROOTDIR . "/modules/" . $module_file . "/modal/doctor.php");
// $doctor = new Doctor();
// include_once(NV_ROOTDIR . "/modules/" . $module_file . "/modal/customer.php");
// $customer = new Customer();

// function spa_list($data_content, $compare_id, $html_pages = '') {
//   global $spa, $doctor, $customer, $pet, $module_info, $lang_module, $module_file;
//   $xtpl = new XTemplate('spa-list.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);
//   $index = 1;
//   $spa_list = $spa->get_list();
//   $doctor_list = $doctor->get_list();
//   $xtpl->assign('lang', $lang_module);

//   foreach ($spa_list as $spa_data) {
//     $customer = $customer->get_by_id($spa_data["id"]);
//     $xtpl->assign("index", $index);
//     $xtpl->assign("doctor", $doctor_list[$spa_data["doctorid"]]);
//     $xtpl->assign("customer_name", $customer["name"]);
//     $xtpl->assign("customer_number", $customer["phone"]);
//     $xtpl->assign("status", $lang_module["spa_status"][$spa_data["status"]]);

//     $index ++;
//   }

//   $xtpl->parse('main');
//   return $xtpl->text('main');
//   return 1;
// }
