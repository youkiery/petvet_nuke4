<?php
/**
* @Project NUKEVIET-MUSIC
* @Phan Tan Dung (phantandung92@gmail.com)
* @Copyright (C) 2011
* @Createdate 26-01-2011 14:43
*/

if (!defined('NV_IS_MOD_QUANLY')) die('Stop!!!');
$link = NV_BASE_ADMINURL . "index.php?" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=";

$xtpl = new XTemplate("main.tpl", PATH2);
$xtpl->assign("lang", $lang_module);
$sort_type = array("Ngày dự sinh giảm dần", "Ngày dự sinh tăng dần", "ngày siêu âm giảm dần", "Ngày siêu âm tăng dần");
$order = array("order by calltime desc", "order by calltime asc", "order by cometime desc", "order by cometime asc");
$filter_type = array("25", "50", "100", "200", "Tất cả");
$ret = array("status" => 0, "data" => "");
$check = false;

$sort = $nv_Request -> get_string('sort', 'get', '');
$filter = $nv_Request -> get_string('filter', 'get', '');
$from = $nv_Request -> get_string('from', 'get', '');
$to = $nv_Request -> get_string('to', 'get', '');
$keyword = $nv_Request -> get_string('keyword', 'get', '');
$page = $nv_Request->get_string('page', 'get', "");
$action = $nv_Request->get_string('action', 'post', "");
$id = $nv_Request->get_string('id', 'post', "");
$xtpl->assign("keyword", $keyword);
$xtpl->assign("nv", $module_name);
$xtpl->assign("op", "sieuam");

$today = date("d/m/Y", NV_CURRENTTIME);
$dusinh = $vacconfigv2["expect"];
if (empty($dusinh)) {
	$dusinh = 21 * 24 * 60 * 60;
}

if (empty($page)) {
	$page = 1;
}

$xtpl->assign("now", $today);
$xtpl->assign("dusinh", date("d/m/Y", strtotime($today) + $dusinh));

if (empty($sort)) $sort = 0;
if (empty($filter)) $filter = 25;
$where = "";
$tick = 0;
if (empty($from)) $tick += 1;
else {
	$xtpl->assign("from", $from);
	$from = totime($from);
}
if (empty($to)) $tick += 2;
else {
	$xtpl->assign("to", $to);
	$to = totime($to);
}

switch ($tick) {
	case 0:
		if ($from > $to) {
			$t = $from;
			$from = $to;
			$to = $t;
		}
		$where = "where calltime between $from and $to";
		break;
	case 1:
		$where = "where calltime <= $to";
	break;
	case 2:
		$where = "where calltime >= $from";
		break;
}
if (empty($where)) {
	$where = "where c.name like '%$keyword%' or phone like '%$keyword%' or b.name like '%$keyword%'";
} else $where .= " and (c.name like '%$keyword%' or phone like '%$keyword%' or b.name like '%$keyword%')";
// die($where);

foreach ($sort_type as $key => $sort_name) {
	$xtpl->assign("sort_name", $sort_name);
	$xtpl->assign("sort_value", $key);
	if ($key == $sort) $xtpl->assign("sort_check", "selected");
	else $xtpl->assign("sort_check", "");
	$xtpl->parse("main.sort");
}

foreach ($filter_type as $filter_value) {
	$xtpl->assign("time_value", $filter_value);
	$xtpl->assign("time_name", $filter_value);
	if ($filter_value == $filter) $xtpl->assign("time_check", "selected");
	else $xtpl->assign("time_check", "");
	$xtpl->parse("main.time");
}

