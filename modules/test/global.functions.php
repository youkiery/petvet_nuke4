<?php

/**
 * @Project NUKEVIecET-MUSIC
 * @Author Phan Tan Dung (phantandung92@gmail.com)
 * @copyright 2011
 * @createdate 26/01/2011 09:17 AM
 */

// die();
if (!defined('NV_MAINFILE')) {
	die('Stop!!!');
}
define('VAC_PREFIX', $db_config['prefix'] . "_" . $module_name);
define('NV_NEXTMONTH', 30 * 24 * 60 * 60);
define('NV_NEXTWEEK', 7 * 24 * 60 * 60);
define('BLOCK', NV_ROOTDIR . '/modules/' . $module_file . '/template/block/');
$datetime = array(1 => "Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7", "CN");

$status_option = array("Bình thường", "Hơi yếu", "Yếu", "Sắp chết");
$export = array("Lưu bệnh", "Xuất viện", "Đã chết");

$sql = "select * from `" . VAC_PREFIX . "_config`";
$query = $db->query($sql);
$vacconfig = $query->fetch();

$sql = "select * from `" . VAC_PREFIX . "_configv2`";
$query = $db->query($sql);
$vacconfigv2 = array();
while ($row = $query->fetch()) {
  $vacconfigv2[$row["name"]] = $row["value"];
}

function updateImage($image, $id) {
  global $db;

  if (!empty($image)) {
    $sql = 'select * from `'. VAC_PREFIX .'_heal` where id = ' . $id;
    die($sql);
    $query = $db->query($sql);
  
    if (empty($row = $query->fetch()) || $row['image'] != $image) {
      $sql = 'update `'. VAC_PREFIX .'_heal` set image = "'. $image .'" where id = ' . $id;
      $db->query($sql);
    }
  }
}

function updateImagev2($image, $id, $path) {
  global $db;

  if (!empty($image)) {
    $sql = 'select * from `'. $path .'` where id = ' . $id;
    $query = $db->query($sql);
  
    if (empty($row = $query->fetch()) || $row['image'] != $image) {
      $sql = 'update `'. $path .'` set image = "'. $image .'" where id = ' . $id;
      $db->query($sql);
    }
  }
}

function selectCustomerId($customerid) {
  global $db;
  $sql = 'select * from `'. VAC_PREFIX .'_customer` where id = '. $customerid;
  $query = $db->query($sql);
  $customer = $query->fetch();
  return $customer;
}

function selectPetId($petid) {
  global $db;
  $sql = 'select * from `'. VAC_PREFIX .'_pet` where id = '. $petid;
  $query = $db->query($sql);
  $pet = $query->fetch();
  return $pet;
}

function diseaseList() {
  global $db;

  $list = array();
  $sql = 'select * from `'. VAC_PREFIX .'_heal_disease`';
  $query = $db->query($sql);

  while ($disease = $query->fetch()) {
    $list[$disease['id']] = $disease['name'];
  }

  return $list;
}

function getDiseaseList() {
  global $db, $db_config, $module_name;
  $sql = "select * from " . VAC_PREFIX . "_disease";
  $result = $db->query($sql);
  return fetchall($db, $result);
}

function getDiseaseData() {
  global $db;

  $list = array();
  $sql = "select * from " . VAC_PREFIX . "_disease";
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $list[$row['id']] = $row['name'];
  }
  return $list;
}

function getCustomerList($key, $sort, $filter, $page) {
  global $db, $db_config, $module_name;
  $order = "order by name ";
  if ($sort == 1)
    $order .= "asc";
  else
    $order .= "desc";
  $from_item = ($page - 1) * $filter;
  $end_item = $from_item + $filter;

  $customers = array();
  $customers["data"] = array();

  $sql = "select count(id) as num from " . VAC_PREFIX . "_customer where name like '%$key%' or phone like '%$key%'";
  $result = $db->query($sql);
  $num = $result->fetch();
  $customers["info"] = $num["num"];

  $sql = "select id, name as customer, phone, address from " . VAC_PREFIX . "_customer where name like '%$key%' or phone like '%$key%' " . $order . " limit $from_item, $end_item";
  $result = $db->query($sql);
  while ($row = $result->fetch()) {
    $customers["data"][] = $row;
  }
  return $customers;
}

