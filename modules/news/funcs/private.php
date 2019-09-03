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
define('BUILDER_INSERT_NAME', 0);
define('BUILDER_INSERT_VALUE', 1);
define('BUILDER_EDIT', 2);

$page_title = "Quản lý thú cưng";

$action = $nv_Request->get_string('action', 'post', '');

$userinfo = getUserinfo();
if (empty($userinfo)) {
	header('location: /'. $module_name .'/login/');
	die();
}
else {
  if (!empty($userinfo['center'])) {
    header('location: /'. $module_name .'/center');
  }
}

if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
    case 'change-mail':
      $mail = $nv_Request->get_string('mail', 'post', '');

      if (empty($mail)) {
        $result['error'] = 'Các trường không được trống';
      }
      else {
        $sql = 'update `'. PREFIX .'_user` set mail = "'. $mail .'" where id = ' . $userinfo['id'];
        $query = $db->query($sql);

        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['error'] = '';
          $result['notify'] = 'Đã lưu email';
        }
        else {
          $result['error'] = 'Có lỗi xảy ra';
        }
      }
    break;
    case 'change-pass':
      $npass = $nv_Request->get_string('npass', 'post', '');
      $opass = $nv_Request->get_string('opass', 'post', '');

      if (empty($npass) || empty($opass)) {
        $result['notify'] = 'Mật khẩu không được trống';
      }
      else {
        $sql = 'select * from `'. PREFIX .'_user` where password = "'. md5($opass) .'" and id = ' . $userinfo['id'];
        $query = $db->query($sql);

        if (empty($query->fetch())) {
          $result['notify'] = 'Mật khẩu sai';
        }
        else {
          $sql = 'update `'. PREFIX .'_user` set password = "'. md5($npass) .'" where id = ' . $userinfo['id'];
          if ($db->query($sql)) {
            $result['status'] = 1;
            $result['notify'] = 'Đã đổi mật khẩu';
          }
        }
      }
    break;
		case 'filter':
			$filter = $nv_Request->get_array('filter', 'post');
			$tabber = $nv_Request->get_array('tabber', 'post');
			
			if (count($filter) > 1) {
				// $result['html'] = userDogRowByList($userinfo['id'], $filter, $tabber);
				$result['html'] = userDogRowByList($userinfo['id'], $tabber, $filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
        else {
          $result['notify'] = 'Có lỗi xảy ra';
        }
			}
		break;
    case 'get-request':
      $id = $nv_Request->get_string('id', 'post', 0);

      if (!empty($id)) {
        $result['status'] = 1;
        $result['html'] = requestDetail($id);
      }
      else {
        $result['notify'] = 'Có lỗi xảy ra';
      }
    break;
    case 'request':
      $id = $nv_Request->get_string('id', 'post', 0);
      $type = $nv_Request->get_string('type', 'post', 0);
      $value = $nv_Request->get_string('value', 'post', 0);

      if (!empty($id)) {
        $sql = 'select * from `'. PREFIX .'_request` where type = '. $type .' and value = '. $value .' and petid = ' . $id;
        $query = $db->query($sql);

        $request = $query->fetch();
        if (!empty($request) && count($request) > 0) {
          $sql = 'update `'. PREFIX .'_request` set time = ' . time() . ', status = 1 where id = ' . $request['id'];
          // die($sql);
          if ($db->query($sql)) {
            $result['status'] = 1;
            $result['html'] = requestDetail($id);
          }
        }
        else {
          $sql = 'insert into `'. PREFIX .'_request` (petid, type, value, status, time) values('. $id .', '. $type .', '. $value .', 1, '. time() .')';
          // die($sql);
          if ($db->query($sql)) {
            $result['status'] = 1;
            $result['html'] = requestDetail($id);
          }
        }
        if (empty($result['html'])) {
          $result['notify'] = 'Có lỗi xảy ra';
        }
      }
      else {
        $result['notify'] = 'Có lỗi xảy ra';
      }
    break;
    case 'cancel':
      $id = $nv_Request->get_string('id', 'post', 0);
      $type = $nv_Request->get_string('type', 'post', 0);
      $value = $nv_Request->get_string('value', 'post', 0);

      if (!empty($id)) {
        $sql = 'update `'. PREFIX .'_request` set time = ' . time() . ', status = 0 where type = '. $type .' and value = '. $value .' and petid = ' . $id;
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = requestDetail($id);
        }
        if (empty($result['html'])) {
          $result['notify'] = 'Có lỗi xảy ra';
        }
      }
      else {
        $result['notify'] = 'Có lỗi xảy ra';
      }
    break;
		case 'filteruser':
			$filter = $nv_Request->get_array('filter', 'post');
			
			if (count($filter) > 1) {
				$result['html'] = userRowList($filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
        else {
          $result['notify'] = 'Có lỗi xảy ra';
        }
			}
		break;
    case 'insert-vaccine':
    	$id = $nv_Request->get_string('id', 'post', 0);
			$data = $nv_Request->get_array('data', 'post');
      $result['notify'] = 'Có lỗi xảy ra';
      
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
            $result['notify'] = 'Đã thêm tiêm phòng';
          }
        }
      }

    break;
		case 'get':
			$id = $nv_Request->get_string('id', 'post', 0);
			
			$sql = 'select * from `'. PREFIX .'_pet` where id = ' . $id;
			$query = $db->query($sql);

			if (!empty($row = $query->fetch())) {
				$result['data'] = array('name' => $row['name'], 'dob' => date('d/m/Y', $row['dateofbirth']), 'species' => $row['species'], 'breed' => $row['breed'], 'color' => $row['color'], 'microchip' => $row['microchip'], 'parentf' => $row['fid'], 'parentm' => $row['mid'], 'miear' => $row['miear'], 'origin' => $row['origin']);
        $result['more'] = array('breeder' => $row['breeder'],'sex' => intval($row['sex']), 'm' => getPetNameId($row['mid']), 'f' => getPetNameId($row['fid']));
        $result['image'] = $row['image'];
				$result['status'] = 1;
			}
      else {
        $result['notify'] = 'Có lỗi xảy ra';
      }
		break;
		case 'getuser':
			$id = $nv_Request->get_string('id', 'post');
			
			$sql = 'select * from `'. PREFIX .'_user` where id = ' . $id;
			$query = $db->query($sql);

			if (!empty($row = $query->fetch())) {
        $row['mobile'] = xdecrypt($row['mobile']);
        $row['address'] = xdecrypt($row['address']);
				$result['data'] = array('fullname' => $row['fullname'], 'mobile' => $row['mobile'], 'address' => $row['address']);
				$result['image'] = $row['image'];
				$result['status'] = 1;
			}
      else {
        $result['notify'] = 'Có lỗi xảy ra';
      }
		break;
		case 'remove':
			$id = $nv_Request->get_string('id', 'post');
			$filter = $nv_Request->get_array('filter', 'post');
			$tabber = $nv_Request->get_array('tabber', 'post');
      $result['notify'] = 'Có lỗi xảy ra';

			$sql = 'delete from `'. PREFIX .'_pet` where id = ' . $id;
			if ($db->query($sql)) {
  			$result['html'] = userDogRowByList($userinfo['id'], $tabber, $filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
			}
		break;
		case 'insert-owner':
			$data = $nv_Request->get_array('data', 'post');
      $result['notify'] = 'Có lỗi xảy ra';

			if (count($data) > 1 && !checkObj($data)) {
        $result['notify'] = 'Các trường không được bỏ trống';
      }
      else {
        // ???
        $sql = 'select * from `'. PREFIX .'_contact` where mobile = "'. $data['mobile'] .'"';
        $query = $db->query($sql);
        if (empty($query->fetch)) {
          $data['mobile'] = xencrypt($data['mobile']);
          $data['address'] = xencrypt($data['address']);

          $sql = 'insert into `'. PREFIX .'_contact` (fullname, address, mobile, userid) values ("'. $data['fullname'] .'", "'. $data['address'] .'", "'. $data['mobile'] .'", '. $userinfo['id'] .')';

          if ($db->query($sql)) {
            $result['status'] = 1;
            $result['id'] = $db->lastInsertId();
            $result['name'] = $data['fullname'];
            // $result['html'] = userDogRowByList($userinfo['id']);
          }
        }
			}
		break;
		case 'transfer-owner':
			$petid = $nv_Request->get_string('petid', 'post', 0);
			$ownerid = $nv_Request->get_string('ownerid', 'post', 0);
			$type = $nv_Request->get_string('type', 'post', 2);
      $filter = $nv_Request->get_array('filter', 'post');
			$tabber = $nv_Request->get_array('tabber', 'post');
      $result['notify'] = 'Có lỗi xảy ra';

      $check = 0;
      if (empty($pet = getPetById($petid))) {
        $result['notify'] = 'Thú cưng không tồn tại';
      }
      else if (empty($owner = getOwnerById($ownerid, $type))) {
        $result['notify'] = 'Chủ nuôi không tồn tại';
      }
      else {
        if ($type == 1) {
          $sql2 = 'insert into `'. PREFIX .'_transfer_request` (userid, petid, time, note) values('. $ownerid .', '. $petid .', '. time() .', "")';
          if ($db->query($sql2)) {
            $check = 1;
          }
        }
        else {
          $type = 2;
          $sql = 'update `'. PREFIX .'_pet` set userid = ' . $ownerid . ', type = '. $type .' where id = ' . $petid;
          $sql2 = 'insert into `'. PREFIX .'_transfer` (fromid, targetid, petid, time, type) values('. $pet['userid'] .', '. $ownerid .', '. $petid .', '. time() .', '. $type .')';
          if ($db->query($sql) && $db->query($sql2)) {
            $check = 1;
          }
        }

        if ($check) {
          $result['status'] = 1;
          $result['notify'] = 'Đã chuyển nhượng';
    			$result['html'] = userDogRowByList($userinfo['id'], $tabber, $filter);
        }
			}
		break;
    case 'parent2':
			$keyword = $nv_Request->get_string('keyword', 'post', '');

			$sql = 'select * from ((select id, fullname, mobile, address, 1 as type from `'. PREFIX .'_user`) union (select id, fullname, mobile, address, 2 as type from `'. PREFIX .'_contact` where userid = '. $userinfo['id'] .')) as a';
			$query = $db->query($sql);

			$html = '';
      $count = 0;
      // checkMobile
			while (($row = $query->fetch()) && $count < 10) {
        if (checkMobile($row['mobile'], $keyword)) {
          $html .= '
          <div class="suggest_item" onclick="pickOwner(\''. $row['fullname'] .'\', '. $row['id'] .', '. $row['type'] .')">
            <p>
            '. $row['fullname'] .'
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
    case 'species':
			$keyword = $nv_Request->get_string('keyword', 'post', '');

			$sql = 'select * from `'. PREFIX .'_species` where (name like "%'. $keyword .'%" or fci like "%'. $keyword .'%" or origin like "%'. $keyword .'%") limit 10';
			$query = $db->query($sql);

			$html = '';
			while ($row = $query->fetch()) {
				$html .= '
				<div class="suggest_item" onclick="pickSpecies(\''. $row['name'] .'\', '. $row['id'] .')">
					'. $row['name'] .'
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
			$filter = $nv_Request->get_array('filter', 'post');
			$tabber = $nv_Request->get_array('tabber', 'post');
			$image = $nv_Request->get_string('image', 'post');
      $result['notify'] = 'Có lỗi xảy ra';

      if (empty($data['name']) || empty($data['species']) || empty($data['breed'])) {
        $result['notify'] = 'Các trường bắt buộc không được bỏ trống';
      }
      else if (checkPet($data['name'], $userinfo['id'])) {
        $result['notify'] = 'Tên thú cưng đã tồn tại';
      }
      else {
        // ???
        $sex = 1;
        if ($data['sex1'] == 'false') {
          $sex = 0;
        }
				$data['dob'] = totime($data['dob']);
				$data['sex'] = $sex;
				$data['dateofbirth'] = totime($data['dob']);
        $data['fid'] = $data['parentf'];
				$data['mid'] = $data['parentm'];

        if ($data['sex']) {
          $data['breeder'] = 1;
        }
        else {
          $data['breeder'] = 0;
        }

        unset($data['sex0']);
        unset($data['sex1']);
				unset($data['dob']);
        unset($data['parentf']);        
				unset($data['parentm']);

        checkRemind($data['species'], 'species');
        checkRemind($data['breed'], 'breed');

				$sql = 'insert into `'. PREFIX .'_pet` (userid, '. sqlBuilder($data, BUILDER_INSERT_NAME) .', active, image, type) values('. $userinfo['id'] .', '. sqlBuilder($data, BUILDER_INSERT_VALUE) .', 0, "'. $image .'", 1)';

				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['notify'] = 'Đã thêm thú cưng';
					$result['remind'] = json_encode(getRemind());
					$result['html'] = userDogRowByList($userinfo['id'], $tabber, $filter);
				}
			}
		break;
		case 'insert-parent':
			$data = $nv_Request->get_array('data', 'post');
			$image = $nv_Request->get_string('image', 'post');
			$filter = $nv_Request->get_array('filter', 'post');
			$tabber = $nv_Request->get_array('tabber', 'post');
      $result['notify'] = 'Có lỗi xảy ra';

      if (empty($data['name']) || empty($data['species']) || empty($data['breed'])) {
        $result['notify'] = 'Các trường bắt buộc không được bỏ trống';
      }
      else if (checkPet($data['name'], $userinfo['id'])) {
        $result['notify'] = 'Tên thú cưng đã tồn tại';
      }
      else {
        $sex = 1;
        if ($data['sex1'] == 'false') {
          $sex = 0;
        }
				$data['dateofbirth'] = totime($data['dob']);
				$data['sex'] = $sex;
        $data['fid'] = $data['parentf'];
				$data['mid'] = $data['parentm'];

        $data['breeder'] = 1;
        if ($data['sex']) {
          $data['breeder'] = 1;
        }
        else {
          $data['breeder'] = 0;
        }

        unset($data['sex0']);
        unset($data['sex1']);
        unset($data['parentf']);        
				unset($data['parentm']);
				unset($data['dob']);

        checkRemind($data['species'], 'species');
        checkRemind($data['breed'], 'breed');

				$sql = 'insert into `'. PREFIX .'_pet` (userid, '. sqlBuilder($data, BUILDER_INSERT_NAME) .', active, image, type, origin, graph) values('. $userinfo['id'] .', '. sqlBuilder($data, BUILDER_INSERT_VALUE) .', 0, "", 1, "", "")';

				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['name'] = $data['name'];
					$result['notify'] = 'Đã thêm thú cưng';
					$result['id'] = $db->lastInsertId();
					$result['remind'] = json_encode(getRemind());
					$result['html'] = userDogRowByList($userinfo['id'], $tabber, $filter);
				}
			}
		break;
		case 'editpet':
			$id = $nv_Request->get_string('id', 'post', '');
			$image = $nv_Request->get_string('image', 'post');
			$data = $nv_Request->get_array('data', 'post');
			$filter = $nv_Request->get_array('filter', 'post');
			$tabber = $nv_Request->get_array('tabber', 'post');
      $result['notify'] = 'Có lỗi xảy ra';

			if (count($data) > 1 && !empty($id)) {
				$data['dateofbirth'] = totime($data['dob']);
				$data['fid'] = $data['parentf'];
				$data['mid'] = $data['parentm'];
        $sex = 1;
        if ($data['sex1'] == 'false') {
          $sex = 0;
        }

        unset($data['sex0']);
        unset($data['sex1']);
				$data['sex'] = $sex;

				unset($data['dob']);
				unset($data['parentf']);        
				unset($data['parentm']);
        
        checkRemind($data['species'], 'species');
        checkRemind($data['breed'], 'breed');
        checkRemind($data['origin'], 'origin');

        if ($data['sex']) {
          $data['breeder'] = 1;
        }
        else {
          $data['breeder'] = 0;
        }

				$sql = 'update `'. PREFIX .'_pet` set '. sqlBuilder($data, BUILDER_EDIT) .', image = "'. $image .'" where id = ' . $id;
        // die($sql);

				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['notify'] = 'Đã chỉnh sửa thú cưng';
					$result['remind'] = json_encode(getRemind());
					$result['html'] = userDogRowByList($userinfo['id'], $tabber, $filter);
				}
			}
		break;
		case 'edituser':
			$id = $nv_Request->get_string('id', 'post', '');
			$data = $nv_Request->get_array('data', 'post');
			$image = $nv_Request->get_string('image', 'post');
      $result['notify'] = 'Có lỗi xảy ra';

			if (count($data) > 1 && !empty($id)) {
        $data['mobile'] = xencrypt($data['mobile']);
        $data['address'] = xencrypt($data['address']);
				$sql = 'update `'. PREFIX .'_user` set '. sqlBuilder($data, BUILDER_EDIT) . (strlen(trim($image)) > 0 ? ', image = "'. $image .'"' : '') . ' where id = ' . $id;
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['notify'] = 'Đã chỉnh sửa thông tin cá nhân';
				}
			}
		break;
    case 'new-request':
      $name = $nv_Request->get_string('name', 'post');
      $id = $nv_Request->get_string('id', 'post', '');
      $result['notify'] = 'Có lỗi xảy ra';

      if (!empty($name) && !empty($id)) {
        $type = checkRemind($name, 'request');

        $sql = 'insert into `'. PREFIX .'_request` (petid, type, status, time, value) values ("'. $id .'", 2, 1, '. time() .', '. $type .')';

        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['notify'] = 'Đã thêm yêu cầu';
          $result['html'] = requestDetail($id);
        }
      }
    break;
		case 'center':
			if (!empty($userinfo)) {
				$sql = 'update `'. PREFIX .'_user` set center = 1 where id = ' . $userinfo['id'];

				if ($db->query($sql)) {
					$result['status'] = 1;
				}
			}
		break;
		case 'parent':
			$keyword = $nv_Request->get_string('keyword', 'post', '');

			$sql = 'select a.id, a.name, b.fullname, b.mobile from `'. PREFIX .'_pet` a inner join (select * from ((select id, fullname, mobile, address, 1 as type from `'. PREFIX .'_user`) union (select id, fullname, mobile, address, 2 as type from `'. PREFIX .'_contact` where userid = '. $userinfo['id'] .')) as c) b on a.userid = b.id and a.type = b.type';
			$query = $db->query($sql);

			$html = '';
      $count = 0;
      // checkMobile
			while (($row = $query->fetch()) && $count < 10) {
        if (checkMobile($row['mobile'], $keyword)) {
          $html .= '
          <div class="suggest_item2" onclick="pickParent(this, \''. $row['name'] .'\', '. $row['id'] .')">
            <p> '. $row['fullname'] .' </p>
            <p> '. $row['name'] .' </p>
          </div>';
          $count ++;
        }
			}

			if (empty($html)) {
				$html = 'Không có kết quả trùng khớp';
			}

			$result['status'] = 1;
			$result['html'] = $html;
		break;
    case 'insert-disease-suggest':
			$disease = $nv_Request->get_string('disease', 'post');
      $result['notify'] = 'Có lỗi xảy ra';

      $sql = 'select * from `'. PREFIX .'_disease_suggest` where disease = "'. $disease .'"';
      $query = $db->query($sql);

      $sql = "";
      if (empty($disease)) {
        $result['notify'] = 'Các trường không được để trống';
      }
      else if (!empty($row = $query->fetch())) {
        if ($row['active'] = 1) {
          $result['notify'] = 'Đã có trong danh sách';
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
        $result['notify'] = 'Đã thêm danh sách';
      }
		break;
	}
	echo json_encode($result);
	die();
}

