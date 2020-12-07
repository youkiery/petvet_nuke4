<?php
require_once(NV_ROOTDIR . '/ionic/ride.php');
$ride = new Ride();

$id = parseGetData('id', 0);
$sql = "delete from `" . $ride->prefix . "` where id = " . $id;

$ride->db->query($sql);
$result['status'] = 1;