function getVaccineTable($path, $lang, $key, $sort, $time) {
  // next a week
  global $db, $module_name, $lang_module;
  $fromtime = strtotime(date("Y-m-d", NV_CURRENTTIME)) - $time;
  $endtime = $fromtime + 2 * $time;
  $link = NV_BASE_ADMINURL . "index.php?" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=";

  $sort_type[1] = 'order by calltime asc';
  $sort_type[2] = 'order by calltime desc';
  $sort_type[3] = 'order by cometime asc';
  $sort_type[4] = 'order by cometime desc';

  if ($sort_type[$sort])
    $order = $sort_type[$sort];
  else
    $order = "";
  $xtpl = new XTemplate("main-1.tpl", $path);
  $xtpl->assign("lang", $lang);

    $sql = "SELECT a.id, p.id as petid, a.status, p.name as petname, c.id as customerid, c.name as customer, c.phone, cometime, calltime, a.status, dd.name as disease, d.name as doctor FROM " . VAC_PREFIX . "_vaccine a inner join " . VAC_PREFIX . "_disease dd on calltime between " . $fromtime . " and " . $endtime . " and a.diseaseid = dd.id inner join " . VAC_PREFIX . "_pet p on a.petid = p.id inner join " . VAC_PREFIX . "_customer c on p.customerid = c.id inner join " . VAC_PREFIX . "_doctor d on a.doctorid = d.id where c.name like '%$key%' or phone like '%$key%' " . $order;
    $result = $db->query($sql);
    $sql = "SELECT a.id, p.id as petid, a.status, p.name as petname, c.id as customerid, c.name as customer, c.phone, cometime, calltime, a.status, dd.name as disease, d.name as doctor FROM " . VAC_PREFIX . "_vaccine a inner join (select 0 as id, 'Siêu Âm' as name from DUAL) dd on calltime between " . $fromtime . " and " . $endtime . " and a.diseaseid = dd.id inner join " . VAC_PREFIX . "_pet p on a.petid = p.id inner join " . VAC_PREFIX . "_customer c on p.customerid = c.id inner join " . VAC_PREFIX . "_doctor d on a.doctorid = d.id where c.name like '%$key%' or phone like '%$key%' " . $order;
    $result2 = $db->query($sql);
    $vaccines = array();

    while ($row = $result->fetch()) {
      $vaccines[] = $row;
    }
    while ($row = $result2->fetch()) {
      $vaccines[] = $row;
    }

    $i = 1;
    foreach ($vaccines as $vac_index => $vac_data) {
      $xtpl->assign("index", $i);
      $xtpl->assign("petname", $vac_data["petname"]);
      $xtpl->assign("customer", $vac_data["customer"]);
      $xtpl->assign("pet_link", $link . "patient&petid=" . $vac_data["petid"]);
      $xtpl->assign("customer_link", $link . "customer&customerid=" . $vac_data["customerid"]);
      $xtpl->assign("phone", $vac_data["phone"]);
      $xtpl->assign("disease", $vac_data["disease"]);
      $xtpl->assign("confirm", $lang_module["confirm_value"][$vac_data["status"]]);
      $xtpl->assign("doctor", $vac_data["doctor"]);
      $xtpl->assign("cometime", date("d/m/Y", $vac_data["cometime"]));
      $xtpl->assign("calltime", date("d/m/Y", $vac_data["calltime"]));
      $i++;
      $xtpl->parse("main.disease.vac_body");
    }

    $xtpl->parse("main.disease");
  $xtpl->parse("main");


  // $sql = "select a.id, b.id as petid, b.petname, c.id as customerid, c.customer, c.phone as phone, cometime, calltime, status from " . VAC_PREFIX . "_" . $id . " a inner join " . VAC_PREFIX . "_pet b on calltime between " . $time . " and " . $next_time . " and a.petid = b.id inner join " . VAC_PREFIX . "_customer c on b.customerid = c.id" . $order;

  return $xtpl->text("main");
}

function getdoctorlist($daily = 0) {
  global $db, $db_config;
  $xtra = '';
  if ($daily) $xtra = 'where daily = 1';
  $sql = "select b.userid, b.username, b.first_name, b.last_name, concat(b.last_name, ' ', b.first_name) as fullname, a.manager, a.except from " . VAC_PREFIX . "_user a inner join `". $db_config['prefix'] ."_users` b on a.userid = b.userid ". $xtra;

  $result = $db->query($sql);
  $doctor = array();

  while ($row = $result->fetch()) {
    $doctor[] = $row;
  }
  return $doctor;
}

function getdoctorlist2() {
  global $db, $db_config;
  $sql = "select userid, username, first_name, last_name, concat(last_name, ' ', first_name) as fullname from " . $db_config['prefix'] . "_users";

  $result = $db->query($sql);
  $doctor = array();

  while ($row = $result->fetch()) {
    $doctor[$row['userid']] = $row;
  }
  return $doctor;
}

function wconfirm($date) {
  global $db, $userList;

  $startDate = date ('N', $date) == 1 ? strtotime(date('Y-m-d', $date)) : strtotime('last monday', $date);
  $endDate = strtotime('next monday', $date);
  $xtpl = new XTemplate("ad_schedule_list.tpl", PATH2);

  $xtpl->assign("from", date("d/m/Y", $startDate));
  $xtpl->assign("to", date("d/m/Y", $endDate - 1));
  $xtpl->assign("c2", date("d/m", $startDate));
  $xtpl->assign("c3", date("d/m", $startDate + A_DAY));
  $xtpl->assign("c4", date("d/m", $startDate + A_DAY * 2));
  $xtpl->assign("c5", date("d/m", $startDate + A_DAY * 3));
  $xtpl->assign("c6", date("d/m", $startDate + A_DAY * 4));
  $xtpl->assign("c7", date("d/m", $startDate + A_DAY * 5));
  $xtpl->assign("c8", date("d/m", $startDate + A_DAY * 6));

  $index = 1;
  foreach ($userList as $row) {
    $xtpl->assign("index", $index ++);
    $xtpl->assign("username", $row["first_name"]);
    $currentDate = $startDate;
    $indexRou = 2;
    $t = array(1 => 0, 0);

    while ($indexRou > 1) {
      if ($indexRou > 7) {
        $indexRou = 0;
      }
      $sql = "select * from `" .VAC_PREFIX . "_row` where time = $currentDate and user_id = $row[userid] and type > 1 order by time, type asc";
      $query2 = $db->query($sql);

      $xtpl->assign("color_" . $indexRou . "1", "green");
      $xtpl->assign("color_" . $indexRou . "2", "green");
      $xtpl->assign("date_" . $indexRou . "1", $currentDate);
      $xtpl->assign("date_" . $indexRou . "2", $currentDate);
      $xtpl->assign("type_" . $indexRou . "1", 2);
      $xtpl->assign("type_" . $indexRou . "2", 3);
      while ($rou = $query2->fetch()) {
        $xtpl->assign("color_" . $indexRou . ($rou["type"] - 1), "red");
        $t[$rou["type"] - 1] ++;
      }
      $indexRou += 1;
      $currentDate += A_DAY;
    }
    $xtpl->assign("t1", $t[1]);
    $xtpl->assign("t2", $t[2]);
    $xtpl->assign("t", $t[1] + $t[2]);
    $xtpl->parse("main.row");
  }
  
  $xtpl->parse("main");
  return $xtpl->text();
}

