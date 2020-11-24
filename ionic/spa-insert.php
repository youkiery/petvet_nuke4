<?php 

require_once(NV_ROOTDIR . '/ionic/spa.php');
$spa = new Spa();

$data = array(
  'customer' => parseGetData('customer', ''),
  'phone' => parseGetData('phone', ''),
  'note' => parseGetData('note', ''),
);

$result['status'] = 1;

$time = time();
// thay đổi thông tin khách
$sql = 'select * from `pet_'. $spa->table .'_customer` where phone = "'. $data['phone'] .'"';
$query = $mysqli->query($sql);
$row = $query->fetch_assoc();

if (empty($row)) {
  // insert khách hàng 
  $sql = 'insert into `pet_'. $spa->table .'_customer` (name, phone, address) values("'. $data['customer'] .'", "'. $data['phone'] .'", "")';
  $mysqli->query($sql);
  $row['id'] = $mysqli->insert_id;
}
else {
  $sql = 'update `pet_'. $spa->table .'_customer` set name = "'. $data['customer'] .'" where phone = "'. $data['phone'] .'"';
  $mysqli->query($sql);
}

$sql = 'insert into `'. $spa->prefix .'` (doctorid, doctor, customerid, note, time, done, payment, image) values('. $userid .', '. $userid .', '. $row['id'] .', "'. $data['note'] .'", '. $time .', 0, 0, "")';
$mysqli->query($sql);
$spa->setLastUpdate($time);