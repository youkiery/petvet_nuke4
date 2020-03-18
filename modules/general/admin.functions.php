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

function priceCategoryList() {
    global $db;

    $sql = 'select * from `'. PREFIX .'price_category`';
    $query = $db->query($sql);
    $list = array();

    while ($row = $query->fetch()) {
        $list[$row['id']] = $row;
    }
    return $list;
}

function priceContent($filter = array('page' => 1, 'limit' => 20)) {
    global $db;
    $xtpl = new XTemplate("list.tpl", PATH);
    $index = ($filter['page'] - 1) * $filter['limit'] + 1;
    $category = priceCategoryList();

    $sql = 'select count(*) as count from `'. PREFIX .'price_item` where (name like "%'. $filter['keyword'] .'%" or code like "%'. $filter['keyword'] .'%") '. ($filter['category'] ? 'and category = ' . $filter['category'] : '');
    $query = $db->query($sql);
    $number = $query->fetch()['count'];

    $sql = 'select * from `'. PREFIX .'price_item` where (name like "%'. $filter['keyword'] .'%" or code like "%'. $filter['keyword'] .'%") '. ($filter['category'] ? 'and category = ' . $filter['category'] : '') .' limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
    $query = $db->query($sql);

    while ($item = $query->fetch()) {
        $detailList = priceItemDetail($item['id']);
        $count = count($detailList);
        $xtpl->assign('index', $index ++);
        $xtpl->assign('row', $count + 1);
        $xtpl->assign('id', $item['id']);
        $xtpl->assign('code', $item['code']);
        $xtpl->assign('name', $item['name']);
        $xtpl->assign('category', $category[$item['category']]['name']);

        foreach ($detailList as $detail) {
            $xtpl->assign('price', number_format($detail['price'], 0, '', ','));
            $xtpl->assign('number', $detail['number']);
            if ($count == 1 && $detail['number'] == 0) $xtpl->parse('main.row.section.p1');
            else $xtpl->parse('main.row.section.p2');
            $xtpl->parse('main.row.section');
        }
        $xtpl->parse('main.row');
    }
    $xtpl->assign('nav', nav_generater('/admin/index.php?nv='. $module_name .'&op='. $op, $number, $filter['page'], $filter['limit']));
    $xtpl->parse('main');
    return $xtpl->text();
}

function priceItemDetail($id) {
    global $db;
    $sql = 'select * from `'. PREFIX .'price_detail` where itemid = ' . $id . ' order by number';
    $query = $db->query($sql);
    $list = array();

    while ($row = $query->fetch()) {
        $list[]= $row;
    }
    return $list;
}

function priceCategoryContent() {
    $xtpl = new XTemplate("category-list.tpl", PATH);
    $list = priceCategoryList();
    $index = 1;

    foreach ($list as $category) {
        $xtpl->assign('index', $index ++);
        $xtpl->assign('id', $category['id']);
        $xtpl->assign('name', $category['name']);
        $xtpl->assign('active', ($category['active'] ? 'warning' : 'info'));
        $xtpl->parse('main.row');
    }
    $xtpl->parse('main');
    return $xtpl->text();
}

function priceModal() {
    $xtpl = new XTemplate("modal.tpl", PATH);
    $xtpl->assign('category_option', priceCategoryOption());
    $xtpl->assign('category_content', priceCategoryContent());
    $xtpl->parse('main');
    return $xtpl->text();
}

function priceCategoryOption($categoryid = 0) {
    $list = priceCategoryList();
    $html = '';

    foreach ($list as $category) {
        $check = '';
        if ($categoryid == $category['id']) $check = 'selected';
        $html .= '<option value="'. $category['id'] .'" '. $check .'>' . $category['name'] . '</option>';
    }
    return $html;
}
