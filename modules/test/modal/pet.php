<?php
  class Pet {
    private $prefix;
    function __construct() {
      global $db_config, $module_name;
      $this->prefix = $db_config["prefix"] . "_" . $module_name . "_pet";
    }
    function get_by_id($id) {
      global $db;
      $sql = "select * from `" . $this->prefix . "` where id = " . $id;
      $query = $db->query($sql);
      $pet = $query->fetch();
      return $pet;
    }
    function get_by_customerid($customerid) {
      global $db;
      $sql = "select * from `" . $this->prefix . "` where customerid = " . $customerid;
      $query = $db->query($sql);
      $pet = $query->fetch();
      return $pet;
    }
  }
?>