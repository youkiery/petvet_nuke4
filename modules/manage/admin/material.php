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
    case 'get-employ':
      $id = $nv_Request->get_int('id', 'post', 0);
      $name = $nv_Request->get_string('name', 'post', '');

      $result['status'] = 1;
      $result['html'] = materialPermitSuggest($name);
    break;
    case 'insert-employ':
      $id = $nv_Request->get_int('id', 'post', '');
      $name = $nv_Request->get_string('name', 'post', '');

      $sql = 'select * from `'. PREFIX .'permit` where userid = '. $id;
      $query = $db->query($sql);
      if (empty($row = $query->fetch())) {
        $sql = 'insert into `'. PREFIX .'permit` (userid, type) values('. $id .', 0)';
        $db->query($sql);
        $result['status'] = 1;
        $result['html'] = materialPermitList();
        $result['html2'] = materialPermitSuggest($name);
      }
    break;
    case 'remove-employ':
      $id = $nv_Request->get_int('id', 'post', '');

      $sql = 'delete from `'. PREFIX .'permit` where userid = ' . $id;
      $db->query($sql);
      $result['status'] = 1;
      $result['html'] = materialPermitList();
    break;
    case 'change-permit':
      $id = $nv_Request->get_int('id', 'post', 0);
      $type = $nv_Request->get_int('type', 'post', 0);

      $sql = 'update `'. PREFIX .'permit` set type = '. $type .' where userid = ' . $id;
      $db->query($sql);
      $result['status'] = 1;
      $result['html'] = materialPermitList();
    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", PATH);

$xtpl->assign('content', materialPermitList());

$xtpl->parse('main');
$contents = $xtpl->text();
include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
