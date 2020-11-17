<?php
function checkUserId($userid) {
    global $mysqli;
    $sql = 'select * from `pet_users` where userid = '. $userid;
    $query = $mysqli->query($sql);

    if (!empty($user = $query->fetch_assoc())) {
        return $user;
    }
    return false;
}

function cmp($source, $target) {
  return strcmp($target['calltime'], $source['calltime']);
}

function checkUserRole($userid) {
  global $mysqli;
  if (!empty(checkUserId($userid))) {
      $sql = 'select * from `pet_test_user` where userid = '. $userid;
      $query = $mysqli->query($sql);
  
      $user = $query->fetch_assoc();
      if ($user['manager']) return true;
  }
  return false;
}

function parseGetData($dataname, $default = '') {
  global $_GET;
  return (!empty($_GET[$dataname]) ? $_GET[$dataname] : $default);
}

function totime($time) {
  if (preg_match("/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/", $time, $m)) {
    $time = mktime(0, 0, 0, $m[2], $m[1], $m[3]);
  }
  else return false;
  return $time;
}

function getUserList($daily = false) {
  global $mysqli;

  $list = array();
  $xtra = '';
  if ($daily) $xtra = 'where daily = 1';

  $sql = 'select * from `pet_test_user`' . $xtra;
  $query = $mysqli->query($sql);

  while($row = $query->fetch_assoc()) {
    $user = checkUserId($row['userid']);
    $list[$row['userid']] = (!empty($user['last_name']) ? $user['last_name'] . ' ': '') . $user['first_name'];
  }
  return $list;
}
