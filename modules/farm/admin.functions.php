<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate 12/31/2009 2:29
 */

if (! defined('NV_ADMIN') or ! defined('NV_MAINFILE') or ! defined('NV_IS_MODADMIN')) {
    die('Stop!!!');
}

include_once(NV_ROOTDIR . "/modules/". $module_file ."/global.functions.php");

define('NV_IS_ADMIN_MODULE', true);
define('PATH', NV_ROOTDIR . "/modules/". $module_file ."/template/admin/". $op);

function content() {
    global $filter, $db;

    $xtpl = new XTemplate("list.tpl", PATH);
  
    $status = $filter['status'] - 1;
    $query = $db->query("select count(*) as count from `". PREFIX ."_row` where (fullname like '%$filter[keyword]%' or name like '%$filter[keyword]%' or mobile like '%$filter[keyword]%') " . ($status >= 0 ? ' and status = ' . $status : ''));
    $number = $query->fetch()['count'];
  
    $sql = "select * from `". PREFIX ."_row` where (fullname like '%$filter[keyword]%' or name like '%$filter[keyword]%' or mobile like '%$filter[keyword]%') " . ($status >= 0 ? ' and status = ' . $status : '') . " order by status desc, id desc limit $filter[limit] offset " . ($filter['page'] - 1) * $filter['limit'];
    $query = $db->query($sql);
    $index = ($filter['page'] - 1) * $filter['limit'] + 1;

    while ($row = $query->fetch()) {
      $xtpl->assign('index', $index ++);
      $xtpl->assign('id', $row['id']);
      $xtpl->assign('fullname', $row['fullname']);
      $xtpl->assign('name', $row['name']);
      $xtpl->assign('mobile', $row['mobile']);
      $xtpl->assign('address', $row['address']);
      if (!$row['status']) $xtpl->parse('main.row.undone');
      $xtpl->parse('main.row');
    }
    $xtpl->assign('nav', nav_generater('/admin/index.php?language=vi&nv=register&op=happy', $number, $filter['page'], $filter['limit']));
    $xtpl->parse('main');
    return $xtpl->text();
}

function preview($id) {
    global $db;

    $xtpl = new XTemplate("preview.tpl", PATH);
  
    $query = $db->query("select * from `". PREFIX ."_row` where id = " . $id);
    $happy = $query->fetch();

    $images = explode(',', $happy['image']);
    $xtpl->assign('fullname', $happy['fullname']);
    $xtpl->assign('name', $happy['name']);
    $xtpl->assign('species', $happy['species']);
    $xtpl->assign('address', $happy['address']);
    $xtpl->assign('facebook', $happy['facebook']);
    $xtpl->assign('target', $happy['target']);
    $xtpl->assign('note', $happy['note']);
    $xtpl->assign('mobile', $happy['mobile']);

    foreach ($images as $img) {
        $xtpl->assign('image', $img);
        $xtpl->parse('main.img');
    }

    $xtpl->parse('main');
    return $xtpl->text();
}

function modal() {
    $xtpl = new XTemplate("modal.tpl", PATH);
    $xtpl->parse('main');
    return $xtpl->text();
}
