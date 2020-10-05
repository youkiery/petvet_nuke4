<?php 

if (!checkUserRole($userid)) $result['messenger'] = 'no permission allow';
else {
    $content = $_GET['content'];
    $cometime = $_GET['cometime'];
    $calltime = $_GET['calltime'];
    $sql = 'insert into `pet_petwork_row` (cometime, calltime, last_time, post_user, edit_user, userid, depart, customer, content, process, confirm, review, note) value("'. totime($cometime) .'", "'. totime($calltime) .'", '. time() .', '. $userid .', '. $userid .', '. $userid .', 0, 0, "'. $content .'", 0, 0, "", "")';
    if ($mysqli->query($sql)) {
        $result['status'] = 1;
        $result['id'] = $mysqli->insert_id;
        $result['messenger'] = 'inserted work';
    }
}

echo json_encode($result);
die();