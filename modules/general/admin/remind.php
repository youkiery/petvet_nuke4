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
      $filter = $nv_Request->get_array('filter', 'post');

      $result['status'] = 1;
      $result['html'] = remindList($filter);
    break;
    case 'insert-remind':
      $filter = $nv_Request->get_array('filter', 'post');
      $data = $nv_Request->get_array('data', 'post');

      $sql = 'select * from `'. PREFIX .'remind` where name = "'. $data['name'] .'" and value = "'. $data['value'] .'"';
      $query = $db->query($sql);

      if (empty($query->fetch())) {
        $sql = 'insert into `'. PREFIX .'remind` (name, value) values ("'. $data['name'] .'", "'. $data['value'] .'")';
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['notify'] = 'Đã thêm';
          $result['html'] = remindList($filter);
        }
      }
    break;
    case 'update-remind':
      $id = $nv_Request->get_int('id', 'post');
      $value = $nv_Request->get_string('value', 'post');

      $sql = 'update `'. PREFIX .'remind` set value = "'. $value .'" where id = ' . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['notify'] = 'Cập nhật giá trị';
      }
    break;
    case 'remove-remind':
      $id = $nv_Request->get_int('id', 'post');
      $filter = $nv_Request->get_array('filter', 'post');

      $sql = 'delete from `'. PREFIX .'remind` where id = ' . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['notify'] = 'Đã xóa gợi ý';
          $result['html'] = remindList($filter);
      }
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);
$xtpl->assign('module_file', $module_file);

foreach ($remind_title as $key => $value) {
  $xtpl->assign('id', $key);
  $xtpl->assign('name', $value);
  $xtpl->parse("main.filter");
}

$xtpl->assign('modal', remindModal());
$xtpl->assign('content', remindList());
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");