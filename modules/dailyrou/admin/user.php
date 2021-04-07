<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_ADMIN_DAILY')) { die('Stop!!!'); }

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

      $db->query('insert into `'. PREFIX .'_user` (userid) values('. $id .')');
      $result['status'] = 1;
      $result['html'] = memberFilter();
      $result['html2'] = memberuserList();
    break;
    case 'get-member':
      $id = $nv_Request->get_int('id', 'post');

      $query = $db->query('select * from `'. PREFIX .'_user` where userid = ' . $id);
      $member = $query->fetch();

      $result['status'] = 1;
      $result['member'] = $member;
    break;
    case 'remove-member':
      $id = $nv_Request->get_int('id', 'post');

      $sql = 'delete from `'. PREFIX .'_user` where userid = ' . $id;
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

$xtpl = new XTemplate("main.tpl", PATH2);

// var_dump(memberuserList());die();

$xtpl->assign('modal', userModal());
$xtpl->assign('content', memberuserList());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
