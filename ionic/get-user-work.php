<?php 

$filter = array(
  'startdate' => ( !empty($_GET['startdate']) ? $_GET['startdate'] : '' ),
  'enddate' => ( !empty($_GET['enddate']) ? $_GET['enddate'] : '' ),
  'keyword' => ( !empty($_GET['keyword']) ? $_GET['keyword'] : '' ),
  'user' => ( !empty($_GET['user']) ? $_GET['user'] : '' )
);

$list = array();
$role = checkUserRole($userid);

$tick = 0;
$xtra = array();
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
if ($role) {
  if (!empty($filter['user'])) $xtra []= 'userid in ('. $filter['user'] .')';
}
else $xtra []= 'userid = '. $userid;
if (count($xtra)) $xtra = ' where '. implode(' and ', $xtra);
else $xtra = '';

$sql = 'select id, userid, cometime, calltime, process, content, note from `pet_petwork_row`'. $xtra . ' order by calltime';
$query = $mysqli->query($sql);
$user = array();

while ($row = $query->fetch_assoc()) {
  if (empty($user[$row['userid']])) {
    $userinfo = checkUserId($row['userid']);
    $user[$row['userid']] = (!empty($userinfo['last_name']) ? $userinfo['last_name'] . ' ': '') . $userinfo['first_name'];
  }
  $row['name'] = $user[$row['userid']];
  $row['cometime'] = date('d/m/Y', $row['cometime']);
  $row['calltime'] = date('d/m/Y', $row['calltime']);
  $list []= $row;
}
$result['list'] = $list;
$result['status'] = 1;

echo json_encode($result);
die();
