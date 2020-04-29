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
    case 'remove':
      $id = $nv_Request->get_int('id', 'post', 0);

      $sql = 'delete from `'. UPREFIX .'_happy` where id = ' . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = happyContent();
      }
    break;  
    case 'done':
      $id = $nv_Request->get_int('id', 'post', 0);
      $type = $nv_Request->get_int('type', 'post', 0);

      $sql = 'update `'. UPREFIX .'_happy` set status = '. $type .' where id = ' . $id;
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
  case 'employ-filter':
    $id = $nv_Request->get_int('id', 'post', '');
    $name = $nv_Request->get_string('name', 'post', '');
  
    $result['status'] = 1;
    $result['html'] = managerContentId($name);
    break;
  case 'insert-employ':
    $id = $nv_Request->get_int('id', 'post', '');
    $name = $nv_Request->get_string('name', 'post', '');
  
    $sql = 'select * from `'. $db_config['prefix'] .'_config` where config_name = "'. $module_name .'_level" and config_value = '. $id;
    $query = $db->query($sql);
    if (empty($row = $query->fetch())) {
      $sql = 'insert into `'. $db_config['prefix'] .'_config` (lang, module, config_name, config_value) values("sys", "'. time() .'", "'. $module_name .'_level", "'. $id .'")';
      $db->query($sql);
    }
    $result['status'] = 1;
    $result['html'] = managerContent();
    $result['html2'] = managerContentId($name);
  break;
  case 'remove-manager':
    $id = $nv_Request->get_int('id', 'post', '');
  
    $sql = 'delete from `'. $db_config['prefix'] .'_config` where config_name = "'. $module_name .'_level" and config_value = '. $id;
    $db->query($sql);
    $result['status'] = 1;
    $result['html'] = managerContent();
  break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", PATH2);
$xtpl->assign('module_name', $module_name);

// Danh sách khóa học, xác nhận
$xtpl->assign('keyword', $filter['keyword']);

$xtpl->assign('status', $filter['status']);
$xtpl->assign('status'. $filter['status'], 'active');
$xtpl->assign('modal', happyModal());
$xtpl->assign('content', happyContent());

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
