<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'done-check':
      $x = 1;
    break;
    case 'select-member':
      $id = $nv_Request->get_int('id', 'post', 0);

      $query = $db->query('select * from `'. PREFIX .'member` where userid = ' . $id);
      if ($query->fetch()) {
        // exist
        $result['notify'] = 'Người này đã có trong danh sách';
      }
      else {
        $query = $db->query('insert into `'. PREFIX .'member` (userid, author) values ('. $id .', "")');
        if ($query) {
          $result['status'] = 1;
          $result['html'] = memberList();
          $result['notify'] = 'Đã thêm';
        }
      }
    break;
    case 'remove-member':
      $id = $nv_Request->get_int('id', 'post', 0);

      $query = $db->query('delete from `'. PREFIX .'member` where id = '. $id);
      if ($query) {
        $result['status'] = 1;
        $result['html'] = memberList();
        $result['notify'] = 'Đã xóa';
      }
    break;
    case 'edit-member':
      $id = $nv_Request->get_int('id', 'post', 0);
      $data = $nv_Request->get_array('data', 'post');

      // die('update `'. PREFIX .'member` set author = \''. json_encode($data, JSON_UNESCAPED_UNICODE) .'\' where id = '. $id);
      $query = $db->query('update `'. PREFIX .'member` set author = \''. json_encode($data, JSON_UNESCAPED_UNICODE) .'\' where id = '. $id);
      if ($query) {
        $result['status'] = 1;
        $result['html'] = memberList();
        $result['notify'] = 'Đã cập nhật';
      }
    break;
    case 'get-member':
      $id = $nv_Request->get_int('id', 'post', 0);

      $query = $db->query('select * from `'. PREFIX .'member` where id = '. $id);
      if ($row = $query->fetch()) {
        $result['status'] = 1;
        $data = json_decode($row['author']);
        if (empty($data->{depart})) {
          $data->{depart} = array();
        }
        if (empty($data->{device})) {
          $data->{device} = 0;
        }
        if (empty($data->{material})) {
          $data->{material} = 0;
        }
        $result['data'] = $data;
      }
    break;
    case 'insert-depart':
      $name = $nv_Request->get_string('name', 'post', '');
      $name = ucwords($name);
       
      if (checkDepartName($name)) {
        $result['notify'] = 'Đơn vị đã tồn tại';
      }
      else {
        $query = $db->query('insert into `'. PREFIX .'depart` (name, update_time) values("'. $name .'", '. time() .')');
        if ($query) {
          $result['status'] = 1;
          $result['inserted'] = array('id' => $db->lastInsertId(), 'name' => $name);
          $result['notify'] = 'Đã thêm đơn vị';
        }
      }
    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", PATH);

$member = array();
$query = $db->query('select * from `'. $db_config['prefix'] .'_users`');
while ($row = $query->fetch()) {
  $member[]= array('id' => $row['userid'], 'name' => $row['first_name'], 'title' => simplize($row['last_name'] . ' ' . $row['first_name']));
}

$xtpl->assign('member', json_encode($member, JSON_UNESCAPED_UNICODE));
$xtpl->assign('content', memberList());
$xtpl->assign('edit_member_modal', editMemberModal());
$xtpl->assign('remove_member_modal', removeMemberModal());
$xtpl->assign('member_modal', memberModal());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
