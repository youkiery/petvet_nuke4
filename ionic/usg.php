<?php
class Usg extends Module {
  function __construct() {
    parent::__construct();
    $this->module = 'usg';
    $this->prefix = 'pet_' . $this->table .'_'. $this->module;
    $this->role = $this->getRole();
  }

  function getList($filter) {
    $list = array();
    $data = array();

    $time = time();
    $limit = $time + 60 * 60 * 24 * 14;

    $sql = 'select * from `'. $this->prefix .'` where calltime < '. $limit .' and status = '. $filter['status'] .' order by calltime limit 20';
    $query = $this->db->query($sql);

    // tên thú cưng, sđt, vaccine, ngày tái chủng, ghi chú, trạng thại
    while ($row = $query->fetch_assoc()) {
      if ($time > $row['calltime']) $row['color'] = 'red';
      else $row['color'] = 'green';
      $list []= $row;
    }

    usort($list, "cmp");

    // tên thú cưng, sđt, vaccine, ngày tái chủng, ghi chú, trạng thại
    foreach ($list as $row) {
      $pet = $this->getPetId($row['petid']);
      $customer = $this->getCustonerId($pet['customerid']);
      if (!empty($customer['phone'])) {
        $data []= array(
          'id' => $row['id'],
          'petname' => $pet['name'],
          'name' => $customer['name'],
          'number' => $customer['phone'],
          'time' => date('d/m/Y', $row['cometime']),
          'calltime' => date('d/m/Y', $row['calltime']),
          'note' => $row['note'],
          'color' => $row['color'],
        );
      }
    }
    return $data;
  }

  function getCustonerId($cid) {
    if (!empty($cid)) {
      $sql = 'select * from `pet_'. $this->table .'_customer` where id = ' . $cid;
      $query = $this->db->query($sql);
  
      if (!empty($row = $query->fetch_assoc())) return $row;
    }
    return array('phone' => '');
  }

  function getPetId($pid) {
    if (!empty($pid)) {
      $sql = 'select * from `pet_'. $this->table .'_pet` where id = ' . $pid;
      $query = $this->db->query($sql);
  
      if (!empty($row = $query->fetch_assoc())) return $row;
    }
    return array('customerid' => 0);
  }
}