function getcustomer($customer, $phone) {
  global $db;
  if (!empty($customer)) {
    $sql = "select * from `" . VAC_PREFIX . "_customer` where name like '%$customer%' limit 20";
  } else {
    $sql = "select * from `" . VAC_PREFIX . "_customer` where phone like '%$phone%' limit 20";
  }

  $result = $db->query($sql);
  $ret = array();
  while ($row = $result->fetch()) {
    $ret[] = $row;
  }
  return $ret;
}

function getPatientsList($key, $sort, $filter, $page) {
  global $db;
  $patients = array();
  $patients["data"] = array();

  if ($sort / 2 <= 1)
    $order = "order by petname ";
  else
    $order = "order by customer ";
  if ($sort == 1)
    $order .= "asc";
  else
    $order .= "desc";
  $from_item = ($page - 1) * $filter;
  $end_item = $from_item + $filter;

  $sql = "select count(b.id) as num from " . VAC_PREFIX . "_pet b inner join " . VAC_PREFIX . "_customer c on b.customerid = c.id where c.name like '%$key%' or b.name like '%$key%'";
  $result = $db->query($sql);
  $num = $result->fetch();
  $patients["info"] = $num["num"];
  // var_dump($patients["info"]);

  $sql = "select b.id, b.name as petname, c.id as customerid, c.name as customer, c.phone from " . VAC_PREFIX . "_pet b inner join " . VAC_PREFIX . "_customer c on b.customerid = c.id where c.name like '%$key%' or b.name like '%$key%' or c.phone like '%$key%' " . $order . " limit $from_item, $end_item";
  $result = $db->query($sql);
  while ($row = $result->fetch()) {
    $patients["data"][] = $row;
  }
  // var_dump($patients);
  return $patients;
}

function getPatientsList2($customerid) {
  global $db;
  $sql = "select name as customer, phone, address from " . VAC_PREFIX . "_customer where id = $customerid";
  $result = $db->query($sql);
  $patients = $result->fetch();
  $patients["data"] = array();
  $sql = "select name as petname, id from " . VAC_PREFIX . "_pet where customerid = $customerid";
  $result = $db->query($sql);
  $ax = array();
  while ($row = $result->fetch()) {
    $ax[] = $row;
  }
  foreach ($ax as $row) {
    $petid = $row["id"];
    $sql = "SELECT v.cometime, v.calltime, dd.name as disease from " . VAC_PREFIX . "_vaccine v inner join " . VAC_PREFIX . "_pet p on  v.petid = " . $petid . " and v.petid = p.id inner join " . VAC_PREFIX . "_customer c on p.customerid = c.id inner join " . VAC_PREFIX . "_disease dd on v.diseaseid = dd.id order by v.id desc";
    $query = $db->query($sql);
    $crow = $query->fetch();
    $sql = "SELECT v.cometime, v.calltime, dd.name as disease from " . VAC_PREFIX . "_vaccine v inner join " . VAC_PREFIX . "_pet p on  v.petid = " . $petid . " and v.petid = p.id inner join " . VAC_PREFIX . "_customer c on p.customerid = c.id inner join (select 0 as id, 'Siêu Âm' as name from DUAL) dd on v.diseaseid = dd.id order by v.id desc";
    $query2 = $db->query($sql);
    $crow2 = $query->fetch();

    if ($crow["cometime"] > $crow2["cometime"]) {
        $data = $crow;
    }
    else {
        $data = $crow2;
    }
    if ($data) {
      $patients["data"][] = array("petid" => $row["id"], "petname" => $row["petname"], "lastcome" => $crow["calltime"], "lastname" => $crow["disease"]);
    } else {
      $patients["data"][] = array("petid" => $row["id"], "petname" => $row["petname"], "lastcome" => "", "lastname" => "");
    }
  }
  // ();
  return $patients;
}

