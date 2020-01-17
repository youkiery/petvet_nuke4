<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE') or !defined('NV_IS_MODADMIN')) die('Stop!!!');
define('NV_IS_FILE_ADMIN', true);
define('PATH', NV_ROOTDIR . '/modules/' . $module_file . '/template/admin/' . $op);
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php');
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/theme.php');

function remindList($filter) {
    global $db, $remind_title;

    $filter = parseFilter($filter);
    if (!empty($filter['name'])) $xtra = 'where name = "'. $filter['name'] .'"';

    $xtpl = new XTemplate("remind-list.tpl", PATH);
    $sql = 'select count(*) as number from `'. PREFIX .'remind` '. $xtra;
    $query = $db->query($sql);
    $number = $query->fetch()['number'];

    $sql = 'select * from `'. PREFIX .'remind` '. $xtra .' order by name, id desc limit ' . $filter['limit'] . ' offset ' . ($filter['limit'] * ($filter['page'] - 1));
    $query = $db->query($sql);
    $index = $filter['limit'] * ($filter['page'] - 1) + 1;

    while ($row = $query->fetch()) {
        $xtpl->assign('index', $index++);
        $xtpl->assign('id', $row['id']);
        $xtpl->assign('name', (!empty($remind_title[$row['name']]) ? $remind_title[$row['name']] : ''));
        $xtpl->assign('value', $row['value']);
        if ($row['active']) $xtpl->parse('main.row.yes');
        else $xtpl->parse('main.row.no');
        $xtpl->parse('main.row');
    }
    $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));
    $xtpl->parse('main');
    return $xtpl->text();
}

function remindModal() {
    global $remind_title;
    $xtpl = new XTemplate("modal.tpl", PATH);
    foreach ($remind_title as $key => $value) {
        $xtpl->assign('id', $key);
        $xtpl->assign('name', $value);
        $xtpl->parse('main.name');
    }
    $xtpl->parse('main');
    return $xtpl->text();
}