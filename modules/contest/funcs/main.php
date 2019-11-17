<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) die('Stop!!!');

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'signup':
      $data = $nv_Request->get_array('data', 'post');

      $query = $db->query("select * from `". PREFIX ."row` where mobile = '$data[mobile]'");
      if ($row = $query->fetch()) {
        $result['notify'] = 'Số điện thoại đã đăng ký';
      }
      else {
        $test = implode(', ', $data['test']);
        $sql = "insert into `". PREFIX ."row` (name, address, mobile, test) values('$data[name]', '$data[address]', '$data[mobile]', '$test')";
        if (!$db->query($sql)) {
          $result['notify'] = 'Lỗi đăng ký';
        }
        else {
          $result['status'] = 1;
          $result['notify'] = 'Đã đăng ký thành công';
        }
      }

    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/". $op);
$query = $db->query("select * from `". PREFIX ."test`");
while ($row = $query->fetch()) {
  $xtpl->assign('id', $row['id']);
  $xtpl->assign('name', $row['name']);
  $xtpl->parse('main.test');
}

// $xtpl->assign('content', outdateList());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
