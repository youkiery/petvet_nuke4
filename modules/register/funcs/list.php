<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_NEWS')) { die('Stop!!!'); }

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

      $sql = 'select * from `'. UPREFIX .'_happy` where id = ' . $id;
      $query = $db->query($sql);
      $happy = $query->fetch();
      $happy['image'] = explode(',', $happy['image']);

      $result['status'] = 1;
      $result['data'] = $happy;
    break;
    case 'edit':
      $id = $nv_Request->get_int('id', 'post', 0);
      $data = $nv_Request->get_array('data', 'post');

      $sql = 'update `'. UPREFIX .'_happy` set fullname = "'. $data['fullname'] .'", mobile = "'. $data['mobile'] .'", address = "'. $data['address'] .'", name = "'. $data['name'] .'", species = "'. $data['species'] .'", note = "'. $data['note'] .'" where id = ' . $id;
      // die($sql);
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = happyContent();
      }
    break;  
    case 'done':
      $id = $nv_Request->get_int('id', 'post', 0);

      $sql = 'update `'. UPREFIX .'_happy` set status = 1 where id = ' . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = happyContent();
      }
    break;  
    case 'preview':
      $id = $nv_Request->get_int('id', 'post', 0);

      $result['status'] = 1;
      $result['html'] = happyPreview($id);
  break;  
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", PATH2);

// Danh sách khóa học, xác nhận
$xtpl->assign('keyword', $filter['keyword']);
$xtpl->assign('active_' . $filter['status'], 'selected');

$xtpl->assign('modal', happyModal());
$xtpl->assign('content', happyContent());

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . "/modules/$module_file/template/layout/header.php";
echo $contents;
include NV_ROOTDIR . "/modules/$module_file/template/layout/footer.php";