function getPatientDetail($petid) {
  global $db;
  $sql = "select b.name as petname, c.name as customer, c.phone from " . VAC_PREFIX . "_pet b inner join " . VAC_PREFIX . "_customer c on b.id = $petid and b.customerid = c.id";
  $result = $db->query($sql);
  $patients = $result->fetch();

  $sql = "select v.*, dd.name as disease, dd.id as diseaseid from " . VAC_PREFIX . "_vaccine v inner join " . VAC_PREFIX . "_disease dd on v.diseaseid = dd.id and petid = $petid";
  $result = $db->query($sql);
  $sql = "select v.*, dd.name as disease, dd.id as diseaseid from " . VAC_PREFIX . "_vaccine v inner join (select 0 as id, 'Siêu Âm' as name from DUAL) dd on v.diseaseid = dd.id and petid = $petid";
  $result2 = $db->query($sql);
  $data = fetchall($db, $result);
  $data2 = fetchall($db, $result2);
  $patients["data"] = array_merge($data, $data2);
  
  return $patients;
}

function user_vaccine($keyword = '') {
  global $nv_Request, $db, $vacconfigv2;
  // initial
  $today = strtotime(date("Y-m-d"));
  $page = $nv_Request->get_string('page', 'get/post', "");
  $id = $nv_Request->get_int('id', 'post/get', 0);
  $list = array();
  
  switch ($page) {
    case 'today':
      $end = $today + 60 * 60 * 24;
      $where = "where ctime between $today and $end and a.status = $id";
    break;
    case 'retoday':
      $end = $today + 60 * 60 * 24;
      $where = "where calltime between $today and $end and a.status = $id";
    break;
    case 'search-all':
      $where = '';
    break;
    default:
      // filter time
      $time = $vacconfigv2["filter"];
      if (empty($time)) {
        $time = 60 * 60 * 24 * 14;
      }
      $from = $today;
      $end = $today + $time;
      $where = "where calltime between $from and $end and a.status = $id";
  }
  
  $sql = "select a.id, a.note, a.recall, b.id as petid, b.name as petname, c.id as customerid, c.name as customer, c.phone as phone, cometime, calltime, ctime, a.status, diseaseid, dd.name as disease from " . VAC_PREFIX . "_vaccine a inner join " . VAC_PREFIX . "_pet b on a.petid = b.id inner join " . VAC_PREFIX . "_customer c on b.customerid = c.id inner join " . VAC_PREFIX . "_disease dd on a.diseaseid = dd.id $where and (c.name like '%$keyword%' or c.phone like '%$keyword%') order by calltime";
  // die($sql);
  $query = $db->query($sql);
  $list = fetchall($db, $query);
  return vaccine_list($list);
}

function spa_list() {
  global $db, $module_file, $lang_module, $global_config;
  $xtpl = new XTemplate("list.tpl", PATH2);
  $status = array("Chưa xong", "Đã xong");
  $from = strtotime(date("Y-m-d"));
  $end = $from + 60 * 60 * 24;
  $index = 1;
  $image = "<img src='/themes/" . $global_config["site_theme"] . "/images/" . $module_file . "/payment.gif'>";
  $xtpl->assign("lang", $lang_module);

  $doctor_list = getdoctorlist();
  $doctor = array();
  foreach ($doctor_list as $row) {
    $doctor[$row["userid"]] = $row;
  }

  $sql = "select * from `" . VAC_PREFIX . "_spa` where time between $from and $end order by id";
  $query = $db->query($sql);
  while ($row = $query->fetch()) {
    $sql = "select * from `" . VAC_PREFIX . "_customer` where id = " . $row["customerid"];
    $customer_query = $db->query($sql);
    $customer = $customer_query->fetch();
    $xtpl->assign("index", $index);
    $xtpl->assign("color", '');
    $xtpl->assign("check_avai", '');
    $xtpl->assign("pay_avai", '');
    if ($row["done"] > 0) {
      $row["done"] = date("H:i:s", $row["done"]);
      $xtpl->assign("check_avai", 'disabled');
      $xtpl->assign("color", 'blue');
    }
    else {
      $row["done"] = $status[0];
    }
    if ($row["payment"]) {
      $xtpl->assign("pay_avai", 'disabled');
      $xtpl->assign("color", 'green');
    }
    else {
      $xtpl->assign("payment", "");
    }
    $xtpl->assign("id", $row["id"]);
    $xtpl->assign("spa_doctor", $doctor[$row["doctorid"]]["fullname"]);
    $xtpl->assign("customer_name", $customer["name"]);
    $xtpl->assign("customer_number", $customer["phone"]);
    $xtpl->assign("spa_from", date("H:i:s", $row["time"]));
    $xtpl->assign("note", $row["note"]);
    $xtpl->assign("spa_end", $row["done"]);
    $xtpl->assign("image", $row["image"]);
    $xtpl->parse("main.row");
    $index ++;
  }
  $xtpl->parse("main");
  $text = $xtpl->text();
  return $text;
}

