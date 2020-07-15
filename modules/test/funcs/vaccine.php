<?php
/**
* @Project NUKEVIET-MUSIC
* @Phan Tan Dung (phantandung92@gmail.com)
* @Copyright (C) 2011
* @Createdate 26-01-2011 14:43
*/
if ( ! defined( 'NV_IS_MOD_QUANLY' ) ) die( 'Stop!!!' );

$filter = array(
  'page' => $nv_Request->get_int('page', 'get', 0),
  'status' => $nv_Request->get_int('status', 'get', 0),
  'keyword' => $nv_Request->get_string('keyword', 'get/post', '')
);

checkUserPermit(OVERCLOCK);

$action = $nv_Request->get_string("action", "get/post", "");
if (!empty($action)) {
  $result = array("status" => 0);
  switch ($action) {
    case 'get-customer':
      $id = $nv_Request->get_int('id', 'post');

      $sql = 'select * from `'. VAC_PREFIX .'_customer` where id = '. $id;
      $query = $db->query($sql);
      if (!empty($row = $query->fetch())) {
        $result['status'] = 1;
        $result['data'] = $row;
      }
    break;
    case 'edit-customer':
      // kiểm tra thông tin số điện thoại người dùng, nếu có, báo lỗi, nếu không, cập nhật
      $id = $nv_Request->get_int('id', 'post');
      $data = $nv_Request->get_array('data', 'post');
      
      $sql = 'select * from `'. VAC_PREFIX .'_customer` where id <> '. $id .' and phone = "'. $data['phone'] . '"';
      $query = $db->query($sql);
      if (!empty($row = $query->fetch())) {
        // Có sđt, báo lỗi
        $result['data'] = 2;
      }
      else {
        // cập nhật
        $sql = "update `" . VAC_PREFIX . "_customer` set name = '$data[name]', phone = '$data[phone]', address = '$data[address]' where id = $id";
        if ($db->query($sql)) {
          $result['status'] = 1;
        }
      }
    break;
    case 'customer-suggest':
      $keyword = $nv_Request->get_string('keyword', 'get/post', '');

      $sql = 'select * from `'. VAC_PREFIX .'_customer` where name like "%'.$keyword.'%" or phone like "%'.$keyword.'%" limit 20';
      $query = $db->query($sql);
      $html = '';
      while ($customer = $query->fetch()) {
        $html .= '<div class="hr"><div class="item_suggest item_suggest2" onclick="parseKeyword(\''.$customer['phone'].'\')">' . $customer['name'] . ' <br>' . $customer['phone'] . '</div><div class="item_suggest3" onclick="editCustomer('. $customer['id'] .')"> <p class="btn btn-info btn-xs"> sửa </p> </div></div><div style="clear: both;"></div>';
      }
      $result['status'] = 1;
      $result['html'] = $html;
    break;
    case 'search-all':
      $result['status'] = 1;
      $result['html'] = vaccineSearchAll();
    break;
    case 'change_custom':
    $id = $nv_Request->get_string('cid', 'post/get', "");
    $name = $nv_Request->get_string('name', 'post/get', "");
    $phone = $nv_Request->get_string('phone', 'post/get', "");
    $address = $nv_Request->get_string('address', 'post/get', "");
    $keyword = $nv_Request->get_string('keyword', 'post/get', "");

    if (!empty($name) && !empty($phone)) {
        $sql = "update `" . VAC_PREFIX . "_customer` set name = '$name', phone = '$phone', address = '$address' where id = $id";
        $query = $db->query($sql);
        if ($query) {
          $result["status"] = 1;
          $result["notify"] = $lang_module["saved"];
          $result["list"] = user_vaccine();
        }
    }
    break;
    case 'customer-remind':
      $name = $nv_Request->get_string('name', 'post', '');
      $type = $nv_Request->get_int('type', 'post', '');

      if ($type) {
        $list = getcustomer('', $name);
      }
      else {
        $list = getcustomer($name, '');
      }

      $html = '';
      foreach ($list as $customer) {
        $html .= '<div class="hr"><div class="item_suggest item_suggest2" onclick="selectCustomer('. $customer['id'] .', \''.$customer['name'].'\', \''.$customer['phone'].'\', `'. petOption($customer['id']) .'`)">' . $customer['name'] . ' <br>' . $customer['phone'] . '</div></div><div style="clear: both;"></div>';
      }
      $result["status"] = 1;
      $result["html"] = $html;
    break;
    case 'insert-pet':
      $name = $nv_Request->get_string('name', 'post', '');
      $id = $nv_Request->get_int('id', 'post', '');

      $sql = "insert into `". VAC_PREFIX ."_pet` (name, customerid) values('$name', $id)";
      $db->query($sql);

      $result["status"] = 1;
      $result["id"] = $id;
      $result["html"] = petOption($id);
    break;
    case 'insert-vaccine':
      $data = $nv_Request->get_array('data', 'post');

      // chuyển loại thời gian
      $data['cometime'] = totime($data['cometime']);
      $data['calltime'] = totime($data['calltime']);
      // kiểm tra $data, nếu customer trống, thêm khách hàng mới

      // kiểm tra sđt có trùng không
      // nếu trùng, lấy id
      // nếu chưa, thêm mới
      $sql = "select * from `" . VAC_PREFIX . "_customer` where phone = '$data[phone]'";
      $query = $db->query($sql);
      if (!empty($customer = $query->fetch())) {
        $data['customer'] = $customer['id'];
        $sql = "update `" . VAC_PREFIX . "_customer` set name = '$data[name]', address = '$data[address]' where phone = '$data[phone]'";
        $db->query($sql);
      }
      else {
        $sql = "insert into `" . VAC_PREFIX . "_customer` (name, phone, address) values ('$data[name]', '$data[phone]', '$data[address]');";
        $db->query($sql);
        $data['customer'] = $db->lastInsertId();
        
        $sql = "insert into `" . VAC_PREFIX . "_pet` (name, customerid) values ('Chưa đặt tên', $data[customer]);";
        $db->query($sql);
        $data['pet'] = $db->lastInsertId();
      }
      
      if (empty($data['pet'])) {
        // thêm thú cưng mặc định
        $sql = "insert into `" . VAC_PREFIX . "_pet` (name, customerid) values ('Chưa đặt tên', $data[customer]);";
        $db->query($sql);
        $data['pet'] = $db->lastInsertId();
      }

      // kiểm tra phiếu vaccine trước đó 
      // nếu có, cập nhật trạng thái
      $sql = "select * from " . VAC_PREFIX . "_vaccine where petid = $data[pet] order by id desc limit 1";
      $query = $db->query($sql);
      if ($row = $query->fetch()) {
        $sql = "update " . VAC_PREFIX . "_vaccine set status = 2, recall = $data[calltime] where id = $row[id]";
        $db->query($sql);
      }
          
      // thêm phiếu vaccine
      $sql = "insert into `" . VAC_PREFIX . "_vaccine` (petid, cometime, calltime, doctorid, note, status, diseaseid, recall, ctime) values ($data[pet], $data[cometime], $data[calltime], $data[doctor], '$data[note]', 0, $data[disease], 0, " . time() . ");";
      $query = $db->query($sql);
      $id = $db->lastInsertId();
      $result['status'] = 1;
      $result['html'] = vaccineContent();
      break;
      case 'change-status':
        $id = $nv_Request->get_int('id', 'post');
        $type = $nv_Request->get_int('type', 'post');

        $sql = "update `". VAC_PREFIX ."_vaccine` set status = ". ($filter['status'] + ($type ? 1 : -1)) ." where id = " . $id;
        $db->query($sql);
        $result['status']  = 1;
        $result['html'] = vaccineContent();
      break;
      case 'edit-note':
        $id = $nv_Request->get_int('id', 'post');
        $text = $nv_Request->get_string('text', 'post');

        $sql = "update `". VAC_PREFIX ."_vaccine` set note = '$text' where id = " . $id;
        $db->query($sql);
        $result['status'] = 1;
      break;
  }
  echo json_encode($result);
  die();
}
// initial
$xtpl = new XTemplate("main.tpl", PATH2);
$page_title = $lang_module["main_title"];
$xtpl->assign("lang", $lang_module);
$xtpl->assign("nv", $module_name);
$xtpl->assign("op", $op);

$xtpl->assign("page", $filter['page']);
$xtpl->assign("status", $filter['status']);
// keyword
$keyword = $nv_Request->get_string('keyword', 'get', '');
$xtpl->assign("keyword", $keyword);
// // status

foreach ($lang_module["vacstatusname"] as $key => $value) {
  if ($key == $filter['status']) {
    $check = "btn-info";
  }
  else {
    $check = "btn-default";
  }
  $xtpl->assign("check", $check);
  $xtpl->assign("ipd", $key);
  $xtpl->assign("vsname", $value);
  $xtpl->parse("main.filter");
}
// doctor
$sql = "select * from " . VAC_PREFIX . "_doctor";
$query = $db->query($sql);
while($row = $query->fetch()) {
  $xtpl->assign("doctorid", $row["id"]);
  $xtpl->assign("doctorname", $row["name"]);
  $xtpl->parse("main.doctor");
}

$xtpl->assign("modal", vaccineModal());
$xtpl->assign('content', vaccineContent());
$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme( $contents );
include ( NV_ROOTDIR . "/includes/footer.php" );
