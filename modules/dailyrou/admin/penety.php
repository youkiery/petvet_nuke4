<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_ADMIN_DAILY')) {
	die('Stop!!!');
}

$page_title = "Nghỉ phạt";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
    case 'filter':
			$filter = $nv_Request->get_array("filter", "post");
      $html = penetyList($filter);

      if (!empty($html)) {
        $result['status'] = 1;
        $result['html'] = $html;
      }
    break;
		case 'change':
			$id = $nv_Request->get_string("id", "get/post", "");
      $except = $nv_Request->get_int("except", "get/post", 0);
			$filter = $nv_Request->get_array("filter", "post");
      
      if ($except) {
        $except = 0;
      }
      else {
        $except = 1;
      }

			if (checkUser($id)) {
        $sql = "delete from `" . PREFIX . "_penety` where id = " . $id;
				if ($db->query($sql) && $html = penetyList($filter)) {
					$result["status"] = 1;
					$result["html"] = $html;
				}
			}
		break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("penety.tpl", PATH);

$xtpl->assign("today", date('d/m/Y'));
$xtpl->assign("content", penetyList());
$xtpl->parse("main");

$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");