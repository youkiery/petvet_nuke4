<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) die('Stop!!!');

$page_title = "Quản lý thiết bị";

if (!empty($user_info)) {
  $sql = 'select * from `'. PREFIX .'device_manager` where userid = ' . $user_info['userid'];
  $query = $db->query($sql);
  $allow = $query->fetch();
}
$date = $nv_Request->get_int('date', 'post', time());
$config = checkDeviceConfig();
$period = $config * 60 * 60 * 24;
$start = floor($date / $period) * $period;
$start2 = floor(time() / $period) * $period;

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'change-date':
      $result['status'] = 1;
      $result['html'] = deviceManagerList();
    break;
    case 'insert-depart':
      $name = $nv_Request->get_string('name', 'post', '');
      $name = ucwords($name);
       
      if (checkDepartName($name)) {
        $result['notify'] = 'Đơn vị đã tồn tại';
      }
      else {
        $query = $db->query('insert into `'. PREFIX .'device_depart` (name, update_time) values("'. $name .'", '. time() .')');
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
          $result['html'] = deviceList();
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
          $result['html'] = deviceList();
          $result['notify'] = 'Đã thêm thiết bị';
        }
      // }
    break;
    case 'get-device':
      $id = $nv_Request->get_int('id', 'post');

      if ($device = getDeviceData($id)) {
        $sql = 'select * from `'. PREFIX .'device_detail` where itemid = ' . $id . ' and time >= '. $start2 .' order by id desc limit 1';
        $detail_query = $db->query($sql);
        $detail = $detail_query->fetch();
        $data = array(
          'note' => $detail['note'],
          'status' => $detail['status'],
          'msg' => ''
        );
        if (!empty($detail)) $data['msg'] = 'Gửi lúc ' . date('d/m/Y', $detail['time']);

        $device['import'] = date('d/m/Y', $device['import_time']);
        unset($device['import_time']);
        unset($device['update_time']);
        $result['status'] = 1;
        $result['device'] = $device;
        $result['data'] = $data;
      }
    break;
    case 'remove-device':
      $id = $nv_Request->get_int('id', 'post');

      if ($db->query('delete from `'. PREFIX .'device` where id = ' . $id)) {
        $result['status'] = 1;
        $result['notify'] = 'Đã xóa';
        $result['html'] = deviceList();
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
      $result['html'] = deviceList();
    break;
    case 'insert-detail':
      $id = $nv_Request->get_int('id', 'post', '');
      $status = $nv_Request->get_string('status', 'post', '');
      $note = $nv_Request->get_string('note', 'post', '');

      $sql = 'insert into `'. PREFIX .'device_detail` (itemid, status, note, time) values('. $id .', "'. $status .'", "'. $note .'", '. time() .')';
      $sql2 = 'update `'. PREFIX .'device` set status = "'. $status .'", description = "'. $note .'" where id = ' . $id;
      if ($db->query($sql) && $db->query($sql2)) {
        $result['status'] = 1;
        $result['notify'] = "Đã cập nhật";
        $result['html'] = deviceList();
      }
    break;
    case 'report-detail':
      $id = $nv_Request->get_int('id', 'post', '');

      $xtpl = new XTemplate("report-list.tpl", PATH);
      $sql = 'select * from `'. PREFIX .'device_detail` where itemid = ' . $id . ' and (time between '. $start .' and '. ($start + $period) .') order by time desc';
      $query = $db->query($sql);
      while($detail = $query->fetch()) {
        $xtpl->assign('time', date('d/m/Y', $detail['time']));
        $xtpl->assign('note', $detail['note']);
        $xtpl->assign('status', $detail['status']);
        $xtpl->parse('main');
      }
      
      $result['status'] = 1;
      $result['html'] = $xtpl->text();
    break;
    case 'report-content':
      $xtpl = new XTemplate("report-content.tpl", PATH);
      $sql = 'select * from `'. PREFIX .'device` order by name';
      $query = $db->query($sql);
      $end = $start + $period;
      $depart = getDeviceDepartList();

      while ($device = $query->fetch()) {
        $sql = 'select * from `'. PREFIX .'device_detail` where itemid = ' . $device['id'] . ' and (time between '. $start .' and '. $end .') order by time desc limit 1';
        $detail_query = $db->query($sql);
        $detail = $detail_query->fetch();
        $xtpl->assign('class', '');
        if (empty($detail)) $xtpl->assign('class', 'red');
        $xtpl->assign('name', $device['name']);
        $xtpl->assign('depart', checkDeviceDepart(json_decode($device['depart']), $depart));
        $xtpl->assign('note', $detail['note']);
        $xtpl->assign('status', $detail['status']);
        $xtpl->parse('main.row');
      }
      
      $xtpl->parse('main');
      $result['status'] = 1;
      $result['html'] = $xtpl->text();
    break;
    case 'get-manual':
      $id = $nv_Request->get_int('id', 'post', 0);

      $manual = getDeviceManual($id);

      $result['status'] = 1;
      $result['manual'] = $manual['manual'];
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);
$xtpl->assign('device_modal', deviceModal());
$xtpl->assign('config', $config);
$xtpl->assign('time', time());
$xtpl->assign('today', date('d/m/Y', time()));
$xtpl->assign('depart', json_encode(getDepartList(), JSON_UNESCAPED_UNICODE));
$xtpl->assign('remind', json_encode(getRemind(), JSON_UNESCAPED_UNICODE));
$xtpl->assign('remindv2', json_encode(getRemindv2(), JSON_UNESCAPED_UNICODE));

$xtpl->assign('content', deviceList());
if (!empty($allow)) {
  $manager = checkDeviceManagerId($user_info['userid']);
  $xtpl->assign('manager_content', deviceManagerList());
  $xtpl->parse('main.m1');
}

$xtpl->parse('main');
$contents = $xtpl->text();
include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
