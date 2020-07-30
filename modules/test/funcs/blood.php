<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_QUANLY')) die('Stop!!!');
checkUserPermit(OVERCLOCK);

$type = 0;
$sql = 'select * from `' . VAC_PREFIX . '_user` where userid = ' . $user_info['userid'];
$query = $db->query($sql);
$user = $query->fetch();
if (!empty($user)) {
  if ($user['manager']) $type = 2;
  else $type = 1;
}
$link = '/' . $module_name . '/' . $op;
$sample_number = checkLastBlood();
$sample_total = checkBloodSample();

$filter = array(
  'type' => $nv_Request->get_int('type', 'get', 0),
  'page' => $nv_Request->get_int('page', 'get', 1),
  'limit' => $nv_Request->get_int('limit', 'get', 10)
);

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'insert-blood':
      $data = $nv_Request->get_array('data', 'post');
      $data['time'] = totime($data['time']);

      $targetid = checkBloodRemind($data['name']);
      $end = $sample_number - $data['number'];

      $sql = 'insert into `' . VAC_PREFIX . '_blood_row` (time, number, start, end, doctor, target) values(' . $data['time'] . ', ' . $data['number'] . ', ' . $sample_number . ', ' . $end . ', ' . $data['doctor'] . ', ' . $targetid . ')';
      // die($sql);
      if ($db->query($sql)) {
        $query = $db->query('update `' . $db_config['prefix'] . '_config` set config_value = ' . $end . ' where config_name = "' . $module_name . '_blood_number"');

        $result['status'] = 1;
        $result['html'] = bloodList();
        $result['number'] = checkLastBlood();
        $result['total'] = checkBloodSample();
      }
      break;
    case 'insert-import':
      $data = $nv_Request->get_array('data', 'post');
      $data['time'] = totime($data['time']);
      $data['number1'] = parseNumber($data['number1']);
      $data['number2'] = parseNumber($data['number2']);
      $data['number3'] = parseNumber($data['number3']);

      $data['price'] = str_replace(',', '', $data['price']);
      $sql = 'insert into `' . VAC_PREFIX . '_blood_import` (time, number1, number2, number3, price, note, doctor) values(' . $data['time'] . ', ' . $data['number1'] . ', ' . $data['number2'] . ', ' . $data['number3'] . ', ' . $data['price'] . ', "' . $data['note'] . '", ' . ($user_info['userid'] ? $user_info['userid'] : 0) . ')';
      $query = $db->query($sql);
      if ($query) {
        updateBloodSample(array(
          'number1' => $data['number1'],
          'number2' => $data['number2'],
          'number3' => $data['number3']
        ));
        $result['status'] = 1;
        $result['notify'] = 'Đã nhập hóa chất';
        $result['number'] = checkLastBlood();
        $result['total'] = checkBloodSample();
        $result['html'] = bloodList();
      }
      break;
      // case 'edit':
      //   $id = $nv_Request->get_int('id', 'post');
      //   $type = $nv_Request->get_int('type', 'post');

      //   if ($type) {
      //     $sql = 'select * from `' . VAC_PREFIX . '_blood_import` where id = ' . $id;
      //     $query = $db->query($sql);
      //     $row = $query->fetch();
      //   } else {
      //     $sql = 'select * from `' . VAC_PREFIX . '_blood_row` where id = ' . $id;
      //     $query = $db->query($sql);
      //     $row = $query->fetch();
      //     $sql = 'select * from `' . VAC_PREFIX . '_remind` where id = ' . $row['target'];
      //     $query = $db->query($sql);
      //     $remind = $query->fetch();
      //     $row['target'] = $remind['value'];
      //   }
      //   $row['time'] = date('d/m/Y', $row['time']);
      //   $result = $row;
      //   $result['status'] = 1;
      //   break;
      // case 'edit-import':
      //   $id = $nv_Request->get_int('id', 'post', 0);
      //   $data = $nv_Request->get_array('data', 'post');

      //   $sql = 'select * from `' . VAC_PREFIX . '_blood_import` where id = ' . $id;
      //   $query = $db->query($sql);

      //   if (!empty($row = $query->fetch())) {
      //     $sql = 'update `' . VAC_PREFIX . '_blood_import` set time = ' . totime($data['time']) . ', price = ' . $data['price'] . ', number = ' . $data['number'] . ', note = "' . $data['note'] . '" where id = ' . $id;
      //     $sql2 = 'update `' . $db_config['prefix'] . '_config` set config_value = config_value + ' . ($data['number'] - $row['number']) . ' where config_name = "' . $module_name . '_blood_number"';
      //     if ($db->query($sql) && $db->query($sql2)) {
      //       $sql = 'select * from `' . $db_config['prefix'] . '_config` where config_name = "blood_number"';
      //       $query = $db->query($sql);
      //       $config = $query->fetch();
      //       $result['status'] = 1;
      //       $result['number'] = $config['config_value'];
      //       $result['notify'] = 'Đã lưu thay đổi phiếu nhập';
      //       $result['html'] = bloodList();
      //     }
      //   }
      //   break;
      // case 'edit-blood':
      //   $id = $nv_Request->get_int('id', 'post', 0);
      //   $data = $nv_Request->get_array('data', 'post');

      //   $sql = 'select * from `' . VAC_PREFIX . '_blood_row` where id = ' . $id;
      //   $query = $db->query($sql);

      //   if (!empty($row = $query->fetch())) {
      //     $targetid = 0;
      //     $sql = 'select * from `' . VAC_PREFIX . '_remind` where name = "blood" and value = "' . $data['name'] . '"';
      //     $query = $db->query($sql);
      //     if (!empty($row = $query->fetch())) {
      //       $targetid = $row['id'];
      //     } else {
      //       $sql = 'insert into `' . VAC_PREFIX . '_remind` (name, value) values ("blood", "' . $data['name'] . '")';
      //       if ($db->query($sql)) {
      //         $targetid = $db->lastInsertId();
      //       }
      //     }

      //     $sql = 'update `' . VAC_PREFIX . '_blood_row` set time = ' . totime($data['time']) . ', target = ' . $targetid . ', doctor = ' . $data['doctor'] . ' where id = ' . $id;
      //     if ($db->query($sql)) {
      //       $result['status'] = 1;
      //       $result['notify'] = 'Đã lưu thay đổi phiếu xét nghiệm';
      //       $result['html'] = bloodList();
      //     }
      //   }
      //   break;
    case 'remove':
      $id = $nv_Request->get_int('id', 'post');
      $typeid = $nv_Request->get_int('typeid', 'post');

      // xóa phiếu
      // kiểm tra loại phiếu
      // xóa loại phiếu
      // cập nhật số lượng

      if ($typeid) {
        // xóa phiếu nhập
        // cập nhật số lượng tổng

        $sql = 'select * from `' . VAC_PREFIX . '_blood_import` where id = ' . $id;
        $query = $db->query($sql);
        $import = $query->fetch();

        $sql = 'delete from `' . VAC_PREFIX . '_blood_import` where id = ' . $id;
        updateBloodSample(array(
          'number1' => -1 * $import['number1'],
          'number2' => -1 * $import['number2'],
          'number3' => -1 * $import['number3']
        ));
      } else {
        // xóa phiếu, cập nhật số lượng máy
        $sql = 'select * from `' . VAC_PREFIX . '_blood_row` where id = ' . $id;
        $query = $db->query($sql);
        $number2 = $query->fetch()['number'];

        $sql = 'delete from `' . VAC_PREFIX . '_blood_row` where id = ' . $id;
        $sql2 = 'update `' . $db_config['prefix'] . '_config` set config_value = config_value + ' . $number2 . ' where config_name = "' . $module_name . '_blood_number"';
        $db->query($sql2);
      }
      $db->query($sql);
      $result['status'] = 1;
      $result['notify'] = 'Đã xóa phiếu';
      $result['number'] = checkLastBlood();
      $result['total'] = checkBloodSample();
      $result['html'] = bloodList();
      break;
    case 'statistic':
      $result['status'] = 1;
      $result['html'] = bloodStatistic();
      break;
    case 'push':
      $number = $nv_Request->get_int('number', 'post', 1);
      $number1 = parseNumber($nv_Request->get_string('number1', 'post', 1));
      $number2 = parseNumber($nv_Request->get_string('number2', 'post', 1));
      $number3 = parseNumber($nv_Request->get_string('number3', 'post', 1));

      updateBloodSample(array(
        'number1' => -1 * $number1,
        'number2' => -1 * $number2,
        'number3' => -1 * $number3
      ));
      $sql = 'update `' . $db_config['prefix'] . '_config` set config_value = ' . $number . ' where config_name = "' . $module_name . '_blood_number"';

      $db->query($sql);

      $result['status'] = 1;
      $result['number'] = checkLastBlood();
      $result['total'] = checkBloodSample();
      break;
    case 'pull':
      $number = $nv_Request->get_int('number', 'post', 1);

      $targetid = checkBloodRemind('Chạy hóa chất tự động');
      $end = $sample_number - $number;

      $sql = 'insert into `' . VAC_PREFIX . '_blood_row` (time, number, start, end, doctor, target) values(' . time() . ', ' . $number . ', ' . $sample_number . ', ' . $end . ', ' . $user_info['userid'] . ', ' . $targetid . ')';
      // die($sql);
      $query = $db->query($sql);
      if ($query) {
        $query = $db->query('update `' . $db_config['prefix'] . '_config` set config_value = ' . $end . ' where config_name = "' . $module_name . '_blood_number"');
        if ($query) {
          $result['status'] = 1;
          $result['number'] = checkLastBlood();
          $result['total'] = checkBloodSample();
          $result['html'] = bloodList();
        }
      }
  }
  echo json_encode($result);
  die();
}

