<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_ADMIN_FORM')) {
	die('Stop!!!');
}
define('BUILDER_EDIT', 2);

$page_title = "Quản lý thu chi";

$action = $nv_Request->get_string('action', 'post', '');

if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
    case 'a':
      $x = 1;
		break;
    case 'pet':
      $userid = $nv_Request->get_string('userid', 'post', '');
			$keyword = $nv_Request->get_string('keyword', 'post', '');
      $html = '';

      if (!empty(getOwnerById($userid))) {
        $sql = 'select * from `'. PREFIX .'_pet` where name like "%'. $keyword .'%"';
        $query = $db->query($sql);

        while ($row = $query->fetch()) {
          $html .= '
            <div class="suggest_item" onclick="pickPet(\''. $row['name'] .'\', '. $row['id'] .')">
              <p>
              '. $row['name'] .'
              </p>
            </div>
          ';
        }

        if (empty($html)) {
          $html = 'Không có kết quả trùng khớp';
        }
      }
      else {
        $html = 'Chưa chọn chủ thú cưng';
      }


			$result['status'] = 1;
			$result['html'] = $html;
		break;
    case 'parent':
			$keyword = $nv_Request->get_string('keyword', 'post', '');

			$sql = 'select * from `'. PREFIX .'_user`';
			$query = $db->query($sql);

			$html = '';
      $count = 0;
      // checkMobile
			while (($row = $query->fetch()) && $count < 10) {
        if (checkMobile($row['mobile'], $keyword)) {
          $row['mobile'] = xdecrypt($row['mobile']);
          $html .= '
          <div class="suggest_item" onclick="pickOwner(\''. $row['mobile'] .'\', '. $row['id'] .')">
            <p>
              '. $row['fullname'] .' ('. $row['mobile'] .')
            </p>
          </div>
          ';
          $count ++;
        }
			}

			if (empty($html)) {
				$html = 'Không có kết quả trùng khớp';
			}

			$result['status'] = 1;
			$result['html'] = $html;
		break;
	}
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("revenue.tpl", PATH);

// $xtpl->assign('content', revenue());
// $xtpl->assign('remind', json_encode(getRemind()));
$xtpl->assign('module_file', $module_file);
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
include (NV_ROOTDIR . "/modules/". $module_file ."/layout/prefix.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");