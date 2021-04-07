<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }
$page_title = "Quản lý phòng ban";
$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'edit-depart':
      $id = $nv_Request->get_int('id', 'post');
      $name = $nv_Request->get_string('name', 'post', '');
      $name = ucwords($name);
       
      if (checkDepartName($name, $id)) {
        $result['notify'] = 'Phòng ban đã tồn tại';
      }
      else {
        $query = $db->query('update `'. PREFIX .'depart` set name = "'. $name .'", update_time = '. time() .' where id = ' . $id);
        if ($query) {
          $result['status'] = 1;
          $result['notify'] = 'Đã cập nhật';
        }
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
          $result['html'] = departContentList();
          $result['notify'] = 'Đã thêm đơn vị';
        }
      }
    break;
    case 'remove-depart':
      $id = $nv_Request->get_int('id', 'post');

      if ($db->query('delete from `'. PREFIX .'depart` where id = ' . $id)) {
        $result['status'] = 1;
        $result['notify'] = 'Đã xóa phòng ban';
        $result['html'] = departContentList();
      }
    break;
    case 'remove-all-depart':
      $list = $nv_Request->get_array('list', 'post');
      $count = 0;
      $total = count($list);

      foreach ($list as $id) {
        if ($db->query('delete from `'. PREFIX .'depart` where id = ' . $id)) {
          $count ++;
        }
      }
      $result['status'] = 1;
      $result['notify'] = 'Đã xóa '. $count .' trên '. $total .' phòng ban';
      $result['html'] = departContentList();
    break;
    case 'filter':
      $result['status'] = 1;
      $result['html'] = deviceList();
    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", PATH);

// $xtpl->assign('device_modal', deviceModal());
$xtpl->assign('remove_modal', removeModal());
$xtpl->assign('remove_all_modal', removeAllModal());
$xtpl->assign('content', departContentList());
// $xtpl->assign('today', date('d/m/Y', time()));
// $xtpl->assign('depart', json_encode(getDepartList(), JSON_UNESCAPED_UNICODE));
// $xtpl->assign('remind', json_encode(getRemind(), JSON_UNESCAPED_UNICODE));
// $xtpl->assign('remindv2', json_encode(getRemindv2(), JSON_UNESCAPED_UNICODE));

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