function admin_spa() {
  global $db, $module_info, $module_file, $lang_module, $global_config;
  $xtpl = new XTemplate("spa-list.tpl", NV_ROOTDIR . "/themes/" . $global_config['module_theme'] . "/modules/" . $module_file);
  $status = array("Chưa xong", "Đã xong");
  $from = strtotime(date("Y-m-d"));
  $end = $from + 60 * 60 * 24;
  $index = 1;
  $xtpl->assign("lang", $lang_module);

  $sql = "select * from `" . VAC_PREFIX . "_doctor`";
  $doctor_query = $db->query($sql);
  $doctor = array();
  while ($doctor_row = $doctor_query->fetch()) {
    $doctor[$doctor_row["id"]] = $doctor_row;
  }

  $sql = "select * from `" . VAC_PREFIX . "_spa` order by id";
  $query = $db->query($sql);
  while ($row = $query->fetch()) {
    $sql = "select * from `" . VAC_PREFIX . "_customer` where id = " . $row["customerid"];
    $customer_query = $db->query($sql);
    $customer = $customer_query->fetch();
    $xtpl->assign("index", $index);
    // var_dump($doctor);
    // var_dump($row["doctorid"]);
    // die();
    if ($row["done"] > 0) {
      $row["done"] = date("H:i:s", $row["done"]);
    }
    else {
      $row["done"] = $status[0];
    }
    $xtpl->assign("id", $row["id"]);
    $xtpl->assign("spa_doctor", $doctor[$row["doctorid"]]["name"]);
    $xtpl->assign("customer_name", $customer["name"]);
    $xtpl->assign("customer_number", $customer["phone"]);
    $xtpl->assign("spa_from", date("H:i:s", $row["time"]));
    $xtpl->assign("spa_end", $row["done"]);
    $xtpl->parse("main");
    $index ++;
  }
  $text = $xtpl->text();
  return $text;
}

function adminSummary($startDate = 0, $endDate = 0) {
  global $db, $db_config;

  if (empty($startDate) || empty($endDate)) {
    $time = time();
    if (date('N', $time) < 23) {
      $time = time() - A_DAY * 23;
    }
    $startDate = strtotime(date("Y", $time) . "-" . date("m", $time) . "-24");
    $endDate = strtotime(date("Y", $time) . "-" . (intval(date("m", $time)) + 1) . "-23");
  }

  $xtpl = new XTemplate("summary.tpl", PATH2);
  $user = array();

  $sql = "select * from `" . $db_config["prefix"] . "_users` where userid in (select userid from `" .VAC_PREFIX . "_user`)";
  $query = $db->query($sql);

  $xtpl->assign("from", date("d/m/Y", $startDate));
  $xtpl->assign("to", date("d/m/Y", $endDate));

  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign("index", $index++);
    $xtpl->assign("username", $row["last_name"] . " " . $row["first_name"]);

    $sql = "select count(*) as num from `" .VAC_PREFIX . "_row` where time between $startDate and ".($endDate + A_DAY - 1)." and user_id = $row[userid] and type > 1";
    $query2 = $db->query($sql);
    $count = $query2->fetch();
    $sql = "select count(*) as num from `" .VAC_PREFIX . "_penety` where time between $startDate and ".($endDate + A_DAY - 1)." and userid = $row[userid]";
    $query2 = $db->query($sql);
    $count2 = $query2->fetch();
    // $count['num'] += $count2['num'];

    $sql2 = 'select time, type from `' .VAC_PREFIX . '_penety` where time between '. $startDate .' and '.($endDate + A_DAY - 1).' and userid = ' . $row['userid'];
    $query2 = $db->query($sql2);
    $list = array();
    while ($row2 = $query2->fetch()) {
      $list[] = $row2;
    }

    $total = round(($count2['num'] + $count['num']) / 2, 1);
    $xtpl->assign("rest", round($count['num'] / 2, 1));
    $xtpl->assign("overflow", round($count2['num'] / 2, 1));
    $xtpl->assign("data", json_encode($list));

    $xtpl->assign("total", $total);
    $xtpl->assign("exceed", $total > 4 ? $total - 4 : 0);
    $xtpl->parse("main.row");
  }
  
  $xtpl->parse("main");
  return $xtpl->text();
}

function scheduleList($startDate, $endDate) {
  global $db, $datetime;
  $xtpl = new XTemplate("schedule_list.tpl", PATH2);

  $userList = userList();
  $date = $startDate;
  $rest_list = array("morning_guard" => array(), "afternoon_guard" => array(), "morning_rest" => array(), "afternoon_rest" => array());

  $sql = "select * from `" . VAC_PREFIX . "_row` where `time` between $startDate and $endDate order by time, type asc, user_id";
  $query = $db->query($sql);
  $currentRow = $query->fetch();
  $count = 0;

  while ($count < 7) {
    $xtpl->assign("date", date("d/m/Y", $date));
    $xtpl->assign("day", $datetime[date("N", $date)]);

    if ($currentRow["time"] == $date) {
      switch ($currentRow["type"]) {
        case '0':
          $rest_list["morning_guard"][] = $userList[$currentRow["user_id"]]["first_name"];
          $xtpl->assign("morning_guard", implode(", ", $rest_list["morning_guard"]));
        break;
        case '1':
          $rest_list["afternoon_guard"][] = $userList[$currentRow["user_id"]]["first_name"];
          $xtpl->assign("afternoon_guard", implode(", ", $rest_list["afternoon_guard"]));
        break;
        case '2':
          $rest_list["morning_rest"][] = $userList[$currentRow["user_id"]]["first_name"];
          $xtpl->assign("morning_rest", implode(", ", $rest_list["morning_rest"]));
        break;
        case '3':
          $rest_list["afternoon_rest"][] = $userList[$currentRow["user_id"]]["first_name"];
          $xtpl->assign("afternoon_rest", implode(", ", $rest_list["afternoon_rest"]));
        break;
      }
      $currentRow = $query->fetch();
      $currentRow["time"] = strtotime(date("Y-m-d", $currentRow["time"]));
    }
    else {
      $rest_list = array("morning_guard" => array(), "afternoon_guard" => array(), "morning_rest" => array(), "afternoon_rest" => array());
      $date += A_DAY;
      $count ++;
      $xtpl->parse("main.row");
      $xtpl->assign("morning_guard", "");
      $xtpl->assign("afternoon_guard", "");
      $xtpl->assign("morning_rest", "");
      $xtpl->assign("afternoon_rest", "");
    }
  }  
  $xtpl->parse("main");
  return $xtpl->text();
}

