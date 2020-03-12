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
    case 'insert':
        $data = $nv_Request->get_array('data', 'post');

        $sql = 'insert into `'. PREFIX .'market` (doctor, name, unit, address, price) values(0, "'. $data['name'] .'", "'. $data['unit'] .'", "'. $data['address'] .'", "'. $data['price'] .'")';

        if ($db->query($sql)) {
            $result['status'] = 1;
            $result['id'] = $db->lastInsertId();
        }
    break;
    case 'remove':
        $id = $nv_Request->get_int('id', 'post');

        $sql = 'delete from `'. PREFIX .'market` where id = ' . $id;
        if ($db->query($sql)) {
            $result['status'] = 1;
        }
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);

$data = array();
$sql = 'select * from `'. PREFIX .'market`';
$query = $db->query($sql);
while ($row = $query->fetch()) {
    $data[]= $row;
}

$xtpl->assign('modal', marketModal());
$xtpl->assign('content', marketContent());
$xtpl->assign('data', json_encode($data, JSON_UNESCAPED_UNICODE));
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
