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

function summaryOn($starttime, $endtime) {
  global $db, $global_config, $module_file;
  $xtpl = new XTemplate("treat-summary.tpl", NV_ROOTDIR . "/themes/" . $global_config['module_theme'] . "/modules/" . $module_file);
  $xtpl->assign('starttime', date('d/m/Y', $starttime));
  $xtpl->assign('endtime', date('d/m/Y', $endtime));

  $sql = 'select * from `'.VAC_PREFIX.'_treat` where cometime between '. $starttime .' and '. $endtime;
  $query = $db->query($sql);
  $data = array(0, 0, 0);
  while ($treat = $query->fetch()) {
    $data[$treat['insult']] ++;
  }
  $rate1 = round(($data[1] + $data[2]) > 0 ? $data[1] * 100 / ($data[1] + $data[2]) : 0, 1);
  $rate2 = round(($data[0] + $data[1] + $data[2]) > 0 ? ($data[1] + $data[0]) * 100 / ($data[0] + $data[1] + $data[2]) : 0, 1);
  $xtpl->assign('total', $data[0] + $data[1] + $data[2]);
  $xtpl->assign('treating', $data[0]);
  $xtpl->assign('safe', $data[1]);
  $xtpl->assign('dead', $data[2]);
  $xtpl->assign('rate1', $rate1);
  $xtpl->assign('rate2', $rate2);
  $xtpl->parse('main');
  return $xtpl->text();
}

function healList($page, $limit, $cometime, $calltime, $customer = 0, $pet = 0) {
  global $db;
  $xtpl = new XTemplate("heal-list.tpl", PATH);

  if (!($page > 0)) $page = 1;
  // if (!($insult > 0)) $insult = 0;
  if (!($limit > 0)) $limit = 10;

  $sql = 'select count(id) as id from `'. VAC_PREFIX .'_heal` where (time between '. $cometime .' and '. $calltime .')';
  $query = $db->query($sql);
  $count = $query->fetch();
  $xtpl->assign('total', $count['id']);

  $sql = 'select * from `'. VAC_PREFIX .'_heal` where (time between '. $cometime .' and '. $calltime .') order by time desc limit '. $limit .' offset '. (($page - 1) * $limit);

  if (!empty($customer)) {
    if (!empty($pet)) {
      $sql = 'select * from `'. VAC_PREFIX .'_heal` where petid = '.$pet.' and (time between '. $cometime .' and '. $calltime .') order by time desc limit '. $limit .' offset '. (($page - 1) * $limit);
    }
    else {
      $sql = 'select * from `'. VAC_PREFIX .'_heal` where petid in (select id from `'.VAC_PREFIX.'_pet` where customerid = '.$customer.') and (time between '. $cometime .' and '. $calltime .') order by time desc limit '. $limit .' offset '. (($page - 1) * $limit);
    }
  }

  $query = $db->query($sql);
  $index = 1;
  while ($heal = $query->fetch()) {
    $drug = implode(', ', getDrugIdList($heal['id']));
    $pet = selectPetId($heal['petid']);
    $customer = selectCustomerId($pet['customerid']);
    $xtpl->assign('id', $heal['id']);
    $xtpl->assign('time', date('d/m', $heal['time']));
    $xtpl->assign('customer', $customer['name']);
    $xtpl->assign('petname', $pet['name']);
    $xtpl->assign('oriental', $heal['oriental']);
    $xtpl->assign('drug', $drug);
    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
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
