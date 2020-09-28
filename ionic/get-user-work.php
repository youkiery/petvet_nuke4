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
    
    $list = array();
    $sql = 'select id, userid, cometime, calltime, process, content, note from `pet_petwork_row` where userid = '. $userid .' order by calltime';
    $query = $mysqli->query($sql);
    while ($row = $query->fetch_assoc()) {
        $list []= $row;
    }

    $result['list'] = $list;
    $result['status'] = 1;
}

echo json_encode($result);
die();