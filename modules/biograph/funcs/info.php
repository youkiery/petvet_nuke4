<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_FORM')) {
	die('Stop!!!');
}

$page_title = "autoload";

define('BUILDER_INSERT_NAME', 0);
define('BUILDER_INSERT_VALUE', 1);
define('BUILDER_EDIT', 2);

$userinfo = getUserInfo();
if (empty($userinfo)) {
	header('location: /' . $module_name . '/login/');
	die();
}

$id = $nv_Request->get_int('id', 'get', 0);
$action = $nv_Request->get_string('action', 'post', '');

if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
		case 'insert-breeder':
			$time = $nv_Request->get_string('time', 'post', 0);
			$target = $nv_Request->get_string('target', 'post', 0);
			$note = $nv_Request->get_string('note', 'post', 0);
			$child = $nv_Request->get_array('child', 'post');

      $time = totime($time);
      $list = array();

      foreach ($child as $key => $row) {
        if (!empty($row['name'])) {
          $list[] = $row['id'];
        }
      }

      $sql = 'insert into `'. PREFIX .'_breeder` (petid, targetid, child, time) values('. $id .', '. $target .', '. implode(', ', $child) .', '. time() .')';
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = breederList($id);
      }

		break;
 		case 'target':
			$keyword = $nv_Request->get_string('keyword', 'post', '');
			$index = $nv_Request->get_int('index', 'post', -1);

			$sql = 'select a.id, a.name, b.fullname, b.image from `'. PREFIX .'_pet` a inner join `'. PREFIX .'_user` b on a.userid = b.id where (a.name like "%'. $keyword .'%" or b.fullname like "%'. $keyword .'%") and userid = ' . $userinfo['id'];
			$query = $db->query($sql);

			$html = '';
      $xtra = '';
      if ($index >= 0) {
        $xtra .= ', 0, ' . $index;
      }
			while ($row = $query->fetch()) {
				$html .= '
				<div class="suggest_item2" onclick="pickTarget(\''. $row['name'] .'\', '. $row['id'] . $xtra .')">
					<div class="xleft">
					</div>
					<div class="xright">
						<p> '. $row['fullname'] .' </p>
						<p> '. $row['name'] .' </p>
					</div>
				</div>
				';
			}

			if (empty($html)) {
				$html = 'Không có kết quả trùng khớp';
			}

			$result['status'] = 1;
			$result['html'] = $html;
		break;
		case 'insertpet':
			$data = $nv_Request->get_array('data', 'post');

			if (count($data) > 1 && !checkPet($data['name'], $userinfo['id'])) {
        // ???
        $sex = 0;
        if ($data['sex1']) {
          $sex = 1;
        }
				$data['dob'] = totime($data['dob']);
				$data['sex'] = $sex;
				$data['dateofbirth'] = totime($data['dob']);

        if (!empty($data['breeder'])) {
          if ($data['sex']) {
            $data['breeder'] = 0;
          }
          else {
            $data['breeder'] = 1;
          }
        }
        else {
          $data['breeder'] = 2;
        }

        unset($data['sex0']);
        unset($data['sex1']);
				unset($data['dob']);

        checkRemind($data['species'], 'species');
        checkRemind($data['breed'], 'breed');

				$sql = 'insert into `'. PREFIX .'_pet` (userid, '. sqlBuilder($data, BUILDER_INSERT_NAME) .', active, image, fid, mid) values('. $userinfo['id'] .', '. sqlBuilder($data, BUILDER_INSERT_VALUE) .', 0, "", 0, 0)';

				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['notify'] = 'Đã thêm thú cưng';
					$result['name'] = $data['name'];
					$result['id'] = $db->lastInsertId();
					$result['remind'] = json_encode(getRemind());
				}
			}
		break;
	}
	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("info.tpl", "modules/biograph/template");

$sql = 'select * from `'. PREFIX .'_pet` where id = ' . $id;
$query = $db->query($sql);

if (!empty($row = $query->fetch())) {
	$xtpl->assign('name', $row['name']);
	$xtpl->assign('dob', $row['dateofbirth']);
	$xtpl->assign('breed', $row['breed']);
	$xtpl->assign('species', $row['species']);
	$xtpl->assign('sex', $row['sex']);
	$xtpl->assign('color', $row['color']);
	$xtpl->assign('microchip', $row['microchip']);
	$xtpl->assign('image', $row['image']);
  $xtpl->assign('breeder', breederList($id));
}

$xtpl->assign('url', '/' . $module_name . '/' . $op . '/');
$xtpl->assign('remind', json_encode(getRemind()));

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/biograph/layout/header.php");
echo $contents;
include ("modules/biograph/layout/footer.php");

