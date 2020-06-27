<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }
$page_title = "Quản lý vật tư, hóa chất";

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'remove-link':
      $id = $nv_Request->get_int('id', 'post');

      $sql = 'delete from `'. PREFIX .'material_link` where id = ' . $id;

      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = materialLinkList();
        $result['notify'] = 'Xóa liên kết';
      }
    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", PATH);

$xtpl->assign('content', materialList());

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
