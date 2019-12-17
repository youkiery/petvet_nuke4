<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) die('Stop!!!');

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'insert-blood':
      $data = $nv_Request->get_array('data', 'post');
      $data['time'] = totime($data['time']);

      $query = $db->query('insert into `'. PREFIX .'blood_row` (time, number, start, end, doctor) values('. $data['time'] .', '. $data['number'] .', '. $data['start'] .', '. $data['end'] .', '. $data['doctor'] .')');
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

      $query = $db->query('insert into `'. PREFIX .'blood_import` (time, number, price, note) values('. $data['time'] .', '. $data['number'] .', '. $data['price'] .', "'. $data['note'] .'")');
      if ($query) {
        $query = $db->query('update `'. $db_config['prefix'] .'_config` set config_value = config_value + ' . $data['number'] . ' where config_name = "blood_number"');
        if ($query) {
          $query = $db->query('select * from `'. $db_config['prefix'] .'_config` where config_name = "blood_number"');
          $row = $query->fetch();
          $result['status'] = 1;
          $result['number'] = $row['config_value'];
          $result['html'] = bloodList();
        }
      }
    break;
    case 'edit':
      $id = $nv_Request->get_int('id', 'post');
      $type = $nv_Request->get_int('type', 'post');

      if ($type) {
        $sql = 'select * from `'. PREFIX .'blood_import` where id = ' . $id;
      }
      else {
        $sql = 'select * from `'. PREFIX .'blood_row` where id = ' . $id;
      }
      $query = $db->query($sql);
      $row = $query->fetch();
      $row['time'] = date('d/m/Y', $row['time']);
      $result = $row;
      $result['status'] = 1;
    break;
    case 'remove':
      $id = $nv_Request->get_int('id', 'post');
      $type = $nv_Request->get_int('type', 'post');

      if ($type) {
        $sql = 'delete from `'. PREFIX .'blood_import` where id = ' . $id;
      }
      else {
        $sql = 'delete from `'. PREFIX .'blood_row` where id = ' . $id;
      }
      $db->query($sql);
      $result['status'] = 1;
      $result['notify'] = 'Đã xóa phiếu';
      $result['html'] = bloodList();
    break;
    case 'filter':
      $result['status'] = 1;
      $result['html'] = bloodList();
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);
$xtpl->assign('module_file', $module_file);
$xtpl->assign('module_name', $module_name);
$xtpl->assign('today', date('d/m/Y'));

$xtpl->assign('insert_modal', bloodInsertModal());
$xtpl->assign('import_modal', bloodImportModal());
$xtpl->assign('remove_modal', loadModal('remove-modal'));

$xtpl->assign('content', bloodList());
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
