<?php
  $db = new MYSQLI('localhost', 'root', '', 'petcoffee');
  $db->set_charset('UTF8');

  $query = $db->query('select * from pet_formt_notires');
  while ($row = $query->fetch_assoc()) {
    $data = str_replace('THTY-5', 'TYV5-TH', $row['data']);
    // echo "update pet_formt_notires set data = '$data' where id = $row[id] <br>";
    $db->query("update pet_formt_notires set data = '$data' where id = $row[id]");
  }
?>
