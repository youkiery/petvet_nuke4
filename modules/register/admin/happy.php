<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }

$filter = array(
  'page' => $nv_Request->get_int('page', 'get', 1),
  'limit' => $nv_Request->get_int('limit', 'get', 10),
  'keyword' => $nv_Request->get_string('keyword', 'get', ''),
  'court' => $nv_Request->get_int('court', 'get', 0),
  'active' => $nv_Request->get_int('active', 'get', 0)
);

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'get-info':
    break;  
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", PATH2);


// Danh sách khóa học, xác nhận
$xtpl->assign('keyword', $filter['keyword']);
$xtpl->assign('active_' . $filter['active'], 'selected');

// $sql = 'select * from `'. PREFIX .'court` order by name';
// $query = $db->query($sql);
// while ($row = $query->fetch()) {
//   $xtpl->assign('selected', '');
//   if ($row['id'] == $filter['court']) $xtpl->assign('selected', 'selected');
//   $xtpl->assign('id', $row['id']);
//   $xtpl->assign('name', $row['name']);
//   $xtpl->parse('main.court');
// }

// $xtpl->assign('modal', modal());
$xtpl->assign('content', happyContent($filter));

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
