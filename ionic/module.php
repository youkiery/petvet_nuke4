<?php 
class Module {
  public $db;
  public $table;
  public $module;
  public $prefix;
  public $userid;
  public $role;

  function __construct() {
    global $mysqli, $userid;
    $this->db = $mysqli;
    $this->userid = $userid;
    $this->role = checkUserRole($this->userid);
    $this->table = $this->getUserBranch();
  }

  function getUserBranch() {
    try {
      $sql = 'select * from `pet_branch_user` where userid = ' . $this->userid;
      $query = $this->db->query($sql);
      $user = $query->fetch_assoc();

      if (!empty($user)) {
        $sql = 'select * from `pet_branch` where id = '. $user['branchid'];
        $query = $this->db->query($sql);
        $branch = $query->fetch_assoc();
        return $branch['prefix'];
      }
    }
    catch(Exception $e) { }
    return 'test';
  }

  function setLastRead($time) {
    $read = $this->checkLastRead();
    
    if ($read) $sql = 'update `pet_'. $this->table .'_notify_read` set time = '. $time .' where userid = '. $this->userid . ' and module = "'. $this->module .'"';
    else $sql = 'insert into `pet_'. $this->table .'_notify_read` (userid, module, time) values ('. $this->userid .',  "'. $this->module .'", '. $time .')';
    $this->db->query($sql);
  }

  function checkLastRead() {
    $sql = 'select * from `pet_'. $this->table .'_notify_read` where module = "'. $this->module .'" and userid = '. $this->userid;
    $query = $this->db->query($sql); 
    $read = $query->fetch_assoc();
    if (!empty($read)) {
      return $read['time'];
    }
    return 0;
  }
  
  function insertNotify($action, $targetid, $time) {
    $sql = 'insert into `pet_'. $this->table .'_notify` (userid, action, workid, module, time) values ('. $this->userid .', '. $action .', '. $targetid .', "'. $this->module .'", '. $time .')';
    $this->db->query($sql);
    $this->setLastUpdate($time);
  }

  function setLastUpdate($time) {
    $sql = 'update `pet_'. $this->table .'_notify_last` set time = "'. $time .'" where module = "'. $this->module .'"';
    $this->db->query($sql);
  }

  function checkLastUpdate($time) {
    $config = $this->getLastUpdate();

    if ($config > $time) return true;
    return false;
  }

  function getLastUpdate() {
    $sql = 'select * from `pet_'. $this->table .'_notify_last` where module = "'. $this->module .'"';
    $query = $this->db->query($sql);
    $config = $query->fetch_assoc();
    if (empty($config)) {
      $sql = 'insert into `pet_'. $this->table .'_notify_last` (module, time) values ("'. $this->module .'", 0)';
      $this->db->query($sql);
      $config = array('time' => 0);
    }

    return intval($config['time']);
  }

  function getNotifyTime() {
    $sql = 'select * from `pet_'. $this->table .'_notify_read` where userid = ' . $this->userid;
    $query = $this->db->query($sql);

    if (empty($row = $query->fetch_assoc())) {
      $sql = 'insert into `pet_'. $this->table .'_notify_read` (userid, module, time) values ('. $this->userid .', "'. $this->module .'", 1)';
      $this->db->query($sql);
      $row = array(
        'time' => 0
      );
    }
    return $row['time'];
  }

  function getNotifyUnread() {
    $time = $this->getNotifyTime();

    $xtra = '';
    if (!$this->role) $xtra = 'and userid = '. $this->userid;
    $sql = 'select id from `pet_'. $this->table .'_notify` where module = "'. $this->module .'" and time > ' . $time . ' ' . $xtra;
    $query = $this->db->query($sql);

    return $query->num_rows;
  }
}
