<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_ADMIN_MODULE')) { die('Stop!!!'); }

$id = $nv_Request->get_int('id', 'get', 0);
$sql = 'select * from `pet_setting_branch` where id = '. $id;
$query = $db->query($sql);
$branch = $query->fetch();

$module = array();
$sql = 'select * from `pet_setting_module`';
$query = $db->query($sql);

while ($row = $query->fetch()) {
  $module[$row['name']] = $row['intro'];
} 

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'user-suggest':
      $keyword = $nv_Request->get_string('keyword', 'post', '');

      $result['status'] = 1;
      $result['html'] = mainUserSuggest();
    break;
    case 'insert-branch':
      $name = $nv_Request->get_string('name', 'post', '');
      $prefix = $nv_Request->get_string('prefix', 'post', '');

      $sql = 'select * from `pet_setting_branch` where name = "'. $name .'" or prefix = "'. $prefix .'"';
      $query = $db->query($sql);

      $result['status'] = 1;
      if (!empty($query->fetch())) $result['msg'] = 'Trùng tên chi nhánh hoặc tiền tố';
      else {
        $sql = 'insert into `pet_setting_branch` (name, prefix) values ("'. $name .'", "'. $prefix .'")';
        if ($db->query($sql)) $result['html'] = mainBranchContent();
      }
    break;
    case 'update-branch':
      $data = $nv_Request->get_array('data', 'post', '');

      foreach ($data as $row) {
        $sql = 'update `pet_setting_branch` set name = "'. $row['name'] .'", prefix = "'. $row['prefix'] .'" where id = ' . $row['id'];
        $db->query($sql);
      }

      $result['status'] = 1;
    break;
    case 'remove-branch':
      $id = $nv_Request->get_int('rid', 'post', '');

      $sql = 'delete from `pet_setting_branch` where id = ' . $id;
      $result['status'] = 1;
      if (!$db->query($sql)) $result['html'] = mainBranchContent();
    break;
    case 'insert-user':
      $keyword = $nv_Request->get_string('keyword', 'post', '');
      $userid = $nv_Request->get_string('userid', 'post', '');

      $sql = 'select * from `pet_setting_user` where userid = '. $userid .' and branch = ' . $id;
      $query = $db->query($sql);

      if (empty($query->fetch())) {
        $sql = 'insert into `pet_setting_user` (userid, branch, manager, `except`) values ('. $userid .', '. $id .', 0, 0)';
        $db->query($sql);
      }
      
      $result['status'] = 1;
      $result['content'] = mainUserContent($id);
      $result['list'] = mainUserSuggest();
    break;
    case 'remove-user':
      $keyword = $nv_Request->get_string('keyword', 'post', '');
      $userid = $nv_Request->get_string('userid', 'post', 0);

      $sql = 'delete from `pet_setting_user` where userid = ' . $userid;
      $db->query($sql);
      $result['status'] = 1;
      $result['content'] = mainUserContent($id);
    break;
    case 'config-overtime':
      $data = $nv_Request->get_array('data', 'post');

      foreach ($data as $module => $row) {
        $sql = 'select * from `pet_setting_config_module` where branchid = ' . $id . ' and module = "'. $module .'"';
        $query = $db->query($sql);

        if (empty($query->fetch())) {
          $sql = 'insert into `pet_setting_config_module` (branchid, module, start, end) values ('. $id .', "'. $module .'", "'. $row['starthour'] . '-' . $row['startminute'] .'", "'. $row['endhour'] . '-' . $row['endminute'] .'")';
        }
        else {
          $sql = 'update `pet_setting_config_module` set start = "'. $row['starthour'] . '-' . $row['startminute'] .'", end = "'. $row['endhour'] . '-' . $row['endminute'] .'" where branchid = ' . $id . ' and module = "'. $module .'"';
        }

        $db->query($sql);
      }
      $result['status'] = 1;
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