function userList() {
  global $db, $db_config;
  $list = array();

  $sql = "select userid, username, last_name, first_name from `" .  $db_config["prefix"] . "_users`";
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $list[$row["userid"]] = $row;
  }

  return $list;
}
  
function nv_generate_page_shop($base_url, $num_items, $per_page, $start_item, $add_prevnext_text = true, $onclick = false, $js_func_name = 'nv_urldecode_ajax', $containerid = 'generate_page') {
  global $lang_global;
  $start_item = ($start_item - 1) * $per_page;

  $total_pages = ceil($num_items / $per_page);
  if ($total_pages == 1)
    return '';
  @$on_page = floor($start_item / $per_page) + 1;
  $amp = preg_match("/\?/", $base_url) ? "&amp;" : "?";
  $page_string = "";
  if ($total_pages > 10) {
    $init_page_max = ( $total_pages > 3 ) ? 3 : $total_pages;
    for ($i = 1; $i <= $init_page_max; $i ++) {
      $href = !$onclick ? "href=\"" . $base_url . $amp . "page=" . ( $i ) . "\"" : "href=\"javascript:void(0)\" onclick=\"" . $js_func_name . "('" . rawurlencode(nv_unhtmlspecialchars($base_url . $amp . "page=" . ( $i ))) . "','" . $containerid . "')\"";
      $page_string .= ( $i == $on_page ) ? "<strong>" . $i . "</strong>" : "<a " . $href . ">" . $i . "</a>";
      if ($i < $init_page_max)
        $page_string .= " ";
    }
    if ($total_pages > 3) {
      if ($on_page > 1 && $on_page < $total_pages) {
        $page_string .= ( $on_page > 5 ) ? " ... " : ", ";
        $init_page_min = ( $on_page > 4 ) ? $on_page : 5;
        $init_page_max = ( $on_page < $total_pages - 4 ) ? $on_page : $total_pages - 4;
        for ($i = $init_page_min - 1; $i < $init_page_max + 2; $i ++) {
          $href = !$onclick ? "href=\"" . $base_url . $amp . "page=" . ( $i ) . "\"" : "href=\"javascript:void(0)\" onclick=\"" . $js_func_name . "('" . rawurlencode(nv_unhtmlspecialchars($base_url . $amp . "page=" . ( $i ))) . "','" . $containerid . "')\"";
          $page_string .= ( $i == $on_page ) ? "<strong>" . $i . "</strong>" : "<a " . $href . ">" . $i . "</a>";
          if ($i < $init_page_max + 1) {
            $page_string .= " ";
          }
        }
        $page_string .= ( $on_page < $total_pages - 4 ) ? " ... " : ", ";
      } else {
        $page_string .= " ... ";
      }

      for ($i = $total_pages - 2; $i < $total_pages + 1; $i ++) {
        $href = !$onclick ? "href=\"" . $base_url . $amp . "page=" . ( $i ) . "\"" : "href=\"javascript:void(0)\" onclick=\"" . $js_func_name . "('" . rawurlencode(nv_unhtmlspecialchars($base_url . $amp . "page=" . ( $i ))) . "','" . $containerid . "')\"";
        $page_string .= ( $i == $on_page ) ? "<strong>" . $i . "</strong>" : "<a " . $href . ">" . $i . "</a>";
        if ($i < $total_pages) {
          $page_string .= " ";
        }
      }
    }
  } else {
    for ($i = 1; $i < $total_pages + 1; $i ++) {
      $href = !$onclick ? "href=\"" . $base_url . $amp . "page=" . ( $i ) . "\"" : "href=\"javascript:void(0)\" onclick=\"" . $js_func_name . "('" . rawurlencode(nv_unhtmlspecialchars($base_url . $amp . "page=" . ( $i - 1 ))) . "','" . $containerid . "')\"";
      $page_string .= ( $i == $on_page ) ? "<strong>" . $i . "</strong>" : "<a " . $href . ">" . $i . "</a>";
      if ($i < $total_pages) {
        $page_string .= " ";
      }
    }
  }
  // if ( $add_prevnext_text )
  // {
  //   if ( $on_page > 1 )
  //   {
  //   $href = ! $onclick ? "href=\"" . $base_url . $amp . "page=" . ( $on_page - 1 ) . "\"" : "href=\"javascript:void(0)\" onclick=\"" . $js_func_name . "('" . rawurlencode( nv_unhtmlspecialchars( $base_url . $amp . "page=" . ( $on_page - 2 ) ) ) . "','" . $containerid . "')\"";
  //   $page_string = "&nbsp;&nbsp;<span><a " . $href . ">" . $lang_global['pageprev'] . "</a></span>&nbsp;&nbsp;" . $page_string;
  //   }
  //   if ( $on_page < $total_pages )
  //   {
  //   $href = ! $onclick ? "href=\"" . $base_url . $amp . "page=" . ( $on_page ) . "\"" : "href=\"javascript:void(0)\" onclick=\"" . $js_func_name . "('" . rawurlencode( nv_unhtmlspecialchars( $base_url . $amp . "page=" . ( $on_page ) ) ) . "','" . $containerid . "')\"";
  //   $page_string .= "&nbsp;&nbsp;<span><a " . $href . ">" . $lang_global['pagenext'] . "</a></span>";
  //   }
  // }
  return $page_string;
}

