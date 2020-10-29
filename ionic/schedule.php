<?php
class Schedule extends Module {
  function __construct() {
    parent::__construct();
    $this->module = 'row';
    $this->prefix = 'pet_' . $this->table .'_'. $this->module;
    $this->role = $this->getRole();
  }

  function getList($filter) {
    $list = array();
    if (!$filter['time']) $filter['time'] = time();
    $starttime = date("N", $filter['time']) == 1 ? strtotime(date("Y-m-d", $filter['time'])) : strtotime(date("Y-m-d", strtotime('last monday', $filter['time'])));
    $endtime = $starttime + 60 * 60 * 24 * 7 - 1;
    $reversal = array(
      1 => 1, 2, 3, 4, 5, 6, 0
    );

    $data = array();
    for ($i = 0; $i < 7; $i++) { 
      $data []= array(
        'data' => array(
          1 => array(),
          array(),
          array()
        ), 
        'time' => date('d/m', $starttime + 60 * 60 * 24 * $i)
      );
    }

    $sql = 'select id, user_id, type, time from `'. $this->prefix .'` where (time between '. $starttime .' and '. $endtime .')';
    $query = $this->db->query($sql);
    $row = array();
    $userList = getUserList();

    while ($row = $query->fetch_assoc()) {
      $day = date('N', $row['time']);
      $name = $userList[$row['user_id']];
      if ($row['type']) $data[$reversal[$day]]['data'][$row['type']] []= $name;
    }

    return $data;
  }

  function getScheduleById($id) {
    $sql = 'select * from `'. $this->prefix .'` where id = '. $id;
    $query = $this->db->query($sql);
    if (!empty($row = $query->fetch_assoc())) return $row;
    return array();
  }

  function insert($userid, $time, $type, $action) {
    $start = strtotime(date('Y/m/d', $time));
    $end = $start + 60 * 60 * 24 - 1;

    $sql = 'select * from `'. $this->prefix .'` where user_id = '. $userid . ' and (time between '. $start .' and '. $end .') and type = '. $type;
    die($sql);
    $query = $this->db->query($sql);
    $row = $query->fetch_assoc();
    if ($action) {
      if ($row) $sql = 'delete from `'. $this->prefix .'` where id = ' . $row['id'];
    }
    else if (!$row) $sql = 'insert into `'. $this->prefix .'` (user_id, type, time, reg_time) values('. $userid .', )';
    if ($sql) $this->db->query($sql);
  }
}