if ($action) {
	$ret = array("status" => 0, "data" => array());
	switch ($action) {
		case 'xoasieuam':
			$id = $nv_Request->get_string('id', 'post', "");
			if (!empty($id)) {
				$sql = "delete from " .  VAC_PREFIX . "_usg where id = $id";
				// echo json_encode($ret);
				// die();
				$result = $db->query($sql);
			
				if ($result) {
					$check = true;
				}
				echo 1;
			}
		break;
		case 'usg_info':
			$id = $nv_Request->get_string('id', 'post', "");
			if (!empty($id)) {
				$sql = "select * from " .  VAC_PREFIX . "_usg where id = $id";
				$result = $db->query($sql);

				if ($result) {
					$row = $result->fetch();
					$sql = "select * from " .  VAC_PREFIX . "_pet where id = $row[petid]";
					$result = $db->query($sql);
					$row2 = $result->fetch();
					$ret["status"] = 1;
					$recall = 0;
					if ($row["recall"]) {
						$recall = date("d/m/Y", $row["recall"]);
					}
					$vaccine = "";
					foreach ($lang_module["confirm_value"] as $key => $value) {
						$select = "";
						if ($row["vaccine"] == $key) {
							$select = "selected";
						}
						$vaccine .= "<option value='$key' $select>$value</option>";
					}
					$birthday = "";
					$firstvac = "";
					if ($row["birthday"] > 0) {
						$birthday = date("d/m/Y", $row["birthday"]);
					}
					if ($row["firstvac"] > 0) {
						$firstvac = date("d/m/Y", $row["firstvac"]);
					}
					$ret["data"] = array("calltime" => date("d/m/Y", $row["calltime"]), "cometime" => date("d/m/Y", $row["cometime"]), "doctorid" => $row["doctorid"], "note" => $row["note"], "image" => $row["image"], "customerid" => $row2["customerid"], "petid" => $row["petid"], "birth" => $row["birth"], "exbirth" => $row["expectbirth"], "recall" => $recall, "vaccine" => $vaccine, "vacid" => $row["vaccine"], "firstvac" => $firstvac, "birthday" => $birthday);
				}
				echo json_encode($ret);
			}
		break;
		case 'update_usg':
			$id = $nv_Request->get_string('id', 'post', "");
			$cometime = $nv_Request->get_string('cometime', 'post', "");
			$calltime = $nv_Request->get_string('calltime', 'post', "");
			$doctorid = $nv_Request->get_string('doctorid', 'post', "");
			$birth = $nv_Request->get_string('birth', 'post', "");
			$exbirth = $nv_Request->get_string('exbirth', 'post', "");
			$recall = $nv_Request->get_string('recall', 'post', "");
			$vaccine = $nv_Request->get_int('vaccine', 'post', 0);
			$note = $nv_Request->get_string('note', 'post', "");
			$image = $nv_Request->get_string('image', 'post', "");
			$customer = $nv_Request->get_string('customer', 'post', "");

			$firstvac = $nv_Request->get_string('firstvac', 'post', "");
			$birthday = $nv_Request->get_string('birthday', 'post', "");
			if (!(empty($id) || empty($cometime) || empty($calltime) || empty($doctorid))) {
				$cometime = totime($cometime);
				$calltime = totime($calltime);
				$sql = "select * from `" . VAC_PREFIX . "_usg` where id = $id";
				$query = $db->query($sql);
				$usg = $query->fetch();
				// var_dump($usg);
				$today = strtotime(date("Y-m-d"));
				if (empty($firstvac)) {
					$firstvac = $today;
				}
				else {
					$firstvac = totime($firstvac);
				}
				if (empty($birthday)) {
					$birthday = $today;
				}
				else {
					$birthday = totime($birthday);
				}
				if ($usg["vaccine"] >= 2) {
					$vaccine = 2;
				}
				if ($vaccine == 2) {
					if ($recall == 0) {
						$recall = strtotime(date("Y-m-d"));
					}
					else {
						$recall = totime($recall);
					}
					if ($usg["childid"] == 0 && $customer > 0) {
						$sql = "insert into " . VAC_PREFIX . "_pet (name, customerid) values('" . date("d/m/Y", $calltime) . "', $customer)";
						$query = $db->query($sql);
						$pet_id = $db->lastInsertId();
	
						if ($pet_id > 0) {
							$sql = "update `" . VAC_PREFIX . "_usg` set childid = $pet_id, firstvac = $firstvac, birthday = $birthday, cbtime = " . time() . " where id = $id";
							$query = $db->query($sql);
						}
							
						$sql = "insert into `" . VAC_PREFIX . "_vaccine` (petid, diseaseid, cometime, calltime, status, note, recall, doctorid, ctime) values ($pet_id, 0, $firstvac, $recall, 0, '', 0, $doctorid, " . time() . ");";
						$query = $db->query($sql);
					}
				}
				if ($recall == 0) {
					$recall = 0;
				}
				$sql = "update " .  VAC_PREFIX . "_usg set cometime = $cometime, calltime = $calltime, doctorid = $doctorid, note = '$note', image = '$image', birth = $birth, expectbirth = $exbirth, recall = $recall, vaccine = $vaccine, firstvac = $firstvac, birthday = $birthday  where id = $id";
				$result = $db->query($sql);
				if ($result) {
					$ret["status"] = 1;
				}
				echo json_encode($ret);
			}
		break;
	}
	die();
}
$sql = "select * from " .  VAC_PREFIX . "_doctor";
$result = $db->query($sql);

