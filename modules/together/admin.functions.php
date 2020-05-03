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

function content($id) {
    global $filter, $db;

    $xtpl = new XTemplate("list.tpl", PATH);
  
    $sql = "select * from `". PREFIX ."_row` where parentid = $id order by id desc";
    $query = $db->query($sql);
    $index = 1;

    while ($row = $query->fetch()) {
        $xtpl->assign('index', $index++);
        $xtpl->assign('id', $row['id']);
        $xtpl->assign('name', $row['name']);
        $xtpl->assign('title', $row['title']);
        $xtpl->parse('main.row');
    }
    $xtpl->parse('main');
    return $xtpl->text();
}
