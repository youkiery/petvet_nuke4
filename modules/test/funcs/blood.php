<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_QUANLY')) die('Stop!!!');

$type = 0;
if (!empty($user_info)) {
  $sql = 'select * from `'. $db_config['prefix'] .'_users` where userid = ' . $user_info['userid'];
  $query = $db->query($sql);
  $user = $query->fetch();
  $group = explode(',', $user['in_groups']);
  if (in_array('1', $group)) {
    // do nothing
    $type = 2;
  }
  else {
    $sql = 'select * from `'. VAC_PREFIX .'_config` where name = "config" and type = 2 and groupid in ('. $user['in_groups'] .')';
    $query = $db->query($sql);
    if (!empty($query->fetch())) {
      $type = 2;
    }
    else {
      $sql = 'select * from `'. VAC_PREFIX .'_config` where name = "config" and type = 1 and groupid in ('. $user['in_groups'] .')';
      $query = $db->query($sql);
      if (!empty($query->fetch())) {
        $type = 1;
      }
    }
  }
}

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'insert-blood':
      $data = $nv_Request->get_array('data', 'post');
      $data['time'] = totime($data['time']);

      $targetid = 0;
      $sql = 'select * from `'. VAC_PREFIX .'_remind` where name = "blood" and value = "'. $data['name'] .'"';
      $query = $db->query($sql);
      if (!empty($row = $query->fetch())) {
        $targetid = $row['id'];
      }
      else {
        $sql = 'insert into `'. VAC_PREFIX .'_remind` (name, value) values ("blood", "'. $data['name'] .'")';
        if ($db->query($sql)) {
          $targetid = $db->lastInsertId();
        }
      }
      
      $sql = 'insert into `'. VAC_PREFIX .'_blood_row` (time, number, start, end, doctor, target) values('. $data['time'] .', '. $data['number'] .', '. $data['start'] .', '. $data['end'] .', '. $data['doctor'] .', '. $targetid .')';
      // die($sql);
      $query = $db->query($sql);
      if ($query) {
        $query = $db->query('update `'. $db_config['prefix'] .'_config` set config_value = ' . $data['end'] . ' where config_name = "blood_number"');
        if ($query) {
          $result['status'] = 1;
          $result['html'] = bloodList();
        }
      }
    break;
    case 'insert-import':
      $data = $nv_Request->get_array('data', 'post');
      $data['time'] = totime($data['time']);

      $data['price'] = str_replace(',', '', $data['price']);
      $sql = 'insert into `'. VAC_PREFIX .'_blood_import` (time, number, price, note, doctor) values('. $data['time'] .', '. $data['number'] .', '. $data['price'] .', "'. $data['note'] .'", '. ($user_info['userid'] ? $user_info['userid'] : 0) .')';
      $query = $db->query($sql);
      if ($query) {
        $query = $db->query('update `'. $db_config['prefix'] .'_config` set config_value = config_value + ' . $data['number'] . ' where config_name = "blood_number"');
        if ($query) {
          $query = $db->query('select * from `'. $db_config['prefix'] .'_config` where config_name = "blood_number"');
          $row = $query->fetch();
          $result['status'] = 1;
          $result['notify'] = 'Đã nhập hóa châ';
          $result['number'] = $row['config_value'];
          $result['html'] = bloodList();
        }
      }
    break;
    case 'edit':
      $id = $nv_Request->get_int('id', 'post');
      $type = $nv_Request->get_int('type', 'post');

      if ($type) {
        $sql = 'select * from `'. VAC_PREFIX .'_blood_import` where id = ' . $id;
        $query = $db->query($sql);
        $row = $query->fetch();
      }
      else {
        $sql = 'select * from `'. VAC_PREFIX .'_blood_row` where id = ' . $id;
        $query = $db->query($sql);
        $row = $query->fetch();
        $sql = 'select * from `'. VAC_PREFIX .'_remind` where id = ' . $row['target'];
        $query = $db->query($sql);
        $remind = $query->fetch();
        $row['target'] = $remind['value'];
      }
      $row['time'] = date('d/m/Y', $row['time']);
      $result = $row;
      $result['status'] = 1;
    break;
    case 'edit-import':
      $id = $nv_Request->get_int('id', 'post', 0);
      $data = $nv_Request->get_array('data', 'post');

      $sql = 'select * from `'. VAC_PREFIX .'_blood_import` where id = ' . $id;
      $query = $db->query($sql);

      if (!empty($row = $query->fetch())) {
        $sql = 'update `'. VAC_PREFIX .'_blood_import` set time = ' . totime($data['time']) . ', price = ' . $data['price'] . ', number = ' . $data['number'] .', note = "'. $data['note'] .'" where id = ' . $id;
        $sql2 = 'update `'. $db_config['prefix'] .'_config` set config_value = config_value + ' . ($data['number'] - $row['number']) . ' where config_name = "blood_number"';
        if ($db->query($sql) && $db->query($sql2)) {
          $sql = 'select * from `'. $db_config['prefix'] .'_config` where config_name = "blood_number"';
          $query = $db->query($sql);
          $config = $query->fetch();
          $result['status'] = 1;
          $result['number'] = $config['config_value'];
          $result['notify'] = 'Đã lưu thay đổi phiếu nhập';
          $result['html'] = bloodList();
        }        
      }
    break;
    case 'edit-blood':
      $id = $nv_Request->get_int('id', 'post', 0);
      $data = $nv_Request->get_array('data', 'post');

      $sql = 'select * from `'. VAC_PREFIX .'_blood_row` where id = ' . $id;
      $query = $db->query($sql);

      if (!empty($row = $query->fetch())) {
        $targetid = 0;
        $sql = 'select * from `'. VAC_PREFIX .'_remind` where name = "blood" and value = "'. $data['name'] .'"';
        $query = $db->query($sql);
        if (!empty($row = $query->fetch())) {
          $targetid = $row['id'];
        }
        else {
          $sql = 'insert into `'. VAC_PREFIX .'_remind` (name, value) values ("blood", "'. $data['name'] .'")';
          if ($db->query($sql)) {
            $targetid = $db->lastInsertId();
          }
        }

        $sql = 'update `'. VAC_PREFIX .'_blood_row` set time = ' . totime($data['time']) . ', target = '. $targetid .', doctor = '. $data['doctor'] .' where id = ' . $id;
        if ($db->query($sql)) {
          $result['status'] = 1;
          $result['notify'] = 'Đã lưu thay đổi phiếu xét nghiệm';
          $result['html'] = bloodList();
        }        
      }
    break;
    case 'remove':
      $id = $nv_Request->get_int('id', 'post');
      $typeid = $nv_Request->get_int('typeid', 'post');

      $sql = 'select * from `'. $db_config['prefix'] .'_config` where config_name = "blood_number"';
      $query = $db->query($sql);
      $number = $query->fetch()['config_value'];
      
      if ($typeid) {
        $sql = 'select * from `'. VAC_PREFIX .'_blood_import` where id = ' . $id;
        $query = $db->query($sql);
        $number2 = $query->fetch()['number'];
        $result['number'] = $number - $number2;

        $sql = 'delete from `'. VAC_PREFIX .'_blood_import` where id = ' . $id;
        $sql2 = 'update `'. $db_config['prefix'] .'_config` set config_value = ' . ($result['number']) . ' where config_name = "blood_number"';
      }
      else {
        $sql = 'select * from `'. VAC_PREFIX .'_blood_row` where id = ' . $id;
        $query = $db->query($sql);
        $number2 = $query->fetch()['number'];
        $result['number'] = $number + $number2;

        $sql = 'delete from `'. VAC_PREFIX .'_blood_row` where id = ' . $id;
        $sql2 = 'update `'. $db_config['prefix'] .'_config` set config_value = ' . ($result['number']) . ' where config_name = "blood_number"';
      }
      $db->query($sql);
      $db->query($sql2);
      $result['status'] = 1;
      $result['notify'] = 'Đã xóa phiếu';
      $result['html'] = bloodList();
    break;
    case 'filter':
      $result['status'] = 1;
      $result['html'] = bloodList();
    break;
    case 'statistic':
      $result['status'] = 1;
      $result['html'] = bloodStatistic();
      break;
  }
  echo json_encode($result);
  die();
}

if ($type) {
  $xtpl = new XTemplate("main.tpl", PATH2);
  $xtpl->assign('module_file', $module_file);
  $xtpl->assign('module_name', $module_name);
  $xtpl->assign('type', $type);
  $xtpl->assign('today', date('d/m/Y'));
  
  $sql = 'select * from `'. VAC_PREFIX .'_remind` where name = "blood" and active = 1';
  $query = $db->query($sql);
  $list = array();
  while ($row = $query->fetch()) {
    $list[$row['id']] = $row['value'];
  }
  
  $xtpl->assign('_remind_data', json_encode($list));
  
  $xtpl->assign('modal', bloodModal());
  $xtpl->assign('insert_modal', bloodInsertModal());
  $xtpl->assign('import_modal', bloodImportModal());
  $xtpl->assign('remove_modal', loadModal('remove-modal'));
  
  $xtpl->assign('content', bloodList());
  $xtpl->parse('main');
  $contents = $xtpl->text();
}
else {
  $contents = '<div class="form-group text-center"> Tài khoản cần cấp quyền để sử dụng chức năng này </div>';
}
$sql = 'select * from `'. $db_config['prefix'] .'_user`';

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