while ($row = $result->fetch()) {
	$xtpl->assign("doctor_value", $row["id"]);
	$xtpl->assign("doctor_name", $row["name"]);
	$xtpl->parse("main.doctor");
	$xtpl->parse("main.doctor3");
}

// $sql = "select * from " .  VAC_PREFIX . "_usg a inner join " .  VAC_PREFIX . "_pet b on a.petid = b.id $order[$sort]";
$revert = true;
$tpage = $page;
while ($revert) {
	$tpage --;
	if ($tpage <= 0) $revert = false;
	$from = $tpage * $filter;
	$to = $from + $filter;
	$sql = "select a.id, a.cometime, a.calltime, a.birth, a.expectbirth, a.vaccine, a.recall, b.id as petid, b.name as petname, c.id as customerid, c.name as customer, c.phone, d.name as doctor from " .  VAC_PREFIX . "_usg a inner join " .  VAC_PREFIX . "_pet b on a.petid = b.id inner join " .  VAC_PREFIX . "_customer c on b.customerid = c.id inner join " .  VAC_PREFIX . "_doctor d on a.doctorid = d.id $where $order[$sort] limit $from, $to";
	$result = $db->query($sql);
	$display_list = array();
	while ($row = $result->fetch()) {
		$display_list[] = $row;
		$revert = false;
	}
}

$sql = "select count(a.id) as num from " .  VAC_PREFIX . "_usg a inner join " .  VAC_PREFIX . "_pet b on a.petid = b.id inner join " .  VAC_PREFIX . "_customer c on b.customerid = c.id inner join " .  VAC_PREFIX . "_doctor d on a.doctorid = d.id $where";
$result = $db->query($sql);
$row = $result->fetch();

// die($sql);
$num = $row["num"];
$url = $link . $op . "&sort=$sort&filter=$filter";
if(!empty($keyword)) {
	$url .= "&key=$keyword";
}

// echo "$url, $num, $filter, $page";die();

$nav = nv_generate_page_shop($url, $num, $filter, $page);

// if ($action == "xoasieuam") {
// 	if ($check) {
// 		$ret["status"] = 1;
// 		$ret["data"] = displayRed($display_list, NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file, $lang_module, $from + 1, $nav);
// 	}

// 	echo json_encode($ret);
// 	die();
// } else {
// 	$xtpl->assign("content", displayRed($display_list, NV_ROOTDIR . "/themes/" . $global_config['admin_theme'] . "/modules/" . $module_file, $lang_module, $from + 1, $nav));
// }

$xtpl->assign('modal', usgModal($lang_module));
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_site_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");

// function displayRed($list, $path, $lang_module, $index, $nav) {
// 	global $link;
// 	$xtpl = new XTemplate("sieuam-hang.tpl", $path);
// 	$xtpl->assign("lang", $lang_module);	

// 	// echo $path; die();
// 	$stt = $index;
// 	foreach ($list as $key => $row) {
// 		// var_dump($row); die();
// 		$xtpl->assign("stt", $stt);
// 		$xtpl->assign("id", $row["id"]);
// 		$xtpl->assign("customer", $row["customer"]);
// 		$xtpl->assign("petname", $row["petname"]);
// 		$xtpl->assign("pet_link", $link . "patient&petid=" . $row["petid"]);
// 		$xtpl->assign("customer_link", $link . "customer&customerid=" . $row["customerid"]);
// 		$xtpl->assign("phone", $row["phone"]);
// 		$xtpl->assign("doctor", $row["doctor"]);
// 		$xtpl->assign("birth", $row["birth"]);
// 		$xtpl->assign("exbirth", $row["expectbirth"]);
// 		$xtpl->assign("cometime", date("d/m/Y", $row["cometime"]));
// 		$xtpl->assign("calltime", date("d/m/Y", $row["calltime"]));
// 		$recall = $row["recall"];
// 		if ($recall > 0 && $row["vaccine"] > 2) {
// 			$xtpl->assign("recall", date("d/m/Y", $recall));
// 			$xtpl->assign("vacname", "");
// 		}
// 		else {
// 			$xtpl->assign("recall", $lang_module["norecall"]);
// 			$xtpl->assign("vacname", " / " . $lang_module["confirm_value"][$row["vaccine"]]);
// 		}
// 		$xtpl->assign("nav_link", $nav);
// 		// $xtpl->assign("delete_link", "");

// 		$xtpl->parse("main.row");
// 		$stt ++;
// 	}

// 	$xtpl->parse("main");
// 	return $xtpl->text("main");
// }
?>