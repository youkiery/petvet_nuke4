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
      $keyword = $nv_Request->get_string('keyword', 'post', '');

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
    case 'remove-user':
      $id = $nv_Request->get_int('id', 'post', 0);

      $sql = 'delete from `'. PREFIX .'permit` where userid = '. $id;
      $db->query($sql);

      $result['status'] = 1;
      $result['html'] = productUserContent();
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
    case 'get-tag':
      $keyword = $nv_Request->get_string('keyword', 'post', '');
      
      $xtpl = new XTemplate("user-tag-suggest.tpl", PATH);

      $sql = 'select * from `'. PREFIX .'tag` where name like "%'. $keyword .'%" order by name limit 10';
      $query = $db->query($sql);
      $check = true;
      while ($row = $query->fetch()) {
        $check = false;
        $xtpl->assign('id', $row['id']);
        $xtpl->assign('name', $row['name']);
        $xtpl->parse('main.row');
      }
      if ($check) $xtpl->parse('main.no');
      $xtpl->parse('main');

      $result['status'] = 1;
      $result['html'] = $xtpl->text();
    break;
    case 'save-tag-permit':
      $id = $nv_Request->get_int('id', 'post');
      $list = $nv_Request->get_array('list', 'post');

      $permit = array();
      $sql = 'select b.name from `'. PREFIX .'tag_permit` a inner join `'. PREFIX .'tag` b on a.tagid = b.id where a.userid = '. $id;
      $query = $db->query($sql);
      while ($row = $query->fetch()) $permit []= $row['name'];

      $compare = compareArray($permit, $list);
      // echo json_encode($compare);die();
      foreach ($compare[1] as $value) {
        $tagid = getTagId($value);
        $sql = 'delete from `'. PREFIX .'tag_permit` where tagid = '. $tagid;
        $db->query($sql);
      }
      foreach ($compare[2] as $value) {
        $tagid = getTagId($value);
        $sql = 'insert into `'. PREFIX .'tag_permit` (userid, tagid) values('. $id .', '. $tagid .')';
        $db->query($sql);
      }

      $result['status'] = 1;
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("user.tpl", PATH);
$xtpl->assign("link", '/admin/index.php?nv='. $module_name . '&op='. $op);
$xtpl->assign("modal", productUserModal());
$xtpl->assign("content", productUserContent());
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");