<?php 

require_once(NV_ROOTDIR . '/ionic/kaizen.php');
$kaizen = new Kaizen();

$kaizen->setLastRead(time());
$result['status'] = 1;
$result['list'] = $kaizen->getKaizenNotify();
