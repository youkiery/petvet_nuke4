<?php
/**
 * @Project Petcoffee-technical
 * @Author Chistua
 * @Copyright (C) 2019
 * @Createdate 18/03/2019
 */
if (!defined('NV_IS_MOD_QUANLY')) {
  die('Stop!!!');
}

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array("status" => 0);
  switch ($action) {
    case 'remind_vaccine':
      $keyword = $nv_Request->get_string('keyword', 'post/get', "");
      $fromtime = $nv_Request->get_string('fromtime', 'post/get', "");
      $totime = $nv_Request->get_string('totime', 'post/get', "");

      if (totime($fromtime) && totime($totime)) {
        $result["status"] = 1;
        $result["html"] = vaccineRemind($keyword, $fromtime, $totime);
      }
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("overmind.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);

$today = strtotime(date("Y-m-d"));
$from = $today - $vacconfigv2["filter"];
$to = $today + $vacconfigv2["filter"];

$xtpl->assign("content", vaccineRemind("", $from, $to));

$xtpl->parse("main");

$contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );
