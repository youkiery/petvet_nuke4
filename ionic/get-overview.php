<?php 

$new_date = strtotime(date('Y/m/d'));
$end_date = $new_date + 60 * 60 * 24 - 1;

$sql = 'select count(id) as number from `pet_petwork_row` where userid = '. $userid .' and process < 100';
$query = $mysqli->query($sql);
$result['work'] = $query->fetch_assoc()['number'];

$sql = 'select count(id) as number from `pet_test_row` where user_id = '. $userid .' and type < 2 and (time between '. $new_date .' and '. $end_date .')';
$query = $mysqli->query($sql);
$result['user_guard'] = boolval($query->fetch_assoc()['number']);
 
$sql = 'select count(id) as number from `pet_test_row` where user_id = '. $userid .' and type > 1 and (time between '. $new_date .' and '. $end_date .')';
$query = $mysqli->query($sql);
$result['user_relax'] = boolval($query->fetch_assoc()['number']);

$list = array();
$sql = 'select user_id from `pet_test_row` where type < 2 and (time between '. $new_date .' and '. $end_date .') group by user_id';
$query = $mysqli->query($sql);
    
while ($row = $query->fetch_assoc()) {
    $user = checkUserId($row['user_id']);
    $list []= $user['first_name'];
}
$result['current_guard'] = implode(', ', $list);

$list = array();
$sql = 'select user_id from `pet_test_row` where type > 1 and (time between '. $new_date .' and '. $end_date .') group by user_id';
$query = $mysqli->query($sql);

while ($row = $query->fetch_assoc()) {
    $user = checkUserId($row['user_id']);
    $list []= $user['first_name'];
}
$result['current_relax'] = implode(', ', $list);

$list = array();
$sql = 'select a.userid, b.username as username, concat(last_name, " ", first_name) as name from `pet_petwork_employ` a inner join `pet_users` b on a.userid = b.userid';
$query = $mysqli->query($sql);

while ($row = $query->fetch_assoc()) {
    $list []= $row;
}
$result['employ'] = $list;

$list = array();
$sql = 'select a.userid, b.username as username, concat(last_name, " ", first_name) as name from `pet_test_user` a inner join `pet_users` b on a.userid = b.userid and a.except = 1';
$query = $mysqli->query($sql);

while ($row = $query->fetch_assoc()) {
    $list []= $row;
}
$result['except'] = $list;

$result['today'] = date('d/m/Y');
$result['status'] = 1;

echo json_encode($result);
die();