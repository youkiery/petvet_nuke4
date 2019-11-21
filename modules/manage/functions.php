<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_SYSTEM')) die('Stop!!!');
define('NV_IS_MOD_CONGVAN', true);
define('PATH', NV_ROOTDIR . "/modules/". $module_file ."/template/" . $op);
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php');

function checkMember() {
  global $db, $user_info, $op;

  if (empty($user_info)) {
    $content = 'Xin hãy đăng nhập trước khi sử dụng chức năng này';
  }
  else {
    $query = $db->query('select * from `'. PREFIX .'member` where userid = '. $user_info['userid']);
    $user = $query->fetch();
    $authors = json_decode($user['author']);
    if ($op == 'device' && $authors->{device}) {
      // ok
    }
    else if ($op == 'material' && $authors->{material}) {
      // ok
    }
    else if ($op == 'main' && ($authors->{device} || $authors->{material})) {
      // ok
    }
    else {
      // prevent
      $content = 'Tài khoản không có quyền truy cập';
    }
  }
  if ($content) {
    include NV_ROOTDIR . '/includes/header.php';
    echo nv_site_theme($content);
    include NV_ROOTDIR . '/includes/footer.php';
  }
}
