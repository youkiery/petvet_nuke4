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

if ($manager) {}
else if (empty($user)) {
  $contents = 'Người dùng chưa được phân quyền';
  include NV_ROOTDIR . '/includes/header.php';
  echo nv_site_theme($contents);
  include NV_ROOTDIR . '/includes/footer.php';
}

$filter = array(
  'start' => $nv_Request->get_int('start', 'get', 0),
  'end' => $nv_Request->get_int('end', 'get', 0),
  'done' => $nv_Request->get_int('done', 'get', 0),
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
      $manager = $nv_Request->get_int('id', 'post', 0);

      $sql = 'select * from `'. PREFIX .'_employ` where userid = ' . $id;
      $query = $db->query($sql);
      $user = $query->fetch();

      if (empty($user)) {
        $sql = 'insert into `'. PREFIX .'_employ` (userid, depart, role) values ('. $id .', 0, 1)';
        if ($db->query($sql)) {
          if ($manager) $result['html'] = managerContent();
          $result['status'] = 1;
        }
      }
    break;
    case 'update-process':
      $data = $nv_Request->get_array("data", "post");

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
    case 'finish-work':
      $id = $nv_Request->get_int("id", "post", 0);

      $sql = "update `" . PREFIX . "_row` set process = 100, last_time = ". time() .", edit_user =  ". $user_info['userid'] ." where id = $id";
      if ($db->query($sql)) {
        $result["html"] = mainContent();
        $result["status"] = 1;
      }
    break;
    case 'set-permission':
      $userid = $nv_Request->get_int("userid", "post", 0);
      $role = $nv_Request->get_int("role", "post", 0);

      $sql = "update `" . PREFIX . "_employ` set role = $role where userid = $userid";
      if ($db->query($sql)) {
        $result["html"] = managerContent();
        $result["status"] = 1;
      }
    break;
    case 'remove-employ':
      $userid = $nv_Request->get_int("userid", "post", 0);

      $sql = "delete from `" . PREFIX . "_employ` where userid = $userid";
      if ($db->query($sql)) {
        $result["employ"] = json_encode($employ);
        $result["user"] = json_encode($userlist);
        $result["html"] = managerContent();
        $result["status"] = 1;
      }
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate('main.tpl', PATH);
$xtpl->assign("lang", $lang_module);

if (!empty($filter['start'])) $xtpl->assign('starttime', date('d/m/Y', $filter['start']));
if (!empty($filter['end'])) $xtpl->assign('endtime', date('d/m/Y', $filter['start']));
if (!empty($filter['done'])) $xtpl->assign('done', 'checked');

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
