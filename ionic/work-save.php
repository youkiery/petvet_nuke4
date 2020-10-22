<?php 

if (empty($_GET['id'])) $result['messenger'] = 'no work exist';
else {
  require_once(NV_ROOTDIR . '/ionic/work.php');
  $work = new Work();

  $data = array(
    'id' => parseGetData('id'),
    'content' => parseGetData('content'),
    'process' => parseGetData('process', 0),
    'calltime' => totime(parseGetData('calltime')),
    'note' => parseGetData('note')
  );

  $filter = array(
    'startdate' => ( !empty($_GET['startdate']) ? $_GET['startdate'] : '' ),
    'enddate' => ( !empty($_GET['enddate']) ? $_GET['enddate'] : '' ),
    'keyword' => ( !empty($_GET['keyword']) ? $_GET['keyword'] : '' ),
    'user' => ( !empty($_GET['user']) ? $_GET['user'] : '' )
  );

  if (!$work->checkWorkId($data['id'])) $result['messenger'] = 'no work exist';
  else {
    $time = time();
    $work->updateWork($data, $time);
    $result['status'] = 1;
    $result['messenger'] = 'updated work';
    $result['time'] = $time;
    $result['unread'] = $work->getNotifyUnread();
    $result['data'] = $work->getWork($filter);
  }
}

echo json_encode($result);
die();
