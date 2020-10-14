<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_ADMIN_MODULE')) { die('Stop!!!'); }

$id = $nv_Request->get_int('id', 'get', 0);
$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'insert-branch':
      $name = $nv_Request->get_string('name', 'post', '');

      $sql = 'select * from `pet_setting_branch` where name = "'. $name .'"';
      $query = $db->query($sql);

      $result['status'] = 1;
      if (!empty($query->fetch())) $result['msg'] = 'Chi nhánh đã tồn tại';
      else {
        $sql = 'insert into `pet_setting_branch` (name) values ("'. $name .'")';
        if ($db->query($sql)) $result['html'] = mainBranchContent();
      }
    break;
    case 'remove-branch':
      $id = $nv_Request->get_int('rid', 'post', '');

      $sql = 'delete from `pet_setting_branch` where id = ' . $id;
      $result['status'] = 1;
      if (!$db->query($sql)) $result['html'] = mainBranchContent();
    break;
    case 'insert-user':
      $userid = $nv_Request->get_string('userid', 'post', '');

      $sql = 'select * from `pet_setting_user` where userid = '. $userid;
      $query = $db->query($sql);

      $result['status'] = 1;
      if (!empty($query->fetch())) $sql = 'update `pet_setting_user` set branch = ' . $id . ' where userid = '. $userid;
      else $sql = 'insert into `pet_setting_user` (userid, branch, manager, except) values ('. $userid .', '. $id .', 0, 0)';
      
      if ($db->query($sql)) {
        $result['content'] = mainUserContent($id);
        $result['list'] = mainUserModal();
      }
    break;
    case 'remove-branch':
      $userid = $nv_Request->get_int('rid', 'post', '');

      $sql = 'delete from `pet_setting_user` where id = ' . $userid;
      $result['status'] = 1;
      if (!$db->query($sql)) $result['html'] = mainUserContent($id);
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);
$index = 1;

if (!empty($id)) {
  $xtpl->assign('user_content', mainUserContent($id));
  $xtpl->parse('main.user');
}
else {
  $xtpl->assign('branch_content', mainBranchContent());
  $xtpl->parse('main.branch');
}

$xtpl->assign('modal', modal());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
