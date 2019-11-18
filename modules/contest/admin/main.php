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
    case 'insert-test':
      $id = $nv_Request->get_int('id', 'post', 0);
      $name = $nv_Request->get_string('name', 'post', '');

      if ($db->query("insert into `". PREFIX ."test` (name) values ('$name')")) {
        $result['status'] = 1;
        $result['html'] = testList();
        $result['notify'] = 'Đã thêm';
      }
    break;
    case 'update-test':
      $id = $nv_Request->get_int('id', 'post', 0);
      $name = $nv_Request->get_string('name', 'post', '');

      if ($db->query("update `". PREFIX ."test` set name = '$name' where id = $id")) {
        $result['status'] = 1;
        $result['notify'] = 'Đã cập nhật';
      }
    break;
    case 'update-test-all':
      $data = $nv_Request->get_array('data', 'post');
      $update = 0;
      $total = count($data);

      foreach ($data as $id => $name) {
        if ($db->query("update `". PREFIX ."test` set name = '$name' where id = $id")) {
          $update ++;
        }
      }
      $result['status'] = 1;
      $result['notify'] = "Đã cập nhật $update trên $total";
    break;
    case 'remove-contest':
      $id = $nv_Request->get_int('id', 'post', 0);

      if ($db->query("delete from `". PREFIX ."row` where id = $id")) {
        $result['status'] = 1;
        $result['html'] = contestList();
        $result['notify'] = 'Đã xóa';
      }
    break;
    case 'remove-all-contest':
      $list = $nv_Request->get_array('list', 'post');
      $delete = 0;
      $total = count($list);

      foreach ($list as $id) {
        if ($db->query("delete from `". PREFIX ."row` where id = $id")) $delete ++;
      }
      $result['status'] = 1;
      $result['html'] = contestList();
      $result['notify'] = "Đã xóa $delete trên tổng số $total";
    break;
    case 'toggle-test':
      $id = $nv_Request->get_string('id', 'post', 0);
      $type = $nv_Request->get_string('type', 'post', 0);

      if ($db->query("update `". PREFIX ."test` set active = $type where id = $id")) {
        $result['status'] = 1;
        $result['html'] = testList();
        $result['notify'] = 'Đã ẩn';
      }
    break;
    case 'confirm-contest':
      $id = $nv_Request->get_string('id', 'post', 0);
      $type = $nv_Request->get_string('type', 'post', 0);

      if ($db->query('update `'. PREFIX .'row` set active = ' . $type . ' where id = ' . $id)) {
        $result['status'] = 1;
        $result['html'] = contestList();
        if ($type) $result['notify'] = 'Đã duyệt';
        else $result['notify'] = 'Đã bỏ duyệt';
      }
      else $result['notify'] = 'Có lỗi xảy ra';
    break;
    case 'done-all-contest':
      $list = $nv_Request->get_array('list', 'post');
      $type = $nv_Request->get_string('type', 'post', 0);
      $update = 0;
      $total = count($list);

      foreach ($list as $id) {
        if ($db->query('update `'. PREFIX .'row` set active = ' . $type . ' where id = ' . $id)) $update ++;
      }
      
      $result['status'] = 1;
      $result['html'] = contestList();
      if ($type) $result['notify'] = "Đã duyệt $update trên tổng số $total";
      else $result['notify'] = "Đã bỏ duyệt $update trên tổng số $total";
    break;
    case 'filter':
      $result['status'] = 1;
      $result['html'] = contestList();
    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/modules/$module_file/template/admin/$op");

$query = $db->query('select * from `'. PREFIX .'species` order by rate desc');
$species = array();
while ($row = $query->fetch()) {
  $xtpl->assign('id', $row['id']);
  $xtpl->assign('species', ucwords($row['name']));
  $xtpl->parse('main.species');
}

$query = $db->query('select * from `'. PREFIX .'test`');
$species = array();
while ($row = $query->fetch()) {
  $xtpl->assign('id', $row['id']);
  $xtpl->assign('contest', $row['name']);
  $xtpl->parse('main.contest');
}

$xtpl->assign('modal_test', testModal());
$xtpl->assign('remove_contest_modal', removeModal());
$xtpl->assign('remove_all_contest_modal', removeAllModal());
$xtpl->assign('content', contestList());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
