<?php
$value = $nv_Request->get_string('value', 'get/post', '');
$keyword = $nv_Request->get_string('keyword', 'get/post', '');
$vacid = $nv_Request->get_string('vacid', 'get/post', '');
$diseaseid = $nv_Request->get_string('diseaseid', 'get/post', '');
$act = $nv_Request->get_string('act', 'get/post', '');
$ret = array("status" => 0, "data" => "");
if(!(empty($act) || empty($value) || empty($vacid)) && $diseaseid >= 0) {
	$mod = 0;
	if ($act == "up") {
		$mod = 1;
	} else {
		$mod = -1;
	}

	$x = in_array($value, $lang_module["confirm_value"]);
	if ($x) {
		$confirmid = array_search($value, $lang_module["confirm_value"]);
		$confirmid += $mod;
		if (!empty($lang_module["confirm_value"][$confirmid]) && $confirmid < 2) {
			$sql = "update " .  VAC_PREFIX . "_vaccine set status = $confirmid where id = $vacid";
			$result = $db->query($sql);
			if ($result) {
				$sql = "select * from " .  VAC_PREFIX . "_vaccine where id = $vacid";
		    $result = $db->query($sql);
				$row = $result->fetch();
		    if (empty($row["recall"]) || $row["recall"] == "0") $ret["data"]["recall"] = 0;
				else $ret["data"]["recall"] = 1;
				// $ret["data"]["recall"] = $row["recall"];
				$ret["status"] = 1;
				$ret["data"]["html"] = user_vaccine($keyword);
			}
		}
	}
}

echo json_encode($ret);
die();
?>
