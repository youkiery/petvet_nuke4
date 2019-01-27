<?php
class Depart {
  private $prefix;
  function __construct() {
    global $db_config, $module_name;
    $this->prefix = $db_config["prefix"] . "_work_schedules_config";
  }
  function list() {
    // init
    global $nv_Request, $db;
    $list = array();
    $page = $nv_Request->get_int("page", "get/post", 1);
    // list
    $sql = "select * from " . $this->prefix;
    $query = $db->query($sql);
    while ($row = $query->fetch()) {
      $list[$row["name"]] = $row["value"];
    }
    return $list;
  }
  function fetch($query) {
    $list = array();
    while ($row = $query->fetch($query)) {
      $list[] = $row;
    }
    return $list;
  }
}