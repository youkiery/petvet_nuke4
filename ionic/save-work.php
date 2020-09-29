<?php 

if (empty($_GET['id']) || empty(checkWorkId($_GET['id']))) $result['messenger'] = 'no work exist';
else {
    $id = $_GET['id'];
    $process = $_GET['process'];
    $note = $_GET['note'];
    $xtra = '';
    if (checkUserRole($userid)) {
        $content = $_GET['content'];
        $xtra = ', content = "' $content . '"';
    }
    $sql = 'update `pet_petwork_row` set process = '. $process .' and note = "'. $note .'" '. $xtra .' where id = '. $id;
    if ($mysqli->query($sql)) {
        $result['status'] = 1;
        $result['messenger'] = 'updated work';
    }
}

echo json_encode($result);
die();