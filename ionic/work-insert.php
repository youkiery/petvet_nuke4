<?php 

if (!checkUserRole($userid)) $result['messenger'] = 'no permission allow';
else {
  require_once(NV_ROOTDIR . '/ionic/work.php');
  $work = new Work();

  $data = array(
    'content' => parseGetData('content'),
    'cometime' => totime(parseGetData('cometime')),
    'calltime' => totime(parseGetData('calltime')),
    'employ' => parseGetData('employ')
  );

  $filter = array(
    'startdate' => ( !empty($_GET['startdate']) ? $_GET['startdate'] : '' ),
    'enddate' => ( !empty($_GET['enddate']) ? $_GET['enddate'] : '' ),
    'keyword' => ( !empty($_GET['keyword']) ? $_GET['keyword'] : '' ),
    'user' => ( !empty($_GET['user']) ? $_GET['user'] : '' )
  );

  $time = time();
  $work->insertWork($data, $time);
  $result['status'] = 1;
  $result['messenger'] = 'inserted work';
  $result['time'] = $time;
  $result['unread'] = $work->getNotifyUnread();
  $result['data'] = $work->getWork($filter);
}
