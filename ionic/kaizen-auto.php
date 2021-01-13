<?php 

$filter = array(
  'time' => parseGetData('time'),
  'starttime' => parseGetData('starttime'),
  'endtime' => parseGetData('endtime'),
  'keyword' => parseGetData('keyword'),
  'page' => parseGetData('page', 1),
  'type' => parseGetData('type', 'undone'),
  'auto' => parseGetData('auto', 1),
  'sort' => parseGetData('sort')
);
$filter['time'] = intval($filter['time']);

require_once(NV_ROOTDIR . '/ionic/kaizen.php');
$kaizen = new Kaizen();
$result['status'] = 1;
if (!$filter['auto'] || ($filter['auto'] && $kaizen->checkLastUpdate($filter['time']))) {
  $result['time'] = $kaizen->getLastUpdate();
  $result['list'] = $kaizen->getKaizenList();
  $result['unread'] = $kaizen->getNotifyUnread();
}
