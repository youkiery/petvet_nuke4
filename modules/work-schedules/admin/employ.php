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
    case 'remove':
      $id = $nv_Request->get_string("id", "get/post", "");

      if (!empty($id)) {
        $sql = "delete from `" . WORK_PREFIX . "_employ` where userid = $id";

        if ($db->query($sql)) {
          $result["status"] = 1;
          $result["notify"] = $lang_module["g_saved"];
          $result["list"] = employ_list();
        }
      }
    break;

    case 'edit':
      $userid = $nv_Request->get_string("userid", "get/post", "");
      $depart_list = $nv_Request->get_array("depart", "get/post", "");

      if (!empty($userid) && !empty($depart_list)) {
        $sql = "select * from `" . WORK_PREFIX . "_employ` where userid = $userid";
        $query = $db->query($sql);

        foreach ($depart_list as $key => $value) {
          $array = array("depart" => $value, "action" => 1); // 0: nothing, 1: insert, 2: delete
          $depart_list[$key] = $array;
        }
        
        while ($row = $query->fetch()) {
          $position = in_array($row["depart"], $depart_list["depart"]);

          if ($position != false) {
            $depart_list[$position]["action"] = 0;
          }
          else {
            $depart_list[$position]["action"] = 1;
          }
        }
        var_dump($depart_list);
        die();
      }
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate('employ.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
$xtpl->assign('lang', $lang_module);

$xtpl->assign('content', employ_list());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
