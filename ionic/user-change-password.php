<?php
include_once(NV_ROOTDIR . '/ionic/Encryption.php');

$crypt = new NukeViet\Core\Encryption($sitekey);

if (empty($_GET['old'])) $result['messenger'] = 'empty username';
else if (empty($_GET['new'])) $result['messenger'] = 'empty username';
else {
    $old = $_GET['old'];
    $new = $_GET['new'];

    $sql = 'select * from `pet_users` where userid = '. $userid;
    $query = $mysqli->query($sql);
    $user_info = $query->fetch_assoc();

    if (empty($user_info)) $result['messenger'] = 'user not exist';
    else if (!$crypt->validate_password($old, $user_info['password'])) $result['messenger'] = 'Incorrect old password';
    else {
      $password = $crypt->hash_password($new, '{SSHA512}');
      $sql = 'update `pet_users` set password = "'. $password .'" where userid = '. $userid;
      $mysqli->query($sql);
      $result['status'] = 1;
      $result['messenger'] = 'Change password successfully';
    }
}

echo json_encode($result);
die();