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

$action = $nv_Request->get_string('action', 'post', '');

if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
		case 'insert-disease-suggest':
			$disease = $nv_Request->get_string('disease', 'post');

      $sql = 'select * from `'. PREFIX .'_disease_suggest` where disease = "'. $disease .'"';
      $query = $db->query($sql);

      $sql = "";
      if (!empty($row = $query->fetch())) {
        if ($row['active'] = 1) {
          $result['error'] = 'Đã có trong danh sách';
        }
        else {
          $sql = 'update into `'. PREFIX .'_disease_suggest` set rate = rate + 1';
        }
      }
      else {
        $sql = 'insert into `'. PREFIX .'_disease_suggest` (userid, disease, active, rate) values('. $userinfo['id'] .', "'. $disease .'", 0, 1)';
      }

      if (!empty($sql) && $db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = parseVaccineType($userinfo['id']);
      }
		break;
		case 'insert-breeder':
			$data = $nv_Request->get_array('data', 'post');
			// $child = $nv_Request->get_array('child', 'post');
			$id = $nv_Request->get_string('id', 'post', 0);

      $data['time'] = totime($data['time']);
      $list = array();

      // foreach ($child as $key => $row) {
      //   if (!empty($row['name'])) { 
      //     $list[] = $row['id'];
      //   }
      // }

      $sql = 'insert into `'. PREFIX .'_breeder` (petid, targetid, child, time, number, note) values('. $id .', '. $data['target'] .', "[]", "'. $data['time'] .'", '. $data['number'] .', "'. $data['note'] .'")';
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = breederList($id);
      }

		break;
		case 'insert-disease':
			$id = $nv_Request->get_string('id', 'post', 0);
			$data = $nv_Request->get_array('data', 'post');

      $data['treat'] = totime($data['treat']);
      $data['treated'] = totime($data['treated']);
      checkRemind($data['disease'], 'disease');
      $list = array();

      $sql = 'insert into `'. PREFIX .'_disease` (petid, treat, treated, disease, note) values('. $id .', '. $data['treat'] .', '. $data['treated'] .', "'. $data['disease'] .'", "'. $data['note'] .'")';
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = diseaseList($id);
      }

		break;
    case 'insert-vaccine':
			$id = $nv_Request->get_string('id', 'post', 0);
			$data = $nv_Request->get_array('data', 'post');
      
      if (!empty($id) && count($data) > 0) {
        $data['time'] = totime($data['time']);
        $data['recall'] = totime($data['recall']);
        if (!empty($row = checkPrvVaccine($data))) {
          // 
          $sql = 'update `'. PREFIX .'_vaccine` set status =  1 where id = ' . $row['id'];
          die($sql);
        }
        else {
          $sql = 'insert into `'. PREFIX .'_vaccine` (petid, time, recall, type, val, status) values ("'. $id .'", "'. $data['time'] .'", "'. $data['recall'] .'", "'. $data['type'] .'",  "'. $data['val'] .'", 0)';
          if ($db->query($sql)) {
            $result['status'] = 1;
            $result['html'] = vaccineList($id);
            $result['notify'] = 'Đã thêm tiêm phòng';
          }
        }
      }
    break;

 		case 'target':
			$keyword = $nv_Request->get_string('keyword', 'post', '');
			$index = $nv_Request->get_int('index', 'post', -1);
			$func = $nv_Request->get_string('func', 'post', '');

			$sql = 'select a.id, a.name, b.fullname, b.image from `'. PREFIX .'_pet` a inner join `'. PREFIX .'_user` b on a.userid = b.id where (a.name like "%'. $keyword .'%" or b.fullname like "%'. $keyword .'%") and userid = ' . $userinfo['id'];
			$query = $db->query($sql);

			$html = '';
      $xtra = '';
      $ex = 'pickTarget';
      if (!empty($func)) {
        $ex = $func;
      }
      else if ($index >= 0) {
        $xtra .= ', 0, ' . $index;
      }
			while ($row = $query->fetch()) {
				$html .= '
				<div class="suggest_item2" onclick="'. $ex .'(\''. $row['name'] .'\', '. $row['id'] . $xtra .')">
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
 		case 'disease':
			$keyword = $nv_Request->get_string('keyword', 'post', '');
      checkRemind($keyword, 'disease');

			$sql = 'select * from `'. PREFIX .'_remind` where type = "disease" and name like "%'. $keyword .'%"';
			$query = $db->query($sql);

			$html = '';
			while ($row = $query->fetch()) {
				$html .= '
				<div class="suggest_item" onclick="pickDisease(\''. $row['name'] .'\')">
					<div class="xright">
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

$id = $nv_Request->get_int('id', 'get', 0);
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
  $xtpl->assign('vaccine', vaccineList($id));
  $xtpl->assign('disease', diseaseList($id));

  $relation = getPetRelation($id);
  
  foreach ($relation['grand'] as $lv1) {
    foreach ($lv1 as $lv2) {
      $xtpl->assign($lv2['ns'], parseLink($lv2));
      $xtpl->assign('ig' . $lv2['ns'], parseInfo($lv2));
    }
    foreach ($lv1['m'] as $lv2) {
      $xtpl->assign($lv2['ns'], parseLink($lv2));
      $xtpl->assign('ig' . $lv2['ns'], parseInfo($lv2));
    }
  }
  foreach ($relation['parent'] as $lv1) {
    $xtpl->assign($lv1['ns'], parseLink($lv1));
    $xtpl->assign('ig' . $lv1['ns'], parseInfo($lv1));
  }

  $xtpl->assign('grand', implode('<br>', $bay['grand']));
  $xtpl->assign('parent', implode('<br>', $bay['parent']));
  $xtpl->assign('sibling', implode('<br>', $bay['sibling']));
  $xtpl->assign('child', implode('<br>', $bay['child']));
}

$xtpl->assign('today', date('d/m/Y', time()));
$xtpl->assign('recall', date('d/m/Y', time() + 60 * 60 * 24 * 21));
$xtpl->assign('url', '/' . $module_name . '/' . $op . '/');
$xtpl->assign('remind', json_encode(getRemind()));
$xtpl->assign('v', parseVaccineType($userinfo['id']));
$xtpl->assign('id', $id);

$request = 'breeder';
if (!empty($_REQUEST['target']) && in_array($_REQUEST['target'], array('vaccine', 'disease'))) {
  $request = $_REQUEST['target'];
}

switch ($_REQUEST['target']) {
  case 'vaccine':
    $xtpl->assign('a2', 'class="active"');
    $xtpl->assign('al2', 'in active');
  break;
  case 'disease':
    $xtpl->assign('a3', 'class="active"');
    $xtpl->assign('al3', 'in active');
  break;
  default:
    $xtpl->assign('a1', 'class="active"');
    $xtpl->assign('al1', 'in active');
  break;
}

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/biograph/layout/header.php");
echo $contents;
include ("modules/biograph/layout/footer.php");

