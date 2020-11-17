<?php 

require_once(NV_ROOTDIR . '/ionic/vaccine.php');
$vaccine = new Vaccine();

$filter = array(
  'type' => parseGetData('type', ''),
  'value' => parseGetData('value', '')
);

$data = array();

$sql = 'select * from `pet_'. $vaccine->table .'_customer` where '. $filter['type'] .' like "%'. $filter['value'] .'%" limit 20';
$query = $vaccine->db->query($sql);

while ($row = $query->fetch_assoc()) {
  $data []= array(
    'name' => $row['name'],
    'phone' => $row['phone']
  );
}

$result['status'] = 1;
$result['data'] = $data;

echo json_encode($result);
die();
