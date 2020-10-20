<?php 
class Kaizen extends Module {
  function __construct() {
    parent::__construct();
    $this->module = 'kaizen';
  }

  function getKaizenList() {
    $xtra = '';
    if (!checkUserRole($this->userid)) $xtra = 'and userid = ' . $this->userid;
    $list = array();
    $sql = 'select * from `pet_'. $this->table .'_kaizen` where active = 1 ' . $xtra . ' order by id desc';
    $query = $this->db->query($sql);

    while ($row = $query->fetch_assoc()) {
      $data = array(
        'id' => $row['id'],
        'problem' => $row['problem'],
        'solution' => $row['solution'],
        'result' => $row['result'],
        'time' => date('d/m/Y', $row['edit_time'])
      );
      $list []= $data;
    }
    return $list;
  }

  function getKaizenNotify() {
    $sql = 'select * from `pet_'. $this->table .'_notify` where module = "kaizen" and userid = '. $this->userid . ' order by time desc';
    $query = $this->db->query($sql);
    $list = array();
    $action_trans = array(1 => 'Thêm giải phảp', 'Cập nhật giải pháp', '???', 'Xóa giải phảp');
    
    while ($row = $query->fetch_assoc()) {
      $user = checkUserId($row['userid']);
      $name = (!empty($user['last_name']) ? $user['last_name'] . ' ': '') . $user['first_name'];
      $kaizen = $this->getKaizenById($row['workid']);
      $list []= array(
        'id' => $row['workid'],
        'content' => $name . ' ' . $action_trans[$row['action']] . ' ' . $kaizen['result'],
        'time' => date('d/m/Y H:i', $row['time'])
      );
    }
    return $list;
  }
  
  function getKaizenById($id) {
    $sql = 'select * from `pet_'. $this->table .'_kaizen` where id = ' . $id;
    $query = $this->db->query($sql);
    return $query->fetch_assoc();
  }

  function insertData($data, $time) {
    $sql = 'update `pet_config` set = "'. $time .'" where config_name = "pet_lastkaizen"';
    $this->db->query($sql);

    $sql = 'insert into `pet_'. $this->table .'_kaizen` (userid, problem, solution, result, post_time, edit_time) values('. $this->userid .', "'. $data['problem'] .'", "'. $data['solution'] .'", "'. $data['result'] .'", '. time() .', '. time() .')';
    if ($this->db->query($sql)) {
      $this->insertNotify(INSERT_NOTIFY, $this->db->insert_id);
    }
  }

  function updateData($data) {
    $time = time();
    $sql = 'update `pet_'. $this->table .'_kaizen` set problem = "'. $data['problem'] .'", solution = "'. $data['solution'] .'", result = "'. $data['result'] .'", edit_time = '. $time .' where id = '. $data['id'];
    // die($sql);
    if ($this->db->query($sql)) {
      $this->insertNotify(EDIT_NOTIFY, $this->db->insert_id, $time);
    }
    return $time;
  }

  function removeData($data) {
    $time = time();
    $sql = 'update `pet_'. $this->table .'_kaizen` set active = 0 where id = '. $data['id'];
    if ($this->db->query($sql)) {
      $this->insertNotify(REMOVE_NOTIFY, $data['id'], $time);
    }
    return $time;
  }
}
