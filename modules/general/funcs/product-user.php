<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) die('Stop!!!');

$id = $nv_Request->get_string('id', 'get', '');
$keyword = $nv_Request->get_string('keyword', 'get', '');
$action = $nv_Request->get_string('action', 'get', '');
if (!empty($action)) {
  switch ($action) {
    case 'insert':
      $uid = $nv_Request->get_int('uid', 'get', 0);

      $sql = 'select * from pet_daklak_permission where userid = '. $uid;
      $query = $db->query($sql);
      $user = $query->fetch();
      if (empty($user)) {
        $sql = 'insert into pet_daklak_permission (userid, floorid, status) values ('. $uid .', '. $id .', 0)';
        $db->query($sql);
      }
    break;
    case 'remove':
      $uid = $nv_Request->get_int('uid', 'get', 0);

      $sql = 'delete from pet_daklak_permission where userid = '. $uid;
      $db->query($sql);
    break;
    case 'manager':
      $uid = $nv_Request->get_int('uid', 'get', 0);
      $value = $nv_Request->get_int('value', 'get', 0);

      $sql = 'update pet_daklak_permission set status = '. $value .' where userid = '. $uid;
      $query = $db->query($sql);
    break;
  }
  header('location: /general/product-user/?id='. $id);
}

$xtpl = new XTemplate("product-user.tpl", PATH);
$xtpl->assign('id', $id);
$xtpl->assign('keyword', $keyword);

$sql = 'select * from pet_daklak_permission where floorid = '. $id;
$query = $db->query($sql);
$list = array();
$userid_list = array();
$index = 1;

while ($user = $query->fetch()) {
  $list[] = $user;
  $userid_list []= $user['userid'];
}

if (!empty($keyword)) {
  $sql = 'select userid, username, concat(last_name, " ", first_name) as fullname from pet_users where username like "%'. $keyword .'%" or last_name like "%'. $keyword .'%" or first_name like "%'. $keyword .'%"'. (empty($userid_list) ? '' : ' and userid not in ('. implode(', ', $userid_list) .')');
  $query = $db->query($sql);
  
  while ($user_data = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('uid', $user_data['userid']);
    $xtpl->assign('username', $user_data['username']);
    $xtpl->assign('fullname', $user_data['fullname']);
    $xtpl->parse('main.search.row');
  }

  $xtpl->parse('main.search');
}

foreach ($list as $user) {
  $sql = 'select username, concat(last_name, " ", first_name) as fullname from pet_users where userid = '. $user['userid'];
  $user_query = $db->query($sql);
  $user_data = $user_query->fetch();

  $xtpl->assign('index', $index++);
  $xtpl->assign('uid', $user['userid']);
  $xtpl->assign('username', $user_data['username']);
  $xtpl->assign('fullname', $user_data['fullname']);
  $xtpl->assign('manager', 'btn-info');
  $xtpl->assign('value', intval(!$user['status']));
  if ($user['status']) {
    $xtpl->assign('manager', 'btn-warning');
  }
  $xtpl->parse('main.row');
}

$xtpl->parse('main');
$contents = $xtpl->text();
include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';