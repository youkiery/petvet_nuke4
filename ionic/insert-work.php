<?php 

if (empty($_GET['id']) || empty(checkWorkId($_GET['id']))) $result['messenger'] = 'no work exist';
else if (empty(checkUserRole($userid))) $result['messenger'] = 'no permission allow';
else {
    $id = $_GET['id'];
    $content = $_GET['content'];
    $process = $_GET['process'];
    $note = $_GET['note'];
    $sql = 'insert into `pet_petwork_row`';
    if ($mysqli->query($sql)) {
        $result['status'] = 1;
        $result['messenger'] = 'removed work';
    }
}

echo json_encode($result);
die();