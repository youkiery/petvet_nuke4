<?php
class Blood extends Module {
  function __construct() {
    parent::__construct();
    $this->module = 'blood';
    $this->prefix = 'pet_' . $this->table .'_'. $this->module;
    $this->role = $this->getRole();
  }

  // filter = timespan by second
  function getList() {
    $data = array();

    $target = array();
    $sql = 'select * from `pet_' . $this->table . '_remind` where name = "blood" order by id';
    $query =$this->db->query($sql);
  
    while ($row = $query->fetch_assoc()) {
      $target[$row['id']] = $row['value'];
    }
  
    $sql = 'select * from ((select id, time, 0 as type from `' . $this->prefix . '_row`) union (select id, time, 1 as type from `' . $this->prefix . '_import`)) a order by time desc, id desc limit 10';
    $query =$this->db->query($sql);
    while ($row = $query->fetch_assoc()) {
      if ($row['type']) $sql = 'select * from `' . $this->prefix . '_import` where id = ' . $row['id'];
      else $sql = 'select * from `' . $this->prefix . '_row` where id = ' . $row['id'];
      $query2 =$this->db->query($sql);
      $row2 = $query2->fetch_assoc();
  
      $sql = 'select * from `pet_users` where userid = ' . $row2['doctor'];
      $user_query =$this->db->query($sql);
      $user = $user_query->fetch_assoc();
  
      $data []= array(
        'time' => date('d-m', $row2['time']),
        'id' => $row['id'],
        'typeid' => $row['type'],
        'doctor' => (!empty($user['first_name']) ? $user['first_name'] : ''),
        'type' => $row['type']
      );
      $len = count($data) - 1;

      if ($row['type']) {
        $data[$len]['target'] = 'Nhập ('. $row2['number1'] .'/'. $row2['number2'] .'/'. $row2['number3'] .') giá <span class="text-red">'. number_format($row2['price'], 0, '', ',') .' VND</span>';
        $data[$len]['number'] = '-';
        $data[$len]['number1'] = $row2['number1'];
        $data[$len]['number2'] = $row2['number2'];
        $data[$len]['number3'] = $row2['number3'];
      }
      else {
        $data[$len]['target'] = 'Xét nghiệm: '. (!empty($target[$row2['target']]) ? $target[$row2['target']] : '');
        $data[$len]['number'] = $row2['number'];
      } 
    } 
    return $data;
  }

  function getCatalogById($id) {
    $sql = 'select * from `pet_'. $this->table .'_catalog` where id = ' . $id;
    $query = $this->db->query($sql);
    return $query->fetch_assoc();
  }
}
