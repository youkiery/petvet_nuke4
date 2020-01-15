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
    case 'save':
        $data = $nv_Request->get_array('data', 'post');

        foreach ($data as $key => $value) {
            $sql = 'select * from `'. PREFIX .'config` where name = "config" and groupid = ' . $key;
            $query = $db->query($sql);
            $row = $query->fetch();

            if (empty($row)) {
                $sql = 'insert into `'. PREFIX .'config` (name, groupid, type) values ("config", "'. $key .'", "'. $value .'")';
            }
            else {
                $sql = 'update `'. PREFIX .'config` set type =  "' .$value .'" where name = "config" and groupid = '. $key;
            }
            // die($sql);
            $db->query($sql);
        }
        $result['status'] = 1;
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);
$xtpl->assign('module_file', $module_file);

$sql = 'select * from `'. $db_config['prefix'] .'_users_groups`';
$query = $db->query($sql);
$index = 1;

while ($group = $query->fetch()) {
    $xtpl->assign('index', $index);
    $xtpl->assign('group', $group['title']);
    $xtpl->assign('id', $group['group_id']);

    $sql = 'select * from `'. PREFIX .'config` where groupid = ' . $group['group_id'] . ' and name = "config"';
    $query2 = $db->query($sql);
    $config = $query2->fetch();

    $xtpl->assign('none_check', '');
    $xtpl->assign('view_check', '');
    $xtpl->assign('edit_check', '');
    if (!empty($config['type'])) {
        if ($config['type'] == 1) {
            $xtpl->assign('view_check', 'checked');
        }
        else if ($config['type'] == 2) {
            $xtpl->assign('edit_check', 'checked');
        }
    }
    else {
        $xtpl->assign('none_check', 'checked');
    }

    $xtpl->parse('main.row');
}

$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");