<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 12/31/2009 0:51
 */

if (!defined('NV_MAINFILE')) {
    die('Stop!!!');
}

define('PREFIX', $db_config['prefix'] . '_' . $module_name);

function getData($id) {
  global $db, $admin_menu_mods;

  $list = array();
  foreach ($admin_menu_mods as $name => $value) {
    $sql = "select * from `". PREFIX ."_row` where name = '$name'";
    $query = $db->query($sql);
    if (empty($query->fetch())) $list[]= $name;
  }

  return $list;
}

function getFullData() {
  global $db;

  $list = array();
  $sql = "select * from `". PREFIX ."_row` where parentid = 0";
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $list[$row['id']] = array(
      'title' => $row['title'],
      'child' => array()
    );

    $sql = "select * from `". PREFIX ."_row` where parentid = $row[id]";
    $query2 = $db->query($sql);
    while ($row2 = $query2->fetch()) {
      $list[$row['id']]['child'] []= $row2['name'];
    }
  }
  
  return $list;
}

function nav_generater($url, $number, $page, $limit) {
    $html = '';
    $total = floor($number / $limit) + ($number % $limit ? 1 : 0);
    for ($i = 1; $i <= $total; $i++) {
      if ($page == $i) {
        $html .= '<a class="btn btn-default">' . $i . '</a>';
      } 
      else {
        $html .= '<a class="btn btn-info" href="'. $url .'&page='. $i .'&limit='. $limit .'">' . $i . '</a>';
      }
    }
    return $html;
}
  