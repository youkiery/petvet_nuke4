<?php

/**
 * @Project WORK SCHEDULES 4.X
 * @Author PHAN TAN DUNG (phantandung92@gmail.com)
 * @Copyright (C) 2016 PHAN TAN DUNG. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Sat, 11 Jun 2016 23:45:51 GMT
 */
if (!defined('NV_IS_FILE_ADMIN')) {
  die('Stop!!!');
}

$action = $nv_Request->get_string("action", "get/post", "");
if (!empty($action)) {
  $result = array("status" => 0, "notify" => $lang_module["g_error"]);
  switch ($action) {
    case 'remove':
      $id = $nv_Request->get_string("id", "post/get", "");

      if (!empty($id)) {
        $sql = "delete from `" . WORK_PREFIX . "_row` where id = $id";
        if ($db->query($sql)) {
          $result["status"] = 1;
          $result["notify"] = $lang_module["saved"];
          $result["list"] = work_list();
        }
      }
    break;

    case 'save':
      $content = $nv_Request->get_string("content", "get/post", "");
      $starttime = $nv_Request->get_string("starttime", "get/post", "");
      $endtime = $nv_Request->get_string("endtime", "get/post", "");
      // $customer = $nv_Request->get_string("customer", "get/post", "");
      $userid = $nv_Request->get_string("userid", "get/post", "");
      $depart = $nv_Request->get_string("depart", "get/post", "");
      $process = $nv_Request->get_string("process", "get/post", "");
      $note = $nv_Request->get_string("note", "get/post", "");

      if (!(empty($content) || empty($starttime) || empty($endtime) /*|| empty($customer)*/ || empty($userid) || empty($depart))) {
        if (empty($process))  {
          $process = 0;
        }
        $starttime = totime($starttime);
        $endtime = totime($endtime);

        // $sql = "insert into `" . WORK_PREFIX . "_row` (cometime, calltime, last_time, post_user, edit_user, userid, depart, customer, content, process, confirm, review, note) values ($starttime, $endtime, " . time() . ", 0, 0, $userid, $depart, $customer, '$content', $process, 0, 0, '$note')";
        $sql = "insert into `" . WORK_PREFIX . "_row` (cometime, calltime, last_time, post_user, edit_user, userid, depart, customer, content, process, confirm, review, note) values ($starttime, $endtime, " . time() . ", 0, 0, $userid, $depart, 0, '$content', $process, 0, 0, '$note')";
        $query = $db->query($sql);
        if ($query) {
          $result["status"] = 1;
          $result["list"] = work_list();
          $result["notify"] = $lang_module["g_saved"];
        }
      }
    break;
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
          $result["status"] = 1;
          $result["list"] = work_list();
          $result["notify"] = $lang_module["g_saved"];
        }
      }
    break;
    case 'get_user':
      $user = $nv_Request->get_string("user", "get/post", "");

      $xtpl = new XTemplate('work-suggest.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
      $sql = "select * from `" . $db_config["prefix"] . "_users` where username like '%$user%'";
      $query = $db->query($sql);
      while($user = $query->fetch()) {
        $xtpl->assign("name", $user["last_name"] . " " . $user["first_name"]);
        $xtpl->assign("id", $user["userid"]);
        $xtpl->parse("main");
      }
      $result["status"] = 1;
      $result["list"] = $xtpl->text();
    break;
    case 'search':
      $keyword = $nv_Request->get_string("keyword", "get/post", "");

      $xtpl = new XTemplate('work-user-suggest.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
      $sql = "select * from `" . $db_config["prefix"] . "_users` where username like '%$keyword%' or last_name like '%$keyword%' or first_name like '%$keyword%' order by last_name limit 10";
      $query = $db->query($sql);
      $count = 0;
      while($user = $query->fetch()) {
        $count ++;
        $xtpl->assign("name", $user["last_name"] . " " . $user["first_name"]);
        $xtpl->assign("id", $user["userid"]);
        $xtpl->parse("main");
      }
      if (!$count) {
        $xtpl->assign("name", "Không có nhân viên nào");
        $xtpl->parse("main");
      }
      $result["status"] = 1;
      $result["notify"] = "";
      $result["list"] = $xtpl->text();
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
    case 'filter':
      $startTime = $nv_Request->get_string('startTime', 'get/post', '');
      $endTime = $nv_Request->get_string('endTime', 'get/post', '');

      $result['status'] = 1;
      $result['list'] = work_list();
      $result['notify'] = '';
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate('work.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
$today = strtotime(date("Y-m-d"));
$xtpl->assign("lang", $lang_module);
$xtpl->assign("today", $today * 1000);
$xtpl->assign("starttime", date("d/m/Y", $today));
$xtpl->assign("endtime", date("d/m/Y", $today + 60 * 60 * 24));

foreach ($time_option as $key => $value) {
  $xtpl->assign("time_value", $key);
  $xtpl->assign("time_name", $value["name"]);
  $xtpl->parse("main.time_option");
}

foreach ($sort_option as $key => $row) {
  $xtpl->assign("sort_value", $key);
  $xtpl->assign("sort_name", $row["name"]);
  $xtpl->parse("main.sort_option");
}

// $sql = "select * from `" . WORK_PREFIX . "_customer`";
// $query = $db->query($sql);
// while ($customer = $query->fetch()) {
//   $xtpl->assign("customer_value", $customer["id"]);
//   $xtpl->assign("customer_name", $customer["name"]);
//   $xtpl->parse("main.customer_option");
//   $xtpl->parse("main.customer_option2");
// }

$sql = "select * from `" . WORK_PREFIX . "_depart`";
$query = $db->query($sql);
while ($depart = $query->fetch()) {
  $xtpl->assign("depart_value", $depart["id"]);
  $xtpl->assign("depart_name", $depart["name"]);
  $xtpl->parse("main.depart_option");
  $xtpl->parse("main.depart_option2");
}

$sql = "select * from `" . $db_config["prefix"] . "_users`";
$query = $db->query($sql);
while ($user = $query->fetch()) {
  $xtpl->assign("user_value", $user["userid"]);
  $xtpl->assign("user_name", $user["last_name"] . " " . $user["first_name"]);
  $xtpl->parse("main.user_option");
  $xtpl->parse("main.user_option2");
}

$list = work_list();
$xtpl->assign('content', $list['html']);
$xtpl->assign('count', $list['count']);
$xtpl->assign('nav', navList($list['count'], 1, 10));
$xtpl->assign("page", 1);
$xtpl->assign("limit", 10);
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
