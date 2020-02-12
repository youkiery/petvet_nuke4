<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_SYSTEM')) die('Stop!!!');
define('NV_IS_MOD_CONGVAN', true);
define('PATH', NV_ROOTDIR . "/modules/". $module_file ."/template/user/" . $op);
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php');



function deviceModal() {
  $xtpl = new XTemplate("device-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function excelModal() {
  $xtpl = new XTemplate("excel-modal.tpl", PATH);

  $depart = getDepartList();
  foreach ($depart as $data) {
    $xtpl->assign('id', $data['id']);
    $xtpl->assign('name', $data['name']);
    $xtpl->parse('main.depart');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function transferModal() {
  $xtpl = new XTemplate("transfer-modal.tpl", PATH);

  $depart = getDepartList();
  foreach ($depart as $data) {
    $xtpl->assign('id', $data['id']);
    $xtpl->assign('name', $data['name']);
    $xtpl->parse('main.depart');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function removeModal() {
  $xtpl = new XTemplate("remove-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function removeAllModal() {
  $xtpl = new XTemplate("remove-all-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function deviceList() {
  global $db, $nv_Request, $user_info, $db_config;
  
  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['limit'])) $filter['limit'] = 10;

  $xtpl = new XTemplate("device-list.tpl", PATH);

  // $query = $db->query('select * from `'. PREFIX .'member` where userid = '. $user_info['userid']);
  // $user = $query->fetch();
  // $authors = json_decode($user['author']);

  // $depart = $authors->{depart};
  // $depart2 = array();
  // $departid = array();
  // foreach ($depart as $id) {
  //   $departid[$id] = 1;
  //   $depart2[]= $id;
  // }
  // $xtra = '';
  // if (empty($filter['depart'])) {
  //   $filter['depart'] = $depart2;
  // }
  // else {
  //   foreach ($filter['depart'] as $index => $value) {
  //     if (empty($departid[$value])) unset($filter['depart'][$index]);
  //   }
  // }

  $sql = 'select * from `'. $db_config['prefix'] .'_users` where userid = ' . $user_info['userid'];
  $query = $db->query($sql);
  $user = $query->fetch();
  $group = explode(',', $user['in_groups']);
  // $group = array();
  $list = array();
  $xtra = '';

  if (!in_array('1', $group)) {
    // check if is allowed
    $sql = 'select * from `'. PREFIX .'devicon` where userid = ' . $user_info['userid'];
    $query = $db->query($sql);
    $devicon = $query->fetch();

    if ($devicon['level'] < 3) {
      $list = json_decode($devicon['depart']);
      // var_dump($devicon);die(); 
    } 
    else $list = getDepartidList();
  }
  else $list = getDepartidList();

  if (!empty($filter['depart']) && count($filter['depart'])) {
    $query_list = array();
    foreach ($filter['depart'] as $departid) {
      if (in_array($departid, $list)) $query_list[] = 'depart like \'%"'. $departid .'"%\'';
    }
    if (count($query_list)) $xtra = 'where ('. implode(' or ', $query_list) .')';
    else $xtra = 'where 0';
  }

  if (!empty($filter['keyword'])) {
    if ($xtra) $xtra .= ' and name like "%'. $filter['keyword'] .'%"';
    else $xtra .= ' where name like "%'. $filter['keyword'] .'%"';
  }

  // die('select count(*) as count from `'. PREFIX .'device` '. $xtra .' order by update_time desc limit ' . $filter['limit']);
  $sql = 'select count(*) as count from `'. PREFIX .'device` '. $xtra .' order by update_time desc limit ' . $filter['limit'];
  $query = $db->query($sql);

  $count = $query->fetch();
  $number = $count['count'];
  // die('select * from `'. PREFIX .'device` '. $xtra .' order by update_time desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $query = $db->query('select * from `'. PREFIX .'device` '. $xtra .' order by update_time desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  if ($authors->{device} == 2) $xtpl->parse('main.v1');
  while ($row = $query->fetch()) {
    $depart = json_decode($row['depart']);
    $list = array();
    foreach ($depart as $value) {
      $list[]= checkDepartId($value);
    }
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('depart', implode(', ', $list));
    $xtpl->assign('departid', $depart[0]);
    $xtpl->assign('company', $row['intro']);
    $xtpl->assign('status', $row['status']);
    $xtpl->assign('number', $row['number']);
    if (empty($devicon) || (!empty($devicon) && $devicon['level'] > 1)) $xtpl->parse('main.row.v2');
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function reportList() {
  global $db, $op, $module_file, $nv_Request;
  $type_list = array(0 => 'Vật tư', 1 => 'Hóa chất');

  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['limit'])) $filter['limit'] = 10;
  if (empty($filter['start'])) $filter['start'] = strtotime(date('Y/m/d', time() - (date('d') - 1) * 60 * 60 * 24));
  else $filter['start'] = totime($filter['start']);
  if (empty($filter['end'])) $filter['end'] = strtotime(date('Y/m/d')) + 60 * 60 * 24 - 1;
  else $filter['end'] = totime($filter['end']) + 60 * 60 * 24 - 1;

  $xtpl = new XTemplate("report-list.tpl", PATH);
  $data = array();

  $xtpl->assign('from', date('d/m/Y', $filter['start']));
  $xtpl->assign('end', date('d/m/Y', $filter['end']));

  $sql = 'select * from `'. PREFIX .'export` where export_date between '. $filter['start'] .' and '. $filter['end'];
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $sql2 = 'select * from `'. PREFIX .'export_detail` where export_id = ' . $row['id'];
    $query2 = $db->query($sql2);
    
    while ($export = $query2->fetch()) {
      if (empty($data[$export['item_id']])) {
        $data[$export['item_id']] = array(
          'export' => 0,
          'import' => 0
        );
      } 
      $data[$export['item_id']]['export'] += $export['number'];
    }
  }

  $sql = 'select * from `'. PREFIX .'import` where import_date between '. $filter['start'] .' and '. $filter['end'];
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $sql2 = 'select * from `'. PREFIX .'import_detail` where import_id = ' . $row['id'];
    $query2 = $db->query($sql2);
    
    while ($import = $query2->fetch()) {
      if (empty($data[$import['item_id']])) {
        $data[$import['item_id']] = array(
          'export' => 0,
          'import' => 0
        );
      } 
      $data[$import['item_id']]['import'] += $import['number'];
    }
  }

  $index = 1;

  foreach ($data as $itemid => $itemdata) {
    $sql = 'select * from `'. PREFIX .'material` where id = ' . $itemid;
    $query = $db->query($sql);
    $material = $query->fetch();

    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $itemid);
    $xtpl->assign('name', $material['name']);
    $xtpl->assign('type', $type_list[$material['type']]);
    $xtpl->assign('import', $itemdata['import']);
    $xtpl->assign('export', $itemdata['export']);
    $xtpl->parse('main.row');
  }

  $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goReportPage'));

  $xtpl->parse('main');
  return $xtpl->text();
}

function reportDetail() {
  global $db, $nv_Request;
  $type_list = array('Phiếu xuất', 'Phiếu nhập');

  $xtpl = new XTemplate("report-detail.tpl", PATH);
  $id = $nv_Request->get_int('id', 'post');
  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['start'])) $filter['start'] = strtotime(date('Y/m/d', time() - (date('d') - 1) * 60 * 60 * 24));
  else $filter['start'] = totime($filter['start']);
  if (empty($filter['end'])) $filter['end'] = strtotime(date('Y/m/d')) + 60 * 60 * 24 - 1;
  else $filter['end'] = totime($filter['end']) + 60 * 60 * 24 - 1;

  $sql = 'select * from ((select a.number, b.export_date as time, 0 as type, a.note from `'. PREFIX .'export_detail` a inner join `'. PREFIX .'export` b on a.item_id = '. $id .' and a.export_id = b.id) union (select a.number, b.import_date as time, 1 as type, a.note from `'. PREFIX .'import_detail` a inner join `'. PREFIX .'import` b on a.item_id = '. $id .' and a.import_id = b.id)) as a where time between '. $filter['start'] .' and '. $filter['end'] .' order by time desc';
  $query = $db->query($sql);
  $index = 1;

  $total = 0;
  while ($row = $query->fetch()) {
    if ($row['type']) {
      $xtpl->assign('color', 'greenbg');
      $total += $row['number'];
    }
    else {
      $xtpl->assign('color', 'redbg');
      $total -= $row['number'];
    }
    $xtpl->assign('index', $index ++);
    $xtpl->assign('number', $row['number']);
    $xtpl->assign('type', $type_list[$row['type']]);
    $xtpl->assign('time', date('d/m/Y H:i', $row['time']));
    $xtpl->assign('note', $row['note']);
    $xtpl->parse('main.row');
  }
  $xtpl->assign('total', $total);
  $xtpl->parse('main');
  return $xtpl->text();
}

