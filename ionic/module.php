<?php 
class Module {
  public $db;
  public $table;
  public $module;
  public $userid;

  function __construct() {
    global $mysqli, $userid;
    $this->db = $mysqli;
    $this->userid = $userid;
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
    if ($read = $this->checkLastRead()) $sql = 'udate `pet_'. $this->table .'_notify_read` (userid, module, time) values ('. $this->userid .', "'. $this->module .'", '. $time .')';
    else $sql = 'insert into `pet_'. $this->table .'_notify_read` (userid, module, time) values ('. $this->userid .',  "'. $this->module .'", '. $time .')';
    $this->db->query($sql);
  }

  function checkLastRead() {
    $sql = 'select * from `pet_'. $this->table .'_notify_read` where userid = '. $this->userid;
    $query = $this->db->query($sql);
    if (!empty($query->num_rows)) {
      $read = $query->fetch_assoc();
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

    return intval($config['config_value']);
  }

  function getNotifyTime() {
    $sql = 'select * from `pet_'. $this->table .'_notify_read` where userid = ' . $this->userid;
    $query = $this->db->query($sql);

    if (empty($row = $query->fetch_assoc())) {
      $sql = 'insert into `pet_'. $this->table .'_notify_read` (userid, module, time) values ('. $this->userid .', "'. $this->module .'", 0)';
      $this->db->query($sql);
      $row = array(
        'time' => 0
      );
    }
    return $row['time'];
  }

  function getNotifyUnread() {
    $time = $this->getNotifyTime();

    $sql = 'select a.id from `pet_'. $this->table .'_notify` a inner join `pet_'. $this->table .'_'. $this->module .'` b on a.workid = b.id where a.module = "'. $this->module .'" and a.time > ' . $time . ' and (a.userid = '. $this->userid .' or b.userid = '. $this->userid .')';
    $query = $this->db->query($sql);

    return $query->num_rows;
  }
}
