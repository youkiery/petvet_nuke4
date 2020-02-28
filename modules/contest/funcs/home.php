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

      $court = array();
      $temp = array(
        'yes' => array(),
        'no' => array()
      );
      foreach ($data['court'] as $key => $value) {
        $query = $db->query("select * from `". PREFIX ."row` where mobile = '$data[mobile]' and court = $value");
        
        $courtData = checkCourt($value);
        $temp['list'][] = $courtData;
        if (empty($row = $query->fetch())) {
          $court[]= $value;
          $temp['no'][] = $courtData;
        }
      }

      foreach ($court as $value) {
        $sql = "insert into `". PREFIX ."row` (name, address, mobile, court) values('$data[name]', '$dat[address]', '$data[mobile]', $value)";
        $db->query($sql);
      }
      $result['status'] = 1;
      $result['data'] = $temp;
    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", PATH2);
$page_title = 'Đăng ký khóa học thú y';

// $sql = 'select * from `'. PREFIX .'court`';
// $query = $db->query($sql);
// while ($row = $query->fetch()) {
//   $xtpl->assign('id', $row['id']);
//   $xtpl->assign('court', $row['name'] . ' - Giá: ' . number_format($row['price'], 0, '', ',') . ($row['intro'] ? ' - ' : '') . $row['intro']);
//   $xtpl->parse('main.court');
// }

// $xtpl->assign('species', json_encode($species, JSON_UNESCAPED_UNICODE));
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . "/modules/$module_file/template/layout/header.php";
echo $contents;
include NV_ROOTDIR . "/module/$module_file/template/layout/footer.php";
