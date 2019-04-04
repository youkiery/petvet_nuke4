<?php

/**
 * @Project WORK SCHEDULES 4.X
 * @Author PHAN TAN DUNG (phantandung92@gmail.com)
 * @Copyright (C) 2016 PHAN TAN DUNG. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Sat, 11 Jun 2016 23:45:51 GMT
 */

if (!defined('NV_MOD_WORK_SCHEDULES')) {
  die('Stop!!!');
}
$action = $nv_Request->get_string("action", "get/post", "");

if (!empty($action)) {
  $result = array("status" => 0, "notify" => $lang_module["error"]);
  switch ($action) {
    case 'remove':
    $id = $nv_Request->get_string("id", "get/post", "");

    if (!empty($id)) {
      $sql = "delete from `" . WORK_PREFIX . "_row` where id = $id";
      $query = $db->query($sql);
      if ($query) {
        $departid = $nv_Request->get_string("departid", "get/post", "");
        if ($departid > 0) {
          $result["list"] = user_manager_list();
        }
        else {
          $result["list"] = user_work_list();
        }
        $result["status"] = 1;
        $result["notify"] = $lang_module["saved"];
      }
    }

    break;

    case 'insert':
    $content = $nv_Request->get_string("content", "get/post", "");
    $starttime = $nv_Request->get_string("starttime", "get/post", "");
    $endtime = $nv_Request->get_string("endtime", "get/post", "");
    // $customer = $nv_Request->get_string("customer", "get/post", "");
    $userid = $nv_Request->get_string("userid", "get/post", "");
    $depart = $nv_Request->get_string("depart", "get/post", "");
    $process = $nv_Request->get_string("process", "get/post", "");
    $note = $nv_Request->get_string("note", "get/post", "");

    if (!(empty($content) || empty($starttime) || empty($endtime) || /*empty($customer) ||*/ empty($userid) || empty($depart))) {
      if (empty($process))  {
        $process = 0;
      }
      $starttime = totime($starttime);
      $endtime = totime($endtime);

      // $sql = "insert into `" . WORK_PREFIX . "_row` (cometime, calltime, last_time, post_user, edit_user, userid, depart, customer, content, process, confirm, review, note) values ($starttime, $endtime, " . time() . ", 0, 0, $userid, $depart, $customer, '$content', $process, 0, 0, '$note')";
      $sql = "insert into `" . WORK_PREFIX . "_row` (cometime, calltime, last_time, post_user, edit_user, userid, depart, customer, content, process, confirm, review, note) values ($starttime, $endtime, " . time() . ", 0, 0, $userid, $depart, 0, '$content', $process, 0, 0, '$note')";
      $query = $db->query($sql);
      if ($query) {
        $departid = $nv_Request->get_string("departid", "get/post", "");
        if ($departid > 0) {
          $result["list"] = user_manager_list();
        }
        else {
          $result["list"] = user_work_list();
        }
        $result["status"] = 1;
        $result["notify"] = $lang_module["g_saved"];
      }
    }
  break;
  // case 'search':
  //   $keyword = $nv_Request->get_string("keyword", "get/post", "");

    // $xtpl = new XTemplate('work-user-suggest.tpl', NV_ROOTDIR . '/themes/' . $global_config['admin_theme'] . '/modules/' . $module_file);

    // $sql = "select * from `" . $db_config["prefix"] . "_users_groups_users` where userid = $user_info[userid]";
    // $query = $db->query($sql);
    // $user = $query->fetch();

    // $where = "username like '%$keyword%' or last_name like '%$keyword%' or first_name like '%$keyword%'";
  
    // if (!empty($user) && ($user["is_leader"] || $user["group_id"] == 1)) {
    //   $user_sql = "select b.* from (select * from `" . WORK_PREFIX . "_employ` group by userid) a inner join `" . $db_config["prefix"] . "_users` b on a.userid = b.userid  order by last_name limit 10";
    // }
    // else {
    //   $user_sql = "select a.* from `" . $db_config["prefix"] . "_users` a inner join `" . WORK_PREFIX . "_employ` b on a.userid = b.userid where b.role = 1 and b.depart in ((select depart from `" . WORK_PREFIX . "_employ` where userid = $user_info[userid] and role = 2 and ($where)), $user_info[userid]) order by last_name limit 10";
    // }

    // $query = $db->query($user_sql);
    // $count = 0;
    // while($user = $query->fetch()) {
    //   $count ++;
    //   $xtpl->assign("name", $user["last_name"] . " " . $user["first_name"]);
    //   $xtpl->assign("id", $user["userid"]);
    //   $xtpl->parse("main");
    // }
    // if (!$count) {
    //   $xtpl->assign("name", "Không có nhân viên nào");
    //   $xtpl->parse("main");
    // }


  //   $result["status"] = 1;
  //   $result["notify"] = "";
  //   $result["list"] = $xtpl->text();
  // break;
  case 'edit':
    $id = $nv_Request->get_string("id", "get/post", "");
    $content = $nv_Request->get_string("content", "get/post", "");
    $starttime = $nv_Request->get_string("starttime", "get/post", "");
    $endtime = $nv_Request->get_string("endtime", "get/post", "");
    // $customer = $nv_Request->get_string("customer", "get/post", "");
    $userid = $nv_Request->get_string("userid", "get/post", "");
    $depart = $nv_Request->get_string("depart", "get/post", "");
    $process = $nv_Request->get_string("process", "get/post", "");
    $note = $nv_Request->get_string("note", "get/post", "");

    if (!(empty($id) || empty($content) || empty($starttime) || empty($endtime) /*|| empty($customer)*/ || empty($userid) || empty($depart))) {
      if (empty($process))  {
        $process = 0;
      }
      $starttime = totime($starttime);
      $endtime = totime($endtime);

      // $sql = "update `" . WORK_PREFIX . "_row` set cometime = $starttime, calltime = $endtime, last_time = " . time() . ", userid = $userid, customer = $customer, depart = $depart, content = '$content', process = $process, note = '$note' where id = $id";
      $sql = "update `" . WORK_PREFIX . "_row` set cometime = $starttime, calltime = $endtime, last_time = " . time() . ", userid = $userid, depart = $depart, content = '$content', process = $process, note = '$note' where id = $id";
      $query = $db->query($sql);
      if ($query) {
        $departid = $nv_Request->get_string("departid", "get/post", "");
        if ($departid > 0) {
          $result["list"] = user_manager_list();
        }
        else {
          $result["list"] = user_work_list();
        }
        $result["status"] = 1;
        $result["notify"] = $lang_module["g_saved"];
      }
    }
  break;

  case 'get_work':
    $id = $nv_Request->get_string("id", "get/post", "");
    if (!empty($id)) {
      $sql = "select a.*, b.username, b.first_name, b.last_name from `" . WORK_PREFIX . "_row` a inner join `" . $db_config["prefix"] . "_users` b on a.userid = b.userid inner join `" . WORK_PREFIX . "_depart` where a.id = $id";
      $query = $db->query($sql);
      $work = $query->fetch();
      if (!empty($work)) {
        // $sql = "select * from `" . WORK_PREFIX . "_customer`";
        // $query = $db->query($sql);
        // $customer_o = "";
        // while ($customer = $query->fetch()) {
        //   $select = "";
        //   if ($customer["id"] == $work["customer"]) {
        //     $select = "selected";
        //   }
        //   $customer_o .= "<option value='" . $customer["id"] . "' " . $select . ">" . $customer["name"] . "</option>";
        // }

        $sql = "select * from `" . WORK_PREFIX . "_depart`";
        $query = $db->query($sql);
        $depart_o = "";
        while ($depart = $query->fetch()) {
          $select = "";
          if ($depart["id"] == $work["depart"]) {
            $select = "selected";
          }
          $depart_o .= "<option value='" . $depart["id"] . "' " . $select . ">" . $depart["name"] . "</option>";
        }

        $result["status"] = 1;
        $result["content"] = $work["content"];
        $result["starttime"] = date("d/m/Y", $work["cometime"]);
        $result["endtime"] = date("d/m/Y", $work["calltime"]);
        // $result["customer"] = $customer_o;
        $result["depart"] = $depart_o;
        $result["user"] = $work["last_name"] . " " . $work["first_name"];
        $result["userid"] = $work["userid"];
        $result["username"] = $work["username"];
        $result["process"] = $work["process"];
        $result["note"] = $work["note"];
        $result["userid"] = $work["userid"];
      }
    }
  break;

  case 'change_confirm':
    $id = $nv_Request->get_string("id", "get/post", "");

    if (!empty($id)) {
      $sql = "select * from `" . WORK_PREFIX . "_row` where id = $id";
      $query = $db->query($sql);
      $work = $query->fetch();

      if (!empty($work)) {
        $result["status"] = 1;
        $confirm = "";
        foreach ($lang_module["confirm_option"] as $key => $value) {
          $select = "";
          if ($key == $work["confirm"]) {
            $select = "selected";
          }
          $confirm .= "<option value='$key' $select>$value</option>";
        }
        $review = "";
        foreach ($lang_module["review_option"] as $key => $value) {
          $select = "";
          if ($key == $work["review"]) {
            $select = "selected";
          }
          $review .= "<option value='$key' $select>$value</option>";
        }
        $result["confirm"] = $confirm;
        $result["review"] = $review;
        $result["note"] = $work["note"];
        $result["notify"] = "";
      }
    }
  break;

  case 'confirm':
    $id = $nv_Request->get_string("id", "get/post", "");
    $confirm = $nv_Request->get_int("confirm", "get/post", 0);
    $review = $nv_Request->get_int("review", "get/post", 0);
    $note = $nv_Request->get_int("note", "get/post", 0);

    if (!empty($id)) {
      $sql = "update `" . WORK_PREFIX . "_row` set confirm = $confirm, review = $review, note = '$note' where id = $id";
      $query = $db->query($sql);

      if ($query) {
        $result["status"] = 1;
        $result["notify"] = $lang_module["saved"];
        $result["list"] = user_manager_list();
      }
    }
  break;

  case 'change_data':
    $departid = $nv_Request->get_string("departid", "get/post", "");
    if (empty($departid)) {
      $list = user_work_list();
    }
    else {
      if ($departid == "end") {
        $list = work_manager_list();
      }
      else {
        $list = user_manager_list();
      }
    }
    $result["list"] = $list;
    $result["status"] = 1;
    $result["notify"] = "";
  break;

  case 'my_work':
    $list = user_work_list();
    $result["list"] = $list;
    $result["status"] = 1;
    $result["notify"] = "";
  break;

  case 'manager_work':
    $list = work_manager_list();
    $result["list"] = $list;
    $result["status"] = 1;
    $result["notify"] = "";
  break;

  case 'get_process':
    $id = $nv_Request->get_string("id", "get/post", "");
    if (!empty($id)) {
      $sql = "select * from `" . WORK_PREFIX . "_row` where id = $id";
      $query = $db->query($sql);
      $work = $query->fetch();
      if (!empty($work)) {
        $result["status"] = 1;
        $result["process"] = $work["process"];
        $result["note"] = $work["note"];
      }
    }
  break;

  case 'change_process':
    $id = $nv_Request->get_string("id", "get/post", "");
    $process = $nv_Request->get_string("process", "get/post", "");
    $note = $nv_Request->get_string("note", "get/post", "");

    if (!empty($id) && !empty($process)) {
      $sql = "select * from `" . WORK_PREFIX . "_row` where id = $id";
      $query = $db->query($sql);
      $work = $query->fetch();
      if (!empty($work) && $work["process"] <= $process) {
        $sql = "update `" . WORK_PREFIX . "_row` set process = $process, note = '$note' where id = $id";
        if ($db->query($sql)) {
          $result["status"] = 1;
          $result["list"] = user_work_list();
          $result["notify"] = $lang_module["saved"];
        }
      }
    }
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate('user.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
$xtpl->assign("lang", $lang_module);

// $sql = "select * from `" . WORK_PREFIX . "_customer`";
// $query = $db->query($sql);
// while ($customer = $query->fetch()) {
//   $xtpl->assign("customer_value", $customer["id"]);
//   $xtpl->assign("customer_name", $customer["name"]);
//   $xtpl->parse("main.customer_option");
//   $xtpl->parse("main.customer_option2");
// }

if (!empty($user_info)) {
  $sql = "select * from `" . $db_config["prefix"] . "_users_groups_users` where userid = $user_info[userid]";
  $query = $db->query($sql);
  $user = $query->fetch();

  if (!empty($user) && ($user["is_leader"] || $user["group_id"] == 1)) {
    $sql = "select * from `" . WORK_PREFIX . "_depart`";
  }
  else {
    $sql = "select b.* from `" . WORK_PREFIX . "_employ` a inner join `" . WORK_PREFIX . "_depart` b on a.depart = b.id where a.userid = $user_info[userid] order by a.userid";
  }

  $query = $db->query($sql);
  while ($depart = $query->fetch()) {
    $xtpl->assign("depart_value", $depart["id"]);
    $xtpl->assign("depart_name", $depart["name"]);
    $xtpl->parse("main.depart_option");
    $xtpl->parse("main.depart_option2");
  }
  $xtpl->parse("main.manager");
}

$sql = 'select * from `'.WORK_PREFIX.'_employ` where userid = '.$user_info['userid'];
$query = $db->query($sql);

$data = array();
$x = 0;
while ($row = $query->fetch()) {
  if (!$x) {
    $x = $row['depart'];
  }
  $data[$row['depart']] = employDepart($user_info['userid'], $row["depart"]) ;
}

$xtpl->assign("g_depart", $x);
$xtpl->assign("data", json_encode($data));
$xtpl->assign("cometime", date("d/m/Y", strtotime(date("Y-m-d")) - 60 * 60 * 24 * 7));
$xtpl->assign("calltime", date("d/m/Y", strtotime(date("Y-m-d")) + 60 * 60 * 24 * 7));
$xtpl->assign("depart_list", user_main_list());
$xtpl->assign("content", user_work_list());
$xtpl->assign("count", $result["count"]);
$xtpl->parse("main");
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
