<?php 

require_once(NV_ROOTDIR . '/ionic/usg.php');
$usg = new Usg();

$filter = array(
  'status' => parseGetData('status', 0)
);

$result['status'] = 1;
$result['data'] = $usg->getList($filter);

echo json_encode($result);
die();
