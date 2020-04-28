<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_NEWS')) die('Stop!!!');

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'submit':
      $data = $nv_Request->get_array('data', 'post');
      $list = $nv_Request->get_array('list', 'post');

      $sql = "insert into `". UPREFIX ."_happy` (fullname, name, species, mobile, address, image) values('$data[fullname]', '$data[name]', '$data[species]', '$data[mobile]', '$data[address]', '". implode(',', $list) ."')";
      
      if ($db->query($sql)) {
        $result['status'] = 1;
      }
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH2);
$xtpl->assign('module_name', $module_name);
$page_title = 'Đăng ký tham gia ngày yêu thương';

// function: kiểm tra userid cấp quyền
// danh sách trên modal, xuất danh sách đăng ký, chỉ xem chi tiết

if (!empty($user_info) && checkLevel($user_info['userid'])) {
  $xtpl->parse('main.manager');
}

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . "/modules/$module_file/template/layout/header.php";
echo $contents;
include NV_ROOTDIR . "/modules/$module_file/template/layout/footer.php";
