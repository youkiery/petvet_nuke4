<?php 

$result = array(
    'status' => 0,
    'messenger' => ''
);

if (empty($_GET['user']) || empty(checkUserId($_GET['user']))) $result['messenger'] = 'no user';
else {
    $userid = $_GET['user'];
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
    $result['status'] = 1;
}

echo json_encode($result);
die();