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

$STATUS_COLOR = array('white', 'yellow', 'red');

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

function adminDrugList($drugList) {
  global $db;

  $index = 0;

  $xtpl = new XTemplate("heal_drug_list.tpl", PATH);
  foreach ($drugList as $key => $row) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('unit', $row['unit']);
    $xtpl->assign('id', $row['id']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function healFilter($cometime, $calltime, $customer, $pet) {
  global $db;

  $xtpl = new XTemplate("heal-list.tpl", PATH);

  $cometime = totime($cometime);
  $calltime = totime($calltime);

  $sqlQuery = '';
  $queryType = 0;
  if (!empty($pet) && $pet > 0) {
    $sqlQuery = 'where id = ' . $pet;
  }
  else if (!empty($customer) && $customer > 0) {
    $sqlQuery = 'where customerid = ' . $customer;
  }

  $sql = 'select * from  `'. VAC_PREFIX .'_heal` where (time between '. $cometime .' and '. $calltime .') and petid in (select id from `'. VAC_PREFIX .'_pet` '. $sqlQuery .') order by time desc';

  $query = $db->query($sql);
  $count = 0;
  $index = 1;
  while ($heal = $query->fetch()) {
    $count ++;
    $drug = implode(', ', getDrugIdList($heal['id']));
    $pet = selectPetId($heal['petid']);
    $customer = selectCustomerId($pet['customerid']);
    $xtpl->assign('id', $heal['id']);
    $xtpl->assign('time', date('d/m', $heal['time']));
    // die(var_dump($pet));
    $xtpl->assign('system', implode(', ', $heal['system']));
    $xtpl->assign('doctor', selectDoctorId($heal['doctorid'])['first_name']);
    $xtpl->assign('class', $STATUS_COLOR[$pet['status']]);
    $xtpl->assign('customer', $customer['name']);
    $xtpl->assign('petname', $pet['name']);
    $xtpl->assign('oriental', $heal['oriental']);
    $xtpl->assign('drug', $drug);
    $xtpl->assign('nav', navList($count['id'], $page, $limit));
    $xtpl->parse('main.row');
  }

  $xtpl->assign('total', $count);

  $xtpl->parse('main');
  return $xtpl->text();
}

function healList($page, $limit, $customer = 0, $pet = 0, $status = 0, $gdoctor) {
  global $db, $STATUS_COLOR, $vacconfigv2;
  $xtpl = new XTemplate("heal-list.tpl", PATH);

  if (!($page > 0)) $page = 1;
  // if (!($insult > 0)) $insult = 0;
  if (!($limit > 0)) $limit = 10;

  $today = strtotime(date('Y-m-d'));
  if (empty($vacconfigv2['heal']) || $vacconfigv2['heal'] < 10000) {
    $vacconfigv2['heal'] = 60 * 60 * 24 * 7;
  }
  $cometime = $today - $vacconfigv2['heal'];
  $calltime = $today + $vacconfigv2['heal'];

  $extraQuery = '';
  if (!empty($gdoctor)) {
    $extraQuery = 'and doctorid = ' . $gdoctor;
  }

  $sql = 'select * from `'. VAC_PREFIX .'_heal` where (time between '. $cometime .' and '. $calltime .') and petid in (select id from `'. VAC_PREFIX .'_pet` where status = ' . $status . ') '.$extraQuery.' order by time desc limit '. $limit .' offset '. (($page - 1) * $limit);
  $sql2 = 'select count(id) as id from `'. VAC_PREFIX .'_heal` where (time between '. $cometime .' and '. $calltime .') and petid in (select id from `'. VAC_PREFIX .'_pet` where status = ' . $status . ') '.$extraQuery.'';

  if (!empty($customer)) {
    if (!empty($pet)) {
      $sql = 'select * from `'. VAC_PREFIX .'_heal` where petid = '.$pet.' and (time between '. $cometime .' and '. $calltime .') and petid in (select id from `'. VAC_PREFIX .'_pet` where status = ' . $status . ') '.$extraQuery.' order by time desc limit '. $limit .' offset '. (($page - 1) * $limit);
      $sql2 = 'select count(id) as id from `'. VAC_PREFIX .'_heal` where petid = '.$pet.' and (time between '. $cometime .' and '. $calltime .') and petid in (select id from `'. VAC_PREFIX .'_pet` where status = ' . $status . ') '.$extraQuery.'';
    }
    else {
      $sql = 'select * from `'. VAC_PREFIX .'_heal` where petid in (select id from `'.VAC_PREFIX.'_pet` where customerid = '.$customer.') and (time between '. $cometime .' and '. $calltime .') and petid in (select id from `'. VAC_PREFIX .'_pet` where status = ' . $status . ') '.$extraQuery.' order by time desc limit '. $limit .' offset '. (($page - 1) * $limit);
      $sql2 = 'select count(id) as id from `'. VAC_PREFIX .'_heal` where petid in (select id from `'.VAC_PREFIX.'_pet` where customerid = '.$customer.') and (time between '. $cometime .' and '. $calltime .') and petid in (select id from `'. VAC_PREFIX .'_pet` where status = ' . $status . ') '.$extraQuery.'';
    }
  }
  $query = $db->query($sql2);
  $count = $query->fetch();
  $xtpl->assign('total', $count['id'] ? $count['id'] : 0);
  
  $query = $db->query($sql);
  $index = 1;
  while ($heal = $query->fetch()) {
    $drug = implode(', ', getDrugIdList($heal['id']));
    $pet = selectPetId($heal['petid']);
    $customer = selectCustomerId($pet['customerid']);
    $xtpl->assign('id', $heal['id']);
    $xtpl->assign('time', date('d/m', $heal['time']));
    $xtpl->assign('system', parseSystemId($heal['id']));
    $xtpl->assign('doctor', selectDoctorId($heal['doctorid'])['first_name']);
    $xtpl->assign('class', $STATUS_COLOR[$pet['status']]);
    $xtpl->assign('customer', $customer['name']);
    $xtpl->assign('petname', $pet['name']);
    $xtpl->assign('oriental', $heal['oriental']);
    $xtpl->assign('drug', $drug);
    $xtpl->assign('nav', navList($count['id'], $page, $limit));
    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function permissionContent($module) {
  global $db, $db_config;

  $xtpl = new XTemplate("permission_list.tpl", PATH);
  $sql = 'select * from `'. $db_config['prefix'] .'_users_groups`';
  $query = $db->query($sql);

  foreach ($module as $key => $value) {
    $xtpl->assign('module', $value);
    $xtpl->parse('main.module');
  }

  while ($group = $query->fetch()) {
    $xtpl->assign('group', $group['title']);
    $xtpl->assign('groupid', $group['group_id']);
    foreach ($module as $key => $value) {
      $sql = 'select * from `'.VAC_PREFIX.'_heal_manager` where groupid = ' . $group['group_id'] . ' and type = ' . $key;
      $query2 = $db->query($sql);
      if ($query2->fetch()) {
        $xtpl->assign('check', 'checked');
      }
      else {
        $xtpl->assign('check', '');
      }
      $xtpl->assign('moduleid', $key);
      $xtpl->parse('main.row.module2');
    }
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  
  return $xtpl->text();
}

function navList ($number, $page, $limit) {
  global $lang_global;
  $total_pages = ceil($number / $limit);
  $on_page = $page;
  $page_string = "";
  if ($total_pages > 10) {
    $init_page_max = ($total_pages > 3) ? 3 : $total_pages;
    for ($i = 1; $i <= $init_page_max; $i ++) {
      $page_string .= ($i == $on_page) ? '<div class="btn">' . $i . "</div>" : '<button class="btn btn-info" onclick="goPage('.$i.')">' . $i . '</button>';
      if ($i < $init_page_max) $page_string .= " ";
    }
    if ($total_pages > 3) {
      if ($on_page > 1 && $on_page < $total_pages) {
        $page_string .= ($on_page > 5) ? " ... " : ", ";
        $init_page_min = ($on_page > 4) ? $on_page : 5;
        $init_page_max = ($on_page < $total_pages - 4) ? $on_page : $total_pages - 4;
        for ($i = $init_page_min - 1; $i < $init_page_max + 2; $i ++) {
          $page_string .= ($i == $on_page) ? '<div class="btn">' . $i . "</div>" : '<button class="btn btn-info" onclick="goPage('.$i.')">' . $i . '</button>';
          if ($i < $init_page_max + 1)  $page_string .= " ";
        }
        $page_string .= ($on_page < $total_pages - 4) ? " ... " : ", ";
      }
      else {
        $page_string .= " ... ";
      }
      
      for ($i = $total_pages - 2; $i < $total_pages + 1; $i ++) {
        $page_string .= ($i == $on_page) ? '<div class="btn">' . $i . "</div>" : '<button class="btn btn-info" onclick="goPage('.$i.')">' . $i . '</button>';
        if ($i < $total_pages) $page_string .= " ";
      }
    }
  }
  else {
    for ($i = 1; $i < $total_pages + 1; $i ++) {
      $page_string .= ($i == $on_page) ? '<div class="btn">' . $i . "</div>" : '<button class="btn btn-info" onclick="goPage('.$i.')">' . $i . '</button>';
      if ($i < $total_pages) $page_string .= " ";
    }
  }
  return $page_string;
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