$id = $nv_Request->get_int('id', 'get', 0);
$global = array();
$global['login'] = 0;

$xtpl = new XTemplate("private.tpl", "modules/". $module_name ."/template");

$userinfo['mobile'] = xdecrypt($userinfo['mobile']);
$userinfo['address'] = xdecrypt($userinfo['address']);

$xtpl->assign('userid', $userinfo['id']);
$xtpl->assign('fullname', $userinfo['fullname']);
$xtpl->assign('mobile', $userinfo['mobile']);
$xtpl->assign('address', $userinfo['address']);
$xtpl->assign('image', $userinfo['image']);
$xtpl->assign('remind', json_encode(getRemind()));
$xtpl->assign('list', userDogRowByList($userinfo['id']));

if (!$userinfo['center']) {
  $xtpl->assign('tabber', '0, 1, 2');
}
else {
  $xtpl->assign('tabber', '0');
}
$xtpl->assign('v', parseVaccineType($userinfo['id']));

$xtpl->assign('today', date('d/m/Y', time()));
$xtpl->assign('recall', date('d/m/Y', time() + 60 * 60 * 24 * 21));
$xtpl->assign('module_file', $module_file);
$xtpl->assign('module_name', $module_name);

// $xtpl->assign('today', date('d/m/Y', time()));
// $sql = 'select * from `'. PREFIX .'_pet` where userid = ' . $userinfo['id'];
// $query = $db->query($sql);

// $stat = array('species' => array(), 'breeder' => array(), 'origin' => array());

$xtpl->assign('origin', '/' . $module_name . '/' . $op . '/');
$xtpl->assign('mail', $userinfo['mail']);

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/". $module_file ."/layout/header.php");
echo $contents;
include ("modules/". $module_file ."/layout/footer.php");
