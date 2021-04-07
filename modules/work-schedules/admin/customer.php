<?php

/**
 * @Project WORK SCHEDULES 4.X
 * @Author PHAN TAN DUNG (phantandung92@gmail.com)
 * @Copyright (C) 2016 PHAN TAN DUNG. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Sat, 11 Jun 2016 23:45:51 GMT
 */
if (!defined('NV_IS_FILE_ADMIN')) {
  die('Stop!!!');
}

$action = $nv_Request->get_string("action", "get/post", "");
if (!empty($action)) {
  $result = array("status" => 0, "notify" => $lang_module["g_error"]);
  switch ($action) {
    case 'insert':
      $name = $nv_Request->get_string("name", "get/post", "");
      $address = $nv_Request->get_string("address", "get/post", "");
      if (!empty($name) && !empty($address)) {
        $sql = "select * from `" . WORK_PREFIX . "_customer` where name = '$name' or address = '$address'";
        $query = $db->query($sql);
        if (empty($row = $query->fetch())) {
          $sql = "insert into `" . WORK_PREFIX . "_customer` (name, address) values ('$name', '$address')";
          $query = $db->query($sql);
          if ($query) {
            $result["status"] = 1;
            $result["list"] = customer_list();
            $result["notify"] = $lang_module["g_saved"];
          }
        }
      }
      else {
        $result["notify"] = $lang_module["name_existed"];
      }
    break;
    case 'update':
      $id = $nv_Request->get_string("id", "get/post", "");
      $name = $nv_Request->get_string("name", "get/post", "");
      $address = $nv_Request->get_string("address", "get/post", "");

      if (!empty($id) && !empty($name) && !empty($address)) {
        $sql = "select * from `" . WORK_PREFIX . "_customer` where name = '$name' or address = '$address'";
        $query = $db->query($sql);

        if (!empty($row = $query->fetch())) {
          $sql = "update `" . WORK_PREFIX . "_customer` set name = '$name', address = '$address' where id = $id";
          $query = $db->query($sql);

          if ($query) {
            $result["status"] = 1;
            $result["list"] = customer_list();
            $result["notify"] = $lang_module["saved"];
          }
        }
      }
      else {
        $result["notify"] = $lang_module["name_existed"];
      }
    break;
    case 'get_edit':
      $id = $nv_Request->get_string("id", "get/post", "");
      if (!empty($id)) {
        $sql = "select * from `" . WORK_PREFIX . "_customer` where id = '$id'";
        $query = $db->query($sql);
        if (!empty($row = $query->fetch())) {
          $result["status"] = 1;
          $result["name"] = $row["name"];
          $result["address"] = $row["address"];
        }
      }
    break;
    case 'remove':
      $id = $nv_Request->get_string("id", "get/post", "");
      if (!empty($id)) {
        $sql = "select * from `" . WORK_PREFIX . "_customer` where id = $id";
        $query = $db->query($sql);
        if (!empty($row = $query->fetch())) {
          $sql = "delete from `" . WORK_PREFIX . "_customer` where id = $id";
          $query = $db->query($sql);
          if ($query) {
            $result["status"] = 1;
            $result["list"] = customer_list();
            $result["notify"] = $lang_module["saved"];
          }
        }
      }
      else {
        $result["notify"] = $lang_module["name_existed"];
      }
    break;
  }
  echo json_encode($result);
  die();
}


$xtpl = new XTemplate('customer.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
$xtpl->assign('lang', $lang_module);


$xtpl->assign('content', customer_list());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
