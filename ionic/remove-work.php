<?php 

if (empty($_GET['id']) || empty(checkWorkId($_GET['id']))) $result['messenger'] = 'no work exist';
else if (!checkUserRole($userid)) $result['messenger'] = 'no permission allow';
else {
    $id = $_GET['id'];
    $sql = 'delete from `pet_petwork_row` where id = '. $id;
    if ($mysqli->query($sql)) {
        $result['status'] = 1;
        $result['messenger'] = 'removed work';
    }
}

echo json_encode($result);
die();