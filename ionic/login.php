<?php
include_once(NV_ROOTDIR . '/ionic/Encryption.php');

$result = array(
    'status' => 0,
    'messenger' => ''
);

$crypt = new NukeViet\Core\Encryption($sitekey);

if (empty($_GET['username'])) $result['messenger'] = 'empty username';
else if (empty($_GET['username'])) $result['messenger'] = 'empty password';
else {
    $username = mb_strtolower($_GET['username']);
    $password = $_GET['password'];
    $sql = 'select * from `pet_users` where LOWER(username) = "'. $username .'"';
    $query = $mysqli->query($sql);
    $user_info = $query->fetch_assoc();
    if (empty($user_info)) $result['messenger'] = 'username not exist';
    else if (!$crypt->validate_password($password, $user_info['password'])) $result['messenger'] = 'incorrect password';
    else {
        $result['status'] = 1;
        $result['userid'] = $user_info['userid'];
        $result['name'] = (!empty($user_info['last_name']) ? $user_info['last_name'] . ' ': '') . $user_info['first_name'];
        $result['role'] = checkUserRole($user_info['userid']);
        $result['messenger'] = 'login successfully';
    }
}

echo json_encode($result);
die();