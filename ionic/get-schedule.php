<?php 

if (empty($_GET['time'])) $result['messenger'] = 'no time';
else if (!($time = totime($_GET['time']))) $result['messenger'] = 'time syntax error';
else {
    $aday = 60 * 60 * 24;
    if (date("N", $time) == 1) $this_week = $time - date("N", $time) * $aday;
    else $this_week = strtotime('last monday', $time);

    $next_week = $this_week + $aday * 7 - 1;
    $user = getUserList();

    $data = array();
    $day = array();
    $sql = 'select * from `pet_test_row` where type > 0 and (time between ' . $this_week . ' and '. $next_week . ')';
    $query = $mysqli->query($sql);

    $count = $this_week;
    while ($count < $next_week) {
        $day [date('N', $count)]= date('d/m/Y', $count);
        $count += $aday;
    }

    while ($row = $query->fetch_assoc()) {
        $date = date('N', $row['time']);
        if (empty($data[$row['type']])) $data[$row['type']] = array();
        if (empty($data[$row['type']][$date])) $data[$row['type']][$date] = array();
        $data[$row['type']][$date][] = $user[$row['user_id']];
    }
}

$result['status'] = 1;
$result['schedule'] = $data;
$result['day'] = $day;

echo json_encode($result);
die();