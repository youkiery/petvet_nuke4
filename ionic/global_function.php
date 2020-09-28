<?php
function checkUserId($userid) {
    global $mysqli;
    $sql = 'select * from `pet_users` where userid = '. $userid;
    $query = $mysqli->query($sql);

    if (!empty($user = $query->fetch_assoc())) {
        return $user;
    }
    return false;
}

function checkUserRole($userid) {
    global $mysqli;
    if (!empty(checkUserId($userid))) {
        $sql = 'select * from `pet_petwork_employ` where userid = '. $userid;
        $query = $mysqli->query($sql);
    
        $user = $query->fetch_assoc();
        if ($user['role'] > 1) return true;
    }
    return false;
}

function checkWorkId($workid) {
    global $mysqli;
    $sql = 'select * from `pet_petwork_row` where id = '. $workid;
    $query = $mysqli->query($sql);

    if (!empty($query->fetch_assoc())) return true;
    return false;
}
