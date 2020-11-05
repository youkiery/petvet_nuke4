<?php 

require_once(NV_ROOTDIR . '/ionic/schedule.php');
$schedule = new Schedule();

$filter = array(
  'time' => parseGetData('time') / 1000
);

$result['status'] = 1;
$result['data'] = $schedule->getList($filter);;
