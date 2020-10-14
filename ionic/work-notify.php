<?php 


require_once(NV_ROOTDIR . '/ionic/work.php');
$work = new Work('petwork');

$result['status'] = 1;
$result['notify'] = $work->getUserNotify();
$result['time'] = time();

$work->setTime($result['time']);

echo json_encode($result);
die();