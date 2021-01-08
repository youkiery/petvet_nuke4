<?php 

require_once(NV_ROOTDIR . '/ionic/blood.php');
$blood = new Blood();

$from = time() - 60 * 60 * 24 * 30;
$end = time();

$result['status'] = 1;
$result['statistic'] = $blood->statistic($from, $end);

