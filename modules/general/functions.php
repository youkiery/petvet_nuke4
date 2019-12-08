<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_SYSTEM')) die('Stop!!!');
define('NV_IS_MOD_CONGVAN', true);
define('PATH', NV_ROOTDIR . '/modules/' . $module_file . '/template/user/' . $op);
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php');

function excelModal() {
    $xtpl = new XTemplate("excel-modal.tpl", PATH);
    $xtpl->parse('main');
    return $xtpl->text();
}

function categoryModal() {
    $xtpl = new XTemplate("category-modal.tpl", PATH);
    $xtpl->parse('main');
    return $xtpl->text();
}

function itemModal() {
    $xtpl = new XTemplate("item-modal.tpl", PATH);
    $xtpl->parse('main');
    return $xtpl->text();
}

function lowitemModal() {
    global $db;
    $xtpl = new XTemplate("lowitem-modal.tpl", PATH);
    $query = $db->query('select * from `'. PREFIX .'category` order by name');

    while ($row = $query->fetch()) {
        $xtpl->assign('id', $row['id']);
        $xtpl->assign('name', $row['name']);
        $xtpl->parse('main.category');
    }
    $xtpl->assign('content', lowitemList());
    $xtpl->parse('main');
    return $xtpl->text();
}

function removeModal() {
    $xtpl = new XTemplate("remove-modal.tpl", PATH);
    $xtpl->parse('main');
    return $xtpl->text();
}

function filterModal() {
    global $db;
    $xtpl = new XTemplate("filter-modal.tpl", PATH);
    $query = $db->query('select * from `'. PREFIX .'category` order by name');

    while ($row = $query->fetch()) {
        $xtpl->assign('id', $row['id']);
        $xtpl->assign('name', $row['name']);
        $xtpl->parse('main.category');
    }
    $xtpl->parse('main');
    return $xtpl->text();
}

function lowitemList() {
    global $db, $nv_Request;

    $filter = $nv_Request->get_array('filter', 'post');
    if (empty($filter['limit'])) $filter['limit'] = 10;
    $xtra = array();
    // $xtra = '';
    if (!empty($filter['category'])) {
        // $xtra = ' and category = ' . $filter['category'];
        $category = implode(', ', $filter['category']);
        foreach ($filter['category'] as $id) {
            $xtra[]= 'category in ('. $category .')';
        }
    }
    
    $index = 1;
    $xtpl = new XTemplate("lowitem-list.tpl", PATH);

    $query = $db->query('select * from `'. PREFIX .'item` where active = 1 and name like "%'. $filter['keyword'] .'%" and ((bound = 0 and number < '. $filter['limit'] .') or (bound > 0 and number <= bound)) '. (count($xtra) ? ' and ' . implode(' or ', $xtra) : '') .' order by time desc');
    // $query = $db->query('select * from `'. PREFIX .'item` where active = 1 and ((bound = 0 and number < '. $filter['limit'] .') or (bound > 0 and number <= bound)) '. $xtra .' order by time desc');
    while ($row = $query->fetch()) {
        $xtpl->assign('index', $index++);
        $xtpl->assign('name', $row['name']);
        $xtpl->assign('category', categoryName($row['category']));
        $xtpl->assign('number', $row['number']);
        $xtpl->assign('limit', $row['limit']);
        $xtpl->parse('main.row');
    }
    
    $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));
    $xtpl->parse('main');
    return $xtpl->text();
}

function itemList() {
    global $db, $nv_Request;

    $filter = $nv_Request->get_array('filter', 'post');
    $xtra = '';
    if (empty($filter['page'])) $filter['page'] = 1;
    if (empty($filter['limit'])) $filter['limit'] = 10;
    if (!empty($filter['category'])) {
        // $xtra = ' and category = ' . $filter['category'];
        $category = implode(', ', $filter['category']);
        foreach ($filter['category'] as $id) {
            $xtra[]= 'category in ('. $category .')';
        }
    }

    $index = ($filter['page'] - 1) * $filter['limit'] + 1;
    $xtpl = new XTemplate("item-list.tpl", PATH);
    $query = $db->query('select count(*) as count from `'. PREFIX .'item` where active = 1 and name like "%'. $filter['keyword'] .'%" ' . $xtra);
    $number = $query->fetch()['count'];

    $query = $db->query('select * from `'. PREFIX .'item` where active = 1 and name like "%'. $filter['keyword'] .'%" '. $xtra .' order by time desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
    while ($row = $query->fetch()) {
        $xtpl->assign('index', $index++);
        $xtpl->assign('id', $row['id']);
        $xtpl->assign('name', $row['name']);
        $xtpl->assign('category', categoryName($row['category']));
        $xtpl->assign('number', $row['number']);
        $xtpl->assign('bound', $row['bound']);
        $xtpl->assign('limit', $row['limit']);
        $xtpl->parse('main.row');
    }
    
    $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));
    $xtpl->parse('main');
    return $xtpl->text();
}
