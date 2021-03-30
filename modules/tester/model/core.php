<?php
class Core {
  public $db;
  function __construct() {
    global $db;
    $this->db = $db;
  }

  function fetchall($sql) {
    $list = [];
    $query = $this->db->query($sql);
    while($staff = $query->fetch()) {
      $list []= $staff;
    }
    return $list;
  }

  function fetch($sql) {
    $query = $this->db->query($sql);
    return $query->fetch();
  }
}
