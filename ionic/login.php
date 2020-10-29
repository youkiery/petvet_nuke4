<?php
include_once(NV_ROOTDIR . '/ionic/Encryption.php');
require_once(NV_ROOTDIR . '/ionic/kaizen.php');
require_once(NV_ROOTDIR . '/ionic/work.php');

$result = array(
    'status' => 0,
    'messenger' => ''
);

$crypt = new NukeViet\Core\Encryption($sitekey);

if (empty($_GET['username'])) $result['messenger'] = 'Tên tài khoản trống';
else if (empty($_GET['username'])) $result['messenger'] = 'Mật khẩu trống';
else {
    $username = mb_strtolower($_GET['username']);
    $password = $_GET['password'];
    $sql = 'select * from `pet_users` where LOWER(username) = "'. $username .'"';
    $query = $mysqli->query($sql);
    $user_info = $query->fetch_assoc();
    if (empty($user_info)) $result['messenger'] = 'Người dùng không tồn tại';
    else if (!$crypt->validate_password($password, $user_info['password'])) $result['messenger'] = 'Sai mật khẩu';
    else {
      $userList = getUserList();

      $list = array();
      $sql = 'select a.userid, b.username as username, concat(last_name, " ", first_name) as name from `pet_test_user` a inner join `pet_users` b on a.userid = b.userid group by userid';
      $query = $mysqli->query($sql);
      while ($row = $query->fetch_assoc()) {
          $list []= $row;
      }
      $result['employ'] = $list;

      $list = array();
      $sql = 'select a.userid, b.username as username, concat(last_name, " ", first_name) as name from `pet_test_user` a inner join `pet_users` b on a.userid = b.userid and a.except = 1';
      $query = $mysqli->query($sql);
      while ($row = $query->fetch_assoc()) {
          $list []= $userList[$row['userid']];
      }
      $result['except'] = $list;

      $list = array();
      $sql = 'select a.userid, b.username as username, concat(last_name, " ", first_name) as name from `pet_test_user` a inner join `pet_users` b on a.userid = b.userid and a.daily = 1';
      $query = $mysqli->query($sql);
      while ($row = $query->fetch_assoc()) {
          $list []= $row;
      }
      $result['daily'] = $list;

      $result['today'] = date('d/m/Y');
      $result['nextweek'] = date('d/m/Y', time() + 60 * 60 * 24 * 7);

      $userid = $user_info['userid'];
      $work = new work('test');
      $kaizen = new Kaizen('test');
      
      $workUnread = $work->getNotifyUnread();
      $kaizenUnread = $kaizen->getNotifyUnread();
      $result['workrole'] = $work->getRole();
      $result['kaizenrole'] = $kaizen->getRole();
      $result['work'] = $workUnread;
      $result['kaizen'] = $kaizenUnread;
      $result['notify'] = $workUnread + $kaizenUnread;
      $result['status'] = 1;
      $result['messenger'] = 'Đăng nhập thành công';
      $result['userid'] = $user_info['userid'];
      $result['username'] = $username;
      $result['password'] = $password;
      $result['name'] = (!empty($user_info['last_name']) ? $user_info['last_name'] . ' ': '') . $user_info['first_name'];
    }
}

echo json_encode($result);
die();