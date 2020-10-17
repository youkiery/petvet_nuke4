<?php 


require_once(NV_ROOTDIR . '/ionic/work.php');
$work = new Work('petwork');

$result['status'] = 1;
$result['notify'] = $work->getUserNotify();
$work->setTime(time());

echo json_encode($result);
die();
