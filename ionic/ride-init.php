<?php
$filter = array(
  'time' => parseGetData('time', time()),
  'type' => parseGetData('type', 0)
);

require_once(NV_ROOTDIR . '/ionic/ride.php');
$ride = new Ride();

$result['status'] = 1;
$result['list'][0] = $ride->getList($filter);
$filter['type'] = 1;
$result['list'][1] = $ride->getList($filter);

