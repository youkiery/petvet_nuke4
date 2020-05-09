<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }

$filter = array(
  'page' => $nv_Request->get_int('page', 'get', 1),
  'limit' => $nv_Request->get_int('page', 'get', 10)
);

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'insert-depart':
      $name = $nv_Request->get_string('name', 'post', '');

      if (!checkDepartName($name)) {
        $sql = 'insert into `'. PREFIX .'device_depart` (name) values("'. $name .'")';
        $db->query($sql);
        $result['status'] = 1;
        $result['json'] = getDepartList();
        $result['html'] = deviceList();
      }
    break;
    case 'insert-depart2':
      $name = $nv_Request->get_string('name', 'post', '');

      if (!checkDepartName($name)) {
        $sql = 'insert into `'. PREFIX .'device_depart` (name) values("'. $name .'")';
        $db->query($sql);
        $result['status'] = 1;
        $result['json'] = getDepartList();
        $result['html'] = departList();
      }
    break;
    case 'insert-employ':
      $id = $nv_Request->get_int('id', 'post', '');
      $name = $nv_Request->get_string('name', 'post', '');
      $departid = $nv_Request->get_int('departid', 'post', '');

      $sql = 'select * from `'. PREFIX .'device_employ` where userid = '. $id .' and departid = '. $departid;
      $query = $db->query($sql);
      if (empty($row = $query->fetch())) {
        $sql = 'insert into `'. PREFIX .'device_employ` (userid, departid) values('. $id .', '. $departid .')';
        $db->query($sql);
        $result['status'] = 1;
        $result['html'] = departContentId($departid);
        $result['html2'] = employContentId($departid, $name);
      }
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
    case 'remove-depart':
      $id = $nv_Request->get_int('id', 'post', '');

      $sql = 'delete from `'. PREFIX .'device_depart` where id = ' . $id;
      $db->query($sql);
      $result['status'] = 1;
      $result['json'] = getDepartList();
      $result['html'] = departList($id);
    break;
    case 'remove-employ':
      $id = $nv_Request->get_int('id', 'post', '');
      $departid = $nv_Request->get_int('departid', 'post', '');

      $sql = 'delete from `'. PREFIX .'device_employ` where departid = '. $departid .' and userid = ' . $id;
      $db->query($sql);
      $result['status'] = 1;
      $result['html'] = departContentId($departid);
    break;
    case 'edit-depart':
      $name = $nv_Request->get_string('name', 'post', '');
      $id = $nv_Request->get_int('id', 'post', '');

      $sql = 'update `'. PREFIX .'device_depart` set name = "'. $name .'" where id = ' . $id;
      $db->query($sql);
      $result['status'] = 1;
      $result['notify'] = 'Đã cập nhật';
      $result['json'] = getDepartList();
      $result['html'] = departList();
    break;
    case 'insert-device':
      $data = $nv_Request->get_array('data', 'post');
      foreach ($data as $name => $value) {
        if (!($name == 'depart' || $name == 'description')) checkRemind($name, $value);
      }
      if (empty($data['depart'])) $data['depart'] = array();
      $sql = 'insert into `'. PREFIX .'device` (name, unit, number, year, intro, status, depart, source, description, import_time, update_time) values("'. $data['name'] .'", "'. $data['unit'] .'", "'. $data['number'] .'", "'. $data['year'] .'", "'. $data['intro'] .'", "'. $data['status'] .'", \''. json_encode($data['depart']) .'\', "'. $data['source'] .'", "'. $data['description'] .'", '. totime($data['import']) .', '. time() .')';
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = deviceList();
        $result['notify'] = 'Đã thêm thiết bị';
      }
    break;
    case 'get-device':
      $id = $nv_Request->get_int('id', 'post');

      if ($data = getDeviceData($id)) {
        $data['import'] = date('d/m/Y', $data['import_time']);
        unset($data['import_time']);
        unset($data['update_time']);
        $result['status'] = 1;
        $result['device'] = $data;
      }
    break;
    case 'edit-device':
      $id = $nv_Request->get_int('id', 'post', 0);
      $data = $nv_Request->get_array('data', 'post');

      foreach ($data as $name => $value) {
        if (!($name == 'depart' || $name == 'description')) checkRemind($name, $value);
      }
      if (empty($data['depart'])) $data['depart'] = array();
      $sql = 'update `'. PREFIX .'device` set name = "'. $data['name'] .'", unit = "'. $data['unit'] .'", number = "'. $data['number'] .'", year = "'. $data['year'] .'", intro = "'. $data['intro'] .'", status = "'. $data['status'] .'", depart = \''. json_encode($data['depart']) .'\', source = "'. $data['source'] .'", description = "'. $data['description'] .'", import_time = "'. totime($data['import']) .'", update_time = '. time() .' where id = ' . $id;
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = deviceList();
        $result['notify'] = 'Đã thêm thiết bị';
      }
    break;
    case 'get-detail':
      $id = $nv_Request->get_int('id', 'post', 0);

      $result['status'] = 1;
      $result['html'] = departContentId($id);
    break;
    case 'get-employ':
      $id = $nv_Request->get_int('id', 'post', 0);
      $name = $nv_Request->get_string('name', 'post', '');

      $result['status'] = 1;
      $result['html'] = employContentId($id, $name);
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);

$xtpl->assign('modal', deviceModal());
$xtpl->assign('content', deviceList());

$xtpl->assign('today', date('d/m/Y', time()));
$xtpl->assign('depart', json_encode(getDepartList(), JSON_UNESCAPED_UNICODE));
$xtpl->assign('remind', json_encode(getRemind(), JSON_UNESCAPED_UNICODE));
$xtpl->assign('remindv2', json_encode(getRemindv2(), JSON_UNESCAPED_UNICODE));

$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");