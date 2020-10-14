<?php 

$filter = array(
  'startdate' => ( !empty($_GET['startdate']) ? $_GET['startdate'] : '' ),
  'enddate' => ( !empty($_GET['enddate']) ? $_GET['enddate'] : '' ),
  'keyword' => ( !empty($_GET['keyword']) ? $_GET['keyword'] : '' ),
  'user' => ( !empty($_GET['user']) ? $_GET['user'] : '' )
);

require_once(NV_ROOTDIR . '/ionic/work.php');
$work = new Work('petwork');

$result['list'] = $work->getWork($filter);
$result['notify'] = $work->getUserNotify();
$result['unread'] = $work->getUserNotifyUnread();
$result['status'] = 1;

echo json_encode($result);
die();
