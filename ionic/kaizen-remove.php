<?php 

$filter = array(
  'keyword' => ( !empty($_GET['keyword']) ? $_GET['keyword'] : '' )
);

$data = array(
  'id' => parseGetData('id'),
);

require_once(NV_ROOTDIR . '/ionic/kaizen.php');
$kaizen = new Kaizen('test');

if (!$kaizen->role) $result['messenger'] = 'Chưa cấp quyền truy cập';
else {
  $result['status'] = 1;
  $result['time'] = $kaizen->removeData($data);
  $result['list'] = $kaizen->getKaizenList();
  $result['unread'] = $kaizen->getNotifyUnread();
}

