<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_NEWS')) die('Stop!!!');

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'submit':
      $data = $nv_Request->get_array('data', 'post');
      $list = $nv_Request->get_array('list', 'post');

      $sql = "insert into `". UPREFIX ."_happy` (fullname, name, species, mobile, address, image) values('$data[fullname]', '$data[name]', '$data[species]', '$data[mobile]', '$data[address]', '". implode(',', $list) ."')";
      
      if ($db->query($sql)) {
        $result['status'] = 1;
      }
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH2);
$xtpl->assign('module_name', $module_name);
$page_title = 'Đăng ký tham gia ngày yêu thương';

// $sql = 'select * from `'. PREFIX .'court` where parent = 0';
// $query = $db->query($sql);
// while ($row = $query->fetch()) {
//   $xtpl->assign('id', $row['id']);
//   $xtpl->assign('court', $row['name'] . ' - Học phí: <span class="red">' . number_format($row['price'], 0, '', ',') . '</span>' . ($row['intro'] ? ' - ' : '') . $row['intro']);

//   $sql = 'select * from `'. PREFIX .'court` where parent = ' . $row['id'];
//   $query2 = $db->query($sql);
//   while ($row2 = $query2->fetch()) {
//     // var_dump($row);die();
//     $xtpl->assign('id2', $row2['id']);
//     $xtpl->assign('court2', $row2['name'] . ' - <span class="red">Học phí: ' . number_format($row2['price'], 0, '', ',') . '</span>' . ($row2['intro'] ? ' - ' : '') . $row2['intro']);
//     $xtpl->parse('main.court.child');
//   }
//   $xtpl->parse('main.court');
// }

// $xtpl->assign('species', json_encode($species, JSON_UNESCAPED_UNICODE));
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . "/modules/$module_file/template/layout/header.php";
echo $contents;
include NV_ROOTDIR . "/modules/$module_file/template/layout/footer.php";
