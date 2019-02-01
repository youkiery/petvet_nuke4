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
    case 'add':
      $userid = $nv_Request->get_string("userid", "get/post", "");
      $depart = $nv_Request->get_array("depart", "get/post");

      if (!empty($depart) && !empty($userid)) {
        foreach ($depart as $key => $value) {
          $sql = "insert into `" . WORK_PREFIX . "_employ` (userid, depart, role) values ($userid, $key, " . $value["value"] . ")";
          $db->query($sql);
        }
        $result["status"] = 1;
        $result["list"] = employ_list();
        $result["notify"] = $lang_module["saved"];
      }
      else {
        $result["notify"] = $lang_module["noselect"];
      }

    break;

    case 'edit':
      $userid = $nv_Request->get_string("userid", "get/post", "");
      $depart = $nv_Request->get_array("depart", "get/post", "");

      if (!empty($depart) && !empty($userid)) {
        $sql = "select * from `" . WORK_PREFIX . "_employ` where userid = $userid";
        $query = $db->query($sql);
        while ($employ = $query->fetch()) {
          if (empty($depart[$employ["depart"]])) {
            $depart[$employ["depart"]]["action"] = 2; // insert
          }
          else {
            $depart[$employ["depart"]]["action"] = 3;  // do nothing
          }
        }

        foreach ($depart as $key => $value) {
          $sql = "";
          switch ($value["action"]) {
            case '1':
              $sql = "insert into `" . WORK_PREFIX . "_employ` (userid, depart, role) values ($userid, $key, " . $value["value"] . ")";
              break;
            case '2':
              $sql = "delete from `" . WORK_PREFIX . "_employ` where userid = $userid and depart = $key";
              break;
            case '3':
              $sql = "update `" . WORK_PREFIX . "_employ` set role = " . $value["value"] . " where userid = $userid and depart = $key";
              break;
          }
          if (!empty($sql)) {
            $db->query($sql);
          }
        }
        $result["status"] = 1;
        $result["list"] = employ_list();
        $result["notify"] = $lang_module["saved"];
      }

    break;

    case 'search':
      $xtpl = new XTemplate('employ-search.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] .  '/modules/' . $module_file);
      $xtpl->assign("lang", $lang_module);
      $index = 1;

      $sql = "select * from `" . $db_config["prefix"] . "_users` where userid not in (select userid from `" . WORK_PREFIX . "_employ` group by userid)";
      $query = $db->query($sql);
      while ($user = $query->fetch()) {
        $xtpl->assign("index", $index ++);
        $xtpl->assign("id", $user["userid"]);
        $xtpl->assign("employ_name", $user["username"]);
        $xtpl->parse("main");
      }
      $result["status"] = 1;
      $result["list"] = $xtpl->text();
      $result["notify"] = "";
    break;

    case 'get_employ':
      $userid = $nv_Request->get_string("userid", "get/post", "");

      if (!empty($userid)) {
        $xtpl = new XTemplate('employ-suggest.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
        $xtpl->assign("lang", $lang_module);

        $sql = "select * from `" . WORK_PREFIX . "_employ` where userid = $userid";
        $query = $db->query($sql);
        $employ_depart_list = array();
        $employ_role_list = array();
        while ($employ = $query->fetch()) {
          $employ_depart_list[] = $employ["depart"];
          $employ_role_list[] = $employ["role"];
        }

        $sql = "select * from `" . WORK_PREFIX . "_depart` order by id";
        $query = $db->query($sql);
        while ($depart = $query->fetch()) {
          $xtpl->assign("id", $depart["id"]);
          $xtpl->assign("depart", $depart["name"]);
          $check1 = "";
          $check2 = "";
          $index = array_search($depart["id"], $employ_depart_list);
          if ($index !== false) {
            if ($employ_role_list[$index] == 1) {
              $check1 = "checked";
            }
            else {
              $check2 = "checked";
            }
          }
          $xtpl->assign("check1", $check1);
          $xtpl->assign("check2", $check2);
          $xtpl->parse("main.row");
        }
        $xtpl->parse("main");
        // die();
        $result["status"] = 1;
        $result["list"] = $xtpl->text();
      }
      break;

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

$sql = "select * from `" . WORK_PREFIX . "_depart` order by id";
$query = $db->query($sql);
while ($depart = $query->fetch()) {
  $xtpl->assign("id", $depart["id"]);
  $xtpl->assign("depart", $depart["name"]);
  $xtpl->parse("main.row");
}

$xtpl->assign('content', employ_list());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
