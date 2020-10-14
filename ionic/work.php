<?php
class Work {
  public $table;

  function __construct($table) {
    $this->table = $table;
  }

  function getWork($filter) {
    global $mysqli, $userid;

    $list = array();
    $xtra = array();
    $role = checkUserRole($userid);

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
    if ($role) {
      if (!empty($filter['user'])) $xtra []= 'userid in ('. $filter['user'] .')';
    }
    else $xtra []= 'userid = '. $userid;
    if (count($xtra)) $xtra = ' and '. implode(' and ', $xtra);
    else $xtra = '';

    $sql = 'select id, userid, cometime, calltime, process, content, note from `pet_petwork_row` where active = 1 '. $xtra . ' order by calltime';
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
    return $list;
  }

  function getUserNotify($page = 1) {
    global $mysqli, $userid;

    $list = array();
    $role = checkUserRole($userid);
    // lấy danh sách thông báo
    $xtra = '';
    if (!$role) {
      // nhân viên, lấy thông báo bản thân
      $xtra = 'where userid = ' . $userid;
    }
    $sql = 'select * from `pet_'. $this->table .'_notify` ' . $xtra . ' order by time desc';
    $query = $mysqli->query($sql);

    while ($row = $query->fetch_assoc()) {
      $list []= $this->parseWorkNotify($row);
    }
    return $list;
  }

  function getUserNotifyTime() {
    global $mysqli, $userid;

    $sql = 'select * from `pet_'. $this->table .'_notify_read` where userid = ' . $userid;
    $query = $mysqli->query($sql);

    if (empty($row = $query->fetch_assoc())) {
      $sql = 'insert into `pet_'. $this->table .'_notify_read` (userid, time) values ('. $userid .', 0)';
      $mysqli->query($sql);
      $row = array(
        'time' => 0
      );
    }
    return $row['time'];
  }

  // userid, action, workid, time
  function parseWorkNotify($data) {
    global $db;
    $action_trans = array(1 => 'nhận công việc', 'cập nhật tiến độ', 'hoàn thành', 'hủy công việc');
    $user = checkUserId($data['userid']);
    $name = (!empty($user['last_name']) ? $user['last_name'] . ' ': '') . $user['first_name'];
    $work = $this->getWorkById($data['workid']);

    return array(
      'content' => $name . ' ' . $action_trans[$data['action']] . ' ' . $work['content'],
      'time' => date('d/m/Y H:i', $data['time'])
    );
  }

  function getWorkById($workid) {
    global $mysqli;

    $sql = 'select * from `pet_'. $this->table .'_row` where id = ' . $workid;
    $query = $mysqli->query($sql);
    return $query->fetch_assoc();
  }

  function setTime($time) {
    global $mysqli, $userid;

    $sql = 'update `pet_'. $this->table .'_notify_read` set time = '. $time .' where userid = ' . $userid;
    $mysqli->query($sql);
  }

  function getUserNotifyUnread() {
    global $mysqli, $userid;

    $time = $this->getUserNotifyTime();

    $sql = 'select * from `pet_'. $this->table .'_notify` where time > ' . $time;
    $query = $mysqli->query($sql);

    return $query->num_rows;
  }
}
