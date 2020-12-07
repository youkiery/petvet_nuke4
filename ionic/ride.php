<?php
class Ride extends Module {
  function __construct() {
    parent::__construct();
    $this->module = 'ride';
    $this->prefix = 'pet_' . $this->table .'_'. $this->module;
    $this->role = $this->getRole();
    $this->func = array(
      0 => 'parseCollect',
      'parsePay'
    );
  }

  function getList($filter) {
    $time = $filter['time'];
    $from = $time - 60 * 60 * 24 * 15;
    $end = $time + 60 * 60 * 24 * 15;
    $sql = 'select * from `'. $this->prefix .'` where time between '. $from .' and '. $end .' order by time desc';
    $query = $this->db->query($sql);
    $list = array();

    while ($row = $query->fetch_assoc()) {
      $list = $this->func[$filter['type']]($row);
    }
    return $list;
  }

  function getDataById($id, $type) {
    $sql = 'select * from `'. $this->prefix .'_collect` where id = ' . $id;
    $query = $this->db->query($sql);
    $data = $query->fetch_assoc();
    return $this->func[$type]($data);
  }

  function parseCollect($data) {
    return array(
      'driverid' => $data['driverid'],
      'doctorid' => $data['doctorid'],
      'clock_from' => $data['clock_from'],
      'clock_to' => $data['clock_to'],
      'destination' => $data['destination'],
      'note' => $data['note'],
      'time' => $data['time'],
    );
  }

  function parsePay($data) {
    return array(
      'driverid' => $data['driverid'],
      'amount' => $data['amount'],
      'note' => $data['note'],
      'time' => $data['time'],
    );
  }
}
