<?php
class Spa extends Module {
  function __construct() {
    parent::__construct();
    $this->module = 'spa';
    $this->prefix = 'pet_' . $this->table .'_'. $this->module;
    $this->role = $this->getRole();
  }

  // tắm, tỉa, cắt móng, vệ sinh tai, vắt tuyến hôi, nhuộm lông, cắt lông bàn chân, cắt lông rối, vệ sinh răng miệng, combo
  function getList($time) {
    $list = array();
    
    $time = strtotime(date('Y/m/d', $time));
    $end = $time + 60 * 60 * 24 - 1;
    $sql = 'select id, customerid, note, done from `'. $this->prefix .'` where time between '. $time .' and '. $end;
    // die($sql);
    $query = $this->db->query($sql);

    while ($row = $query->fetch_assoc()) {
      // echo $row['done'] . '<br>';
      $customer = $this->getCustonerId($row['customerid']);
      $row['name'] = $customer['name'];
      $row['phone'] = $customer['phone'];
      if ($row['done']) $row['time'] = date('H:i', $row['done']);
      else $row['time'] = 'Chưa xong';
      $list []= $row;
    } 

    return $list;
  }

  function getCustonerId($cid) {
    if (!empty($cid)) {
      $sql = 'select * from `pet_'. $this->table .'_customer` where id = ' . $cid;
      $query = $this->db->query($sql);
  
      if (!empty($row = $query->fetch_assoc())) return $row;
    }
    return array('phone' => '');
  }
}
