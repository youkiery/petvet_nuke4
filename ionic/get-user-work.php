<?php 

$filter = array(
  'startdate' => ( !empty($_GET['startdate']) ? $_GET['startdate'] : '' ),
  'enddate' => ( !empty($_GET['enddate']) ? $_GET['enddate'] : '' ),
  'keyword' => ( !empty($_GET['keyword']) ? $_GET['keyword'] : '' ),
  'user' => ( !empty($_GET['user']) ? $_GET['user'] : '' ),
  'page' => parseGetData('page', 1)
);

require_once(NV_ROOTDIR . '/ionic/work.php');
$work = new Work();

$list = array(
  'undone' => array(),
  'done' => array(),
);
$xtra = array();
$time = time();

$tick = 0;
if (!empty($filter['startdate'])) {
  $filter['startdate'] = totime($filter['startdate']);
  $tick += 1;
}
if (!empty($filter['enddate'])) {
  $filter['enddate'] = totime($filter['enddate']) + 60 * 60 * 24 - 1;
  $tick += 2;
}

switch ($tick) {
  case 1:
    $xtra []= '(calltime >= '. $filter['startdate'] .')';
  break;
  case 2:
    $xtra []= '(calltime <= '. $filter['enddate'] .')';
  break;
  case 3:
    $xtra []= '(calltime between '. $filter['startdate'] .' and '. $filter['enddate'] .')';
  break;
}

if (!empty($filter['keyword'])) $xtra []= 'content like "%'. $filter['keyword'] .'%"';
if ($work->role) {
  if (!empty($filter['user'])) $xtra []= 'userid in ('. $filter['user'] .')';
}
else $xtra []= 'userid = '. $work->userid;
if (count($xtra)) $xtra = ' and '. implode(' and ', $xtra);
else $xtra = '';

$sql = 'select id, userid, cometime, calltime, process, content, note, image from `'. $work->prefix .'` where process < 100 and active = 1 '. $xtra . ' order by calltime limit 10 offset '. ($filter['page'] - 1) * 10;
$query = $work->db->query($sql);
$user = array();

while ($row = $query->fetch_assoc()) {
  if (empty($user[$row['userid']])) {
    $userinfo = checkUserId($row['userid']);
    $user[$row['userid']] = (!empty($userinfo['last_name']) ? $userinfo['last_name'] . ' ': '') . $userinfo['first_name'];
  }
  $row['name'] = $user[$row['userid']];
  $row['color'] = ($row['calltime'] < $time ? 'red' : '');
  $row['day'] = date('N', $row['calltime']);
  $row['cometime'] = date('d/m/Y', $row['cometime']);
  $row['calltime'] = date('d/m/Y', $row['calltime']);
  $row['image'] = explode(',', $row['image']);
  $list['undone'] []= $row;
}

$sql = 'select id, userid, cometime, calltime, process, content, note, image from `'. $work->prefix .'` where process > 99 and active = 1 '. $xtra . ' order by calltime limit 10 offset '. ($filter['page'] - 1) * 10;
$query = $work->db->query($sql);
$user = array();

while ($row = $query->fetch_assoc()) {
  if (empty($user[$row['userid']])) {
    $userinfo = checkUserId($row['userid']);
    $user[$row['userid']] = (!empty($userinfo['last_name']) ? $userinfo['last_name'] . ' ': '') . $userinfo['first_name'];
  }
  $row['name'] = $user[$row['userid']];
  $row['color'] = ($row['calltime'] < $time ? 'red' : '');
  $row['day'] = date('N', $row['calltime']);
  $row['cometime'] = date('d/m/Y', $row['cometime']);
  $row['calltime'] = date('d/m/Y', $row['calltime']);
  $row['image'] = explode(',', $row['image']);
  $list['done'] []= $row;
}

$result['list'] = $list;
$result['time'] = $work->getLastUpdate();
$result['unread'] = $work->getNotifyUnread();
$result['status'] = 1;

echo json_encode($result);
die();
