<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_FILE_ADMIN')) { die('Stop!!!'); }

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'excel':
    $data = $nv_Request->get_array('data', 'post');

    foreach ($data as $index => $row) {
      foreach ($row as $name => $value) {
        if (!($name == '6' || $name == '3' || $name == '7')) checkRemind($name, $value);
      }
      $sql = 'insert into `'. PREFIX .'device` (name, unit, number, year, intro, status, depart, source, description, import_time, update_time) values("'. $row[0] .'", "'. $row[2] .'", "'. $row[3] .'", "'. $row[4] .'", "'. $row[1] .'", "", \'["'. $row[7] .'"]\', "'. $row[5] .'", "'. $row[6] .'", '. totime($row['import']) .', '. time() .')';
      $db->query($sql);
    }
    break;
  }
  echo json_encode($result);
  die();
}
$xtpl = new XTemplate("main.tpl", NV_ROOTDIR . "/modules/". $module_file ."/template/admin/main");
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
