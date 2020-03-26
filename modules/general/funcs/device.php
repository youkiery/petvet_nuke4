<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) die('Stop!!!');

$page_title = "Quản lý thiết bị";
$filter = array(
  'page' => $nv_Request->get_int('page', 'get', 1),
  'limit' => $nv_Request->get_int('limit', 'get', 20),
);

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'insert-depart':
      $name = $nv_Request->get_string('name', 'post', '');
      $name = ucwords($name);
       
      if (checkDepartName($name)) {
        $result['notify'] = 'Đơn vị đã tồn tại';
      }
      else {
        $query = $db->query('insert into `'. PREFIX .'depart` (name, update_time) values("'. $name .'", '. time() .')');
        if ($query) {
          $result['status'] = 1;
          $result['inserted'] = array('id' => $db->lastInsertId(), 'name' => $name);
          $result['notify'] = 'Đã thêm đơn vị';
        }
      }
    break;
    case 'insert-device':
      $data = $nv_Request->get_array('data', 'post');
        foreach ($data as $name => $value) {
          if (!($name == 'depart' || $name == 'description')) checkRemind($name, $value);
        }
        if (empty($data['depart'])) $data['depart'] = array();
        $sql = 'insert into `'. PREFIX .'device` (name, unit, number, year, intro, status, depart, source, description, import_time, update_time) values("'. $data['name'] .'", "'. $data['unit'] .'", "'. $data['number'] .'", "'. $data['year'] .'", "'. $data['intro'] .'", "'. $data['status'] .'", \''. json_encode($data['depart']) .'\', "'. $data['source'] .'", "'. $data['description'] .'", '. totime($data['import']) .', '. time() .')';
        // die($sql);
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = deviceList($filter);
          $result['notify'] = 'Đã thêm thiết bị';
        }
      // }
    break;
    case 'edit-device':
      $id = $nv_Request->get_int('id', 'post', 0);
      $data = $nv_Request->get_array('data', 'post');
      // if (checkDeviceName($data['name'], $id)) {
      //   $result['notify'] = 'Thiết bị đã tồn tại';
      // }
      // else {
        foreach ($data as $name => $value) {
          if (!($name == 'depart' || $name == 'description')) checkRemind($name, $value);
        }
        if (empty($data['depart'])) $data['depart'] = array();
        $sql = 'update `'. PREFIX .'device` set name = "'. $data['name'] .'", unit = "'. $data['unit'] .'", number = "'. $data['number'] .'", year = "'. $data['year'] .'", intro = "'. $data['intro'] .'", status = "'. $data['status'] .'", depart = \''. json_encode($data['depart']) .'\', source = "'. $data['source'] .'", description = "'. $data['description'] .'", import_time = "'. totime($data['import']) .'", update_time = '. time() .' where id = ' . $id;
        // die($sql);
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['html'] = deviceList($filter);
          $result['notify'] = 'Đã thêm thiết bị';
        }
      // }
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
    case 'remove-device':
      $id = $nv_Request->get_int('id', 'post');

      if ($db->query('delete from `'. PREFIX .'device` where id = ' . $id)) {
        $result['status'] = 1;
        $result['notify'] = 'Đã xóa';
        $result['html'] = deviceList($filter);
      }
    break;
    case 'remove-all-device':
      $list = $nv_Request->get_array('list', 'post');
      $count = count($list);
      $removed = 0;

      foreach ($list as $id) {
        if ($db->query('delete from `'. PREFIX .'device` where id = ' . $id)) {
          $removed ++;
        }
      }
      $result['status'] = 1;
      $result['notify'] = "Đã xóa $removed trong tổng số $count đã chọn";
      $result['html'] = deviceList($filter);
    break;
    case 'filter':
      $result['status'] = 1;
      $result['html'] = deviceList($filter);
    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", PATH);
$xtpl->assign('device_modal', deviceModal());
$xtpl->assign('content', deviceList($filter));
$xtpl->assign('today', date('d/m/Y', time()));
$xtpl->assign('depart', json_encode(getDepartList(), JSON_UNESCAPED_UNICODE));
$xtpl->assign('remind', json_encode(getRemind(), JSON_UNESCAPED_UNICODE));
$xtpl->assign('remindv2', json_encode(getRemindv2(), JSON_UNESCAPED_UNICODE));

$xtpl->parse('main');
$contents = $xtpl->text();
include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