function checkMember() {
  global $db, $user_info, $op;

  if (empty($user_info)) {
    $content = 'Xin hãy đăng nhập trước khi sử dụng chức năng này';
  }
  else {
    $query = $db->query('select * from `'. PREFIX .'member` where userid = '. $user_info['userid']);
    $user = $query->fetch();
    $authors = json_decode($user['author']);
    if ($op == 'device' && $authors->{device}) {
      // ok
    }
    else if ($op == 'material' && $authors->{material}) {
      // ok
    }
    else if ($op == 'main' && ($authors->{device} || $authors->{material})) {
      // ok
    }
    else {
      // prevent
      $content = 'Tài khoản không có quyền truy cập';
    }
  }
  if ($content) {
    include NV_ROOTDIR . '/includes/header.php';
    echo nv_site_theme($content);
    include NV_ROOTDIR . '/includes/footer.php';
  }
}

function materialList() {
  global $db, $op, $module_file, $nv_Request;

  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['limit'])) $filter['limit'] = 10;

  $type_list = array(0 => 'Vật tư', 1 => 'Hóa chất');
  $xtpl = new XTemplate("material-list.tpl", PATH);

  $sql = 'select count(*) as count from `'. PREFIX .'material`';
  $query = $db->query($sql);
  $number = $query->fetch()['count'];

  $sql = 'select * from `'. PREFIX .'material` order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;

  while($row = $query->fetch()) {
    // echo json_encode($row);
    // echo '<br>';
    $xtpl->assign('index', $index++);
    $xtpl->assign('type', $type_list[$row['type']]);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('number', $row['number']);
    $xtpl->assign('description', $row['description']);
    if ($row['unit']) $xtpl->assign('unit', "($row[unit])");
    else $xtpl->assign('unit', '');
    $xtpl->parse('main.row');
  }
  // die();
  $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));

  $xtpl->parse('main');
  return $xtpl->text();
}

