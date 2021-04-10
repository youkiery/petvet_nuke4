<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) die('Stop!!!');

$action = $nv_Request->get_string('action', 'get', '');
if (!empty($action)) {
  switch ($action) {
    case 'insert':
      $name = $nv_Request->get_string('name', 'get', '');
      $name = trim(mb_strtolower($name));

      $sql = 'select * from pet_daklak_floor where name = "'. $name .'"';
      $query = $db->query($sql);
      $floor = $query->fetch();

      if (empty($floor)) {
        $sql = 'insert into pet_daklak_floor (name, intro) values ("'. $name .'", "")';
        $db->query($sql);
      }
    break;
    case 'remove':
      $id = $nv_Request->get_string('id', 'get', '');

      $sql = 'delete from pet_daklak_floor where id = '. $id;
      $db->query($sql);
    break;
  }
  header('location: /general/product-floor/');
}

$xtpl = new XTemplate("product-floor.tpl", PATH);

$sql = 'select * from pet_daklak_floor order by name';
$query = $db->query($sql);
$index = 1;

while ($floor = $query->fetch()) {
  $sql = 'select count(*) as number from pet_daklak_permission where floorid = '. $floor['id'];
  $user_query = $db->query($sql);
  $user_data = $user_query->fetch();
  $user = $user_data['number'];

  $sql = 'select count(*) as number from pet_daklak_item_floor where floorid = '. $floor['id'];
  $item_query = $db->query($sql);
  $item_data = $item_query->fetch();
  $item = $item_data['number'];

  $xtpl->assign('index', $index++);
  $xtpl->assign('id', $floor['id']);
  $xtpl->assign('name', $floor['name']);
  $xtpl->assign('user', $user);
  $xtpl->assign('item', $item);
  $xtpl->parse('main.row');
}

$xtpl->parse('main');
$contents = $xtpl->text();
include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';