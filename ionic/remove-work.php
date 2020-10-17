<?php 

if (empty($_GET['id']) || empty(checkWorkId($_GET['id']))) $result['messenger'] = 'no work exist';
else if (!checkUserRole($userid)) $result['messenger'] = 'no permission allow';
else {
  require_once(NV_ROOTDIR . '/ionic/work.php');
  $work = new Work('petwork');

  $id = $_GET['id'];
  $sql = 'update `pet_petwork_row` set active = 0 where id = '. $id;
  if ($mysqli->query($sql)) {
    $sql = 'insert into `pet_petwork_notify` (userid, action, workid, time) values('. $userid .', 4, '. $id .', '. time() .')';
    $mysqli->query($sql);
    $work->setLastUpdate();

    $result['status'] = 1;
    $result['unread'] = $work->getUserNotifyUnread();
    $result['messenger'] = 'removed work';
  }
}

echo json_encode($result);
die();