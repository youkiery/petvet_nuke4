<?php

/**
* @Project Block Test
* @Author DANGDINHTU (dlinhvan@gmail.com)
* @Copyright (C) 2014 Webdep24.com
* @Createdate 16:58 11/11/2014
*/

if (!defined('NV_MAINFILE')) {
  die( 'Stop!!!' );
}

$lang["vac_title"] = "Thêm khách tiêm phòng";
$lang["vaclist_title"] = "Danh sách nhắc tiêm phòng";
$lang["usg_title"] = "Thêm khách siêu âm";
$lang["usglist_title"] = "Danh sách nhắc siêu âm";
$lang["usgbirth_title"] = "Danh sách thú sơ sinh";
$lang["treat_title"] = "Thêm khách lưu bệnh";
$lang["treatlist_title"] = "Danh sách lưu bệnh";
$lang["spa_title"] = "Danh sách Spa ngày";
$lang["redrug_title"] = "Quản lý tẩy KST";

$xtpl = new XTemplate("block_menu.tpl", NV_ROOTDIR . "/themes/" . $global_config['site_theme'] . "/modules/" . $module_file);
$nv = $module_name;
$module_base_url = "/" . $nv . "/" ;
$link = array();

if (!empty($user_info)) {
  $permist = array("main" => "1, 16, 18", "list" => "1, 16, 18", "sieuam" => "1, 16, 19", "danhsachsieuam" => "1, 16, 19", "sieuam-birth" => "1, 16, 19", "luubenh" => "1, 16, 21", "danhsachluubenh" => "1, 16, 21", "spa" => "1, 16, 20", "redrug" => "1, 16, 22");

  $link = array(
    array(
      "func" => "main",
      "title" => "vac_title"
    ),
    array(
      "func" => "list",
      "title" => "vaclist_title"
    ),
    array(
      "func" => "sieuam",
      "title" => "usg_title"
    ),
    array(
      "func" => "danhsachsieuam",
      "title" => "usglist_title"
    ),
    array(
      "func" => "sieuam-birth",
      "title" => "usgbirth_title"
    ),
    array(
      "func" => "luubenh",
      "title" => "treat_title"
    ),
    array(
      "func" => "danhsachluubenh",
      "title" => "treatlist_title"
    ),
    array(
      "func" => "spa",
      "title" => "spa_title"
    ),
    array(
      "func" => "redrug",
      "title" => "redrug_title"
    )
  );


  $index = 0;
  foreach ($permist as $key => $value) {
    $sql = "select * from `" . $db_config['prefix'] . "_users_groups_users` where userid = $user_info[userid] and group_id in ($value)";
    $query = $db->query($sql);
    $group = $query->fetch();
    if (!empty($group)) {
      $link_s = $module_base_url . $link[$index]["func"];
      $title = $lang[$link[$index]["title"]];
      $xtpl->assign("link", $link_s);
      $xtpl->assign("title", $title);
      $xtpl->parse("main.list");
    }
    $index ++;
  }
}

$xtpl->parse("main");
$content = $xtpl->text();
