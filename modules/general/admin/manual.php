<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

$action = $nv_Request->get_string('action', 'post', '');
$manual = getDeviceManual($id);

if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'save-manual':
      $data = $nv_Request->get_string('data', 'post', '');
      
      $data = str_replace('\'', '"', $data);
      if (!empty($manual)) {
        $sql = 'update `'. PREFIX .'device_manual` set manual = \'' . $data . '\' where deviceid = ' . $id;
      }
      else {
        $sql = 'insert into `'. PREFIX .'device_manual` (deviceid, manual) values('. $id .', \''. $data .'\')';
      }
      $db->query($sql);

      $result['status'] = 1;
      $url = '/admin/index.php?nv=' . $module_name . '&op=' . $op . '&' . http_build_query($filter);
      $result['url'] = $url;
    break;
    case 'insert-video':
      $name = $nv_Request->get_string('name', 'post', '');
      $size = $nv_Request->get_string('size', 'post', '');
      $url = $nv_Request->get_string('url', 'post', '');

      $sql = 'insert into `'. PREFIX .'video` (name, size, url, time) values("'. $name .'", "'. parseSize($size) .'", "'. $url .'", '. time() .')';
      if ($db->query($sql)) {
        $result['status'] = 1;
        $result['html'] = videoContent();
      }
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("manual.tpl", PATH);

$device = getDeviceData($id);
$xtpl->assign('modal', manualModal());
$xtpl->assign('device_name', $device['name']);
$xtpl->assign('data', $manual['manual']);
$xtpl->parse("main");
$contents = $xtpl->text("main");

include (NV_ROOTDIR . "/includes/header.php");
echo nv_admin_theme($contents);
include (NV_ROOTDIR . "/includes/footer.php");