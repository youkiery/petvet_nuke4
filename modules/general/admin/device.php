<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'insert-depart':
      $name = $nv_Request->get_string('name', 'post', '');

      if (checkDepartName($name)) {
        $sql = 'insert into `'. PREFIX .'device_depart` (name) values("'. $name .'")';
        $db->query($sql);
        $result['status'] = 1;
        $result['html'] = departList();
      }
    break;
    case 'insert-employ':
      $id = $nv_Request->get_int('id', 'post', '');
      $name = $nv_Request->get_string('name', 'post', '');
      $departid = $nv_Request->get_int('departid', 'post', '');

      $sql = 'select * from `'. PREFIX .'device_employ` where userid = '. $id .', departid = '. $departid;
      $query = $db->query($sql);
      if (!empty($row = $query->fetch())) {
        $sql = 'insert into `'. PREFIX .'device_employ` (userid, departid) values('. $id .', '. $departid .')';
        $db->query($sql);
      }
      $result['status'] = 1;
      $result['html'] = departContentId($departid);
      $result['html2'] = employContentId($departid, $name);
    break;
    case 'get-depart':
      $id = $nv_Request->get_int('id', 'post', '');

      $sql = 'select * from `'. PREFIX .'device_depart` where id = ' . $id;
      $query = $db->query($sql);
      $depart = $query->fetch();

      $result['status'] = 1;
      $result['name'] = $depart['name'];
      $result['html'] = departContentId($id);
    break;
    case 'employ-filter':
      $id = $nv_Request->get_int('id', 'post', '');
      $name = $nv_Request->get_string('name', 'post', '');

      $result['status'] = 1;
      $result['html'] = employContentId($id, $name);
    break;
    case 'remove-employ':
      $id = $nv_Request->get_int('id', 'post', '');
      $departid = $nv_Request->get_int('departid', 'post', '');

      $sql = 'delete from `'. PREFIX .'device_employ` where id = ' . $id;
      $db->query($sql);
      $result['status'] = 1;
      $result['html'] = departContentId($departid);
    break;
    case 'update-depart':
      $name = $nv_Request->get_string('name', 'post', '');
      $departid = $nv_Request->get_int('departid', 'post', '');

      $sql = 'update `'. PREFIX .'device_depart` set name = "'. $name .'" where id = ' . $departid;
      $db->query($sql);
      $result['status'] = 1;
      $result['html'] = departList();
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);

$xtpl->assign('modal', departModal());
$xtpl->assign('content', departList());
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");