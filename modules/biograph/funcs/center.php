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

$page_title = "autoload";

$action = $nv_Request->get_string('action', 'post', '');
$userinfo = getUserInfo();
if (empty($userinfo)) {
	header('location: /' . $module_name . '/login/');
	die();
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

      if (!empty($id)) {
        if (!empty($request = getPetRequest($id, $type)) && count($request) > 0) {
          $sql = 'update `'. PREFIX .'_request` set time = ' . time() . ', status = 1 where type = '. $type .' and petid = ' . $id;
          // die($sql);
          if ($db->query($sql)) {
            $result['status'] = 1;
            $result['html'] = requestDetail($id);
          }
        }
        else {
          $sql = 'insert into `'. PREFIX .'_request` (petid,	type, status, time) values('. $id .', '. $type .', 1, '. time() .')';
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

      if (!empty($id)) {
        if (!empty($request = getPetRequest($id, $type)) && count($request) > 0) {
          $sql = 'update `'. PREFIX .'_request` set time = ' . time() . ', status = 0 where type = '. $type .' and petid = ' . $id;
          // die($sql);
          if ($db->query($sql)) {
            $result['status'] = 1;
            $result['html'] = requestDetail($id);
          }
        }
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
          $sql = 'insert into `'. PREFIX .'_vaccine` (petid, time, recall, type, status) values ("'. $id .'", "'. $data['time'] .'", "'. $data['recall'] .'", "'. $data['type'] .'", 0)';
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
				$result['data'] = array('name' => $row['name'], 'dob' => $row['dateofbirth'], 'species' => $row['species'], 'breed' => $row['breed'], 'color' => $row['color'], 'microchip' => $row['microchip'], 'parentf' => $row['fid'], 'parentm' => $row['mid'], 'miear' => $row['miear']);
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

			$sql = 'delete from `'. PREFIX .'_pet` where id = ' . $id;
			if ($db->query($sql)) {
				$result['html'] = userDogRowByList($userinfo['id'], $filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
			}
		break;
		case 'removeuser':
			$id = $nv_Request->get_string('id', 'post');
			$filter = $nv_Request->get_array('filter', 'post');

			$sql = 'delete from `'. PREFIX .'_user` where id = ' . $id;
			if ($db->query($sql)) {
				$result['html'] = userRowList($filter);
				if ($result['html']) {
					$result['status'] = 1;
				}
			}
		break;
		case 'login':
			$username = $nv_Request->get_string('username', 'post', '');
			$password = $nv_Request->get_string('password', 'post', '');

			if (!empty($username) && !empty($password)) {
				$username = strtolower($username);
				if (checkLogin($username, $password)) {
					$_SESSION['username'] = $username;
					$_SESSION['password'] = $password;
					$result['status'] = 1;
				}
			}
		case 'signup':
			$username = $nv_Request->get_string('username', 'post', '');
			$password = $nv_Request->get_string('password', 'post', '');
			$fullname = $nv_Request->get_string('fullname', 'post', '');
			$mobile = $nv_Request->get_string('phone', 'post', '');
			$address = $nv_Request->get_string('address', 'post', '');

			if (!empty($username) && !empty($password)) {
				$username = strtolower($username);
				if (!checkLogin($username, $password)) {
					$sql = 'insert into `'. PREFIX .'_user` (username, password, fullname, mobile, address, active, image) values("'. $username .'", "'. md5($password) .'", "'. $fullname .'", "'. $mobile .'", "'. $address .'", 0, "")';
					if ($db->query($sql)) {
						$_SESSION['username'] = $username;
						$_SESSION['password'] = $password;
						$result['status'] = 1;
					}
				}
			}
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

				$sql = 'insert into `'. PREFIX .'_pet` (userid, '. sqlBuilder($data, BUILDER_INSERT_NAME) .', active, image) values('. $userinfo['id'] .', '. sqlBuilder($data, BUILDER_INSERT_VALUE) .', 0, "")';
        // die($sql);

				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['notify'] = 'Đã thêm thú cưng';
					$result['remind'] = json_encode(getRemind());
					$result['html'] = userDogRowByList($userinfo['id']);
				}
			}
		break;
		case 'insert-parent':
			$data = $nv_Request->get_array('data', 'post');
			$image = $nv_Request->get_string('image', 'post');

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

				$sql = 'insert into `'. PREFIX .'_pet` (userid, '. sqlBuilder($data, BUILDER_INSERT_NAME) .', active, image) values('. $userinfo['id'] .', '. sqlBuilder($data, BUILDER_INSERT_VALUE) .', 0, "")';

				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['name'] = $data['name'];
					$result['notify'] = 'Đã thêm thú cưng';
					$result['id'] = $db->lastInsertId();
					$result['remind'] = json_encode(getRemind());
					$result['html'] = userDogRowByList($userinfo['id']);
				}
			}
		break;
		case 'editpet':
			$id = $nv_Request->get_string('id', 'post', '');
			$image = $nv_Request->get_string('image', 'post');
			$data = $nv_Request->get_array('data', 'post');

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

				$sql = 'update `'. PREFIX .'_pet` set '. sqlBuilder($data, BUILDER_EDIT) .', image = "'. $image .'" where id = ' . $id;

				if ($db->query($sql)) {
					$result['status'] = 1;
					$result['notify'] = 'Đã chỉnh sửa thú cưng';
					$result['remind'] = json_encode(getRemind());
					$result['html'] = userDogRowByList($userinfo['id']);
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
					$result['remind'] = json_encode(getRemind());
					$result['html'] = userRowList($filter);
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

			$sql = 'select a.id, a.name, b.fullname, b.image from `'. PREFIX .'_pet` a inner join `'. PREFIX .'_user` b on a.userid = b.id where (a.name like "%'. $keyword .'%" or b.fullname like "%'. $keyword .'%") and userid = ' . $userinfo['id'];
			$query = $db->query($sql);

			$html = '';
			while ($row = $query->fetch()) {
				$html .= '
				<div class="suggest_item2" onclick="pickParent(this, \''. $row['name'] .'\', '. $row['id'] .')">
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
	}
	echo json_encode($result);
	die();
}

$id = $nv_Request->get_int('id', 'get', 0);
$global = array();
$global['login'] = 0;

$xtpl = new XTemplate("center.tpl", "modules/biograph/template");

$xtpl->assign('userid', $userinfo['id']);
$xtpl->assign('fullname', $userinfo['fullname']);
$xtpl->assign('mobile', $userinfo['mobile']);
$xtpl->assign('address', $userinfo['address']);
$xtpl->assign('image', $userinfo['image']);
$xtpl->assign('remind', json_encode(getRemind()));
$xtpl->assign('list', userDogRowByList($userinfo['id']));

if (!$userinfo['center']) {
	$xtpl->parse('main.log.center');
  $xtpl->assign('tabber', '0, 1, 2');
}
else {
  $xtpl->assign('tabber', '0');
	$xtpl->parse('main.log.xcenter');
	$xtpl->parse('main.log.tabber');
	$xtpl->parse('main.log.breeder');
	$xtpl->parse('main.log.breeder2');
}

$xtpl->parse('main.log');

$xtpl->assign('origin', '/' . $module_name . '/' . $op . '/');

$xtpl->parse("main");
$contents = $xtpl->text("main");
include ("modules/biograph/layout/header.php");
echo $contents;
include ("modules/biograph/layout/footer.php");
