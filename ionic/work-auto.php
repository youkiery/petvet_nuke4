<?php 

require_once(NV_ROOTDIR . '/ionic/work.php');
$work = new Work();

$time = parseGetData('time', '');
$filter = array(
  'startdate' => ( !empty($_GET['startdate']) ? $_GET['startdate'] : '' ),
  'enddate' => ( !empty($_GET['enddate']) ? $_GET['enddate'] : '' ),
  'keyword' => ( !empty($_GET['keyword']) ? $_GET['keyword'] : '' ),
  'user' => ( !empty($_GET['user']) ? $_GET['user'] : '' ),
  'page' => parseGetData('page', 1)
);

$result['status'] = 1;
if ($work->checkLastUpdate($time)) {
  $result['list'] = $work->getWork($filter);
  $result['unread'] = $work->getNotifyUnread();
  $result['time'] = $work->getLastUpdate();
}

echo json_encode($result);
die();