$nv = $nv_Request->get_string('nv', 'post', '');

$xtpl = new XTemplate("main.tpl", PATH2);

if (strlen($nv)) {
  $xtpl->assign('nv', $module_name);
  $xtpl->assign('op', $op);
  $xtpl->parse('main.http');
}

$xtpl->assign('module_file', $module_file);
$xtpl->assign('module_name', $module_name);
$xtpl->assign('type' . $filter['type'], 'checked');
$xtpl->assign('page', $filter['page']);
$xtpl->assign('limit', $filter['limit']);
$xtpl->assign('type', $type);
$xtpl->assign('today', date('d/m/Y'));

$sql = 'select * from `' . VAC_PREFIX . '_remind` where name = "blood" and active = 1';
$query = $db->query($sql);
$list = array();
while ($row = $query->fetch()) {
  $list[$row['id']] = $row['value'];
}

$xtpl->assign('remind_data', json_encode($list));

$xtpl->assign('modal', bloodModal());

$xtpl->assign('number', $sample_number);
$xtpl->assign('number1', $sample_total['number1']);
$xtpl->assign('number2', $sample_total['number2']);
$xtpl->assign('number3', $sample_total['number3']);

$xtpl->assign('content', bloodList());
$xtpl->parse('main');
$contents = $xtpl->text();
include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
