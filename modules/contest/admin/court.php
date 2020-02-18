<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }

$xco = array(1 => 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AK', 'AM', 'AN', 'AO', 'AP', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY', 'AZ');
$yco = array(1 => 'SBD', 'Tên Chủ nuôi', 'Địa chỉ', 'Số điện thoại', 'Tên thú cưng', 'Giống loài', 'Phần thi');

if ($nv_Request->get_string('download', 'get')) {
  header('location: /assets/excel-output.xlsx?' . time());
}

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'active':
      $id = $nv_Request->get_int('type', 'post', 0);
      $type = $nv_Request->get_int('type', 'post', 0);

      $sql = 'update `'. PREFIX .'row` set active = ' . $type . ' where id = ' . $id;
      if ($db->query($sql)) {
          $result['status'] = 1;
      }
    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("court.tpl", PATH);

// Quản lý khóa học
$xtpl->assign('content', courtList());

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
