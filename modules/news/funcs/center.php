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

$page_title = "Quản lý trang trại";

$action = $nv_Request->get_string('action', 'post', '');
$userinfo = getUserInfo();
if (empty($userinfo)) {
	header('location: /' . $module_name . '/login/');
	die();
}
else {
  if (empty($userinfo['center'])) {
    header('location: /'. $module_name .'/private');
  }
}

if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
		case 'filter':
			$filter = $nv_Request->get_array('filter', 'post');
			$tabber = $nv_Request->get_array('tabber', 'post');
			
			if (count($filter) > 1) {
				// $result['html'] = userDogRowByList($userinfo['id'], $filter, $tabber);
				$result['html'] = userDogRowByList($userinfo['id'], $tabber, $filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
			}
		break;
    case 'get-request':
      $id = $nv_Request->get_string('id', 'post', 0);

      if (!empty($id)) {
        $result['status'] = 1;
        $result['html'] = requestDetail($id);
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
      }
    break;
    case 'cancel':
      $id = $nv_Request->get_string('id', 'post', 0);
      $type = $nv_Request->get_string('type', 'post', 0);
      $value = $nv_Request->get_string('value', 'post', 0);

      if (!empty($id)) {
        // if (!empty($request = getPetRequest($id, $value)) && count($request) > 0) {
          $sql = 'update `'. PREFIX .'_request` set time = ' . time() . ', status = 0 where type = '. $type .' and value = '. $value .' and petid = ' . $id;
          // die($sql);
          if ($db->query($sql)) {
            $result['status'] = 1;
            $result['html'] = requestDetail($id);
          }
        // }
      }
    break;
		case 'filteruser':
			$filter = $nv_Request->get_array('filter', 'post');
			
			if (count($filter) > 1) {
				$result['html'] = userRowList($filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
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
        $result['more'] = array('sex' => intval($row['sex']), 'm' => getPetNameId($row['mid']), 'f' => getPetNameId($row['fid']));
        $result['image'] = $row['image'];
				$result['status'] = 1;
			}
		break;
		case 'getuser':
			$id = $nv_Request->get_string('id', 'post');
			
			$sql = 'select * from `'. PREFIX .'_user` where id = ' . $id;
			$query = $db->query($sql);

			if (!empty($row = $query->fetch())) {
				$result['data'] = array('fullname' => $row['fullname'], 'mobile' => $row['mobile'], 'address' => $row['address']);
				$result['image'] = $row['image'];
				$result['status'] = 1;
			}
		break;
		case 'check':
			$id = $nv_Request->get_string('id', 'post');
			$type = $nv_Request->get_string('type', 'post');
			$filter = $nv_Request->get_array('filter', 'post');

			$sql = 'update `'. PREFIX .'_pet` set active = '. $type .' where id = ' . $id;
			if ($db->query($sql)) {
				$result['html'] = userDogRowByList($userinfo['id'], $filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
			}
		break;
		case 'checkuser':
			$id = $nv_Request->get_string('id', 'post');
			$type = $nv_Request->get_string('type', 'post');
			$filter = $nv_Request->get_array('filter', 'post');

			$sql = 'update `'. PREFIX .'_user` set active = '. $type .' where id = ' . $id;
			if ($db->query($sql)) {
				$result['html'] = userRowList($filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
			}
		break;
		case 'remove':
			$id = $nv_Request->get_string('id', 'post');
			$filter = $nv_Request->get_array('filter', 'post');
			$tabber = $nv_Request->get_array('tabber', 'post');

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

			if (count($data) > 1 && !empty($userinfo['id'])) {
        // ???
        $sql = 'select * from `'. PREFIX .'_contact` where mobile = "'. $data['mobile'] .'"';
        $query = $db->query($sql);
        if (empty($query->fetch)) {
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

      $check = 0;

			if (!empty($pet = getPetById($petid)) && !empty($owner = getOwnerById($ownerid, $type))) {
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
    			$result['html'] = userDogRowByList($userinfo['id'], $tabber, $filter);
        }
			}
		break;

    case 'parent2':
			$keyword = $nv_Request->get_string('keyword', 'post', '');

			$sql = 'select * from ((select id, fullname, mobile, address, 1 as type from `'. PREFIX .'_user`) union (select id, fullname, mobile, address, 2 as type from `'. PREFIX .'_contact` where userid = '. $userinfo['id'] .')) as a where (mobile like "%'. $keyword .'%" or fullname like "%'. $keyword .'%") limit 10';
			$query = $db->query($sql);

			$html = '';
			while ($row = $query->fetch()) {
				$html .= '
				<div class="suggest_item" onclick="pickOwner(\''. $row['fullname'] .'\', '. $row['id'] .', '. $row['type'] .')">
          <p>
					'. $row['fullname'] .'
          </p>
				</div>
				';
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

			if (count($data) > 1 && !checkPet($data['name'], $userinfo['id'])) {
        // ???
        $sex = 0;
        if ($data['sex1']) {
          $sex = 1;
        }
				$data['dob'] = totime($data['dob']);
				$data['sex'] = $sex;
				$data['dateofbirth'] = totime($data['dob']);
        $data['fid'] = $data['parentf'];
				$data['mid'] = $data['parentm'];

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
        unset($data['parentf']);        
				unset($data['parentm']);

        checkRemind($data['species'], 'species');
        checkRemind($data['breed'], 'breed');
        checkRemind($data['origin'], 'origin');

				$sql = 'insert into `'. PREFIX .'_pet` (userid, '. sqlBuilder($data, BUILDER_INSERT_NAME) .', active, image, type) values('. $userinfo['id'] .', '. sqlBuilder($data, BUILDER_INSERT_VALUE) .', 0, "", 1)';
        // die($sql);

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

			if (count($data) > 1 && !checkPet($data['name'], $userinfo['id'])) {
        $sex = 0;
        if ($data['sex1']) {
          $sex = 1;
        }
				$data['dateofbirth'] = totime($data['dob']);
				$data['sex'] = $sex;
        $data['fid'] = $data['parentf'];
				$data['mid'] = $data['parentm'];

        unset($data['sex0']);
        unset($data['sex1']);
        unset($data['parentf']);        
				unset($data['parentm']);
				unset($data['dob']);

        checkRemind($data['species'], 'species');
        checkRemind($data['breed'], 'breed');

				$sql = 'insert into `'. PREFIX .'_pet` (userid, '. sqlBuilder($data, BUILDER_INSERT_NAME) .', active, image, type) values('. $userinfo['id'] .', '. sqlBuilder($data, BUILDER_INSERT_VALUE) .', 0, "", 1)';

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

			if (count($data) > 1 && !empty($id)) {
				$data['dateofbirth'] = totime($data['dob']);
				$data['fid'] = $data['parentf'];
				$data['mid'] = $data['parentm'];
        $sex = 0;
        if ($data['sex1']) {
          $sex = 1;
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

        if (!empty($data['breeder'])) {
          if ($data['sex']) {
            $data['breeder'] = 1;
          }
          else {
            $data['breeder'] = 0;
          }
        }
        else {
          $data['breeder'] = 2;
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
			$filter = $nv_Request->get_array('filter', 'post');
			$image = $nv_Request->get_string('image', 'post');

			if (count($data) > 1 && !empty($id)) {
				$sql = 'update `'. PREFIX .'_user` set '. sqlBuilder($data, BUILDER_EDIT) . (strlen(trim($image)) > 0 ? ', image = "'. $image .'"' : '') . ' where id = ' . $id;
				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['notify'] = 'Đã chỉnh sửa thú cưng';
				}
			}
		break;
    case 'new-request':
      $name = $nv_Request->get_string('name', 'post');
      $id = $nv_Request->get_string('id', 'post', '');

      if (!empty($name) && !empty($id)) {
        $type = checkRemind($name, 'request');

        $sql = 'insert into `'. PREFIX .'_request` (petid, type, status, time, value) values ("'. $id .'", 2, 1, '. time() .', '. $type .')';

        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = requestDetail($id);
        }
      }
    break;
		case 'private':
			if (!empty($userinfo)) {
				$sql = 'update `'. PREFIX .'_user` set center = 0 where id = ' . $userinfo['id'];

				if ($db->query($sql)) {
					$result['status'] = 1;
				}
			}
		break;
		case 'parent':
			$keyword = $nv_Request->get_string('keyword', 'post', '');

			$sql = 'select a.id, a.name, b.fullname from `'. PREFIX .'_pet` a inner join (select * from ((select id, fullname, mobile, address, 1 as type from `'. PREFIX .'_user`) union (select id, fullname, mobile, address, 2 as type from `'. PREFIX .'_contact` where userid = '. $userinfo['id'] .')) as c) b on a.userid = b.id where (a.name like "%'. $keyword .'%" or b.fullname like "%'. $keyword .'%" or b.mobile like "%'. $keyword .'%") limit 10';
			$query = $db->query($sql);

			$html = '';
			while ($row = $query->fetch()) {
				$html .= '
				<div class="suggest_item2" onclick="pickParent(this, \''. $row['name'] .'\', '. $row['id'] .')">
					<p> '. $row['fullname'] .' </p>
					<p> '. $row['name'] .' </p>
				</div>
				';
			}

			if (empty($html)) {
				$html = 'Không có kết quả trùng khớp';
			}

			$result['status'] = 1;
			$result['html'] = $html;
		break;
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
	}
	echo json_encode($result);
	die();
}

$id = $nv_Request->get_int('id', 'get', 0);
$global = array();
$global['login'] = 0;

$xtpl = new XTemplate("center.tpl", "modules/". $module_name ."/template");

$tabber = array('0');
if (!$userinfo['center']) {
  $xtpl->assign('tabber', '0, 1, 2');
  $tabber = array('0', '1', '2');
}
else {
  $xtpl->assign('tabber', '0');
}
$xtpl->assign('userid', $userinfo['id']);
$xtpl->assign('fullname', $userinfo['fullname']);
$xtpl->assign('mobile', $userinfo['mobile']);
$xtpl->assign('address', $userinfo['address']);
$xtpl->assign('image', $userinfo['image']);
$xtpl->assign('remind', json_encode(getRemind()));
$xtpl->assign('list', userDogRowByList($userinfo['id'], $tabber));

$xtpl->assign('v', parseVaccineType($userinfo['id']));

$xtpl->assign('today', date('d/m/Y', time()));
$xtpl->assign('recall', date('d/m/Y', time() + 60 * 60 * 24 * 21));

$xtpl->assign('origin', '/' . $module_name . '/' . $op . '/');
$xtpl->assign('module_file', $module_file);

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/". $module_file ."/layout/header.php");
echo $contents;
include ("modules/". $module_file ."/layout/footer.php");
