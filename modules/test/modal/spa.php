<?php
  class Spa {
    private $prefix;
    public $status;
    function __construct() {
      global $db_config, $module_name, $lang_module;
      $this->prefix = $db_config["prefix"] . "_" . $module_name;
    }
    function get_list() {
      global $db;
      $sql = "select * from `" . $this->prefix . "`";
      $query = $db->query($sql);
      $list = fetchall($query);
      return $list;
    }
    function fetchall($query) {
      global $db;
      $list = array();
      while ($row = $db->fetch()) {
        $list[] = $row;
      }
      return $list;
    }
  }
?>