function fetchall($db, $query) {
  $result = array();
  while ($row = $query->fetch()) {
      $result[] = $row;
  }
  return $result;
}

function totime($time) {
  if (preg_match("/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/", $time, $m)) {
    $time = mktime(0, 0, 0, $m[2], $m[1], $m[3]);
  }
  else {
    $time = time();
  }
  return $time;
}

function getUserList() {
  global $db, $db_config;

  $sql = 'select userid, first_name, last_name from `'. $db_config['prefix'] .'_users`';
  $query = $db->query($sql);
  $list = array();

  while ($row = $query->fetch()) {
    $list[$row['userid']] = $row;
  }
  return $list;
}

function checkRow($module, $id) {
  global $db;

  $sql = 'select * from `'. VAC_PREFIX .'_'. $module .'` where id = '. $id;
  $query = $db->query($sql);

  if ($row = $query->fetch()) {
    return $row;
  }
  return 0;
}

function getXrayTreat($xrayid)
{
  global $db;

  $sql = 'select * from `' . VAC_PREFIX . '_xray_row` where xrayid = ' . $xrayid;
  $query = $db->query($sql);
  $list = array();

  while ($row = $query->fetch()) {
    $row['image'] = explode(',', $row['image']);
    $list[] = $row;
  }
  return $list;
}

function getXrayTreatId($treatid)
{
  global $db;

  $sql = 'select * from `' . VAC_PREFIX . '_xray_row` where id = ' . $treatid;
  $query = $db->query($sql);
  $treat = $query->fetch();
  $treat['image'] = explode(',', $treat['image']);

  return $treat;
}

function getPetById($id)
{
  global $db;

  $sql = "select * from `". VAC_PREFIX ."_pet` where id = " . $id;
  $query = $db->query($sql);
  return $query->fetch();
}

function checkLastBlood() {
  global $db, $db_config, $module_name;

  $sql = 'select * from `'. $db_config['prefix'] .'_config` where config_name = "'. $module_name .'_blood_number"';
  $query = $db->query($sql);
  if (!empty($row = $query->fetch())) {
    return $row['config_value'];
  }
  $sql = 'insert into `'. $db_config['prefix'] .'_config` (lang, module, config_name, config_value) values ("sys", "site", "'. $module_name .'_blood_number", "1")';
  $db->query($sql);
  return 0;
}

function checkBloodRemind($name) {
  global $db;
  $targetid = 0;
  $sql = 'select * from `' . VAC_PREFIX . '_remind` where name = "blood" and value = "' . $name . '"';
  $query = $db->query($sql);
  if (!empty($row = $query->fetch())) {
    echo '1';
    $targetid = $row['id'];
  } else {
    echo '2';
    $sql = 'insert into `' . VAC_PREFIX . '_remind` (name, value) values ("blood", "' . $name . '")';
    if ($db->query($sql)) {
    echo '3';
    $targetid = $db->lastInsertId();
    }
  }
  return $targetid;
}

function updateBloodSample($data) {
  global $db, $db_config, $module_name;

  for ($i = 1; $i <= 3; $i++) {
    $sql = 'update `'. $db_config['prefix'] .'_config` set config_value = config_value + '. $data['number'. $i] .' where config_name = "'. $module_name .'_blood_sample_'. $i .'"';
    $db->query($sql);
  }
}

// source: string
// remove all char other than number
// return float
function parseNumber($number) {
  // convert , to .
  $number = str_replace(',', '.', $number);
  // remove leftover .
  $first = strpos($number, '.');
  $last = strpos($number, '.', $first + 1);
  if ($first !== false && $first !== $last) {
    $left = substr($number, 0, $first);
    $right = str_replace('.', '', substr($number, $first));
    $left = filterNumber($left);
    $right = filterNumber($right);
    $number = $left .'.'. $right;
  }

  return $number;
}

// source: string
// remove all char other than number
// return string of number
function filterNumber($number) {
  $length = strlen($number);
  for ($i = 0; $i < $length; $i++) { 
    if (!is_numeric($number[$i])) {
      $number = str_replace($number[$i], '', $number);
      $length = strlen($number);
      $i --;
    }
  }
  return $number;
}

function checkBloodSample() {
  global $db, $db_config, $module_name;

  $data = array();

  for ($i = 1; $i <= 3; $i++) { 
    $sql = 'select * from `'. $db_config['prefix'] .'_config` where config_name = "'. $module_name .'_blood_sample_'. $i .'"';
    $query = $db->query($sql);
    if (!empty($row = $query->fetch())) {
      $data['number' .$i] = $row['config_value'];
    }
    else {
      $sql = 'insert into `'. $db_config['prefix'] .'_config` (lang, module, config_name, config_value) values ("sys", "site", "'. $module_name .'_blood_sample_'. $i .'", "0")';
      $db->query($sql);
      $data['number'. $i] = 0;
    }
  }
  return $data;
}

