<?php
  class Customer {
    private $prefix;
    function __construct() {
      global $db_config, $module_name;
      $this->prefix = $db_config["prefix"] . "_" . $module_name . "_customer";
    }
    function get_by_id($id) {
      global $db;
      $sql = "select * from `" . $this->prefix . "` where id = " . $id;
      $query = $db->query($sql);
      $customer = $query->fetch();
      return $customer;
    }
  }
?>