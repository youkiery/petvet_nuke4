<?php

/**
 * @Project NUKEVIecET-MUSIC
 * @Author Phan Tan Dung (phantandung92@gmail.com)
 * @copyright 2011
 * @createdate 26/01/2011 09:17 AM
 */

// $sql = "select * from pet_vaccine_usg";
// $query = $db->query($sql);
// while ($row = $query->fetch()) {
//   $sql = "update pet_vaccine_usg set ctime = $row[cometime] where id = $row[id]";
//   $db->query($sql);
//   $sql = "update pet_vaccine_usg set cbtime = $row[birthday] where id = $row[id]";
//   $db->query($sql);
// }
// die();

// $sql = "select * from `pet_vaccine_configv2`";
// $query = $db->query($sql);
// $vacconfigv2 = array();
// while ($row = $query->fetch()) {
//   $vacconfigv2[$row["name"]] = $row["value"];
// }

// $sql = "select * from pet_drug_temp";
// $query = $db->query($sql);
// $weight = array(1 => "2 - 4,5", "4,5 - 10", "10 - 20", "20 - 40", "40 - 56");
// while ($row = $query->fetch()) {
//   $check = 0;
//   foreach ($weight as $key => $value) {
//     if (strpos($row["drug"], $value)) {
//       $check = $key;
//       break;
//     }
//   }
//   if ($check) {
//     $custom = array();
//     if (!empty($row["phone"])) {
//       $sql = "select * from pet_vaccine_customer where phone = '$row[phone]'";
//       $query2 = $db->query($sql);
//       $custom = $query2->fetch();
//     }
//     $time = explode(" ", $row["time"]);
//     $time2 = explode("-", $time[0]);
//     $time3 = "20$time2[2]-$time2[1]-$time2[0]";
//     $time3 = strtotime($time3);
//     $time4 = $time3 + $vacconfigv2["redrug"];

//     if (empty($custom)) {
//       $sql = "insert into pet_vaccine_customer (name, phone, address) values ('$row[name]', '$row[phone]', '')";
//       $db->query($sql);
//       $id = $db->lastInsertId();
//       $sql = "insert into pet_vaccine_redrug (customerid, drugid, cometime, calltime, recall, status, note, ctime) values ($id, $check, $time3, $time4, 0, 0, '', " . time() . ")";
//       $db->query($sql);
//     }
//     else {
//       $sql = "insert into pet_vaccine_redrug (customerid, drugid, cometime, calltime, recall, status, note, ctime) values ($custom[id], $check, $time3, $time4, 0, 0, '', " . time() . ")";
//       $db->query($sql);
//     }
//   }
// }

// die();
if (!defined('NV_MAINFILE')) {
  die('Stop!!!');
}
define('VAC_PREFIX', $db_config['prefix'] . "_" . $module_name);
define('NV_NEXTMONTH', 30 * 24 * 60 * 60);
define('NV_NEXTWEEK', 7 * 24 * 60 * 60);
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

function updateImage($image, $id)
{
  global $db;

  if (!empty($image)) {
    $sql = 'select * from `' . VAC_PREFIX . '_heal` where id = ' . $id;
    die($sql);
    $query = $db->query($sql);

    if (empty($row = $query->fetch()) || $row['image'] != $image) {
      $sql = 'update `' . VAC_PREFIX . '_heal` set image = "' . $image . '" where id = ' . $id;
      $db->query($sql);
    }
  }
}

function updateImagev2($image, $id, $path)
{
  global $db;

  if (!empty($image)) {
    $sql = 'select * from `' . $path . '` where id = ' . $id;
    die($sql);
    $query = $db->query($sql);

    if (empty($row = $query->fetch()) || $row['image'] != $image) {
      $sql = 'update `' . $path . '` set image = "' . $image . '" where id = ' . $id;
      die($sql);
      $db->query($sql);
    }
  }
}

function selectHealInsultId($healid)
{
  global $db;
  $sql = 'select * from `' . VAC_PREFIX . '_heal_insult` where healid = ' . $healid;
  $query = $db->query($sql);
  $insult = $query->fetch();
  return $insult;
}

function selectCustomerId($customerid)
{
  global $db;
  $sql = 'select * from `' . VAC_PREFIX . '_customer` where id = ' . $customerid;
  $query = $db->query($sql);
  $customer = $query->fetch();
  return $customer;
}

function selectPetId($petid)
{
  global $db;
  $sql = 'select * from `' . VAC_PREFIX . '_pet` where id = ' . $petid;
  $query = $db->query($sql);
  $pet = $query->fetch();
  return $pet;
}

function checkStorage($filter)
{
  global $db;

  $sql = 'select * from `' . VAC_PREFIX . '_position` where id = ' . $filter['id'];
  $query = $db->query($sql);
  $position = $query->fetch();

  if (!empty($position)) return 1;
  return 0;
}

function checkSpecies($name)
{
  global $db;

  $sql = 'select * from `' . VAC_PREFIX . '_species` where name = "' . $name . '"';
  $query = $db->query($sql);

  if (empty($query->fetch())) {
    return 0;
  }
  return 1;
}

