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
    case 'filter':
      $result['status'] = 1;
      $result['html'] = memberuserList();
    break;
    case 'member-filter':
      $result['status'] = 1;
      $result['html'] = memberFilter();
    break;
    case 'insert-member':
      $id = $nv_Request->get_int('id', 'post');

      $db->query('insert into `'. PREFIX .'devicon` (userid, level, depart) values('. $id .', 0, \''. json_encode(array()) .'\')');
      $result['status'] = 1;
      $result['html'] = memberFilter();
      $result['html2'] = memberuserList();
    break;
    case 'get-member':
      $id = $nv_Request->get_int('id', 'post');

      $query = $db->query('select * from `'. PREFIX .'devicon` where id = ' . $id);
      $member = $query->fetch();

      $member['depart'] = json_decode($member['depart']);
      $result['status'] = 1;
      $result['member'] = $member;
    break;
    case 'edit-member':
      $id = $nv_Request->get_int('id', 'post');
      $data = $nv_Request->get_array('data', 'post');

      $sql = 'update `'. PREFIX .'devicon` set level = '. $data['level'] .', depart = \''. json_encode($data['depart']) .'\' where id = ' . $id;
      // die($sql);
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['notify'] = 'Đã cập nhật';
        $result['html'] = memberuserList();
      }
    break;
    case 'remove-member':
      $id = $nv_Request->get_int('id', 'post');

      $sql = 'delete from `'. PREFIX .'devicon` where id = ' . $id;
      // die($sql);
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['notify'] = 'Đã xóa';
        $result['html'] = memberuserList();
      }
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);

$xtpl->assign('remove_modal', loadModal('remove-modal'));
$xtpl->assign('member_modal', loadModal('member-modal'));
$xtpl->assign('member_edit_modal', memberEditModal());
$xtpl->assign('content', memberuserList());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
