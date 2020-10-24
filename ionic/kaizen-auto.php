<?php 

$filter = array(
  'time' => parseGetData('time'),
  'starttime' => parseGetData('starttime'),
  'endtime' => parseGetData('endtime'),
  'keyword' => parseGetData('keyword'),
  'sort' => parseGetData('sort')
);
$filter['time'] = intval($filter['time']);

require_once(NV_ROOTDIR . '/ionic/kaizen.php');
$kaizen = new Kaizen();

$last = $kaizen->getLastUpdate();

$result['status'] = 1;
if ($filter['time'] < $last) {
  $result['time'] = $last;
  $result['list'] = $kaizen->getKaizenList();
  $result['unread'] = $kaizen->getNotifyUnread();
}
