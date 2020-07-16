<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC (contact@vinades.vn)
 * @Copyright (C) 2017 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 04/18/2017 09:47
 */

if (!defined('VAC_PREFIX')) {
  die('Stop!!!');
}

$insultValue = array(-1 => 'Tệ', 0 => 'Hơi tệ', 1 => 'Bình thường', 2 => 'Tốt');
$insultClass = array(-1 => 'btn-danger', 0 => 'btn-warning', 1 => 'btn-info', 2 => 'btn-success');

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
