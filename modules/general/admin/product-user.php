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
    case 'get-user':
      $keyword = $nv_Request->get_string('keyword', 'post', '');

      $result['status'] = 1;
      $result['html'] = productUserSuggest($keyword);
    break;
    case 'insert':
      $id = $nv_Request->get_int('id', 'post', 0);

      $sql = 'select * from `'. PREFIX .'permit` where userid = ' . $id;
      $query = $db->query($sql);
      if (empty($query->fetch())) {
        $sql = 'insert into `'. PREFIX .'permit` (userid, type) values ('. $id .', 0)';
        $db->query($sql);
      } 

      $result['status'] = 1;
      $result['html'] = productUserContent();
      $result['html2'] = productUserSuggest($keyword);
    break;
    case 'change-permit':
      $id = $nv_Request->get_int('id', 'post', 0);
      $type = $nv_Request->get_int('type', 'post', 0);

      $sql = 'update `'. PREFIX .'permit` set type = '. $type .' where userid = '. $id;
      $db->query($sql);

      $result['status'] = 1;
      $result['html'] = productUserContent();
    break;
    case 'get-tag-permit':
      $id = $nv_Request->get_int('id', 'post', 0);

      $result['status'] = 1;
      $result['tag'] = getTagPermit($id);
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("user.tpl", PATH);
$xtpl->assign("link", '/admin/index.php?nv='. $module_name . '&op='. $op);
$xtpl->assign("content", productUserContent());
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");