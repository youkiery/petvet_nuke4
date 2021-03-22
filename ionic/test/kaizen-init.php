<?php 

$filter = array(
  'time' => parseGetData('time'),
  'starttime' => parseGetData('starttime'),
  'endtime' => parseGetData('endtime'),
  'keyword' => parseGetData('keyword'),
  'page' => parseGetData('page', 1),
  'auto' => parseGetData('auto', 1),
  'sort' => parseGetData('sort')
);
$filter['time'] = intval($filter['time']);

require_once(ROOTDIR .'/kaizen.php');
$kaizen = new Kaizen();

$result['status'] = 1;
$result['list'] = $kaizen->initList();
$result['unread'] = $kaizen->getNotifyUnread(); 
