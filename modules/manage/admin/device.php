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
    case 'insert-item':
      $data = $nv_Request->get_array('data', 'post');

      if (!strlen($data['name'])) {
        $result['notify'] = 'Tên thiết bị trống';
      }
      else if (checkItemName($data['name'])) {
        $result['notify'] = 'Trùng tên thiết bị';
      }
      else {
        // insert
        $sql = 'insert into `'. PREFIX .'item` (name, unit, company, description) values("'. $data['name'] .'", "'. $data['unit'] .'", "'. checkCompany($data['company']) .'", "'. $data['description'] .'")';
        if ($query = $db->query($sql)) {
          $id = $db->lastInsertId();
          $sql = 'insert into `'. PREFIX .'item_detail` (item_id, number, status) values ('. $id .', '. $data['number'] .', "'. $data['status'] .'")';
          if ($db->query($sql)) {
            $result['status'] = 1;
            $result['notify'] = 'Đã thêm';
            $result['id'] = $db->lastInsertId();
          }
        }
      }
    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/device");

$xtpl2 = new XTemplate("item-modal.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/device");
$xtpl2->parse('main');
$xtpl->assign('item_modal', $xtpl2->text());
$xtpl->assign('content', itemList());

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
