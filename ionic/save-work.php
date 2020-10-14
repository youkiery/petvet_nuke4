<?php 

if (empty($_GET['id']) || empty(checkWorkId($_GET['id']))) $result['messenger'] = 'no work exist';
else {
  require_once(NV_ROOTDIR . '/ionic/work.php');
  $work = new Work('petwork');

  $id = $_GET['id'];
  $process = intval($_GET['process']);
  $note = $_GET['note'];
  $xtra = '';
  if (checkUserRole($userid)) {
      $content = $_GET['content'];
      $xtra = ', content = "'. $content . '"';
  }
  $sql = 'update `pet_petwork_row` set process = '. $process .', note = "'. $note .'" '. $xtra .' where id = '. $id;
  if ($mysqli->query($sql)) {
    if ($process < 100)  $sql = 'insert into `pet_petwork_notify` (userid, action, workid, time) values('. $userid .', 2, '. $id .', '. time() .')';
      else $sql = 'insert into `pet_petwork_notify` (userid, action, workid, time) values('. $userid .', 3, '. $id .', '. time() .')';
      $mysqli->query($sql);

      $result['status'] = 1;
      $result['unread'] = $work->getUserNotifyUnread();
      $result['messenger'] = 'updated work';
    }
}

echo json_encode($result);
die();