function getRowId($id) {
  global $db;

  $query = $db->query('select * from `'. VAC_PREFIX .'_expire` where id = ' . $id);
  if ($row = $query->fetch()) {
    return $row;
  }
  return array();
}

function loadModal($file_name) {
  $xtpl = new XTemplate($file_name . '.tpl', PATH2);
  $xtpl->parse('main');
  return $xtpl->text();
}

function checkDeviceConfig() {
  global $db, $db_config;

  $sql = 'select * from `'. $db_config['prefix'] .'_config` where config_name = "device_config"';
  $query = $db->query($sql);
  if (empty($config = $query->fetch())) {
      // 2 weeks
      return 14;
  }
  return $config['config_value'];
}

function getDepartList() {
  global $db;

  $query = $db->query('select * from `'. VAC_PREFIX .'_device_depart`');
  $list = array();

  while($row = $query->fetch()) {
    $list []= $row;
  }
  return $list;
}

function getRemind() {
  global $db;

  $sql = 'select * from `'. VAC_PREFIX .'_remind` group by name order by rate desc';
  $query = $db->query($sql);
  $list = array();
  while ($row = $query->fetch()) {
    $list[$row['name']] = $row['value'];
  }
  return $list;
}

function getRemindv2() {
  global $db;

  $query = $db->query('select * from `'. VAC_PREFIX .'_remind`');
  $list = array();
  while ($row = $query->fetch()) {
    if (empty($list[$row['name']])) $list[$row['name']] = array();
    $list[$row['name']][] = $row['value'];
  }
  return $list;
}

function checkDeviceManagerId($id = 0) {
  global $db;

  $sql = 'select * from `'. VAC_PREFIX .'_device_manager` where id = '. $id;
  $query = $db->query($sql);
  if ($query->fetch()) {
    return true;
  }
  return false;
}

function getCategoryList() {
  global $db;

  $list = array();
  $query = $db->query('select * from `'. VAC_PREFIX .'_category` order by name');
  while ($row = $query->fetch()) {
    $list[] = $row;
  }
  return $list;
}

function checkItemName($name, $rid = 0) {
  global $db;

  if ($rid) {
    $query = $db->query('select * from `'. VAC_PREFIX .'_item` where name = "'. $name .'" and id = ' . $rid);
    if (!empty($query->fetch())) {
      return 0;
    }
  }
  $query = $db->query('select * from `'. VAC_PREFIX .'_item` where name = "'. $name .'"');
  if (!empty($query->fetch())) {
    return 1;
  }
  return 0;
}

function checkItemCode($name, $rid = 0) {
  global $db;

  if ($rid) {
    $query = $db->query('select * from `'. VAC_PREFIX .'_item` where code = "'. $name .'" and id = ' . $rid);
    if (!empty($query->fetch())) {
      return 0;
    }
  }
  $query = $db->query('select * from `'. VAC_PREFIX .'_item` where name = "'. $name .'"');
  if (!empty($query->fetch())) {
    return 1;
  }
  return 0;
}

function checkItemId($id) {
  global $db;

  $query = $db->query('select * from `'. VAC_PREFIX .'_item` where id = ' . $id);
  if (!empty($query->fetch())) {
    return 1;
  }
  return 0;
}

// check if category exist, if not, insert to table
// return category id
function checkCategory($catename) {
  global $db;
  $catename = mb_strtolower($catename);

  $query = $db->query('select * from `'. VAC_PREFIX .'_category` where name = "'. $catename .'"');
  $cate = $query->fetch();
  $id = 0; // default id = 0
  if (empty($cate) || empty($cate['id'])) {
    $query = $db->query('insert into `'. VAC_PREFIX .'_category` (name) values("'. $catename .'")');
    if ($query) {
      $id = $db->lastInsertId();
    }
  } else {
    $id = $cate['id'];
  }
  return $id;
}

function getFirstCateid() {
  global $db;

  $sql = 'select * from `'. VAC_PREFIX .'_item` limit 1';
  $query = $db->query($sql);
  if (!empty($item = $query->fetch())) return $item['id'];
  return 0;
}

function convert($str) {
  $str = mb_strtolower($str);
  $str = preg_replace("/(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)/", 'a', $str);
  $str = preg_replace("/(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)/", 'e', $str);
  $str = preg_replace("/(ì|í|ị|ỉ|ĩ)/", 'i', $str);
  $str = preg_replace("/(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)/", 'o', $str);
  $str = preg_replace("/(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)/", 'u', $str);
  $str = preg_replace("/(ỳ|ý|ỵ|ỷ|ỹ)/", 'y', $str);
  $str = preg_replace("/(đ)/", 'd', $str);
  return $str;
}

function nav_generater($url, $number, $page, $limit) {
  $html = '';
  $total = floor($number / $limit) + ($number % $limit ? 1 : 0);
  for ($i = 1; $i <= $total; $i++) {
    if ($page == $i) {
      $html .= '<a class="btn btn-default">' . $i . '</a>';
    } 
    else {
      $html .= '<a class="btn btn-info" href="'. $url .'&page='. $i .'&limit='. $limit .'">' . $i . '</a>';
    }
  }
  return $html;
}
