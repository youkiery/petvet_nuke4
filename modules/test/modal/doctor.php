<?php
  class Doctor {
    private $prefix;
    function __construct() {
      global $db_config, $module_name;
      $this->prefix = $db_config["prefix"] . "_" . $module_name . "_doctor";
    }
    function get_list() {
      global $db;
      $sql = "select * from `" . $this->prefix . "`";
      die($sql);
      $query = $db->query($sql);
      $list = array();
      while ($row = $query->fetch()) {
        $list[$row["id"]] = $row;
      }
      return $list;
    }
  }
?>