<?php 

require_once(NV_ROOTDIR . '/ionic/blood.php');
$blood = new Blood();

$result['status'] = 1;
$result['list'] = $blood->getList();
