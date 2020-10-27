<?php 

require_once(NV_ROOTDIR . '/ionic/schedule.php');
$schedule = new Schedule();

$filter = array(
  'time' => totime(parseGetData('time'))
);

$result['status'] = 1;
$result['data'] = $schedule->getList($filter);;
