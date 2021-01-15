<?php 

require_once(NV_ROOTDIR . '/ionic/blood.php');
$blood = new Blood();

$filter = array(
  'page' => parseGetData('page', 1)
);

$result['status'] = 1;
$result['list'] = $blood->initList();
