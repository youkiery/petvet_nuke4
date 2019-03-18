<?php
  class Vaccine {
    private $prefix;
    public $status;
    function __construct() {
      global $db_config, $module_name, $lang_module;
      $this->prefix = $db_config["prefix"] . "_" . $module_name . "_vaccine";
    }
    function get_list() {
      global $db;
      $sql = "select * from `" . $this->prefix . "`";
      $query = $db->query($sql);
      $list = fetchall($query);
      return $list;
    }
    function get_list_by($filter) {
      global $db, $nv_Request;
      // page
      $page_type = $nv_Request->get_string('page', 'get/post', "");
      // keyword
      $keyword = $nv_Request->get_string('keyword', 'get/post', '');
      // id
      $id = $nv_Request->get_int('id', 'post/get', 0);

      // filter time
      $time = $vacconfigv2["filter"];
      if (empty($time)) {
        $time = 60 * 60 * 24 * 14;
      }
      $from = $now - $time;
      $end = $now + $time;
      // filter query
      if ($page == "list") {
        $type = "ctime";
      }
      else {
        $type = "calltime";
      }

      $where = "where (b.name like '%$keyword%' or c.name like '%$keyword%' or c.phone like '%$keyword%') and a.status in (" . $id . ") order by $type";

      $sql = "select a.id, a.note, a.recall, b.id as petid, b.name as petname, c.id as customerid, c.name as customer, c.phone as phone, cometime, calltime, status, diseaseid, dd.name as disease from " . VAC_PREFIX . "_vaccine a inner join " . VAC_PREFIX . "_pet b on $type between " . $from . " and " . $end . " and a.petid = b.id inner join " . VAC_PREFIX . "_customer c on b.customerid = c.id inner join " . VAC_PREFIX . "_disease dd on a.diseaseid = dd.id $where";
      $query = $db->query($sql);

      $list = fetchall($query);
      
      $sort = array();
      foreach ($list as $key => $value) {
        $sort[] = $value[$type];
      }
      return $list;
    }

    function user_theme($list) {
      global $module_info, $module_file, $lang_module;
      // initial
      $xtpl = new XTemplate("list-1.tpl", NV_ROOTDIR . "/themes/" . $module_info['template'] . "/modules/" . $module_file);
      $xtpl->assign("lang", $lang_module);
      $now = strtotime(date("Y-m-d"));
      $index = 1;
      $status_array = array();
      $status_array[0] = array();
      $status_array[1] = array();
      $status_array[2] = array();
      $status_array[4] = array();
      if ($page == "list") {
        $order = 1;
      }
      else {
        $order = 0;
      }
      
      // divide into 3 part
      foreach ($vaclist as $key => $row) {
        $status_array[$row["status"]][] = $key;
      }
      krsort($status_array);
    
      // sort by calltime
      $t_list = array();
      foreach ($status_array as $akey => $status_list) {
        $price = array();
        foreach ($status_list as $lkey => $status_row) {
          if ($order) {
            $price[$status_row] = $vaclist[$status_row]['calltime'];
          }
          else {
            $price[$status_row] = $vaclist[$status_row]['cometime'];
          }
        }
        if ($akey == "0") {
          $sort_order_left = array();
          $sort_order_right = array();
          foreach ($price as $lkey => $status_row) {
            if ($order) {
              if ($row["calltime"] < $now)
                $sort_order_right[] = $lkey;
              else
                $sort_order_left[] = $lkey;
            }
            else {
              if ($row["cometime"] < $now)
                $sort_order_right[] = $lkey;
              else
                $sort_order_left[] = $lkey;      
            }
          }
          asort($sort_order_left);
          arsort($sort_order_right);
          $sort = array();
          $sort = array_merge($sort_order_left, $sort_order_right);
          $t_list = array_merge($t_list, $sort);
        }
        else {
          arsort($price);
          foreach ($price as $key => $value) {
            $t_list[] = $key;
          }
        }
      }
    
      // display
      foreach ($t_list as $key => $value) {
        $xtpl->assign("index", $index);
        $xtpl->assign("petname", $vaclist[$value]["petname"]);
        $xtpl->assign("petid", $vaclist[$value]["petid"]);
        $xtpl->assign("vacid", $vaclist[$value]["id"]);
        $xtpl->assign("customer", $vaclist[$value]["customer"]);
        $xtpl->assign("phone", $vaclist[$value]["phone"]);
        $xtpl->assign("diseaseid", $vaclist[$value]["diseaseid"]);
        $xtpl->assign("disease", $vaclist[$value]["disease"]);
        $xtpl->assign("note", $vaclist[$value]["note"]);
        $xtpl->assign("confirm", $lang_module["confirm_" . $vaclist[$value]["status"]]);
    
        if ($vaclist[$value]["status"] > 1) {
          $xtpl->parse("disease.vac_body.recall_link");
        }
        switch ($vaclist[$value]["status"]) {
          case '1':
            $xtpl->assign("color", "orange");
            break;
          case '2':
            $xtpl->assign("color", "green");
            break;
          case '4':
            $xtpl->assign("color", "gray");
            break;
          default:
            $xtpl->assign("color", "red");
            break;
        }
        $xtpl->assign("cometime", date("d/m/Y", $vaclist[$value]["cometime"]));
        $xtpl->assign("calltime", date("d/m/Y", $vaclist[$value]["calltime"]));
        $index++;
        $xtpl->parse("disease.vac_body");
      }
      $xtpl->parse("disease");
      return $xtpl->text("disease");
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