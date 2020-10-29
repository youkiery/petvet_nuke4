<?php 

require_once(NV_ROOTDIR . '/ionic/schedule.php');
$schedule = new Schedule();
// ['Thứ 2', 'Thứ 3', 'Thứ 4', 'Thứ 5', 'Thứ 6', 'Thứ 7', 'Chủ nhật']
$reversal_day = array(
  0 => 1, 2, 3, 4, 5, 6, 7 
);

$list = json_decode(parseGetData('list'));
$filter = array(
  'time' => totime(parseGetData('time'))
);

foreach ($list as $value) {
  // a => day, b => type
  $time = $filter['time'] + 60 * 60 * 24 * ($value->a - date('N', $filter['time']) + 1);
  $schedule->insert($userid, $time, $value->b, $value->c);
}


$result['status'] = 1;
$result['data'] = $schedule->getList($filter);;