function expireList($limit = 2592000) {
  global $db;

  $sql = "select * from `". PREFIX ."import_detail`"
}

function materialModal() {
  $xtpl = new XTemplate("modal.tpl", PATH);
 
  $start = date('d/m/Y', time() - (date('d') - 1) * 60 * 60 * 24);
  $end = date('d/m/Y');
  $xtpl->assign('start', $start);
  $xtpl->assign('end', $end);
  $xtpl->assign('overlow_content', materialOverlowList());
  $xtpl->assign('import_content', importList());
  $xtpl->assign('export_content', exportList());
  $xtpl->assign('expire_content', expireList());

  $xtpl->parse('main');
  return $xtpl->text();
}

function importList() {
  global $db;

  $filter = parseFilter('import');
  $xtpl = new XTemplate("import-modal-list.tpl", PATH);

  $query = $db->query('select count(*) as count from `'. PREFIX .'import`');
  $number = $query->fetch();

  // die('select * from `'. PREFIX .'import` limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $query = $db->query('select * from `'. PREFIX .'import` order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  while ($row = $query->fetch()) {
    $id = $row['id'];
    $importData = getImportData($row['id']);

    // $xtpl->assign('id', 'ip' . spat(6 - strlen($row['id']), '0'));
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('date', date('d/m/Y H:i', $row['import_date']));
    $xtpl->assign('count', $importData['count']);
    $xtpl->assign('total', $importData['total']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function exportList() {
  global $db;

  $filter = parseFilter('export');
  $xtpl = new XTemplate("export-list.tpl", PATH);

  $query = $db->query('select count(*) as count from `'. PREFIX .'export`');
  $number = $query->fetch();

  // die('select * from `'. PREFIX .'import` limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $query = $db->query('select * from `'. PREFIX .'export` order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  while ($row = $query->fetch()) {
    $id = $row['id'];
    $exportData = getExportData($row['id']);

    // $xtpl->assign('id', 'ip' . spat(6 - strlen($row['id']), '0'));
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('date', date('d/m/Y H:i', $row['export_date']));
    $xtpl->assign('count', $exportData['count']);
    $xtpl->assign('total', $exportData['total']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}