function insertSpecies($name)
{
  global $db;

  $sql = 'insert into `' . VAC_PREFIX . '_species` (name) values("' . $name . '")';
  $query = $db->query($sql);

  if ($query) {
    return $db->lastInsertId();
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

function selectSpeciesId($id = 0)
{
  global $db;
  $sql = 'select * from `' . VAC_PREFIX . '_species`';
  $query = $db->query($sql);
  $html = '';
  while ($species = $query->fetch()) {
    $check = '';
    if ($species['id'] == $id) {
      $check = 'selected';
    }
    $html .= '<option value=' . $species['id'] . ' ' . $check . '>' . $species['name'] . '</option>';
  }
  return $html;
}

function getSystemId($id)
{
  global $db;
  $sql = 'select * from `' . VAC_PREFIX . '_system` where healid = ' . $id;
  $query = $db->query($sql);
  $list = array();
  while ($system = $query->fetch()) {
    $list[] = $system;
  }
  return $list;
}

function parseSystemId($id)
{
  global $db;
  $sql = 'select * from `' . VAC_PREFIX . '_heal_system` where id in (select systemid from `' . VAC_PREFIX . '_system` where healid = ' . $id . ')';
  $query = $db->query($sql);
  $list = array();
  while ($system = $query->fetch()) {
    $list[] = $system['name'];
  }
  return implode(', ', $list);
}

function getDrugId($id)
{
  global $db;
  $sql = 'select * from `' . VAC_PREFIX . '_medicine` where healid = ' . $id;
  $query = $db->query($sql);
  $list = array();
  while ($drug = $query->fetch()) {
    $list[] = $drug;
  }
  return $list;
}

function getDrugList()
{
  global $db;
  $sql = 'select * from `' . VAC_PREFIX . '_heal_medicine`';
  $query = $db->query($sql);
  $list = array();
  while ($drug = $query->fetch()) {
    $drug['system'] = explode(',', $drug['system']);
    $drug['disease'] = explode(',', $drug['disease']);
    $drug['effective'] = explode(',', $drug['effective']);
    $list[] = $drug;
  }
  return $list;
}

function getDrugIdList($id)
{
  global $db;

  $drugs = getDrugId($id);
  $drug = array();
  foreach ($drugs as $row) {
    $drugData = getDrugDataId($row['medicineid']);
    $drug[] = $drugData['name'] . ': ' . $row['quanlity'] . '' . $drugData['unit'];
  }
  return $drug;
}

function getDrugDataId($id)
{
  global $db;

  $sql = 'select * from `' . VAC_PREFIX . '_heal_medicine` where id = ' . $id;
  $query = $db->query($sql);
  return $query->fetch();
}

function passbyParam($list)
{
  $temp = array();

  foreach ($list as $key => $value) {
    if (!empty($key) || !empty($value)) {
      $temp[] = $key;
    }
  }
  // var_dump($temp);
  // die();
  return implode(',', $temp);
}

function diseaseList()
{
  global $db;

  $list = array();
  $sql = 'select * from `' . VAC_PREFIX . '_heal_disease`';
  $query = $db->query($sql);

  while ($disease = $query->fetch()) {
    $list[$disease['id']] = $disease['name'];
  }

  return $list;
}

function getHealId($id)
{
  global $db;
  $sql = 'select * from `' . VAC_PREFIX . '_heal` where id = ' . $id;
  $query = $db->query($sql);
  $heal = $query->fetch();
  $heal['pet'] = selectPetId($heal['petid']);
  $heal['pet']['species'] = selectSpeciesId($heal['pet']['species']);
  $heal['customer'] = selectCustomerId($heal['pet']['customerid']);
  $heal['system'] = getSystemId($heal['id']);
  $heal['drug'] = getDrugId($heal['id']);
  return $heal;
}

function selectDoctorId($id)
{
  global $db, $db_config;

  $sql = 'select * from `' . $db_config['prefix'] . '_users` where userid = ' . $id;
  $query = $db->query($sql);

  return $query->fetch();
}

function getCustomerData()
{
  global $db;

  $customer = array();
  $sql = 'select id as a, name as b, phone as c from `' . VAC_PREFIX . '_customer`';
  $query = $db->query($sql);

  while ($customerData = $query->fetch()) {
    $sql = 'select id as a, name as b from `' . VAC_PREFIX . '_pet` where customerid = ' . $customerData['a'];
    $petQuery = $db->query($sql);

    $customer[] = $customerData;
    $count = count($customer) - 1;
    $customer[$count]['pet'] = array();
    while ($pet = $petQuery->fetch()) {
      $customer[$count]['pet'][] = $pet;
    }
  }
  return json_encode($customer);
}

function getCustomerSuggestList($keyword)
{
  global $db;

  $customer = array();
  $sql = 'select id, name, phone from `' . VAC_PREFIX . '_customer` where name like "%' . $keyword . '%" or phone like "%' . $keyword . '%" limit 20';
  $query = $db->query($sql);

  while ($customerData = $query->fetch()) {
    $sql = 'select id, name, weight, age, species from `' . VAC_PREFIX . '_pet` where customerid = ' . $customerData['id'];
    $petQuery = $db->query($sql);

    $customer[] = $customerData;
    $count = count($customer) - 1;
    $customer[$count]['pet'] = array();
    while ($pet = $petQuery->fetch()) {
      $pet['species'] = selectSpeciesId($pet['species']);
      $customer[$count]['pet'][] = $pet;
    }
  }
  return $customer;
}

function getSystemList()
{
  global $db;

  $list = array();
  $sql = 'select * from `' . VAC_PREFIX . '_heal_system`';
  $query = $db->query($sql);

  while ($system = $query->fetch()) {
    $list[$system['id']] = $system;
  }

  return $list;
}

function getMedicineList()
{
  global $db;

  $list = array();
  $sql = 'select * from `' . VAC_PREFIX . '_heal_medicine`';
  $query = $db->query($sql);

  while ($medicine = $query->fetch()) {
    $list[$medicine['id']] = $medicine;
  }

  return $list;
}

function interpolateQuery($query, $params)
{
  $keys = array();

  # build a regular expression for each parameter
  foreach ($params as $key => $value) {
    if (is_string($key)) {
      $keys[] = '/:' . $key . '/';
    } else {
      $keys[] = '/[?]/';
    }
  }

  $query = preg_replace($keys, $params, $query, 1, $count);

  #trigger_error('replaced '.$count.' keys');

  return $query;
}

function user_redrug()
{
  global $db, $nv_Request, $module_info, $module_file, $lang_module, $vacconfigv2;
  $xtpl = new XTemplate("redrug-list.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
  $today = strtotime(date("Y-m-d"));
  $index = 1;
  $color = array("red", "yellow", "green");

  $filter = $vacconfigv2["filter"];
  if (empty($filter)) {
    $filter = 60 * 60 * 24 * 7;
  }
  $from = $today - $filter;
  $end = $today + $filter;

  $filter_type = $nv_Request->get_string("filter", "get/post", "");
  if (empty($filter_type)) {
    $filter_type = 0;
  }

  $page = $nv_Request->get_string("page", "get/post", "");
  if (empty($page)) {
    $type = "calltime";
  } else {
    $type = "cometime";
  }
  $xtpl->assign("lang", $lang_module);

  $sql = "select * from `" . VAC_PREFIX . "_drug`";
  $drug_query = $db->query($sql);
  $drug = array();
  while ($drug_row = $drug_query->fetch()) {
    $drug[$drug_row["id"]] = $drug_row;
  }

  $sql = "select * from `" . VAC_PREFIX . "_redrug` where ($type between $from and $end) and status = $filter_type order by $type desc";
  $query = $db->query($sql);
  while ($row = $query->fetch()) {
    $sql = "select * from `" . VAC_PREFIX . "_customer` where id = " . $row["customerid"];
    $customer_query = $db->query($sql);
    $customer = $customer_query->fetch();
    $xtpl->assign("index", $index);
    // var_dump($doctor);
    // var_dump($row["doctorid"]);
    // die();
    $xtpl->assign("id", $row["id"]);
    $xtpl->assign("customer_name", $customer["name"]);
    $xtpl->assign("customer_number", $customer["phone"]);
    $xtpl->assign("status", $lang_module["redrugstatus"][$row["status"]]);
    $xtpl->assign("color", $color[$row["status"]]);
    $xtpl->assign("drug", $drug[$row["drugid"]]["name"]);
    $xtpl->assign("drug_from", date("d/m/Y", $row["cometime"]));
    $xtpl->assign("drug_end", date("d/m/Y", $row["calltime"]));
    $xtpl->assign("note", $row["note"]);
    $xtpl->parse("main");
    $index++;
  }
  $text = $xtpl->text();
  return $text;
}

function admin_redrug()
{
  global $db, $nv_Request, $module_info, $module_file, $lang_module, $vacconfigv2, $global_config;
  $xtpl = new XTemplate("redrug-list.tpl", NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file);
  $today = strtotime(date("Y-m-d"));
  $index = 1;
  $color = array("red", "yellow", "green");

  $filter = $vacconfigv2["filter"];
  if (empty($filter)) {
    $filter = 60 * 60 * 24 * 7;
  }
  $from = $today - $filter;
  $end = $today + $filter;

  $filter_type = $nv_Request->get_string("filter", "get/post", "");
  if (empty($filter_type)) {
    $filter_type = 0;
  }

  $xtpl->assign("lang", $lang_module);

  $sql = "select * from `" . VAC_PREFIX . "_drug`";
  $drug_query = $db->query($sql);
  $drug = array();
  while ($drug_row = $drug_query->fetch()) {
    $drug[$drug_row["id"]] = $drug_row;
  }

  $sql = "select * from `" . VAC_PREFIX . "_redrug` where status = $filter_type order by calltime desc";
  $query = $db->query($sql);
  while ($row = $query->fetch()) {
    $sql = "select * from `" . VAC_PREFIX . "_customer` where id = " . $row["customerid"];
    $customer_query = $db->query($sql);
    $customer = $customer_query->fetch();
    $xtpl->assign("index", $index);
    // var_dump($doctor);
    // var_dump($row["doctorid"]);
    // die();
    $xtpl->assign("id", $row["id"]);
    $xtpl->assign("customer_name", $customer["name"]);
    $xtpl->assign("customer_number", $customer["phone"]);
    $xtpl->assign("status", $lang_module["redrugstatus"][$row["status"]]);
    $xtpl->assign("color", $color[$row["status"]]);
    $xtpl->assign("drug", $drug[$row["drugid"]]["name"]);
    $xtpl->assign("drug_from", date("d/m/Y", $row["cometime"]));
    $xtpl->assign("drug_end", date("d/m/Y", $row["calltime"]));
    $xtpl->assign("note", $row["note"]);
    $xtpl->parse("main");
    $index++;
  }
  $text = $xtpl->text();
  return $text;
}

function getDiseaseList()
{
  global $db, $db_config, $module_name;
  $sql = "select * from " . VAC_PREFIX . "_disease";
  $result = $db->query($sql);
  return fetchall($db, $result);
}

function getDiseaseData()
{
  global $db;

  $list = array();
  $sql = "select * from " . VAC_PREFIX . "_disease";
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $list[$row['id']] = $row['name'];
  }
  return $list;
}

function getCustomerList($key, $sort, $filter, $page)
{
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

function getVaccineTable($path, $lang, $key, $sort, $time)
{
  // next a week
  global $db, $db_config, $module_name, $global_config, $lang_module;
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

function getdoctorlist()
{
  global $db, $db_config, $module_name;
  $sql = "select * from " . VAC_PREFIX . "_doctor";
  $result = $db->query($sql);
  $doctor = array();

  while ($row = $result->fetch()) {
    $doctor[] = $row;
  }
  return $doctor;
}

function doctorlist($path, $lang)
{
  $xtpl = new XTemplate("doctor-2.tpl", $path);

  $xtpl->assign("lang", $lang);

  $doctors = getdoctorlist();
  foreach ($doctors as $key => $doctor_data) {
    echo
      $xtpl->assign("index", $doctor_data["id"]);
    $xtpl->assign("name", $doctor_data["name"]);
    $xtpl->parse("main.doctor");
  }

  $xtpl->parse("main");
  return $xtpl->text("main");
}

function getrecentlist($fromtime, $amount_time, $sort, $keyword, $filter)
{
  global $db, $db_config, $module_name;
  return 0;
}

function filterVac($fromtime, $amount_time, $sort, $keyword, $filter)
{
  global $db, $db_config, $module_name;
  $endtime = $fromtime + $amount_time;
  $fromtime -= $amount_time;

  $order = '';
  switch ($sort) {
    case '1':
      $order = 'order by cometime, c.name asc';
      break;
    case '2':
      $order = 'order by cometime, c.name desc';
      break;
    case '3':
      $order = 'order by calltime, c.name asc';
      break;
    case '4':
      $order = 'order by calltime, c.name desc';
      break;
  }

  $where = "where (b.name like '%$keyword%' or c.name like '%$keyword%' or c.phone like '%$keyword%') and a.status in (" . $filter . ")";

  $sql = "select a.id, a.note, b.id as petid, b.name as petname, c.id as customerid, c.name as customer, c.phone as phone, cometime, calltime, recall, status, diseaseid, dd.name as disease from " . VAC_PREFIX . "_vaccine a inner join " . VAC_PREFIX . "_pet b on calltime between " . $fromtime . " and " . $endtime . " and a.petid = b.id inner join " . VAC_PREFIX . "_customer c on b.customerid = c.id inner join " . VAC_PREFIX . "_disease dd on a.diseaseid = dd.id $where " . $order;
  $result = $db->query($sql);
  $sql = "select a.id, a.note, b.id as petid, b.name as petname, c.id as customerid, c.name as customer, c.phone as phone, cometime, calltime, recall, status, diseaseid, dd.name as disease from " . VAC_PREFIX . "_vaccine a inner join " . VAC_PREFIX . "_pet b on calltime between " . $fromtime . " and " . $endtime . " and a.petid = b.id inner join " . VAC_PREFIX . "_customer c on b.customerid = c.id inner join (select 0 as id, 'Siêu Âm' as name from DUAL) dd on a.diseaseid = dd.id $where " . $order;
  $result2 = $db->query($sql);
  $ret = array();
  while ($row = $result->fetch()) {
    $ret[] = $row;
  }
  while ($row = $result2->fetch()) {
    $ret[] = $row;
  }
  //   var_dump($ret);
  //   die();

  return $ret;
}

function getvaccustomer($customer, $fromtime, $amount_time, $sort, $diseaseid, $disease)
{
  global $db, $db_config, $module_name;
  $endtime = $fromtime + $amount_time;
  $fromtime -= $amount_time;

  $order = '';
  switch ($sort) {
    case '1':
      $order = 'order by cometime, customer asc';
      break;
    case '2':
      $order = 'order by cometime, customer desc';
      break;
    case '3':
      $order = 'order by calltime, customer asc';
      break;
    case '4':
      $order = 'order by calltime, customer desc';
      break;
  }

  $sql = "select a.id, a.note, b.id as petid, b.petname, c.id as customerid, c.name as customer, c.phone as phone, cometime, calltime, status, doctorid, recall, '$diseaseid' as diseaseid, '$disease' as disease from " . VAC_PREFIX . "_" . $diseaseid . " a inner join " . VAC_PREFIX . "_pet b on calltime between " . $fromtime . " and " . $endtime . " and a.petid = b.id inner join " . VAC_PREFIX . "_customer c on b.customerid = c.id where c.customer like '%$customer%' or c.phone like '%$customer%' " . $order;

  // if ($diseaseid == 2) {
  // }
  // $sql = "select a.id, b.id as petid, b.petname, c.id as customerid, c.customer, c.phone as phone, cometime, calltime, status from " . VAC_PREFIX . "_" . $diseaseid . " a inner join " . VAC_PREFIX . "_pet b on calltime between " . $fromtime . " and " . $endtime . " and a.petid = b.id inner join " . VAC_PREFIX . "_customer c on b.customerid = c.id where c.customer like '%$customer%' or c.phone like '%$customer%' " . $order;
  $result = $db->query($sql);
  $ret = array();
  while ($row = $result->fetch()) {
    $ret[] = $row;
  }
  return $ret;
}

function getcustomer($customer, $phone)
{
  global $db, $db_config, $module_name;
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

function getPatientsList($key, $sort, $filter, $page)
{
  global $db, $db_config, $module_name;
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

function getPatientsList2($customerid)
{
  global $db, $db_config, $module_name;
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
  foreach ($ax as $key => $row) {
    $petid = $row["id"];
    $sql = "SELECT v.cometime, v.calltime, dd.name as disease from " . VAC_PREFIX . "_vaccine v inner join " . VAC_PREFIX . "_pet p on  v.petid = " . $petid . " and v.petid = p.id inner join " . VAC_PREFIX . "_customer c on p.customerid = c.id inner join " . VAC_PREFIX . "_disease dd on v.diseaseid = dd.id order by v.id desc";
    $query = $db->query($sql);
    $crow = $query->fetch();
    $sql = "SELECT v.cometime, v.calltime, dd.name as disease from " . VAC_PREFIX . "_vaccine v inner join " . VAC_PREFIX . "_pet p on  v.petid = " . $petid . " and v.petid = p.id inner join " . VAC_PREFIX . "_customer c on p.customerid = c.id inner join (select 0 as id, 'Siêu Âm' as name from DUAL) dd on v.diseaseid = dd.id order by v.id desc";
    $query2 = $db->query($sql);
    $crow2 = $query->fetch();

    if ($crow["cometime"] > $crow2["cometime"]) {
      $data = $crow;
    } else {
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

function getPatientDetail($petid)
{
  global $db, $db_config, $module_name;
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

function usg_list($list)
{
  global $url, $count, $limit, $page, $module_info, $module_file, $lang_module, $nv_Request;
  // initial
  $xtpl = new XTemplate("sieuam-hang.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
  $xtpl->assign("lang", $lang_module);
  $index = 1;
  // $index = ($page - 1) * $limit + 1;
  $hex = array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f");
  $status_color = array("red", "yellow", "green", "gray");
  $status_array = array(array(), array(), array(), array()); // [[], [], [], []] from 0 -> 3

  // cnote
  $cnote = $nv_Request->get_string('cnote', 'get/post', "");
  if ($cnote == 0) {
    $xtpl->assign("cnote", "none");
  } else {
    $xtpl->assign("cnote", "table-row");
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
      $price[$status_row] = $list[$status_row]['calltime'];
    }
    arsort($price);
    foreach ($price as $key => $value) {
      $t_list[] = $key;
    }
  }

  // display
  foreach ($t_list as $key => $list_data) {
    $xtpl->assign("index", $index);
    $xtpl->assign("image", $list[$list_data]["image"]);
    $xtpl->assign("petname", $list[$list_data]["petname"]);
    $xtpl->assign("customer", $list[$list_data]["customer"]);
    $xtpl->assign("phone", $list[$list_data]["phone"]);
    $xtpl->assign("vacid", $list[$list_data]["id"]);
    $xtpl->assign("petid", $list[$list_data]["petid"]);
    $xtpl->assign("note", $list[$list_data]["note"]);
    $xtpl->assign("exbirth", $list[$list_data]["expectbirth"]);
    $xtpl->assign("birth", $list[$list_data]["birth"]);
    $xtpl->assign("sieuam", date("d/m/Y", $list[$list_data]["cometime"]));
    $xtpl->assign("dusinh", date("d/m/Y", $list[$list_data]["calltime"]));
    $xtpl->assign("color", $status_color[$list[$list_data]["status"]]);
    if (!empty($status_color[$list[$list_data]["status"]])) {
      $color = $status_color[$list[$list_data]["status"]];
    } else {
      $color = $status_color[0];
    }
    if ($list[$list_data]["status"] == 2) {
      $xtpl->assign("birth", $list[$list_data]["birth"]);
      $xtpl->parse("main.list.birth");
    }
    $xtpl->assign("status", $lang_module["confirm_value2"][$list[$list_data]["status"]]);
    $xtpl->assign("color", $color);
    $xtpl->parse("main.list");
    $index++;
  }
  $xtpl->parse("main");
  return $xtpl->text("main");
}

function user_usg()
{
  global $db, $nv_Request, $module_config, $module_name, $lang_module, $vacconfigv2;
  // initial
  // $vaccine_config = get_user_config();
  $limit_option = array(10, 20, 30, 40, 50, 75, 100);
  $now = strtotime(date("y-m-d"));
  // page
  $page = $nv_Request->get_string('page', 'get/post', "");
  // if ($page < 0) {
  //   $page = 1;
  // }
  // limit 
  // $limit = $nv_Request->get_int('limit', 'get/post', 0);
  // if (empty($limit)) {
  //   if (!empty($_SESSION["usg_limit"]) && $_SESSION["usg_limit"] > 0) {
  //     $limit = $_SESSION["usg_limit"];
  //   }
  //   else {
  //     $limit = $vaccine_config["usg_f"];
  //     $_SESSION["usg_limit"] = $limit;
  //   }
  // }
  // else {
  //   $_SESSION["usg_limit"] = $limit;
  // }
  // $limit_page = "limit " . $limit . " offset " . (($page - 1) * $limit);

  // keyword
  $keyword = $nv_Request->get_string('keyword', 'get/post', '');

  // filter type
  $filter = $nv_Request->get_int('filter', 'get/post', 0);
  // if ($filter == "") {
  //   if (!empty($_SESSION["usg_filter"]) && (strpos($_SESSION["usg_filter"], "0") == false || strpos($_SESSION["usg_filter"], "1") == false || strpos($_SESSION["usg_filter"], "2") == false)) {
  //     $filter = $_SESSION["usg_filter"];
  //   }
  //   else {
  //     $filter = $vaccine_config["usg_s"];
  //     $_SESSION["usg_filter"] = $filter;
  //   }
  // }
  // else {
  //   $_SESSION["usg_filter"] = $filter;
  // }
  // $filter = implode(",", str_split($filter));

  // filter time
  $time = $vacconfigv2["usg_filter"];
  if (empty($time)) {
    $time = 60 * 60 * 24 * 30;
  }
  $from = $now - $time;
  $end = $now + $time;
  // doctor
  $sql = "select * from " . VAC_PREFIX . "_doctor";
  $query = $db->query($sql);
  $doctor = array();
  while ($doctor_row = $query->fetch()) {
    $doctor[$doctor_row["id"]] = $doctor_row["name"];
  }

  // update filter
  // update_usg_filter($filter, $limit);

  // filter sql
  $where = "where (c.name like '%$keyword%' or c.phone like '%$keyword%') and a.status in ($filter)";

  // list
  // $sql = "select a.id, a.cometime, a.calltime, a.status, a.image, a.note, a.birthday, a.birth, a.expectbirth, a.doctorid, b.id as petid, b.name as petname, c.name as customer, c.phone from `" . VAC_PREFIX . "_usg` a inner join `" . VAC_PREFIX . "_pet` b on a.calltime between $from and $end and a.petid = b.id inner join `" . VAC_PREFIX . "_customer` c on b.customerid = c.id $where order by calltime " . $limit_page;
  if ($page == "list") {
    $next = $now + 24 * 60 * 60;
    $time_sql = "(ctime between $now and $next)";
    $type = "ctime";
  } else {
    $time_sql = "(calltime between $from and $end)";
    $type = "calltime";
  }
  $sql = "select a.id, a.cometime, a.calltime, a.status, a.image, a.note, a.birthday, a.birth, a.expectbirth, a.doctorid, b.id as petid, b.name as petname, c.name as customer, c.phone from `" . VAC_PREFIX . "_usg` a inner join `" . VAC_PREFIX . "_pet` b on $time_sql and a.petid = b.id inner join `" . VAC_PREFIX . "_customer` c on b.customerid = c.id $where order by a.$type";
  $query = $db->query($sql);
  $list = array();
  while ($usg_row = $query->fetch()) {
    if ($usg_row["doctorid"]) {
      $usg_row["doctor"] = $doctor[$usg_row["doctorid"]];
    } else {
      $usg_row["doctor"] = "";
    }
    $list[] = $usg_row;
  }

  return usg_list($list);
}

// function user_usg_nav() {
//   global $nv_Request, $db;
//   // initial
// 	$vaccine_config = get_user_config();
//   $limit_option = array(10, 20, 30, 40, 50, 75, 100); 
//   $now = strtotime(date("y-m-d"));
//   // page
//   $page = $nv_Request->get_int('page', 'get/post', 1);
//   if ($page < 0) {
//     $page = 1;
//   }
//   // limit 
//   $limit = $nv_Request->get_int('limit', 'get/post', 0);
//   if (empty($limit)) {
//     if (!empty($_SESSION["usg_limit"]) && $_SESSION["usg_limit"] > 0) {
//       $limit = $_SESSION["usg_limit"];
//     }
//     else {
//       $limit = $vaccine_config["usg_f"];
//       $_SESSION["usg_limit"] = $limit;
//     }
//   }
//   else {
//     $_SESSION["usg_limit"] = $limit;
//   }
// 	$limit_page = "limit " . $limit . " offset " . (($page - 1) * $limit);
//   // keyword
//   $keyword = $nv_Request->get_string('keyword', 'get/post', '');
//   // filter type
//   $filter = $nv_Request->get_string('filter', 'get/post', '');
//   if ($filter == "") {
//     if (!empty($_SESSION["usg_filter"]) && (strpos($_SESSION["usg_filter"], "0") == false || strpos($_SESSION["usg_filter"], "1") == false || strpos($_SESSION["usg_filter"], "2") == false)) {
//       $filter = $_SESSION["usg_filter"];
//     }
//     else {
//       $filter = $vaccine_config["usg_s"];
//       $_SESSION["usg_filter"] = $filter;
//     }
//   }
//   else {
//     $_SESSION["usg_filter"] = $filter;
//   }
//   $filter = implode(",", str_split($filter));
//   // filter time
//   $time = $module_config[$module_name]["filter_time"];
//   if (empty($time)) {
//     $time = 60 * 60 * 24 * 14;
//   }
// 	$from = $now - $time;
// 	$end = $now + $time;
//   // filter sql
//   $where = "where (c.name like '%$keyword%' or c.phone like '%$keyword%') and a.status in ($filter)";
//   // count
// 	$sql = "select count(a.id) as count from `" . VAC_PREFIX . "_usg` a inner join `" . VAC_PREFIX . "_pet` b on a.calltime between $from and $end and a.petid = b.id inner join `" . VAC_PREFIX . "_customer` c on b.customerid = c.id $where order by calltime";
// 	$query = $db->query($sql);
// 	$result = $query->fetch();
//   $count = $result["count"];

//   $url = $link . $op . "&key=$keyword&page=$page&limit=$limit";
//   $nav = nv_generate_page_shop($url, $count, $limit, $page);
//   return $nav;
// }

function user_birth()
{
  global $db, $nv_Request, $module_config, $module_name, $lang_module, $module_info, $module_file, $vacconfigv2;
  // initial
  $xtpl = new XTemplate("sieuam-birth-list.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
  $xtpl->assign("lang", $lang_module);
  // $vaccine_config = get_user_config();
  // $limit_option = array(10, 20, 30, 40, 50, 75, 100); 
  $now = strtotime(date("y-m-d"));
  // $index = ($page - 1) * $limit + 1;
  $index = 1;
  // page
  $page = $nv_Request->get_string('page', 'get/post', "1");
  // if ($page < 0) {
  //   $page = 1;
  // }
  // limit 
  // $limit = $nv_Request->get_int('limit', 'get/post', 0);
  // if (empty($limit)) {
  //   if (!empty($_SESSION["usg_limit"]) && $_SESSION["usg_limit"] > 0) {
  //     $limit = $_SESSION["usg_limit"];
  //   }
  //   else {
  //     $limit = $vaccine_config["usg_f"];
  //     $_SESSION["usg_limit"] = $limit;
  //   }
  // }
  // else {
  //   $_SESSION["usg_limit"] = $limit;
  // }
  // $limit_page = "limit " . $limit . " offset " . (($page - 1) * $limit);
  // keyword
  $keyword = $nv_Request->get_string('keyword', 'get/post', '');
  // filter type
  $filter = $nv_Request->get_int('filter', 'post/get', 0);

  // $filter = $nv_Request->get_string('filter', 'get/post', '');
  // if ($filter == "") {
  //   if (!empty($_SESSION["usg_filter"]) && (strpos($_SESSION["usg_filter"], "0") == false || strpos($_SESSION["usg_filter"], "1") == false || strpos($_SESSION["usg_filter"], "2") == false)) {
  //     $filter = $_SESSION["usg_filter"];
  //   }
  //   else {
  //     $filter = $vaccine_config["usg_s"];
  //     $_SESSION["usg_filter"] = $filter;
  //   }
  // }
  // else {
  //   $_SESSION["usg_filter"] = $filter;
  // }
  // $filter = implode(",", str_split($filter));
  // filter time
  $time = $vacconfigv2["usg_filter"];
  if (empty($time)) {
    $time = 60 * 60 * 24 * 30;
  }
  $from = $now - $time;
  $end = $now + $time;
  // doctor
  $sql = "select * from " . VAC_PREFIX . "_doctor";
  $query = $db->query($sql);
  $doctor = array();
  while ($doctor_row = $query->fetch()) {
    $doctor[$doctor_row["id"]] = $doctor_row["name"];
  }

  // update filter
  // update_usg_filter($filter, $limit);

  // filter sql
  if ($page == "list") {
    $type = "cbtime";
  } else {
    $type = "birthday";
  }

  $where = "where (c.name like '%$keyword%' or c.phone like '%$keyword%') and a.vaccine in ($filter) and a.birthday > 0 and ($type between $from and $end)";
  // list
  // $sql = "select a.id, a.birthday, a.birth, a.expectbirth, a.recall, a.vaccine, a.doctorid, b.id as petid, b.name as petname, c.name as customer, c.phone from `" . VAC_PREFIX . "_usg` a inner join `" . VAC_PREFIX . "_pet` b on a.petid = b.id inner join `" . VAC_PREFIX . "_customer` c on b.customerid = c.id $where order by birthday " . $limit_page;
  $sql = "select a.id, a.birthday, a.birth, a.expectbirth, a.firstvac, a.recall, a.vaccine, a.doctorid, b.id as petid, b.name as petname, c.name as customer, c.phone from `" . VAC_PREFIX . "_usg` a inner join `" . VAC_PREFIX . "_pet` b on a.petid = b.id inner join `" . VAC_PREFIX . "_customer` c on b.customerid = c.id $where order by birthday";
  $query = $db->query($sql);
  $list = fetchall($db, $query);

  foreach ($list as $usg_row) {
    if ($usg_row["doctorid"]) {
      $usg_row["doctor"] = $doctor[$usg_row["doctorid"]];
    } else {
      $usg_row["doctor"] = "";
    }
    $xtpl->assign("index", $index);
    $xtpl->assign("id", $usg_row["id"]);
    $xtpl->assign("confirm", $lang_module["confirm_" . $usg_row["vaccine"]]);
    switch ($usg_row["vaccine"]) {
      case '1':
        $xtpl->assign("color", "yellow");
        break;
      case '2':
        $xtpl->assign("color", "green");
        break;
      case '4':
        $xtpl->assign("color", "gray");
        break;
      default:
        $xtpl->assign("color", "red");
    }

    $xtpl->assign("petid", $usg_row["petid"]);
    $xtpl->assign("petname", $usg_row["petname"]);
    $xtpl->assign("customer", $usg_row["customer"]);
    $xtpl->assign("phone", $usg_row["phone"]);
    $xtpl->assign("doctor", $usg_row["doctor"]);
    $xtpl->assign("birth", $usg_row["birth"]);
    $xtpl->assign("exbirth", $usg_row["expectbirth"]);
    $xtpl->assign("birthday", date("d/m/Y", $usg_row["birthday"]));
    $xtpl->assign("vacday", date("d/m/Y", $usg_row["firstvac"]));
    if ($usg_row["vaccine"] > 1) {
      $xtpl->parse("main.list.recall_link");
    }
    $xtpl->parse("main.list");
    $index++;
  }
  $xtpl->parse("main");
  return $xtpl->text();
}

// function user_birth_nav() {
//   global $db, $nv_Request, $module_config, $module_name, $lang_module, $op;
//   // initial
// 	$vaccine_config = get_user_config();
//   $limit_option = array(10, 20, 30, 40, 50, 75, 100); 
//   $now = strtotime(date("y-m-d"));
//   // page
//   $page = $nv_Request->get_int('page', 'get/post', 1);
//   if ($page < 0) {
//     $page = 1;
//   }
//   // limit 
//   $limit = $nv_Request->get_int('limit', 'get/post', 0);
//   if (empty($limit)) {
//     if (!empty($_SESSION["usg_limit"]) && $_SESSION["usg_limit"] > 0) {
//       $limit = $_SESSION["usg_limit"];
//     }
//     else {
//       $limit = $vaccine_config["usg_f"];
//       $_SESSION["usg_limit"] = $limit;
//     }
//   }
//   else {
//     $_SESSION["usg_limit"] = $limit;
//   }
//   // keyword
//   $keyword = $nv_Request->get_string('keyword', 'get/post', '');
//   // filter type
//   $filter = $nv_Request->get_string('filter', 'get/post', '');
//   if ($filter == "") {
//     if (!empty($_SESSION["usg_filter"]) && (strpos($_SESSION["usg_filter"], "0") == false || strpos($_SESSION["usg_filter"], "1") == false || strpos($_SESSION["usg_filter"], "2") == false)) {
//       $filter = $_SESSION["usg_filter"];
//     }
//     else {
//       $filter = $vaccine_config["usg_s"];
//       $_SESSION["usg_filter"] = $filter;
//     }
//   }
//   else {
//     $_SESSION["usg_filter"] = $filter;
//   }
//   $filter = implode(",", str_split($filter));
//   // filter time
//   $time = $module_config[$module_name]["filter_time"];
//   if (empty($time)) {
//     $time = 60 * 60 * 24 * 14;
//   }
// 	$from = $now - $time;
//   $end = $now + $time;
//   // link
//   $link = "/index.php?" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=";
//   $url = $link . $op . "&key=$keyword&page=$page&limit=$limit";

//   $sql = "select count(a.id) as count from `" . VAC_PREFIX . "_usg` a inner join `" . VAC_PREFIX . "_pet` b on a.petid = b.id inner join `" . VAC_PREFIX . "_customer` c on b.customerid = c.id where (c.name like '%$keyword%' or c.phone like '%$keyword%') and birthday > 0 order by calltime";
//   $query = $db->query($sql);
//   $result = $query->fetch();
//   $count = $result["count"];

//   $nav = nv_generate_page_shop($url, $count, $limit, $page);
//   return $nav;
// }

function treat_list($list)
{
  global $module_info, $module_file, $lang_module;
  // initial
  $xtpl = new XTemplate("luubenh-bang.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
  $status_option = array("Bình thường", "Hơi yếu", "Yếu", "Sắp chết");
  $export = array("Lưu bệnh", "Xuất viện", "Đã chết");
  $status_array = array();
  $status_array[0] = array();
  $status_array[1] = array();
  $status_array[2] = array();
  $index = 1;
  $xtpl->assign("lang", $lang_module);

  // devive into part
  foreach ($list as $key => $row) {
    $status_array[$row["insult"]][] = $key;
  }
  krsort($status_array);

  // sort by time
  $t_list = array();
  foreach ($status_array as $akey => $status_list) {
    $price = array();
    foreach ($status_list as $lkey => $status_row) {
      $price[$status_row] = $list[$status_row]['cometime'];
    }
    arsort($price);
    foreach ($price as $key => $value) {
      $t_list[] = $key;
    }
  }

  // display
  foreach ($t_list as $key => $list_data) {
    // var_dump($list_data); die();
    $xtpl->assign("index", $index);
    $xtpl->assign("lid", $list[$list_data]["id"]);
    $xtpl->assign("petname", $list[$list_data]["petname"]);
    $xtpl->assign("customer", $list[$list_data]["customer"]);
    $xtpl->assign("doctor", $list[$list_data]["doctor"]);
    $xtpl->assign("petid", $list[$list_data]["petid"]);
    $xtpl->assign("cometime", date("d/m/Y", $list[$list_data]["cometime"]));
    $xtpl->assign("insult", $export[$list[$list_data]["insult"]]);
    $xtpl->assign("status", $status_option[$list[$list_data]["status"]]);
    $xtpl->assign("bgcolor", mauluubenh($list[$list_data]["insult"], $list[$list_data]["status"]));

    $xtpl->parse("main.list");
    $index++;
  }

  $xtpl->parse("main");
  return $xtpl->text("main");
}

function user_treat()
{
  global $db, $nv_Request, $module_config, $module_name, $lang_module, $module_info, $module_file, $vacconfigv2;
  // initial
  $xtpl = new XTemplate("sieuam-birth-list.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
  $xtpl->assign("lang", $lang_module);

  $limit_option = array(10, 20, 30, 40, 50, 75, 100);
  $keyword = '';
  $today = strtotime(date("y-m-d"));
  $index = 1;
  $page = $nv_Request->get_string('page', 'get/post', '');

  $filter = $nv_Request->get_int('filter', 'get/post', 0);
  // doctor
  $sql = "select * from " . VAC_PREFIX . "_doctor";
  $query = $db->query($sql);
  $doctor = array();
  while ($doctor_row = $query->fetch()) {
    $doctor[$doctor_row["id"]] = $doctor_row["name"];
  }
  // filter query
  $where = "where (c.name like '%$keyword%' or c.phone like '%$keyword%' or b.name like '%$keyword%') and a.insult in ($filter) ";
  // list
  switch ($page) {
    case 'today':
      $end = $today + 60 * 60 * 24;
      $where .= "and ctime between $today and $end";
      break;
    default:
      $time = $vacconfigv2["filter"];
      if (empty($time)) {
        $time = 60 * 60 * 24 * 14;
      }
      $from = $today - $time;
      $end = $today + $time;
      $where .= "and cometime between $from and $end";
  }
  $sql = "SELECT a.id, a.cometime, a.insult, b.id as petid, b.name as petname, c.name as customer, d.name as doctor from `" . VAC_PREFIX . "_treat` a inner join `" . VAC_PREFIX . "_pet` b on a.petid = b.id inner join `" . VAC_PREFIX .  "_customer` c on c.id = b.customerid  inner join `" . VAC_PREFIX . "_doctor` d on a.doctorid = d.id $where order by a.cometime desc, a.id";
  $result = $db->query($sql);

  $list = array();
  while ($row = $result->fetch()) {
    $sql = "SELECT status from `" . VAC_PREFIX . "_treating` where treatid = $row[id] order by id desc limit 1";
    $query2 = $db->query($sql);
    $row2 = $query2->fetch();
    $row["status"] = $row2["status"] ? $row2["status"] : 0;
    $list[] = $row;
  }

  return treat_list($list);
}

// function vaccine_overdate() {
//   global $db, $lang_module;
//   // ini
//   $xtpl = new XTemplate("vaccine_overdate.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);

//   $today = time();
//   $sql = "select * from `" . VAC_PREFIX . "_vaccine` where calltime < $today and status < 2";
//   $query = $db->query($sql);
//   $index = 1;
//   while ($vac = $query->fetch()) {
//     $sql = "select * from `" . VAC_PREFIX . "_pet` where id = $vac[petid]";
//     $pet_query = $db->query($sql);
//     $pet = $pet_query->fetch();

//     $sql = "select * from `" . VAC_PREFIX . "_custom` where id = $pet[customerid]";
//     $custom_query = $db->query($sql);
//     $custom = $custom_query->fetch();

//     $sql = "select * from `" . VAC_PREFIX . "_disease` where id = $vac[diseaseid]";
//     $disease_query = $db->query($sql);
//     $disease = $disease_query->fetch();

//     $xtpl->assign("index", $index ++);
//     $xtpl->assign("customer", $custom["name"]);
//     $xtpl->assign("id", $vac["id"]);
//     $xtpl->assign("disease", $disease["name"]);
//     $xtpl->assign("vaccome", date("d/m/Y", $vac["cometime"]));
//     $xtpl->assign("vaccame", date("d/m/Y", $vac["calltime"]));
//     $xtpl->assign("status", $lang_module["vacstatusname"][$vac["status"]]);
//     $xtpl->assign("note", $vac["status"]);
//     $xtpl->parse("main.row");
//   }

//   $xtpl->parse("main");
//   return $xtpl->text();
// }

// function usg_overdate() {
//   global $db, $lang_module;
//   // ini
//   $xtpl = new XTemplate("usg_overdate.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);

//   $today = time();
//   $sql = "select * from `" . VAC_PREFIX . "_usg` where birth > $today and vaccine < 2";
//   $query = $db->query($sql);
//   $index = 1;
//   while ($vac = $query->fetch()) {
//     $sql = "select * from `" . VAC_PREFIX . "_pet` where id = $vac[petid]";
//     $pet_query = $db->query($sql);
//     $pet = $pet_query->fetch();

//     $sql = "select * from `" . VAC_PREFIX . "_custom` where id = $pet[customerid]";
//     $custom_query = $db->query($sql);
//     $custom = $custom_query->fetch();

//     $xtpl->assign("index", $index ++);
//     $xtpl->assign("customer", $custom["name"]);
//     $xtpl->assign("id", $vac["id"]);
//     $xtpl->assign("vaccome", date("d/m/Y", $vac["cometime"]));
//     $xtpl->assign("vaccame", date("d/m/Y", $vac["calltime"]));
//     $xtpl->assign("status", $lang_module["vacstatusname"][$vac["status"]]);
//     $xtpl->assign("note", $vac["status"]);
//     $xtpl->parse("main.row");
//   }

//   $xtpl->parse("main");
//   return $xtpl->text();
// }

// function vaccine_overdate() {
//   global $db, $lang_module;
//   // ini
//   $xtpl = new XTemplate("vaccine_overdate.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);

//   $today = time();
//   $sql = "select * from `" . VAC_PREFIX . "_vaccine` where calltime < $today and vaccine < 2";
//   $query = $db->query($sql);
//   $index = 1;
//   while ($vac = $query->fetch()) {
//     $sql = "select * from `" . VAC_PREFIX . "_pet` where id = $vac[petid]";
//     $pet_query = $db->query($sql);
//     $pet = $pet_query->fetch();

//     $sql = "select * from `" . VAC_PREFIX . "_custom` where id = $pet[customerid]";
//     $custom_query = $db->query($sql);
//     $custom = $custom_query->fetch();

//     $xtpl->assign("index", $index ++);
//     $xtpl->assign("customer", $custom["name"]);
//     $xtpl->assign("id", $vac["id"]);
//     $xtpl->assign("vaccome", date("d/m/Y", $vac["cometime"]));
//     $xtpl->assign("vaccame", date("d/m/Y", $vac["calltime"]));
//     $xtpl->assign("status", $lang_module["vacstatusname"][$vac["status"]]);
//     $xtpl->assign("note", $vac["status"]);
//     $xtpl->parse("main.row");
//   }

//   $xtpl->parse("main");
//   return $xtpl->text();
// }

// function vaccine_overdate() {
//   global $db, $lang_module;
//   // ini
//   $xtpl = new XTemplate("overdate-vaccine.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);

//   $today = time();
//   $sql = "select * from `" . VAC_PREFIX . "_vaccine` where calltime < $today and vaccine < 2";
//   $query = $db->query($sql);
//   $index = 1;
//   while ($vac = $query->fetch()) {
//     $sql = "select * from `" . VAC_PREFIX . "_pet` where id = $vac[petid]";
//     $pet_query = $db->query($sql);
//     $pet = $pet_query->fetch();

//     $sql = "select * from `" . VAC_PREFIX . "_custom` where id = $pet[customerid]";
//     $custom_query = $db->query($sql);
//     $custom = $custom_query->fetch();

//     $xtpl->assign("index", $index ++);
//     $xtpl->assign("customer", $custom["name"]);
//     $xtpl->assign("id", $vac["id"]);
//     $xtpl->assign("vaccome", date("d/m/Y", $vac["cometime"]));
//     $xtpl->assign("vaccame", date("d/m/Y", $vac["calltime"]));
//     $xtpl->assign("status", $lang_module["vacstatusname"][$vac["status"]]);
//     $xtpl->assign("note", $vac["status"]);
//     $xtpl->parse("main.row");
//   }

//   $xtpl->parse("main");
//   return $xtpl->text();
// }

// function overdate_list() {
//   global $nv_Request;
//   $tab = array("vaccine", "usg", "birth", "treat");
//   $r_tab = $nv_Request->get_string("tab", "get/post", "");
//   if (in_array($r_tab, $tab) !== false) {
//     $method = $r_tab . "_overdate";
//     $result = call_user_func($method);
//     return $result;
//   }
//   return "";
// }

// function overdate() {
//   global $db, $lang_module, $module_info, $module_file;
//   // initial
//   $xtpl = new XTemplate("overdate.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
//   $xtpl->assign("lang", $lang_module);
//   $xtpl->assign("content", overdate_list());
//   $xtpl->parse("main");

//   return $xtpl->text();
// }

function update_vaccine_filter($filter, $limit)
{
  global $db, $user_info;
  $sql = "update `" . VAC_PREFIX . "_config` set vac_s = '$filter', vac_f = $limit where userid = " . $user_info["user_id"];
  $config_query = $db->query($sql);
  if ($config_query) {
    return 1;
  }
  return 0;
}

function update_usg_filter($filter, $limit)
{
  global $db, $user_info;
  $sql = "update `" . VAC_PREFIX . "_config` set usg_s = '$filter', usg_f = $limit where userid = " . $user_info["userid"];
  $config_query = $db->query($sql);
  if ($config_query) {
    return 1;
  }
  return 0;
}

function update_treat_filter($filter, $limit)
{
  global $db, $user_info;
  $sql = "update `" . VAC_PREFIX . "_config` set treat_s = '$filter', treat_f = $limit where userid = " . $user_info["user_id"];
  $config_query = $db->query($sql);
  if ($config_query) {
    return 1;
  }
  return 0;
}

function user_vaccine($keyword = '')
{
  global $nv_Request, $db, $module_config, $module_name, $module_info, $module_file, $lang_module, $vacconfigv2;
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

function spa_list()
{
  global $db, $module_info, $module_file, $lang_module, $global_config;
  $xtpl = new XTemplate("spa-list.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
  $status = array("Chưa xong", "Đã xong");
  $from = strtotime(date("Y-m-d"));
  $end = $from + 60 * 60 * 24;
  $index = 1;
  $image = "<img src='/themes/" . $global_config["site_theme"] . "/images/" . $module_file . "/payment.gif'>";
  $xtpl->assign("lang", $lang_module);

  $sql = "select * from `" . VAC_PREFIX . "_doctor`";
  $doctor_query = $db->query($sql);
  $doctor = array();
  while ($doctor_row = $doctor_query->fetch()) {
    $doctor[$doctor_row["id"]] = $doctor_row;
  }

  $sql = "select * from `" . VAC_PREFIX . "_spa` where time between $from and $end order by id";
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
    } else {
      $row["done"] = $status[0];
    }
    if ($row["payment"]) {
      $xtpl->assign("payment", $image);
    } else {
      $xtpl->assign("payment", "");
    }
    $xtpl->assign("id", $row["id"]);
    $xtpl->assign("spa_doctor", $doctor[$row["doctorid"]]["name"]);
    $xtpl->assign("customer_name", $customer["name"]);
    $xtpl->assign("customer_number", $customer["phone"]);
    $xtpl->assign("spa_from", date("H:i:s", $row["time"]));
    $xtpl->assign("spa_end", $row["done"]);
    $xtpl->assign("image", $row["image"]);
    $xtpl->parse("main");
    $index++;
  }
  $text = $xtpl->text();
  return $text;
}

function admin_spa()
{
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
    } else {
      $row["done"] = $status[0];
    }
    $xtpl->assign("id", $row["id"]);
    $xtpl->assign("spa_doctor", $doctor[$row["doctorid"]]["name"]);
    $xtpl->assign("customer_name", $customer["name"]);
    $xtpl->assign("customer_number", $customer["phone"]);
    $xtpl->assign("spa_from", date("H:i:s", $row["time"]));
    $xtpl->assign("spa_end", $row["done"]);
    $xtpl->parse("main");
    $index++;
  }
  $text = $xtpl->text();
  return $text;
}

function vaccine_list($vaclist, $order = 0)
{
  global $db, $module_info, $module_file, $lang_module, $nv_Request, $vacconfigv2;
  // initial
  $hex = array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f");
  $xtpl = new XTemplate("list-1.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
  $xtpl->assign("lang", $lang_module);
  $now = strtotime(date("Y-m-d"));
  $index = 1;
  $status_array = array();
  $status_array[0] = array();
  $status_array[1] = array();
  $status_array[2] = array();
  $status_array[4] = array();

  // cnote
  $cnote = $nv_Request->get_string('cnote', 'get/post', "");
  if ($cnote == 0) {
    $xtpl->assign("cnote", "none");
  } else {
    $xtpl->assign("cnote", "table-row");
  }

  // page
  $page = $nv_Request->get_string('page', 'get/post', "");
  $sort_by = "calltime";
  if ($page == "today") {
    $sort_by = "cometime";
  }

  // divide into 3 part
  foreach ($vaclist as $key => $row) {
    $status_array[$row["status"]][] = $key;
  }
  krsort($status_array);

  // sort by calltime
  $t_list = array();
  foreach ($status_array as $akey => $status_list) {
    $price = array();
    foreach ($status_list as $lkey => $status_row) {
      $price[$status_row] = $vaclist[$status_row][$sort_by];
    }
    if ($akey == "0") {
      $sort_order_left = array();
      $sort_order_right = array();
      foreach ($price as $lkey => $status_row) {
        if ($row[$sort_by] < $now) {
          $sort_order_right[] = $lkey;
        } else {
          $sort_order_left[] = $lkey;
        }
      }
      asort($sort_order_left);
      arsort($sort_order_right);
      $sort = array();
      $sort = array_merge($sort_order_left, $sort_order_right);
      $t_list = array_merge($t_list, $sort);
    } else {
      arsort($price);
      foreach ($price as $key => $value) {
        $t_list[] = $key;
      }
    }
  }

  // display
  $id = $nv_Request->get_int('id', 'post/get', 0);
  $keyword = $nv_Request->get_string('keyword', 'post/get', '');
  if (empty($keyword) && $id < 2) {
    $today = strtotime(date('Y/m/d'));
    $fromtime = $today - $vacconfigv2['filter'];
    $diseases = getDiseaseData();

    // $sql = 'select * from (select * from `'.VAC_PREFIX.'_vaccine` where (calltime < '.$fromtime.') and status = 0 order by calltime desc limit 20) a order by calltime asc';
    $sql = 'select * from `' . VAC_PREFIX . '_vaccine` where (calltime < ' . $today . ') and status = ' . $id . ' order by calltime desc limit 20';
    // die($sql);
    $query = $db->query($sql);
    $index = 1;
    $xtpl->assign("brickcolor", "orange");

    while ($row = $query->fetch()) {
      $pet = selectPetId($row['petid']);
      $customer = selectCustomerId($pet['customerid']);

      $xtpl->assign("index", $index);
      $xtpl->assign("petname", $pet["name"]);
      $xtpl->assign("petid", $row["petid"]);
      $xtpl->assign("vacid", $row["id"]);
      $xtpl->assign("customer", $customer["name"]);
      $xtpl->assign("phone", $customer["phone"]);
      $xtpl->assign("diseaseid", $row["diseaseid"]);
      $xtpl->assign("disease", $diseases[$row["diseaseid"]]);
      $xtpl->assign("note", $row["note"]);
      $xtpl->assign("confirm", $lang_module["confirm_" . $row["status"]]);

      // if ($row["status"] > 1) {
      //   $xtpl->parse("disease.vac_body.recall_link");
      // }
      switch ($row["status"]) {
        case '1':
          $xtpl->assign("color", "yellow");
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
      $xtpl->assign("cometime", date("d/m/Y", $row["cometime"]));
      if ($id == 2) {
        $xtpl->assign("calltime", date("d/m/Y", $row["recall"]));
      } else {
        $xtpl->assign("calltime", date("d/m/Y", $row["calltime"]));
      }
      $index++;
      $xtpl->parse("disease.vac_body");
    }
  }
  $xtpl->assign("brickcolor", "");

  foreach ($t_list as $key => $value) {
    $xtpl->assign("index", $index);
    $xtpl->assign("petname", $vaclist[$value]["petname"]);
    $xtpl->assign("petid", $vaclist[$value]["petid"]);
    $xtpl->assign("vacid", $vaclist[$value]["id"]);
    $xtpl->assign("customer", $vaclist[$value]["customer"]);
    $xtpl->assign("phone", $vaclist[$value]["phone"]);
    $xtpl->assign("diseaseid", $vaclist[$value]["diseaseid"]);
    $xtpl->assign("disease", $vaclist[$value]["disease"]);
    $xtpl->assign("note", $vaclist[$value]["note"]);
    $xtpl->assign("confirm", $lang_module["confirm_" . $vaclist[$value]["status"]]);

    // if ($vaclist[$value]["status"] > 1) {
    //   $xtpl->parse("disease.vac_body.recall_link");
    // }
    switch ($vaclist[$value]["status"]) {
      case '1':
        $xtpl->assign("color", "yellow");
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
    $xtpl->assign("cometime", date("d/m/Y", $vaclist[$value]["cometime"]));
    if ($id == 2) {
      $xtpl->assign("calltime", date("d/m/Y", $vaclist[$value]["recall"]));
    } else {
      $xtpl->assign("calltime", date("d/m/Y", $vaclist[$value]["calltime"]));
    }
    $index++;
    $xtpl->parse("disease.vac_body");
  }
  $xtpl->parse("disease");
  return $xtpl->text("disease");
}

function nv_generate_page_shop($base_url, $num_items, $per_page, $start_item, $add_prevnext_text = true, $onclick = false, $js_func_name = 'nv_urldecode_ajax', $containerid = 'generate_page')
{
  global $lang_global;
  $start_item = ($start_item - 1) * $per_page;

  $total_pages = ceil($num_items / $per_page);
  if ($total_pages == 1)
    return '';
  @$on_page = floor($start_item / $per_page) + 1;
  $amp = preg_match("/\?/", $base_url) ? "&amp;" : "?";
  $page_string = "";
  if ($total_pages > 10) {
    $init_page_max = ($total_pages > 3) ? 3 : $total_pages;
    for ($i = 1; $i <= $init_page_max; $i++) {
      $href = !$onclick ? "href=\"" . $base_url . $amp . "page=" . ($i) . "\"" : "href=\"javascript:void(0)\" onclick=\"" . $js_func_name . "('" . rawurlencode(nv_unhtmlspecialchars($base_url . $amp . "page=" . ($i))) . "','" . $containerid . "')\"";
      $page_string .= ($i == $on_page) ? "<strong>" . $i . "</strong>" : "<a " . $href . ">" . $i . "</a>";
      if ($i < $init_page_max)
        $page_string .= " ";
    }
    if ($total_pages > 3) {
      if ($on_page > 1 && $on_page < $total_pages) {
        $page_string .= ($on_page > 5) ? " ... " : ", ";
        $init_page_min = ($on_page > 4) ? $on_page : 5;
        $init_page_max = ($on_page < $total_pages - 4) ? $on_page : $total_pages - 4;
        for ($i = $init_page_min - 1; $i < $init_page_max + 2; $i++) {
          $href = !$onclick ? "href=\"" . $base_url . $amp . "page=" . ($i) . "\"" : "href=\"javascript:void(0)\" onclick=\"" . $js_func_name . "('" . rawurlencode(nv_unhtmlspecialchars($base_url . $amp . "page=" . ($i))) . "','" . $containerid . "')\"";
          $page_string .= ($i == $on_page) ? "<strong>" . $i . "</strong>" : "<a " . $href . ">" . $i . "</a>";
          if ($i < $init_page_max + 1) {
            $page_string .= " ";
          }
        }
        $page_string .= ($on_page < $total_pages - 4) ? " ... " : ", ";
      } else {
        $page_string .= " ... ";
      }

      for ($i = $total_pages - 2; $i < $total_pages + 1; $i++) {
        $href = !$onclick ? "href=\"" . $base_url . $amp . "page=" . ($i) . "\"" : "href=\"javascript:void(0)\" onclick=\"" . $js_func_name . "('" . rawurlencode(nv_unhtmlspecialchars($base_url . $amp . "page=" . ($i))) . "','" . $containerid . "')\"";
        $page_string .= ($i == $on_page) ? "<strong>" . $i . "</strong>" : "<a " . $href . ">" . $i . "</a>";
        if ($i < $total_pages) {
          $page_string .= " ";
        }
      }
    }
  } else {
    for ($i = 1; $i < $total_pages + 1; $i++) {
      $href = !$onclick ? "href=\"" . $base_url . $amp . "page=" . ($i) . "\"" : "href=\"javascript:void(0)\" onclick=\"" . $js_func_name . "('" . rawurlencode(nv_unhtmlspecialchars($base_url . $amp . "page=" . ($i - 1))) . "','" . $containerid . "')\"";
      $page_string .= ($i == $on_page) ? "<strong>" . $i . "</strong>" : "<a " . $href . ">" . $i . "</a>";
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
// Nếu quá giờ làm việc sẽ chặn đường vào
function quagio()
{
  global $module_config, $admin_info, $module_info, $module_name, $module_file, $lang_module;
  // $today = strtotime(date("Y-m-d"));
  // $worktime = 0;
  // $resttime = 0;
  // if (!empty($module_config[$module_name]["worktime"])) {
  //   $worktime = $module_config[$module_name]["worktime"];
  // }
  // else {
  //   $worktime = 7 * 60 * 60;
  // }
  // if (!empty($module_config[$module_name]["resttime"])) {
  //   $resttime = $module_config[$module_name]["resttime"];
  // }
  // else {
  //   $resttime = 17 * 60 * 60 + 30 * 60;
  // }
  // $from = $today + $worktime;
  // $end = $today + $resttime;

  // if (!empty($admin_info) && !empty($admin_info["level"]) && ($admin_info["level"] == "1")) {

  // }
  // else if (NV_CURRENTTIME < $from || NV_CURRENTTIME > $end) {
  //   // echo date("H:i:s", $worktime); 
  //   // echo date("H:i:s", $resttime); 
  //   $xtpl = new XTemplate("overtime.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
  //   $xtpl->assign("lang", $lang_module);

  //   $xtpl->parse("overtime");
  //   $contents = $xtpl->text("overtime");
  //   include ( NV_ROOTDIR . "/includes/header.php" );
  //   echo nv_site_theme($contents);
  //   include ( NV_ROOTDIR . "/includes/footer.php" );
  // }
}
function fetchall($db, $query)
{
  $result = array();
  while ($row = $query->fetch()) {
    $result[] = $row;
  }
  return $result;
}
// Thay đổi màu trong lưu bệnh
function mauluubenh($ketqua, $tinhtrang)
{
  switch ($ketqua) {
    case 1:
      $color = "#ccc";
      break;
    case 2:
      $color = "#f44";
      break;
    default:
      switch ($tinhtrang) {
        case 0:
          $color = "#2d2";
          break;
        case 1:
          $color = "#4a2";
          break;
        case 2:
          $color = "#aa2";
          break;
        case 3:
          $color = "#f62";
          break;
      }
  }
  return $color;
}

function get_user_config()
{
  global $db, $user_info;
  if (empty($user_info)) {
    return array('id' => 0, 'userid' => 0, 'vac_s' => '0124', 'usg_s' => '012', 'treat_s' => '012', 'vac_f' => '20', 'usg_f' => '20', 'treat_f' => '20');
  }
  $sql = "select * from `" . VAC_PREFIX . "_config` where userid = " . $user_info["userid"];
  $config_query = $db->query($sql);
  $config = $config_query->fetch();
  if ($config) {
    return $config;
  } else {
    $sql = "insert into `" . VAC_PREFIX . "_config` (userid, vac_s, usg_s, treat_s, vac_f, usg_f, treat_f) values (" . $user_info["userid"] . ", '012', '012', '012', '20', '20', '20')";
    $config_query = $db->query($sql);
    $sql = "select * from `" . VAC_PREFIX . "_config` limit 0";
    $config_query = $db->query($sql);
    $config = $config_query->fetch();
    if ($config && $config_query) {
      return $config;
    } else {
      return array('id' => 0, 'userid' => 0, 'vac_s' => '0124', 'usg_s' => '012', 'treat_s' => '012', 'vac_f' => '20', 'usg_f' => '20', 'treat_f' => '20');
    }
  }
}


function totime($time)
{
  if (preg_match("/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/", $time, $m)) {
    $time = mktime(0, 0, 0, $m[2], $m[1], $m[3]);
  } else {
    $time = time();
  }
  return $time;
}

function getUserList()
{
  global $db, $db_config;

  $sql = 'select userid, first_name, last_name from `' . $db_config['prefix'] . '_users`';
  $query = $db->query($sql);
  $list = array();

  while ($row = $query->fetch()) {
    $list[$row['userid']] = $row;
  }
  return $list;
}

function checkRow($module, $id)
{
  global $db;

  $sql = 'select * from `' . VAC_PREFIX . '_' . $module . '` where id = ' . $id;
  $query = $db->query($sql);

  if ($row = $query->fetch()) {
    return $row;
  }
  return 0;
}

function getPetById($id)
{
  global $db;

  $sql = "select * from `". VAC_PREFIX ."_pet` where id = " . $id;
  $query = $db->query($sql);
  return $query->fetch();
}
