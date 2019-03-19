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

define("VAC_PATH", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/");
$hex = array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f");

if (!function_exists("vaccine_remind")) {
  function vaccine_remind() {
    global $module_file, $lang_module, $nv_Request, $vacconfigv2, $db, $hex;
    
    $today = strtotime(date("Y-m-d"));
    $page = $nv_Request->get_string('page', 'get/post', "");
    $id = $nv_Request->get_int('id', 'post/get', 0);
    $list = array();
    $now = strtotime(date("Y-m-d"));
    $index = 1;
    $status_array = array(0 => array(), 1 => array(), 2 => array(), 4 => array());

    $xtpl = new XTemplate("2_vaccine.tpl", VAC_PATH . $module_file);
    $xtpl->assign("lang", $lang_module);
    
    switch ($page) {
      case 'today':
        $end = $today + 60 * 60 * 24;
        $where = "where ctime between $today and $end";
      break;
      case 'retoday':
        $end = $today + 60 * 60 * 24;
        $where = "where calltime between $today and $end";
      break;
      default:
        // filter time
        $time = $vacconfigv2["filter"];
        if (empty($time)) {
          $time = 60 * 60 * 24 * 14;
        }
        $from = $today - $time;
        $end = $today + $time;
        $where = "where calltime between $from and $end";
    }
    
    $sql = "select a.id, a.note, a.recall, b.id as petid, b.name as petname, c.id as customerid, c.name as customer, c.phone as phone, cometime, calltime, ctime, status, diseaseid, dd.name as disease from " . VAC_PREFIX . "_vaccine a inner join " . VAC_PREFIX . "_pet b on a.petid = b.id inner join " . VAC_PREFIX . "_customer c on b.customerid = c.id $where and status = $id order by calltime";
    $query = $db->query($sql);
    $list = fetchall($db, $query);
  
    // page
    $sort_by = "calltime";
    if ($page == "today") {
      $sort_by = "cometime";
    }
    
    // divide into 3 part
    foreach ($list as $key => $row) {
      $status_array[$row["status"]][] = $key;
    }
    krsort($status_array);
  
    // sort by calltime
    $t_list = array();
    foreach ($status_array as $akey => $status_list) {
      $price = array();
      foreach ($status_list as $lkey => $status_row) {
        $price[$status_row] = $list[$status_row][$sort_by];
      }
      if ($akey == "0") {
        $sort_order_left = array();
        $sort_order_right = array();
        foreach ($price as $lkey => $status_row) {
          if ($row[$sort_by] < $now) {
            $sort_order_right[] = $lkey;
          }
          else {
            $sort_order_left[] = $lkey;
          }
        }
        asort($sort_order_left);
        arsort($sort_order_right);
        $sort = array();
        $sort = array_merge($sort_order_left, $sort_order_right);
        $t_list = array_merge($t_list, $sort);
      }
      else {
        arsort($price);
        foreach ($price as $key => $value) {
          $t_list[] = $key;
        }
      }
    }
  
    // display
    foreach ($t_list as $key => $value) {
      $xtpl->assign("index", $index);
      $xtpl->assign("petname", $list[$value]["petname"]);
      $xtpl->assign("petid", $list[$value]["petid"]);
      $xtpl->assign("vacid", $list[$value]["id"]);
      $xtpl->assign("customer", $list[$value]["customer"]);
      $xtpl->assign("phone", $list[$value]["phone"]);
      $xtpl->assign("diseaseid", );
      $xtpl->assign("disease", $disease[$list[$value]["diseaseid"]]["name"]);
      $xtpl->assign("note", $list[$value]["note"]);
      $xtpl->assign("confirm", $lang_module["confirm_" . $list[$value]["status"]]);
  
      if ($list[$value]["status"] > 1) {
        $xtpl->parse("main.row.recall");
      }
      switch ($list[$value]["status"]) {
        case '1':
          $xtpl->assign("color", "orange");
          break;
        case '2':
          $xtpl->assign("color", "green");
          break;
        case '4':
          $xtpl->assign("color", "gray");
          break;
        default:
          $xtpl->assign("color", "red");
          break;
      }
      $xtpl->assign("cometime", date("d/m/Y", $list[$value]["cometime"]));
      $xtpl->assign("calltime", date("d/m/Y", $list[$value]["calltime"]));
      $index++;
      $xtpl->parse("main.recall");
    }

    $xtpl->parse("main");
    return $xtpl->text();
  }
}

// include_once(NV_ROOTDIR . "/modules/" . $module_file . "/modal/spa.php");
// $spa = new Spa();
// include_once(NV_ROOTDIR . "/modules/" . $module_file . "/modal/doctor.php");
// $doctor = new Doctor();
// include_once(NV_ROOTDIR . "/modules/" . $module_file . "/modal/customer.php");
// $customer = new Customer();

// function spa_list($data_content, $compare_id, $html_pages = '') {
//     global $spa, $doctor, $customer, $pet, $module_info, $lang_module, $module_file;
//     $xtpl = new XTemplate('spa-list.tpl', NV_ROOTDIR . '/themes/' . $module_info['template'] . '/modules/' . $module_file);
//     $index = 1;
//     $spa_list = $spa->get_list();
//     $doctor_list = $doctor->get_list();
//     $xtpl->assign('lang', $lang_module);

//     foreach ($spa_list as $spa_data) {
//         $customer = $customer->get_by_id($spa_data["id"]);
//         $xtpl->assign("index", $index);
//         $xtpl->assign("doctor", $doctor_list[$spa_data["doctorid"]]);
//         $xtpl->assign("customer_name", $customer["name"]);
//         $xtpl->assign("customer_number", $customer["phone"]);
//         $xtpl->assign("status", $lang_module["spa_status"][$spa_data["status"]]);

//         $index ++;
//     }

//     $xtpl->parse('main');
//     return $xtpl->text('main');
//     return 1;
// }
