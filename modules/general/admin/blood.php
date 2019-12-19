<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'filter':
    $result['status'] = 1;
    $result['html'] = bloodStatistic();
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);

$time = strtotime(date('Y/m/d'));
// $time = strtotime(date('8/8/2019'));
$filter['from'] = $time - 60 * 60 * 24 * 15;
$filter['end'] = $time + 60 * 60 * 24 * 15;

$xtpl->assign('from', date('d/m/Y', $filter['from']));
$xtpl->assign('end', date('d/m/Y', $filter['end']));
$xtpl->assign('content', bloodStatistic());
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");