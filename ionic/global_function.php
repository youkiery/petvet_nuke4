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
  return strcmp($target['expecttime'], $source['expecttime']);
}

function cmp2($source, $target) {
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

function getUserBranch() {
  global $userid, $mysqli;
  try {
    $sql = 'select * from `pet_setting_user` where userid = ' . $userid;
    $query = $mysqli->query($sql);
    $user = $query->fetch_assoc();

    if (!empty($user)) {
      $sql = 'select * from `pet_setting_branch` where id = '. $user['branch'];
      $query = $mysqli->query($sql);
      $branch = $query->fetch_assoc();
      return array(
        'id' => $branch['id'],
        'prefix' => $branch['prefix']
      );
    }
    throw new ErrorException('user without branch');
  }
  catch(Exception $e) { 
    echo json_encode(array(
      'status' => 0,
      'messenger' => 'Nhân viên chưa được phân quyền'
    ));
    die();
  }
}

function parseGetData($dataname, $default = '') {
  global $_GET;
  return (isset($_GET[$dataname]) && $_GET[$dataname] != '' ? $_GET[$dataname] : $default);
}

function totime($time) {
  if (preg_match("/^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/", $time, $m)) {
    $time = mktime(0, 0, 0, $m[2], $m[1], $m[3]);
  }
  else return false;
  return $time;
}
