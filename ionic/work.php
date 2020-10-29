<?php
class Work extends Module {
  function __construct() {
    parent::__construct();
    $this->module = 'work';
    $this->prefix = 'pet_' . $this->table .'_'. $this->module;
    $this->role = $this->getRole();
  }

  function getWork($filter) {
    $list = array();
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
    if ($this->role) {
      if (!empty($filter['user'])) $xtra []= 'userid in ('. $filter['user'] .')';
    }
    else $xtra []= 'userid = '. $this->userid;
    if (count($xtra)) $xtra = ' and '. implode(' and ', $xtra);
    else $xtra = '';

    $sql = 'select id, userid, cometime, calltime, process, content, note from `'. $this->prefix .'` where active = 1 '. $xtra . ' order by calltime';
    $query = $this->db->query($sql);
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
      $list []= $row;
    }
    return $list;
  }

  function getUserNotify($page = 1) {
    $list = array();
    // lấy danh sách thông báo
    $xtra = '';
    if (!$this->role) {
      // nhân viên, lấy thông báo bản thân
      $xtra = 'where userid = ' . $this->userid;
    }
    $sql = 'select * from `pet_'. $this->table .'_notify` ' . $xtra . ' order by time desc';
    $query = $this->db->query($sql);

    while ($row = $query->fetch_assoc()) {
      $list []= $this->parseWorkNotify($row);
    }
    return $list;
  }

  function getUserNotifyTime() {
    $sql = 'select * from `pet_'. $this->table .'_notify_read` where userid = ' . $this->userid;
    $query = $this->db->query($sql);

    if (empty($row = $query->fetch_assoc())) {
      $sql = 'insert into `pet_'. $this->table .'_notify_read` (userid, time) values ('. $this->userid .', 0)';
      $this->db->query($sql);
      $row = array(
        'time' => 0
      );
    }
    return $row['time'];
  }

  // userid, action, workid, time
  function parseWorkNotify($data) {
    $action_trans = array(1 => 'thêm công việc', 'cập nhật tiến độ', 'hoàn thành', 'hủy công việc');
    $user = checkUserId($data['userid']);
    $name = (!empty($user['last_name']) ? $user['last_name'] . ' ': '') . $user['first_name'];
    $work = $this->getWorkById($data['workid']);

    return array(
      'id' => $data['workid'],
      'content' => $name . ' ' . $action_trans[$data['action']] . ' ' . $work['content'],
      'time' => date('d/m/Y H:i', $data['time'])
    );
  }

  function getWorkById($workid) {
    $sql = 'select * from `'. $this->prefix .'` where id = ' . $workid;
    $query = $this->db->query($sql);
    return $query->fetch_assoc();
  }

  function checkWorkId($workid) {
    $sql = 'select * from `'. $this->prefix .'` where id = '. $workid;
    $query = $this->db->query($sql);

    if (!empty($query->fetch_assoc())) return true;
    return false;
  }

  function insertWork($data, $time) {
    $sql = 'insert into `'. $this->prefix .'` (cometime, calltime, last_time, post_user, edit_user, userid, depart, customer, content, process, confirm, review, note) value("'. $data['cometime'] .'", "'. $data['calltime'] .'", '. $time .', '. $this->userid .', '. $this->userid .', '. $data['employ'] .', 0, 0, "'. $data['content'] .'", 0, 0, "", "")';

    if ($this->db->query($sql)) {
      $id = $this->db->insert_id;
      $this->insertNotify(INSERT_NOTIFY, $id, $time);
      $this->setLastUpdate($time);
    }
  }

  function updateWork($data, $time) {
    $xtra = '';
    $sql = 'update `'. $this->prefix .'` set process = '. $data['process'] .', note = "'. $data['note'] .'", calltime = "'. $data['calltime'] .'" '. $xtra .' where id = '. $data['id'];
    if ($this->db->query($sql)) {
      $this->insertNotify(EDIT_NOTIFY, $data['id'], $time);
      $this->setLastUpdate($time);
    }
  }

  function removeWork($data, $time) {
    $sql = 'update `'. $this->prefix .'` set active = 0 where id = '. $data['id'];
    if ($this->db->query($sql)) {
      $this->setLastUpdate($time);
      $this->insertNotify(REMOVE_NOTIFY, $data['id'], $time);
    }
  }
}
