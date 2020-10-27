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
      $data []= array('data' => array(), 'time' => date('d/m', $starttime + 60 * 60 * 24 * $i));
    }

    $sql = 'select id, user_id, type, time from `'. $this->prefix .'` where (time between '. $starttime .' and '. $endtime .')';
    $query = $this->db->query($sql);
    $row = array();
    $userList = getUserList();

    while ($row = $query->fetch_assoc()) {
      $day = date('N', $row['time']);
      $data[$reversal[$day]]['data'] []= $row;
    }

    // foreach ($list as $row) {
    //   $data []= $row;
    // }

    return $data;
  }
}
