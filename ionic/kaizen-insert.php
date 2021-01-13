<?php 

$filter = array(
  'keyword' => ( !empty($_GET['keyword']) ? $_GET['keyword'] : '' )
);

$data = array(
  'problem' => parseGetData('problem'),
  'solution' => parseGetData('solution'),
  'result' => parseGetData('result')
);

$filter = array(
  'starttime' => parseGetData('starttime'),
  'endtime' => parseGetData('endtime'),
  'keyword' => parseGetData('keyword'),
  'page' => parseGetData('page', 1),
  'type' => parseGetData('type', 'undone'),
  'sort' => parseGetData('sort')
);

require_once(NV_ROOTDIR . '/ionic/kaizen.php');
$kaizen = new Kaizen('test');

$result['time'] = time();
$kaizen->insertData($data, $result['time']);

$result['status'] = 1;
$result['list'] = $kaizen->getKaizenList();
$result['messenger'] = 'Đã thêm giải pháp';
$result['unread'] = $kaizen->getNotifyUnread();
