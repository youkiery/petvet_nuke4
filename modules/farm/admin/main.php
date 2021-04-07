<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_ADMIN_MODULE')) { die('Stop!!!'); }

$filter = array(
  'page' => $nv_Request->get_int('page', 'get', 1),
  'limit' => $nv_Request->get_int('limit', 'get', 10),
  'keyword' => $nv_Request->get_string('keyword', 'get', ''),
  'status' => $nv_Request->get_int('status', 'get', 0)
);

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'get-info':
      $id = $nv_Request->get_int('id', 'post', 0);

      $sql = 'select * from `'. PREFIX .'_row` where id = ' . $id;
      $query = $db->query($sql);
      $happy = $query->fetch();
      $happy['image'] = explode(',', $happy['image']);

      $result['status'] = 1;
      $result['data'] = $happy;
    break;
    case 'edit':
      $id = $nv_Request->get_int('id', 'post', 0);
      $data = $nv_Request->get_array('data', 'post');

      $sql = 'update `'. PREFIX .'_row` set fullname = "'. $data['fullname'] .'", mobile = "'. $data['mobile'] .'", address = "'. $data['address'] .'", name = "'. $data['name'] .'", species = "'. $data['species'] .'", facebook = "'. $data['facebook'] .'", target = "'. $data['target'] .'", note = "'. $data['note'] .'" where id = ' . $id;
      // die($sql);
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = content();
      }
    break;  
    case 'done':
      $id = $nv_Request->get_int('id', 'post', 0);

      $sql = 'update `'. PREFIX .'_row` set status = 1 where id = ' . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = content();
      }
    break;  
    case 'preview':
      $id = $nv_Request->get_int('id', 'post', 0);

      $result['status'] = 1;
      $result['html'] = preview($id);
  break;  
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", PATH);


// Danh sách khóa học, xác nhận
$xtpl->assign('keyword', $filter['keyword']);
$xtpl->assign('active_' . $filter['status'], 'selected');

// $sql = 'select * from `'. PREFIX .'court` order by name';
// $query = $db->query($sql);
// while ($row = $query->fetch()) {
//   $xtpl->assign('selected', '');
//   if ($row['id'] == $filter['court']) $xtpl->assign('selected', 'selected');
//   $xtpl->assign('id', $row['id']);
//   $xtpl->assign('name', $row['name']);
//   $xtpl->parse('main.court');
// }

$xtpl->assign('modal', modal());
$xtpl->assign('content', content());

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
