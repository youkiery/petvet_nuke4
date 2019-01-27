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
$status = $nv_Request->get_string('status', 'post', '');
$doctorid = $nv_Request->get_string('doctorid', 'post', '');
$note = $nv_Request->get_string('note', 'post', '');
$customer = $nv_Request->get_string('customer', 'post', '');
$phone = $nv_Request->get_string('phone', 'post', '');
$address = $nv_Request->get_string('address', 'post', '');
$treating = $nv_Request->get_string('treating', 'post', '');
$eye = $nv_Request->get_string('eye', 'post', '');
$temperate = $nv_Request->get_string('temperate', 'post', '');
$other = $nv_Request->get_string('other', 'post', '');
$ret = array("status" => 0, "data" => "");
// var_dump(strlen($tinhtrang) > 0);
if ( ! ( empty($petid) || empty($doctorid) || empty($cometime) || strlen($status) == 0) ) {
  $sql = "select id from `" . VAC_PREFIX . "_pet` where id = $petid";
	$result = $db->query($sql);
	// $ret["data"] .= $sql;

	if ($result->rowCount()) {
		$cometime = totime($cometime);
		$sql = "INSERT INTO `" . VAC_PREFIX . "_treat` (`petid`, `doctorid`, `cometime`, `insult`, `ctime`) VALUES ($petid, $doctorid, $cometime, 0, " . time() . ")";
		$query = $db->query($sql);
		$insert_id = $db->lastInsertId();

		$sql = "INSERT INTO `" . VAC_PREFIX . "_treating` (`treatid`, `temperate`, `eye`, `other`, `treating`, `examine`, `image`, `time`, `status`, `doctorx`) VALUES ($insert_id, '$temperate', '$eye', '$other', '$treating', 0, '', $cometime, $status, $doctorid)";
		$query = $db->query($sql);
		// $ret["sql"] = $sql;

		// if ($sql) {
		if ($query) {
			// $ret["step"] = 4;
      if (!empty($phone)) {
        $sql = "update `" . VAC_PREFIX . "_customer` set name = '$customer', address = '$address' where phone = '$phone'";
        $db->query($sql);
      }
      $ret["status"] = 1;
			$ret["data"] .= $lang_module["themsatc"];
		}
	}
}

// if (!$ret["status"]) {
// 	$ret["data"] .= $lang_module["themsatb"];
// }

echo json_encode($ret);
die();
?>