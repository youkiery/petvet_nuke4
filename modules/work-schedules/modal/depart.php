<?php
class Depart {
  private $prefix;
  function __construct() {
    global $db_config, $module_name;
    $this->prefix = $db_config["prefix"] . "_work_schedules_depart";
  }
  function insert($name) {
    global $db;
    if (!empty($name)) {
      $name = trim($name);
      $sql = "select * from `" . $this->prefix . "` where name like '$name'";
      $query = $db->query($sql);
      if ($row = $query->fetch()) {
        $sql = "insert into `" . $this->prefix . "` (name) values ('$name')";
        $query = $db->query($sql);
        if ($query) {
          return $db->lastInsertId();
        }
      }
    }
    return 0;
  }
  function remove($id) {
    global $db;
    if (!empty($id)) {
      $sql = "delete from `" . $this->prefix . "` where id = $id";
      $query = $db->query($sql);
      if ($row = $query->fetch()) {
        return 1;
      }
    }
    return 0;
  }
  function list() {
    global $modal_config, $nv_Request, $db;
    $page = $nv_Request->get_int("page", "get/post", 1);
    $limit = $nv_Request->get_int("limit", "get/post", 20);
    if ($limit < 5) {
      $limit = 20;
    }
    $sql = "select * from " . $this->prefix . " limit " . $limit . " offset " . (($page - 1) * $limit); 
    $query = $db->query($sql);
    $list = $modal_config->fetch($query);
    return $list;
  }
  function admin_list() {
    global $db, $global_config, $module_file, $module_name, $lang_module;
    // initial
    $xtpl = new XTemplate('depart-list.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
    $base_url = NV_BASE_ADMINURL . "index.php?language=vi&nv=" . $module_name . "&op=depart-employ";
    $xtpl->assign('lang', $lang_module);
    $index = 1;

    // display
    $sql = "select * from `" . WORK_PREFIX . "_depart`";
    $depart_query = $db->query($sql);
    $list = fetchall($depart_query);

    foreach ($list as $depart) {
        $xtpl->assign("index", $index);
        $xtpl->assign("name", $depart["name"]);
        $xtpl->assign("link", $base_url . "&id=" . $depart["id"]);
        $xtpl->parse('main');
        $index ++;
    }
    return $xtpl->text();
  }
}