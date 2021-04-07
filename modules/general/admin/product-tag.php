<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }

if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'insert':
      $name = $nv_Request->get_string('name', 'post', '');

      if (!empty($name) && empty(checkProductTag($name))) {
        $sql = 'insert into `'. PREFIX .'tag` (name) values ("'. $name .'")';
        $db->query($sql);
      }
      $result['status'] = 1;
      $result['html'] = productTagContent();
    break;
    case 'edit':
      $id = $nv_Request->get_int('id', 'post', '');
      $name = $nv_Request->get_string('name', 'post', '');

      if (empty($name)) {
        $result['error'] = 'Tên tag không được để trống';
      }
      else if (!empty($tag = checkProductTag($name)) && $tag['id'] != $id) {
        $result['error'] = 'Trùng tên tag';
      }
      else {
        $sql = 'update `'. PREFIX .'tag` set name = "'. $name .'" where id = '. $id;
        $db->query($sql);
        $result['notify'] = 'Đã lưu';
      }
      $result['status'] = 1;
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("tag.tpl", PATH);
$xtpl->assign("link", '/admin/index.php?nv='. $module_name . '&op='. $op);
$xtpl->assign("modal", productTagModal());
$xtpl->assign("content", productTagContent());
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");