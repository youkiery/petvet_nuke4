<?php

/**
 * @Project NUKEVIET-MUSIC
 * @Author Phan Tan Dung
 * @Copyright (C) 2011
 * @Createdate 26/01/2011 10:26 AM
 */


if (!defined('NV_IS_MOD_QUANLY')) die('Stop!!!');
$petid = $nv_Request->get_string('petid', 'post/get', '');
$cometime = $nv_Request->get_string('cometime', 'post', '');
$calltime = $nv_Request->get_string('calltime', 'post', '');
$ngaythongbao = $nv_Request->get_string('ngaythongbao', 'post', '');
$image = $nv_Request->get_string('image', 'post', '');
$doctorid = $nv_Request->get_string('doctorid', 'post', '');
$note = $nv_Request->get_string('note', 'post', '');
$customer = $nv_Request->get_string('customer', 'post', '');
$phone = $nv_Request->get_string('phone', 'post', '');
$address = $nv_Request->get_string('address', 'post', '');
$exbirth = $nv_Request->get_int('exbirth', 'post', 0);
$ret = array("status" => 0, "data" => array());
// var_dump($_POST);
if ( ! ( empty($petid) || empty($doctorid) || empty($cometime) || empty($calltime) ) ) {
	$sql = "select id from `" . VAC_PREFIX . "_pet` where id = $petid";
	$result = $db->query($sql);

	if ($result->rowCount()) {
		$cometime = totime($cometime);
		$calltime = totime($calltime);
		$sql = "INSERT INTO `" . VAC_PREFIX . "_usg` (`petid`, `doctorid`, `cometime`, `calltime`, `image`, `status`, `expectbirth`, `note`, `ctime`) VALUES ($petid, $doctorid, $cometime, $calltime, '$image', 0, $exbirth, '$note', " . time() . ")";
		$query = $db->query($sql);
		$insert_id = $db->lastInsertId();

		if ($insert_id) {
      if (!empty($phone)) {
        $sql = "update `" . VAC_PREFIX . "_customer` set name = '$customer', address = '$address' where phone = '$phone'";
        $db->query($sql);
      }
			$ret["status"] = 1;
			$ret["data"] = $lang_module["themsatc"];
		}
	}
}

if (!$ret["status"]) {
	$ret["data"] = $lang_module["themsatb"];
}

echo json_encode($ret);
die();
?>