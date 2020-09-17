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
$user = checkUserPermit($user_info['userid']);
$employ = getWorkEmploy();
$depart = getWorkDepart();
$userlist = getUserList();
if (empty($user)) {
  $contents = 'Người dùng chưa được phân quyền';
  include NV_ROOTDIR . '/includes/header.php';
  echo nv_site_theme($contents);
  include NV_ROOTDIR . '/includes/footer.php';
}

$manager = 0;
if (!empty($user_info['admin_id'])) $manager = 1;
else {
  foreach ($user as $key => $role) {
    if ($role > 1) {
      $manager = 1;
      break;
    }
  }
}

$filter = array(
  'start' => $nv_Request->get_int('start', 'get', 0),
  'end' => $nv_Request->get_int('end', 'get', 0),
  'user' => $nv_Request->get_string('user', 'get'),
  'page' => $nv_Request->get_int('page', 'get', 1),
  'limit' => $nv_Request->get_int('limit', 'get', 10)
);
$filter['user'] = explode(',', $filter['user']);
$list = array();
foreach ($filter['user'] as $userid) {
  if ($userid) $list []= $userid;
}
$filter['user'] = $list;

$selected_list = array();
$useridlist = array();
foreach ($filter['user'] as $key => $value) {
  if ($value) {
    $user = getUserById($employ[$value]['id']);
    $useridlist []= $employ[$value]['id'];
    $selected_list []= $user['first_name'];
  }
  $selected_data[$value] = $value;
}

$filter['url'] = '/' . $module_name . '/';

if (!empty($action)) {
  $result = array("status" => 0);
  switch ($action) {
    case 'insert':
      $data = $nv_Request->get_array("data", "post", "");

      $sql = "insert into `" . PREFIX . "_row` (cometime, calltime, last_time, post_user, edit_user, userid, depart, customer, content, process, confirm, review, note) values ($data[starttime], $data[endtime], " . time() . ", ". $user_info['userid'] .", ". $user_info['userid'] .", $data[userid], 0, 0, '$data[work]', $data[process], 0, 0, '$data[note]')";
      if ($db->query($sql)) {
        $result["status"] = 1;
        $result["html"] = mainContent();
      }
      break;
    case 'insert-user':
      $id = $nv_Request->get_int('id', 'post', 0);

      $sql = 'select * from `'. PREFIX .'_employ` where userid = ' . $id;
      $query = $db->query($sql);
      $user = $query->fetch();

      if (empty($user)) {
        $sql = 'insert into `'. PREFIX .'_employ` (userid, depart, role) values ('. $id .', 0, 1)';
        if ($db->query($sql)) {
          $result['status'] = 1;
        }
      }
    break;
    case 'update-process':
      $data = $nv_Request->get_array("data", "post", "");

      $xtra = '';
      if ($data['calltime']) {
        $xtra = ', calltime = ' . $data['calltime'];
      }
      $sql = "update `" . PREFIX . "_row` set process = $data[process], note = '$data[note]', last_time = ". time() .", edit_user =  ". $user_info['userid'] ."$xtra where id = $data[id]";
      if ($db->query($sql)) {
        $result["html"] = mainContent();
        $result["status"] = 1;
      }
    break;
    case 'edit':
      $id = $nv_Request->get_string("id", "get/post", "");
      $content = $nv_Request->get_string("content", "get/post", "");
      $starttime = $nv_Request->get_string("starttime", "get/post", "");
      $endtime = $nv_Request->get_string("endtime", "get/post", "");
      $userid = $nv_Request->get_string("userid", "get/post", "");
      $depart = $nv_Request->get_string("depart", "get/post", "");
      $process = $nv_Request->get_string("process", "get/post", "");
      $note = $nv_Request->get_string("note", "get/post", "");

      if (!(empty($id) || empty($content) || empty($starttime) || empty($endtime) || empty($userid) || empty($depart))) {
        if (empty($process)) {
          $process = 0;
        }
        $starttime = totime($starttime);
        $endtime = totime($endtime);

        $sql = "update `" . WORK_PREFIX . "_row` set cometime = $starttime, calltime = $endtime, last_time = " . time() . ", userid = $userid, depart = $depart, content = '$content', process = $process, note = '$note' where id = $id";
        $query = $db->query($sql);
        if ($query) {
          $departid = $nv_Request->get_string("departid", "get/post", "");
          $result["list"] = callList($departid);
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
          $departid = $nv_Request->get_int("departid", "get/post", 0);
          $result["status"] = 1;
          $result["notify"] = $lang_module["saved"];
          $result["list"] = callList($departid);
        }
      }
      break;

    case 'change_data':
      $departid = $nv_Request->get_string("departid", "get/post", "");
      $list = callList($departid);
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
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate('main.tpl', PATH);
$xtpl->assign("lang", $lang_module);

//   $query = $db->query($sql);
//   while ($depart = $query->fetch()) {
//     $xtpl->assign("depart_value", $depart["id"]);
//     $xtpl->assign("depart_name", $depart["name"]);
//     $xtpl->parse("main.depart_option");
//     $xtpl->parse("main.depart_option2");
//   }
//   $xtpl->parse("main.manager");
// }

// $sql = 'select * from `'.WORK_PREFIX.'_employ` where userid = '.$user_info['userid'];
// $query = $db->query($sql);

// $data = array();
// $x = 0;
// $suggest = '';
// while ($row = $query->fetch()) {
//   $data[$row['depart']] = employDepart($user_info['userid'], $row["depart"]);
//   if (!$x) {
//     $x = $row['depart'];
//     foreach ($data[$x] as $employData) {
//       $suggest .= '<div class="user-suggest-item" onclick="set_user('. $employData['userid'] .', \''. $employData['name']. '\')"> '. $employData['name'] .' </div>';
//     }
//     // die(var_dump($suggest));
//   }
// }
// // die("$x");
// $list = user_work_list($user_info['userid'], 0);

// $xtpl->assign("g_depart", $x);
// $xtpl->assign("data", json_encode($data));
// $xtpl->assign("suggest", $suggest);
// $xtpl->assign("startDate", date("d/m/Y", time()));
// $xtpl->assign("endDate", date("d/m/Y", time() + 60 * 60 * 24));
// $xtpl->assign("cometime", date("d/m/Y", strtotime(date("Y-m-d")) - 60 * 60 * 24 * 15));
// $xtpl->assign("calltime", date("d/m/Y", strtotime(date("Y-m-d")) + 60 * 60 * 24 * 15));
// $xtpl->assign("depart_list", user_main_list());
// $xtpl->assign("content", $list['html']);
// $xtpl->assign("count", $list['count']);
// $xtpl->assign("nav", $list['nav']);
// $xtpl->assign("page", 1);
// $xtpl->assign("limit", 10);

$selected_data = array();
$list = array();
$xtpl->assign('selected', implode(', ', $selected_list));
$xtpl->assign('modal', mainModal());
$xtpl->assign('content', mainContent());
$xtpl->assign('role', json_encode($user));
$xtpl->assign('employ', json_encode($employ));
$xtpl->assign('user', json_encode($userlist));
$xtpl->assign('filter', json_encode($selected_data));
$xtpl->assign('depart', json_encode($depart));

if ($manager) $xtpl->parse('main.manager');

$xtpl->parse("main");
$contents = $xtpl->text();
include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
