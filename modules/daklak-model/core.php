<?php
class Core {
  public $db;
  function __construct() {
    global $db;
    $this->db = $db;
  }

  function fetch($sql) {
    $query = $this->db->query($sql);
    return $query->fetch();
  }

  function fetchall($sql) {
    $list = [];
    $query = $this->db->query($sql);

    while ($row = $query->fetch()) $list []= $query->fetch();
    return $list;
  }
}
