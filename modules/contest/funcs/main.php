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

      $query = $db->query("select * from `". PREFIX ."row` where mobile = '$data[mobile]' and court = $data[court]");
      if ($row = $query->fetch()) {
        $result['notify'] = 'Bạn đã đăng ký khóa này rồi';
      }
      else {
        $sql = "insert into `". PREFIX ."row` (name, address, mobile, court) values('$data[name]', '$data[address]', '$data[mobile]', $data[court])";
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['notify'] = 'Đã đăng ký thành công khoá học';
        }
      }
    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/". $op);
$page_title = 'Đăng ký khóa học thú y';

$sql = 'select * from `'. PREFIX .'court`';
$query = $db->query($sql);
while ($row = $query->fetch()) {
  $xtpl->assign('id', $row['id']);
  $xtpl->assign('court', $row['name'] . ' - Giá: ' . number_format($row['price'], 0, '', ',') . ($row['intro'] ? ' - ' : '') . $row['intro']);
  $xtpl->parse('main.court');
}

$xtpl->assign('species', json_encode($species, JSON_UNESCAPED_UNICODE));
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . "/modules/$module_file/template/layout/header.php";
echo $contents;
include NV_ROOTDIR . "/module/$module_file/template/layout/footer.php";
