<?php 

$filter = array(
  'keyword' => ( !empty($_GET['keyword']) ? $_GET['keyword'] : '' )
);

$data = array(
  'id' => parseGetData('id'),
);

$filter = array(
  'starttime' => parseGetData('starttime'),
  'endtime' => parseGetData('endtime'),
  'keyword' => parseGetData('keyword'),
  'page' => parseGetData('page', 1),
  'sort' => parseGetData('sort')
);

require_once(NV_ROOTDIR . '/ionic/kaizen.php');
$kaizen = new Kaizen('test');

if (!$kaizen->role) $result['messenger'] = 'Chưa cấp quyền truy cập';
else {
  $result['status'] = 1;
  $result['time'] = $kaizen->removeData($data);
  $result['messenger'] = 'Đã xóa giải pháp';
  $result['list'] = $kaizen->getKaizenList();
  $result['unread'] = $kaizen->getNotifyUnread();
}

