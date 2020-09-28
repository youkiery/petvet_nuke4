<?php 

$result = array(
    'status' => 0,
    'messenger' => ''
);

if (empty($_GET['id']) || empty(checkWorkId($_GET['id']))) $result['messenger'] = 'no work exist';
else if (empty($_GET['userid']) || empty(checkUserRole($_GET['userid']))) $result['messenger'] = 'no permission allow';
else {
    $id = $_GET['id'];
    $userid = $_GET['userid'];
    $sql = 'delete from from `pet_petwork_row` where id = '. $id;
    if ($mysqli->query($sql)) {
        $result['status'] = 1;
        $result['messenger'] = 'removed work';
    }
}

echo json_encode($result);
die();