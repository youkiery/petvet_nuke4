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

$page_title = "Danh sách nhân viên";

$action = $nv_Request->get_string('action', 'post/get', "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'change':
			$id = $nv_Request->get_string("id", "get/post", "");
			$sql = 'select * from `' . PREFIX . '_user` where userid = '.  $id;
			$query = $db->query($sql);
			$user = $query->fetch();

			$sql = "update `" . PREFIX . "_user` set manager = ". intval(!$user['manager']) ." where userid = $id";
			if ($db->query($sql)) {
				$result["status"] = 1;
				$result["html"] = doctorUserList();
			}
		break;
		case 'member-filter':
      $result['status'] = 1;
      $result['html'] = memberFilter();
    break;
    case 'insert-member':
      $id = $nv_Request->get_int('id', 'post');

      $db->query('insert into `'. PREFIX .'_user` (userid, manager) values('. $id .', 1)');
      $result['status'] = 1;
      $result['html'] = memberFilter();
      $result['html2'] = doctorUserList();
    break;
    case 'get-member':
      $id = $nv_Request->get_int('id', 'post');

      $query = $db->query('select * from `'. PREFIX .'_user` where userid = ' . $id);
      $member = $query->fetch();

      $result['status'] = 1;
      $result['member'] = $member;
		break;
		case 'remove-member':
      $id = $nv_Request->get_int('id', 'post');

      $sql = 'update from `'. PREFIX .'_user` set manager = 1 where userid = ' . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['notify'] = 'Đã xóa';
        $result['html'] = memberuserList();
      }
    break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("main.tpl", PATH2);

$xtpl->assign('modal', managerModal());
$xtpl->assign("content", doctorUserList());
$xtpl->parse("main");

$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");
