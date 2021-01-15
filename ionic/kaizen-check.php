<?php 

$filter = array(
  'keyword' => ( !empty($_GET['keyword']) ? $_GET['keyword'] : '' )
);

$data = array(
  'id' => parseGetData('id'),
  'type' => parseGetData('type', 0)
);

$filter = array(
  'starttime' => parseGetData('starttime'),
  'endtime' => parseGetData('endtime'),
  'keyword' => parseGetData('keyword'),
  'page' => parseGetData('page', 1),
  'type' => parseGetData('type', 0),
  'sort' => parseGetData('sort')
);

require_once(NV_ROOTDIR . '/ionic/kaizen.php');
$kaizen = new Kaizen('test');

$result['status'] = 1;
$result['messenger'] = 'Đã hoàn thành';
$result['list'] = $kaizen->initList();
$result['unread'] = $kaizen->getNotifyUnread();
