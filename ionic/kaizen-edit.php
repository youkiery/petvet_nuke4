<?php 

$filter = array(
  'starttime' => parseGetData('starttime'),
  'endtime' => parseGetData('endtime'),
  'keyword' => parseGetData('keyword'),
  'sort' => parseGetData('sort')
);

$data = array(
  'id' => parseGetData('id'),
  'problem' => parseGetData('problem'),
  'solution' => parseGetData('solution'),
  'result' => parseGetData('result')
);

require_once(NV_ROOTDIR . '/ionic/kaizen.php');
$kaizen = new Kaizen('test');

$result['status'] = 1;
$result['time'] = $kaizen->updateData($data);
$result['list'] = $kaizen->getKaizenList();
$result['unread'] = $kaizen->getNotifyUnread();
