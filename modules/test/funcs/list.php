<?php
/**
* @Project NUKEVIET-MUSIC
* @Phan Tan Dung (phantandung92@gmail.com)
* @Copyright (C) 2011
* @Createdate 26-01-2011 14:43
*/
if ( ! defined( 'NV_IS_MOD_QUANLY' ) ) die( 'Stop!!!' );
$action = $nv_Request->get_string("action", "get/post", "");
if (!empty($action)) {
	$result = array("status" => 0);
	switch ($action) {
		case 'get-customer':
			$id = $nv_Request->get_int('id', 'post');

			$sql = 'select * from `'. VAC_PREFIX .'_customer` where id = '. $id;
			$query = $db->query($sql);
			if (!empty($row = $query->fetch())) {
				$result['status'] = 1;
				$result['data'] = $row;
			}
		break;
		case 'edit-customer':
			// kiểm tra thông tin số điện thoại người dùng, nếu có, báo lỗi, nếu không, cập nhật
			$id = $nv_Request->get_int('id', 'post');
			$data = $nv_Request->get_array('data', 'post');
			
			$sql = 'select * from `'. VAC_PREFIX .'_customer` where id <> '. $id .' and phone = "'. $data['phone'] . '"';
			$query = $db->query($sql);
			if (!empty($row = $query->fetch())) {
				// Có sđt, báo lỗi
				$result['data'] = 2;
			}
			else {
				// cập nhật
				$sql = "update `" . VAC_PREFIX . "_customer` set name = '$data[name]', phone = '$data[phone]', address = '$data[address]' where id = $id";
				if ($db->query($sql)) {
					$result['status'] = 1;
				}
			}
		break;
		case 'customer-suggest':
			$keyword = $nv_Request->get_string('keyword', 'get/post', '');

			$sql = 'select * from `'. VAC_PREFIX .'_customer` where name like "%'.$keyword.'%" or phone like "%'.$keyword.'%" limit 20';
			$query = $db->query($sql);
			$html = '';
			while ($customer = $query->fetch()) {
				$html .= '<div class="hr"><div class="item_suggest item_suggest2" onclick="parseKeyword(\''.$customer['name'].'\', \''.$customer['phone'].'\')">' . $customer['name'] . ' <br>' . $customer['phone'] . '</div><div class="item_suggest3" onclick="editCustomer('. $customer['id'] .')"> E </div></div><div style="clear: both;"></div>';
			}
			$result['status'] = 1;
			$result['html'] = $html;

		break;
		case 'change_data':
			$page = $nv_Request->get_int('page', 'post/get', 0);
			$keyword = $nv_Request->get_string('keyword', 'post/get', "");
			$id = $nv_Request->get_int('id', 'post/get', 0);

			$result['status'] = 1;
			$result["html"] = user_vaccine($keyword);
		break;
		case 'search':
			$keyword = $nv_Request->get_string('keyword', 'get/post', '');

			$result['status'] = 1;
			$result['html'] = user_vaccine($keyword);
		break;
		case 'search-all':
			$keyword = $nv_Request->get_string('keyword', 'get/post', '');
			$_POST['page'] = 'search-all';

			$result['status'] = 1;
			$result['html'] = user_vaccine($keyword);
		break;
		case 'change_custom':
		$id = $nv_Request->get_string('cid', 'post/get', "");
		$name = $nv_Request->get_string('name', 'post/get', "");
		$phone = $nv_Request->get_string('phone', 'post/get', "");
		$address = $nv_Request->get_string('address', 'post/get', "");
		$keyword = $nv_Request->get_string('keyword', 'post/get', "");

		if (!empty($name) && !empty($phone)) {
				$sql = "update `" . VAC_PREFIX . "_customer` set name = '$name', phone = '$phone', address = '$address' where id = $id";
				$query = $db->query($sql);
				if ($query) {
					$result["status"] = 1;
					$result["notify"] = $lang_module["saved"];
					$result["list"] = user_vaccine();
				}
		}
		break;
		case 'get_miscustom':
			$id = $nv_Request->get_string('id', 'post/get', "");

			if (!empty($id)) {
				$sql = "select a.* from `" . VAC_PREFIX . "_customer` a inner join `" . VAC_PREFIX . "_pet` b on a.id = b.customerid inner join `" . VAC_PREFIX . "_vaccine` c on b.id = c.petid where c.id = '$id'";
				$query = $db->query($sql);
				$custom = $query->fetch();
				if ($custom) {
					$result["status"] = 1;
					$result["id"] = $custom["id"];
					$result["name"] = $custom["name"];
					$result["phone"] = $custom["phone"];
					$result["address"] = $custom["address"];
				}
			}
		break;
		case 'miscustom':
			$id = $nv_Request->get_string("vacid", "get/post", "");
			if (!empty($id)) {
				$sql = "select * from `" . VAC_PREFIX . "_vaccine` where id = $id";
				$vac_query = $db->query($sql);
				$vac = $vac_query->fetch();

				$sql = "select * from `" . VAC_PREFIX . "_pet` where id = $vac[petid]";
				$pet_query = $db->query($sql);
				$pet = array();
				$customerid = 0;
				while ($row = $pet_query->fetch()) {
					$customerid = $row["customerid"];
					$pet[] = $row["id"];
				}
				$pet = implode(", ", $pet);

				$sql = "delete from `" . VAC_PREFIX . "_customer` where id = $customerid";
				$custom_query = $db->query($sql);

				$sql = "delete from `" . VAC_PREFIX . "_spa` where customerid = $customerid";
				$spa_query = $db->query($sql);
				
				if (!empty($pet)) {
					$sql = "delete from `" . VAC_PREFIX . "_pet` where id in ($pet)";
					$pet_query = $db->query($sql);
					
					$sql = "delete from `" . VAC_PREFIX . "_vaccine` where petid in ($pet)";
					$vac_query = $db->query($sql);
					
					$sql = "delete from `" . VAC_PREFIX . "_usg` where petid in ($pet)";
					$usg_query = $db->query($sql);
					
					$sql = "select * from `" . VAC_PREFIX . "_treat` where id = $id";
					$treat_query = $db->query($sql);
					$treat = array();
					while ($row = $treat_query->fetch()) {
						$treat[] = $row;
					}
					$treat = implode(", ", $treat);

					$sql = "delete from `" . VAC_PREFIX . "_treat` where petid in ($pet)";
					$treat_query = $db->query($sql);

					if (!empty($treat)) {
						$sql = "delete from `" . VAC_PREFIX . "_treating` where treatid in ($treat)";
						$treat_query = $db->query($sql);
					}
				}
				
				if ($custom_query) {
					$result["status"] = 1;
					$result["list"] = user_vaccine();
				}
			}
			break;
		case 'deadend':
			$id = $nv_Request->get_string("vacid", "get/post", "");
			if (!empty($id)) {
				$sql = "select * from `" . VAC_PREFIX . "_vaccine` where id = $id";
				$vac_query = $db->query($sql);
				$vac = $vac_query->fetch();

				$sql = "select * from `" . VAC_PREFIX . "_pet` where id = $vac[petid]";
				$pet_query = $db->query($sql);
				$pet = array();
				while ($row = $pet_query->fetch()) {
					$pet[] = $row["id"];
				}
				$pet = implode(", ", $pet);

				if (!empty($pet)) {
					$sql = "delete from `" . VAC_PREFIX . "_pet` where id in ($pet)";
					$pet_query = $db->query($sql);
					
					$sql = "delete from `" . VAC_PREFIX . "_vaccine` where petid in ($pet)";
					$vac_query = $db->query($sql);
					
					$sql = "delete from `" . VAC_PREFIX . "_usg` where petid in ($pet)";
					$usg_query = $db->query($sql);
					
					$sql = "select * from `" . VAC_PREFIX . "_treat` where id = $id";
					$treat_query = $db->query($sql);
					$treat = array();
					while ($row = $treat_query->fetch()) {
						$treat[] = $row;
					}
					$treat = implode(", ", $treat);

					$sql = "delete from `" . VAC_PREFIX . "_treat` where petid in ($pet)";
					$treat_query = $db->query($sql);

					if (!empty($treat)) {
						$sql = "delete from `" . VAC_PREFIX . "_treating` where treatid in ($treat)";
						$treat_query = $db->query($sql);
					}
					if ($pet_query) {
						$result["status"] = 1;
						$result["list"] = user_vaccine();
					}
				}
			}
		break;
    case 'save':
      $recall = $nv_Request->get_string('recall', 'post', '');
      $doctor = $nv_Request->get_string('doctor', 'post', '');
      $vacid = $nv_Request->get_string('vacid', 'post', '');
      $diseaseid = $nv_Request->get_string('diseaseid', 'post', '');
      $petid = $nv_Request->get_string('petid', 'post', '');

      if (!(empty($petid) || empty($recall) || empty($doctor) || empty($vacid)) && $diseaseid >= 0) {
        $cometime = strtotime(date('Y/m/d'));
        $calltime = totime($recall);

        $sql = "select * from `" . VAC_PREFIX . "_vaccine` where id = $vacid";
        $query = $db->query($sql);
        $vaccine = $query->fetch();

        $sql = "update `" . VAC_PREFIX . "_vaccine` set status = 2, recall = $calltime, calltime = $calltime, doctorid = $doctor where id = $vacid";
        // die($sql);
        if ($db->query($sql)) {
          $result["status"] = 1;
          $result["data"]["html"] = user_vaccine();
        }

        if ($vaccine["recall"]) {
          $sql = "insert into `" . VAC_PREFIX . "_vaccine` (petid, diseaseid, cometime, calltime, status, note, recall, doctorid, ctime) values ($petid, $diseaseid, $cometime, $calltime, 0, '', 0, 0, " . time() . ")";
          $db->query($sql);
        }
      }
      break;
	}
	echo json_encode($result);
	die();
}
quagio();
// initial
$xtpl = new XTemplate("list.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
$page_title = $lang_module["main_title"];
$xtpl->assign("lang", $lang_module);
$xtpl->assign("nv", $module_name);
$xtpl->assign("op", $op);
// page
$page = $nv_Request->get_string('page', 'get', '');
$xtpl->assign("page", $page);
// keyword
$keyword = $nv_Request->get_string('keyword', 'get', '');
$xtpl->assign("keyword", $keyword);
// // status
// if (!empty($_SESSION["vac_filter"]) && $_SESSION["vac_filter"] > 0 && !(strpos($_SESSION["vac_filter"], "0") == false || strpos($_SESSION["vac_filter"], "1") == false || strpos($_SESSION["vac_filter"], "2") == false)) {
// 	$filter = $_SESSION["vac_filter"];
// }
// else {
// 	$filter = $vaccine_config["vac_s"];
// 	$_SESSION["vac_filter"] = $filter;
// }

// $filter_array = str_split($filter);

foreach ($lang_module["vacstatusname"] as $key => $value) {
	if (!$key) {
		$check = "btn-info";
	}
	else {
		$check = "";
	}
	$xtpl->assign("check", $check);
	$xtpl->assign("ipd", $key);
	$xtpl->assign("vsname", $value);
	$xtpl->parse("main.filter");
}
// doctor
$sql = "select * from " . VAC_PREFIX . "_doctor";
$query = $db->query($sql);
while($row = $query->fetch()) {
  $xtpl->assign("doctorid", $row["id"]);
  $xtpl->assign("doctorname", $row["name"]);
  $xtpl->parse("main.doctor");
}

$list = user_vaccine();
$xtpl->assign("content", $list);

$xtpl->parse("main");
$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme( $contents );
include ( NV_ROOTDIR . "/includes/footer.php" );
