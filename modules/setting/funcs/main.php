<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_MODULE')) die('Stop!!!');

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'submit':
      $data = $nv_Request->get_array('data', 'post');
      $list = $nv_Request->get_array('list', 'post');

      $sql = "insert into `". PREFIX ."_row` (fullname, mobile, address, image) values('$data[fullname]', '$data[mobile]', '$data[address]', '". implode(',', $list) ."')";
      
      if ($db->query($sql)) {
        $result['status'] = 1;
      }
    break;
  }
  echo json_encode($result);
  die();
}

$xtpl = new XTemplate("main.tpl", PATH);
$xtpl->assign('module_name', $module_name);

$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . "/modules/$module_file/template/layout/header.php";
echo $contents;
include NV_ROOTDIR . "/modules/$module_file/template/layout/footer.php";
