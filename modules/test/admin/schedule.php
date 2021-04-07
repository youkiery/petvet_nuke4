<?php
/**
* @Project NUKEVIET-MUSIC
* @Phan Tan Dung (phantandung92@gmail.com)
* @Copyright (C) 2011
* @Createdate 26-01-2011 14:43
*/

if (!defined('NV_IS_QUANLY_ADMIN')) die('Stop!!!');

$action = $nv_Request->get_string('action', 'post/get', "");
if($action) {
	$result = array("status" => 0);
	switch ($action) {
    case "save":
      $userid = $nv_Request->get_string("userid", "get/post", "");
      $restday = $nv_Request->get_string("restday", "get/post", "");

      if (!empty($userid) && !empty($restday)) {
        $restday = totime($restday);
        $sql = "insert into `" . VAC_PREFIX . "_schedule` (userid, time, ctime) values($userid, $restday, " . time() . ")";
        $query = $db->query($sql);
        if ($query) {
          $result["status"] = 1;
          $result["notify"] = $lang_module["saved"];
          $result["list"] = admin_schedule();
        }
        else {
          $result["notify"] = $lang_module["error"];
        }
      }

      break;

    case "remove":
      $id = $nv_Request->get_string("id", "get/post", "");

      if (!empty($id)) {
        $result["notify"] = $lang_module["error"];
        $sql = "delete from `" . VAC_PREFIX . "_schedule` where id = $id";
        $query = $db->query($sql);
        if ($query) {
          $result["status"] = 1;
          $result["notify"] = $lang_module["saved"];
          $result["list"] = admin_schedule();
        }
      }

      break;

    case "get_user":
      $user = $nv_Request->get_string("user", "get/post", "");

      if (!empty($user)) {
        $sql = "select * from `" . $db_config["prefix"] . "_users` where username like'%$user%' limit 50";
        $query = $db->query($sql);
        $xtpl = new XTemplate("schedule-suggest.tpl", NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file);

        while ($user = $query->fetch()) {
          $xtpl->assign("id", $user["userid"]);
          $xtpl->assign("user", $user["username"]);
          $xtpl->parse("main");
        }

        $result["status"] = 1;
        $result["list"] = $xtpl->text();
      }
		break;
	} 
	
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("schedule.tpl", NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file);
$page_title = $lang_module["schedule_title"];

$xtpl->assign("lang", $lang_module);
$xtpl->assign("content", admin_schedule());

$xtpl->parse("main");
$contents = $xtpl->text();

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");


