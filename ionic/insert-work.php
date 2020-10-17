<?php 

if (!checkUserRole($userid)) $result['messenger'] = 'no permission allow';
else {
  require_once(NV_ROOTDIR . '/ionic/work.php');
  $work = new Work('petwork');

  $content = $_GET['content'];
    $cometime = totime($_GET['cometime']);
    $calltime = totime($_GET['calltime']);
    $employ = $_GET['employ'];
    $sql = 'insert into `pet_petwork_row` (cometime, calltime, last_time, post_user, edit_user, userid, depart, customer, content, process, confirm, review, note) value("'. $cometime .'", "'. $calltime .'", '. time() .', '. $userid .', '. $userid .', '. $employ .', 0, 0, "'. $content .'", 0, 0, "", "")';

    if ($mysqli->query($sql)) {
      $id = $mysqli->insert_id;
      $sql = 'insert into `pet_petwork_notify` (userid, action, workid, time) values('. $userid .', 1, '. $id .', '. time() .')';
      $mysqli->query($sql);
      $work->setLastUpdate();

      $result['status'] = 1;
      $result['messenger'] = 'inserted work';
      $result['unread'] = $work->getUserNotifyUnread();
      $userinfo = checkUserId($employ);
      $result['data'] = array(
        'id' => $id,
        'userid' => $employ,
        'name' => (!empty($userinfo['last_name']) ? $userinfo['last_name'] . ' ': '') . $userinfo['first_name'],
        'content' => $content,
        'cometime' => date('d/m/Y', $cometime),
        'calltime' => date('d/m/Y', $calltime),
        'process' => '0',
        'note' => ''
      );
    }
}

echo json_encode($result);
die();