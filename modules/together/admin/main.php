<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_ADMIN_MODULE')) { die('Stop!!!'); }

$id = $nv_Request->get_int('id', 'get', 0);
$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'insert-root':
      $title = $nv_Request->get_string('title', 'post', '');

      $sql = 'insert into `'. PREFIX .'_row` (name, title, parentid) values ("", "'. $title .'", 0)';
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = content($id);
      }
    break;
    case 'insert-child':
      $title = $nv_Request->get_string('title', 'post', '');
      $name = $nv_Request->get_string('name', 'post', '');

      $sql = 'insert into `'. PREFIX .'_row` (name, title, parentid) values ("'. $name .'", "'. $title .'", '. $id .')';
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = content($id);
        $result['data'] = json_encode(getData($id));
      }
    break;
    case 'remove':
      $rid = $nv_Request->get_int('rid', 'post', '');

      $sql = 'delete from `'. PREFIX .'_row` where id = ' . $rid;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = content($id);
        $result['data'] = json_encode(getData($id));
      }
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);

if (empty($id)) $xtpl->assign('func', 'insertRoot()');
else {
  $xtpl->assign('func', 'insertChild('. $id .')');
  $xtpl->parse('main.child');
} 
$xtpl->assign('id', $id);
$xtpl->assign('data', json_encode(getData($id)));
$xtpl->assign('content', content($id));

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
