<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE') or !defined('NV_IS_MODADMIN')) die('Stop!!!');
define('NV_IS_FILE_ADMIN', true);
define('PATH', NV_ROOTDIR . '/modules/' . $module_file . '/template/admin/' . $op);
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php');
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/theme.php');

function remindList($filter)
{
  global $db, $remind_title;

  $filter = parseFilter($filter);
  if (!empty($filter['name'])) $xtra = 'where name = "' . $filter['name'] . '"';

  $xtpl = new XTemplate("remind-list.tpl", PATH);
  $sql = 'select count(*) as number from `' . PREFIX . 'remind` ' . $xtra;
  $query = $db->query($sql);
  $number = $query->fetch()['number'];

  $sql = 'select * from `' . PREFIX . 'remind` ' . $xtra . ' order by name, id desc limit ' . $filter['limit'] . ' offset ' . ($filter['limit'] * ($filter['page'] - 1));
  $query = $db->query($sql);
  $index = $filter['limit'] * ($filter['page'] - 1) + 1;

  while ($row = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('name', (!empty($remind_title[$row['name']]) ? $remind_title[$row['name']] : ''));
    $xtpl->assign('value', $row['value']);
    if ($row['active']) $xtpl->parse('main.row.yes');
    else $xtpl->parse('main.row.no');
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function remindModal()
{
  global $remind_title;
  $xtpl = new XTemplate("modal.tpl", PATH);
  foreach ($remind_title as $key => $value) {
    $xtpl->assign('id', $key);
    $xtpl->assign('name', $value);
    $xtpl->parse('main.name');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function manualModal()
{
  $xtpl = new XTemplate("manual-modal.tpl", PATH);
  $xtpl->assign('video_content', videoContent());
  $xtpl->parse('main');
  return $xtpl->text();
}

function videoContent()
{
  global $db;
  $xtpl = new XTemplate("video-content.tpl", PATH);
  $sql = 'select * from `' . PREFIX . 'video` order by id desc';
  $query = $db->query($sql);
  while ($row = $query->fetch()) {
    $xtpl->assign('name', substr($row['name'], 0, 18) . '...');
    $xtpl->assign('size', $row['size']);
    $xtpl->assign('url', $row['url']);
    $xtpl->assign('time', date('d/m/Y', $row['time']));
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function priceContent($filter = array('page' => 1, 'limit' => 20))
{
  global $db, $module_name, $op;
  $xtpl = new XTemplate("list.tpl", PATH);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;
  $category = priceCategoryList();

  $sql = 'select count(*) as count from `' . PREFIX . 'price_item` where (name like "%' . $filter['keyword'] . '%" or code like "%' . $filter['keyword'] . '%") ' . ($filter['category'] ? 'and category = ' . $filter['category'] : '');
  $query = $db->query($sql);
  $number = $query->fetch()['count'];

  $sql = 'select * from `' . PREFIX . 'price_item` where (name like "%' . $filter['keyword'] . '%" or code like "%' . $filter['keyword'] . '%") ' . ($filter['category'] ? 'and category = ' . $filter['category'] : '') . ' limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);

  while ($item = $query->fetch()) {
    $detailList = priceItemDetail($item['id']);
    $count = count($detailList);
    $xtpl->assign('index', $index++);
    $xtpl->assign('row', $count + 1);
    $xtpl->assign('id', $item['id']);
    $xtpl->assign('code', $item['code']);
    $xtpl->assign('name', $item['name']);
    $xtpl->assign('category', $category[$item['category']]['name']);

    foreach ($detailList as $key => $detail) {
      $xtpl->assign('price', number_format($detail['price'], 0, '', ','));
      if (!empty($detail['number'])) {
        $xtpl->assign('number', $detail['number']);
        $xtpl->parse('main.row.section.p2');
      } else $xtpl->parse('main.row.section.p1');
      $xtpl->parse('main.row.section');
    }
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', nav_generater('/admin/index.php?nv=' . $module_name . '&op=' . $op, $number, $filter['page'], $filter['limit']));
  $xtpl->parse('main');
  return $xtpl->text();
}

function priceCategoryContent()
{
  $xtpl = new XTemplate("category-list.tpl", PATH);
  $list = priceCategoryList();
  $index = 1;

  foreach ($list as $category) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $category['id']);
    $xtpl->assign('name', $category['name']);
    $xtpl->assign('active', ($category['active'] ? 'warning' : 'info'));
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function priceModal()
{
  $xtpl = new XTemplate("modal.tpl", PATH);
  $xtpl->assign('category_option', priceCategoryOption());
  $xtpl->assign('category_content', priceCategoryContent());
  $xtpl->assign('allower_content', priceAllowerContent());
  $xtpl->parse('main');
  return $xtpl->text();
}

function priceCategoryOption($categoryid = 0)
{
  $list = priceCategoryList();
  $html = '';

  foreach ($list as $category) {
    $check = '';
    if ($categoryid == $category['id']) $check = 'selected';
    $html .= '<option value="' . $category['id'] . '" ' . $check . '>' . $category['name'] . '</option>';
  }
  return $html;
}

function priceAllower()
{
  global $db, $db_config;
  $sql = 'select userid, username, concat(last_name, " ", first_name) as fullname from `' . $db_config['prefix'] . '_users` where userid in (select userid from `' . PREFIX . 'price_allow`)';
  $query = $db->query($sql);
  $list = array();

  while ($row = $query->fetch()) {
    $list[] = $row;
  }
  return $list;
}

function priceAllowerContent()
{
  $allower_list = priceAllower();
  $xtpl = new XTemplate("allow-list.tpl", PATH);
  $index = 1;
  foreach ($allower_list as $allower) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $allower['userid']);
    $xtpl->assign('username', $allower['username']);
    $xtpl->assign('fullname', $allower['fullname']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function priceFilterUser($name)
{
  global $db, $db_config;
  $allower_list = priceAllower();
  $xtpl = new XTemplate("user-list.tpl", PATH);
  $index = 1;
  $sql = 'select userid, username, concat(last_name, " ", first_name) as fullname from `' . $db_config['prefix'] . '_users` where (last_name like "%' . $name . '%" or last_name like "%' . $name . '%" or username like "%' . $name . '%") and userid not in (select userid from `' . PREFIX . 'price_allow`)';
  $query = $db->query($sql);
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

function managerContentId($name = "")
{
  global $db, $db_config;
  $xtpl = new XTemplate("manager-list.tpl", PATH);
  $sql = 'select userid, username, concat(last_name, " ", first_name) as fullname from `' . $db_config['prefix'] . '_users` where (last_name like "%' . $name . '%" or last_name like "%' . $name . '%" or username like "%' . $name . '%") and userid not in (select userid from `' . PREFIX . 'device_manager`) limit 10';
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

function deviceList()
{
  global $db, $module_name, $op, $filter;
  $xtpl = new XTemplate("device-list.tpl", PATH);

  $xtra = '';
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
  $link = '/admin/index.php?nv=' . $module_name . '&op=' . $op . '&' . http_build_query($filter) . '&act=manual';
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
    $xtpl->assign('url', $link . '&id=' . $row['id']);
    $xtpl->assign('number', $row['number']);
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));
  $xtpl->parse('main');
  return $xtpl->text();
}

function productTagContent()
{
  global $db, $filter, $link;

  $xtpl = new XTemplate("tag-content.tpl", PATH);
  $sql = 'select count(id) as number from `' . PREFIX . 'tag`';
  $query = $db->query($sql);
  $number = $query->fetch()['number'];

  $sql = 'select * from `' . PREFIX . 'tag` order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;

  while ($tag = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $tag['id']);
    $xtpl->assign('name', $tag['name']);
    $xtpl->parse('main.row');
  }
  $xtpl->assign('nav', nav_generater($link, $number, $filter['page'], $filter['limit']));
  $xtpl->parse('main');
  return $xtpl->text();
}

function productTagModal()
{
  $xtpl = new XTemplate("tag-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}

function productUserContent()
{
  global $db, $db_config;
  $type_data = array(
    0 => array(
      'btn_type' => 'btn-info',
      'name' => 'nhân viên'
    ),
    array(
      'btn_type' => 'btn-warning',
      'name' => 'quản lý'
    )
  );

  $xtpl = new XTemplate("user-content.tpl", PATH);

  $sql = 'select b.userid, username, concat(first_name, last_name) as fullname, a.type from `' . PREFIX . 'permit` a inner join `' . $db_config['prefix'] . '_users` b on a.userid = b.userid order by id desc';
  $query = $db->query($sql);
  $index = 1;

  while ($user = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $user['userid']);
    $xtpl->assign('username', $user['username']);
    $xtpl->assign('fullname', $user['fullname']);
    $xtpl->assign('btn_type', $type_data[$user['type']]['btn_type']);
    $xtpl->assign('name', $type_data[$user['type']]['name']);
    $xtpl->assign('type', intval(!$user['type']));
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function productUserSuggest($keyword)
{
  global $db, $db_config;

  $xtpl = new XTemplate("user-suggest.tpl", PATH);
  $sql = 'select userid, username, concat(first_name, last_name) as fullname from `' . $db_config['prefix'] . '_users` where userid not in (select userid from `'. PREFIX .'permit`) limit 10';
  $query = $db->query($sql);
  $index = 1;

  while ($user = $query->fetch()) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $user['userid']);
    $xtpl->assign('username', $user['username']);
    $xtpl->assign('fullname', $user['fullname']);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function productUserModal()
{
  $xtpl = new XTemplate("user-modal.tpl", PATH);
  $xtpl->parse('main');
  return $xtpl->text();
}
