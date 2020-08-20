<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE') or !defined('NV_IS_MODADMIN')) die('Stop!!!');
define('NV_IS_FILE_ADMIN', true);
define('PATH', NV_ROOTDIR . "/modules/" . $module_file . "/template/admin/" . $op);
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php');
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/theme.php');

function memberFilter()
{
  global $db, $nv_Request, $db_config;

  $xtpl = new XTemplate("member-modal-list.tpl", PATH);
  $filter = $nv_Request->get_array('memfilter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['limit'])) $filter['limit'] = 10;
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  $query = $db->query('select count(*) as number from `' . $db_config['prefix'] . '_users` where (first_name like "%' . $filter['keyword'] . '%" or last_name like "%' . $filter['keyword'] . '%") and userid not in (select userid from `' . PREFIX . 'devicon`)');

  $number = $query->fetch()['number'];
  // die('select userid, username, first_name, last_name from `'. $db_config['prefix'] .'_users` where (first_name like "%'. $filter['keyword'] .'%" or last_name like "%'. $filter['keyword'] .'%") and userid not in (select userid from `'. PREFIX .'devicon`) order by first_name');
  $query = $db->query('select userid, username, first_name, last_name from `' . $db_config['prefix'] . '_users` where (first_name like "%' . $filter['keyword'] . '%" or last_name like "%' . $filter['keyword'] . '%") and userid not in (select userid from `' . PREFIX . 'devicon`) order by first_name limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);

  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['userid']);
    $xtpl->assign('username', $row['username']);
    $xtpl->assign('name', $row['last_name'] . ' ' . $row['first_name']);
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goMemPage'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function memberuserList()
{
  global $db, $nv_Request, $db_config;

  $xtpl = new XTemplate("member-list.tpl", PATH);
  $filter = $nv_Request->get_array('filter', 'post');
  if (empty($filter['page'])) $filter['page'] = 1;
  if (empty($filter['limit'])) $filter['limit'] = 10;
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  $query = $db->query('select count(*) as number from `' . PREFIX . 'devicon`');

  $number = $query->fetch()['number'];
  // die('select a.userid, a.level, a.depart, b.username, b.first_name from `'. PREFIX .'devicon` a inner join `'. $db_config['prefix'] .'users` b on a.userid = b.userid order by a.id desc');
  $query = $db->query('select a.id, a.userid, a.level, a.depart, b.username, b.first_name from `' . PREFIX . 'devicon` a inner join `' . $db_config['prefix'] . '_users` b on a.userid = b.userid order by a.id desc');

  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['last_name'] . ' ' . $row['first_name']);
    $xtpl->assign('username', $row['username']);
    $xtpl->assign('level', $row['level']);
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function memberModal()
{
  $xtpl = new XTemplate("member-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function memberEditModal()
{
  $xtpl = new XTemplate("member-edit-modal.tpl", PATH);
  $depart = getDepartList();
  foreach ($depart as $data) {
    $xtpl->assign('id', $data['id']);
    $xtpl->assign('name', $data['name']);
    $xtpl->parse('main.depart');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function managerContent()
{
  global $db, $db_config;
  $xtpl = new XTemplate("manager-content.tpl", PATH);
  $sql = 'select userid, username, concat(last_name, " ", first_name) as fullname from `' . $db_config['prefix'] . '_users` where userid in (select userid from `' . PREFIX . 'device_manager`)';
  $query = $db->query($sql);
  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['userid']);
    $xtpl->assign('username', $row['username']);
    $xtpl->assign('fullname', $row['fullname']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function deviceModal()
{
  $xtpl = new XTemplate("modal.tpl", PATH);
  $xtpl->assign('manager_content', managerContent());
  $xtpl->assign('depart_content', departList());
  $xtpl->parse('main');
  return $xtpl->text();
}

function departModal()
{
  global $module_file, $op;
  $xtpl = new XTemplate("depart-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function removeModal()
{
  global $module_file, $op;
  $xtpl = new XTemplate("remove-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function removeAllModal()
{
  global $module_file, $op;
  $xtpl = new XTemplate("remove-all-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function deviceList()
{
  global $db, $module_file, $op, $nv_Request;

  $filter = parseFilter('device');
  $xtpl = new XTemplate("device-list.tpl", PATH);

  $xtra = '';
  // var_dump($filter);die();
  if (!empty($filter['depart'])) {
    $list = array();
    foreach ($filter['depart'] as $value) {
      $list[] = 'depart like \'%"' . $value . '"%\'';
    }
    $xtra = ' where (' . implode(' or ', $list) . ') ';
  }
  $query = $db->query('select count(*) as count from `' . PREFIX . 'device` ' . $xtra . ' order by update_time desc limit ' . $filter['limit']);
  $count = $query->fetch();
  $number = $count['count'];
  // die('select * from `'. PREFIX .'device` '. $xtra .' order by update_time desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $query = $db->query('select * from `' . PREFIX . 'device` ' . $xtra . ' order by update_time desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  while ($row = $query->fetch()) {
    $depart = json_decode($row['depart']);
    $list = array();
    foreach ($depart as $value) {
      $list[] = checkDepartId($value);
    }
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('depart', implode(', ', $list));
    $xtpl->assign('company', $row['intro']);
    $xtpl->assign('status', $row['status']);
    $xtpl->assign('number', $row['number']);
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function importInsertModal()
{
  global $op;
  $xtpl = new XTemplate("import-insert-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function materialModal()
{
  global $op;
  $xtpl = new XTemplate("material-modal.tpl", PATH);
  $xtpl->assign('content', materialOverlowList());
  $xtpl->assign('link_content', materialLinkList());
  $xtpl->parse('main');
  return $xtpl->text();
}

function importModal()
{
  global $op;
  $xtpl = new XTemplate("import-modal.tpl", PATH);
  $xtpl->assign('content', importList());
  $xtpl->parse('main');
  return $xtpl->text();
}

function importModalInsert()
{
  global $op;
  $xtpl = new XTemplate("import-modal-insert.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function exportModalInsert()
{
  global $op;
  $xtpl = new XTemplate("export-modal-insert.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function importModalRemove()
{
  global $op;
  $xtpl = new XTemplate("import-modal-remove.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function exportModalRemove()
{
  global $op;
  $xtpl = new XTemplate("export-modal-remove.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function importList()
{
  global $db, $module_file, $op;

  $filter = parseFilter('import');
  $xtpl = new XTemplate("import-modal-list.tpl", PATH);

  $query = $db->query('select count(*) as count from `' . PREFIX . 'import`');
  $number = $query->fetch();

  // die('select * from `'. PREFIX .'import` limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $query = $db->query('select * from `' . PREFIX . 'import` order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
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

function exportModal()
{
  global $op;
  $xtpl = new XTemplate("export-modal.tpl", PATH);
  $xtpl->assign('content', exportList());
  $xtpl->parse('main');
  return $xtpl->text();
}

function exportList()
{
  global $db, $module_file, $op;

  $filter = parseFilter('export');
  $xtpl = new XTemplate("export-list.tpl", PATH);

  $query = $db->query('select count(*) as count from `' . PREFIX . 'export`');
  $number = $query->fetch();

  // die('select * from `'. PREFIX .'import` limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
  $query = $db->query('select * from `' . PREFIX . 'export` order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
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

function departList()
{
  global $db;
  $xtpl = new XTemplate("list.tpl", PATH);
  $sql = 'select * from `' . PREFIX . 'device_depart` order by id desc';
  $query = $db->query($sql);
  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function departContentList()
{
  global $db;

  $xtpl = new XTemplate("depart-list.tpl", PATH);
  $index = 1;

  $sql = 'select * from `' . PREFIX . 'depart` order by id desc';
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['name']);
    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function editMemberModal()
{
  global $db;
  $xtpl = new XTemplate("edit-member-modal.tpl", PATH);

  $xtpl->assign('content', departList());
  $xtpl->parse('main');
  return $xtpl->text();
}

function removeMemberModal()
{
  $xtpl = new XTemplate("remove-member-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function memberList()
{
  global $db, $db_config;

  $xtpl = new XTemplate("member-list.tpl", PATH);
  $allowance = array(1 => 'Chỉ xem', 'Chỉnh sửa');

  $sql = 'select a.id, a.author, b.first_name from `' . PREFIX . 'member` a inner join `' . $db_config['prefix'] . '_users` b on a.userid = b.userid';
  $query = $db->query($sql);
  $index = 1;

  while ($row = $query->fetch()) {
    $authors = json_decode($row['author']);
    $author = '';
    if (!empty($authors->{'depart'})) {
      if (!empty($authors->{'device'}) || !empty($authors->{'device'})) {
        $depart = array();
        $query2 = $db->query('select * from `' . PREFIX . 'depart` where id in (' . implode(', ', $authors->{'depart'}) . ')');
        while ($row2 = $query2->fetch()) $depart[] = '[' . $row2['name'] . ']';
        $author =  ($authors->{'device'} ? ' [' . $allowance[$authors->{'device'}] . '] thiết bị' : '') . ($authors->{'material'} ? ' [' . $allowance[$authors->{'material'}] . '] vật tư' : '') . ' của phòng ban ' . implode(', ', $depart);
      }
    }
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $row['first_name']);
    $xtpl->assign('author', $author);
    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function materialLinkList()
{
  global $db;

  $xtpl = new XTemplate("link-list.tpl", PATH);

  $sql = 'select * from `' . PREFIX . 'material_link`';
  $query = $db->query($sql);
  $index = 1;

  while ($row = $query->fetch()) {
    $item = getMaterialData($row['item_id']);
    $item2 = getMaterialData($row['link_id']);
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', $item['name']);
    $xtpl->assign('name2', ($item2['name']));
    $xtpl->assign('unit', (strlen($item['unit']) ? "($item[unit])" : ''));
    $xtpl->assign('unit2', (strlen($item2['unit']) ? "($item2[unit])" : ''));
    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function itemContentId($id)
{
  global $db, $db_config;
  $xtpl = new XTemplate("depart-list.tpl", PATH);
  $sql = 'select userid, username, concat(last_name, " ", first_name) as fullname from `' . $db_config['prefix'] . '_users` where userid in (select userid from `' . PREFIX . 'device_employ` where itemid = ' . $id . ')';
  $query = $db->query($sql);
  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['userid']);
    $xtpl->assign('username', $row['username']);
    $xtpl->assign('fullname', $row['fullname']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function employContentId($id, $name = "")
{
  global $db, $db_config;
  $xtpl = new XTemplate("employ-list.tpl", PATH);
  $sql = 'select userid, username, concat(last_name, " ", first_name) as fullname from `' . $db_config['prefix'] . '_users` where (last_name like "%' . $name . '%" or last_name like "%' . $name . '%" or username like "%' . $name . '%") and userid not in (select userid from `' . PREFIX . 'device_employ` where itemid = ' . $id . ') limit 10';
  $query = $db->query($sql);
  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['userid']);
    $xtpl->assign('username', $row['username']);
    $xtpl->assign('fullname', $row['fullname']);
    $xtpl->parse('main');
  }
  return $xtpl->text();
}

function materialPermitSuggest($name)
{
  global $db, $db_config;

  $xtpl = new XTemplate("permit-suggest.tpl", PATH);
  $sql = 'select userid, username, concat(last_name, " ", first_name) as fullname from `' . $db_config['prefix'] . '_users` where (last_name like "%' . $name . '%" or last_name like "%' . $name . '%" or username like "%' . $name . '%") and userid not in (select userid from `' . PREFIX . 'permit`) limit 10';
  $query = $db->query($sql);
  $index = 1;
  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['userid']);
    $xtpl->assign('username', $row['username']);
    $xtpl->assign('fullname', $row['fullname']);
    $xtpl->parse('main');
  }
  return $xtpl->text();
}

function materialPermitList()
{
  global $db, $db_config;
  $xtpl = new XTemplate("permit-list.tpl", PATH);
  $sql = 'select * from `' . PREFIX . 'permit`';
  $query = $db->query($sql);
  $index = 1;
  $type_info = array(
    0 => array(
      'type' => '1',
      'name' => 'nhân viên',
      'btn' => 'btn-info'
    ),
    array(
      'type' => '0',
      'name' => 'quản lý',
      'btn' => 'btn-warning'
    ),
    array(
      'type' => '0',
      'name' => 'quản lý',
      'btn' => 'btn-warning'
    )
  );
  while ($row = $query->fetch()) {
    $sql = 'select username, concat(last_name, " ", first_name) as fullname from `' . $db_config['prefix'] . '_users` where userid = '. $row['userid'];
    $info_query = $db->query($sql);
    $info = $info_query->fetch();
    $xtpl->assign('type', $type_info[$row['type']]['type']);
    $xtpl->assign('type_name', $type_info[$row['type']]['name']);
    $xtpl->assign('type_btn', $type_info[$row['type']]['btn']);

    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['userid']);
    $xtpl->assign('username', $info['username']);
    $xtpl->assign('fullname', $info['fullname']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}
