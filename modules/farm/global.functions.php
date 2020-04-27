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
  