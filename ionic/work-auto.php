<?php 

require_once(NV_ROOTDIR . '/ionic/work.php');
$work = new Work('petwork');

$time = $_GET['time'];
$filter = array(
  'startdate' => ( !empty($_GET['startdate']) ? $_GET['startdate'] : '' ),
  'enddate' => ( !empty($_GET['enddate']) ? $_GET['enddate'] : '' ),
  'keyword' => ( !empty($_GET['keyword']) ? $_GET['keyword'] : '' ),
  'user' => ( !empty($_GET['user']) ? $_GET['user'] : '' )
);

$result['status'] = 1;
if ($work->checkLastUpdate($time)) {
  $result['data'] = $work->getWork($filter);
  $result['unread'] = $work->getUserNotifyUnread();
  $result['time'] = $work->getLastUpdate();
  $work->setTime($result['time']);
}


echo json_encode($result);
die();