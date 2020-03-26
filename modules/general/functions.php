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

function bloodInsertModal() {
    global $db, $db_config, $user_info, $remind_title;

    $xtpl = new XTemplate("insert-modal.tpl", PATH);
    $last = checkLastBlood();
    $query = $db->query('select a.user_id, b.first_name from `'. $db_config['prefix'] .'_rider_user` a inner join `'. $db_config['prefix'] .'_users` b on a.user_id = b.userid where a.type = 1');
    $xtpl->assign('today', date('d/m/Y'));
    $xtpl->assign('last', $last);
    $xtpl->assign('nextlast', $last - 1);

    while ($row = $query->fetch()) {
        $xtpl->assign('id', $row['user_id']);
        $xtpl->assign('name', $row['first_name']);
        if ($row['user_id'] == $user_info['userid']) $xtpl->assign('selected', 'selected');
        else $xtpl->assign('selected', '');
        $xtpl->parse('main.doctor');
    }
    $xtpl->parse('main');
    return $xtpl->text();
}

function bloodImportModal() {
    global $db;

    $xtpl = new XTemplate("import-modal.tpl", PATH);
    $xtpl->assign('today', date('d/m/Y'));
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
    $xtra = '';
    if (!empty($filter['category'])) {
        // $xtra = ' and category = ' . $filter['category'];
        $category = implode(', ', $filter['category']);
        $xtra= 'and category in ('. $category .')';
    }
    
    $index = 1;
    $xtpl = new XTemplate("lowitem-list.tpl", PATH);

    $query = $db->query('select * from `'. PREFIX .'item` where active = 1 and name like "%'. $filter['keyword'] .'%" and ((bound = 0 and number < '. $filter['limit'] .') or (bound > 0 and number <= bound)) '. $xtra .' order by time desc');
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

function bloodList() {
    global $db, $nv_Request, $type, $db_config;
    $xtpl = new XTemplate("blood-list.tpl", PATH);
    $filter = $nv_Request->get_array('filter', 'post');
    if ($type == 1) {
        $xtpl->assign('show', 'hide');
    }

    if (empty($filter['page'])) {
        $filter['page'] = 1;
    }
    if (empty($filter['limit'])) {
        $filter['limit'] = 10;
    }

    $xtra = '';
    if (!empty($filter['type'])) {
        $xtra = 'where type in ('. implode(', ', $filter['type']) .')';
    }

    $target = array();
    $sql = 'select * from `'. PREFIX .'remind` where name = "blood" order by id';
    $query = $db->query($sql);

    while ($row = $query->fetch()) {
        $target[$row['id']] = $row['value'];
    }

    $query = $db->query('select count(*) as num from ((select id, time, 0 as type, number from `'. PREFIX .'blood_row`) union (select id, time, 1 as type, number from `'. PREFIX .'blood_import`)) a '. $xtra);
    $number = $query->fetch()['num'];

    $query = $db->query('select * from ((select id, time, 0 as type, number, doctor, target from `'. PREFIX .'blood_row`) union (select id, time, 1 as type, number, doctor, 0 as target from `'. PREFIX .'blood_import`)) a '. $xtra .' order by time desc, id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit']);
    $index = ($filter['page'] - 1) * $filter['limit'] + 1;
    while ($row = $query->fetch()) {
        $sql = 'select * from `'. $db_config['prefix'] .'_users` where userid = ' . $row['doctor'];
        $user_query = $db->query($sql);
        $user = $user_query->fetch();

        $xtpl->assign('index', $index++);
        $xtpl->assign('time', date('d-m-Y', $row['time']));
        $xtpl->assign('target', (!empty($target[$row['target']]) ? $target[$row['target']] : ''));
        $xtpl->assign('number', $row['number']);
        $xtpl->assign('id', $row['id']);
        $xtpl->assign('typeid', $row['type']);
        $xtpl->assign('doctor', (!empty($user['first_name']) ? $user['first_name'] : ''));
        if ($row['type']) $xtpl->assign('type', 'Phiếu nhập');
        else $xtpl->assign('type', 'Phiếu xét nghiệm');
        if ($type == 2) {
            $xtpl->parse('main.row.test');
        }
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
        $xtra= 'and category in ('. $category .')';
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
        $xtpl->assign('number2', $row['number2']);
        $xtpl->assign('bound', $row['bound']);
        $xtpl->assign('limit', $row['limit']);
        $xtpl->parse('main.row');
    }
    
    $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));
    $xtpl->parse('main');
    return $xtpl->text();
}

function bloodModal() {
    $xtpl = new XTemplate("modal.tpl", PATH);
    $xtpl->assign('statistic_content', bloodStatistic());

    $time = strtotime(date('Y/m/d'));
    // $time = strtotime(date('8/8/2019'));
    $filter['from'] = $time - 60 * 60 * 24 * 15;
    $filter['end'] = $time + 60 * 60 * 24 * 15;

    $xtpl->assign('from', date('d/m/Y', $filter['from']));
    $xtpl->assign('end', date('d/m/Y', $filter['end']));

    $xtpl->parse('main');
    return $xtpl->text();
}

// function productList($url, $filter = array('page' => 1, 'limit' => 10, 'brand' => 1)) {
//     global $db;

//     $xtpl = new XTemplate("product-list.tpl", PATH);
//     $sql = 'select count(*) as count from `'. PREFIX .'brand_product` where brandid = '. $filter['brand'];
//     $query = $db->query($sql);
//     $number = $query->fetch()['count'];

//     $sql = 'select * from `'. PREFIX .'brand_product` where brandid = '. $filter['brand'] .' limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];

//     $query = $db->query($sql);
//     $index = ($filter['page'] - 1) * $filter['limit'] + 1;
    
//     while ($row = $query->fetch()) {
//         $sql = 'select * from `'. PREFIX .'product` where id = '. $row['productid'];
//         $query = $db->query($sql);
//         $product = $query->fetch();

//         $sql = 'select * from `'. PREFIX .'product_category` where id = '. $product['category'];
//         $query = $db->query($sql);
//         $category = $query->fetch();

//         $xtpl->assign('index', $index++);
//         $xtpl->assign('category', $category['name']);
//         $xtpl->assign('item', $product['name']);
//         $xtpl->assign('number', $row['number']);
//         $xtpl->parse('main.row');
//     }
//     $xtpl->assign('nav', nv_generate_page_shop($url, $number, $filter['limit'], $filter['page']));
//     $xtpl->parse('main');
//     return $xtpl->text();
// }

function productCategory() {
    global $db;
    $sql = 'select * from `'. PREFIX .'product_category` order by id';
    $query = $db->query($sql);
    $list = array();

    while ($row = $query->fetch()) {
        $list[$row['id']] = $row['name'];
    }
    return $list;
}

function productList($url, $filter) {
    global $db;
    $category = productCategory();

    $xtpl = new XTemplate("list.tpl", PATH);
    $sql = 'select count(*) as count from `'. PREFIX .'product` where (code like "%'. $filter['keyword'] .'%" or name like "%'. $filter['keyword'] .'%") ' . (intval($filter['category']) ? 'and category = ' . $filter['category'] : '');
    $query = $db->query($sql);
    $number = $query->fetch()['count'];

    $sql = 'select * from `'. PREFIX .'product` where (code like "%'. $filter['keyword'] .'%" or name like "%'. $filter['keyword'] .'%") ' . (intval($filter['category']) ? 'and category = ' . $filter['category'] : '') . ' order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];

    $query = $db->query($sql);
    $index = ($filter['page'] - 1) * $filter['limit'] + 1;
   
    while ($row = $query->fetch()) {
        $xtpl->assign('index', $index++);
        $xtpl->assign('id', $row['id']);
        $xtpl->assign('name', $row['name']);
        $xtpl->assign('code', $row['code']);
        $xtpl->assign('categoryid', $row['category']);
        $xtpl->assign('category', $category[$row['category']]);
        $xtpl->parse('main.row');
    }
    $xtpl->assign('nav', nav_generater($url, $number, $filter['page'], $filter['limit']));
    $xtpl->parse('main');
    return $xtpl->text();
}

function productModal() {
    $xtpl = new XTemplate("modal.tpl", PATH);
    $category = productCategory();
    foreach ($category as $id => $name) {
        $xtpl->assign('id', $id);
        $xtpl->assign('name', $name);
        $xtpl->assign('check', '');
        if ($filter['category'] == $id) $xtpl->assign('check', 'selected');
        $xtpl->parse('main.category');
    }
    $xtpl->parse('main');
    return $xtpl->text();
}

function marketModal() {
    $xtpl = new XTemplate("modal.tpl", PATH);
    $xtpl->parse('main');
    return $xtpl->text();
}

function marketContent($filter) {
    global $db;

    // $xtpl = new XTemplate("list.tpl", PATH);
    // $sql = 'select count(*) as number from `'. PREFIX .'remind` '. $xtra;
    // $query = $db->query($sql);
    // $number = $query->fetch()['number'];

    // $sql = 'select * from `'. PREFIX .'remind` '. $xtra .' order by name, id desc limit ' . $filter['limit'] . ' offset ' . ($filter['limit'] * ($filter['page'] - 1));
    // $query = $db->query($sql);
    // $index = $filter['limit'] * ($filter['page'] - 1) + 1;

    // while ($row = $query->fetch()) {
    //     $xtpl->assign('index', $index++);
    //     $xtpl->assign('id', $row['id']);
    //     $xtpl->assign('name', (!empty($remind_title[$row['name']]) ? $remind_title[$row['name']] : ''));
    //     $xtpl->assign('value', $row['value']);
    //     if ($row['active']) $xtpl->parse('main.row.yes');
    //     else $xtpl->parse('main.row.no');
    //     $xtpl->parse('main.row');
    // }
    // $xtpl->assign('nav', navList($number, $filter['page'], $filter['limit'], 'goPage'));
    // $xtpl->parse('main');
    // return $xtpl->text();
}

function priceContent($filter = array('page' => 1, 'limit' => 20)) {
    global $db, $allow;
    $xtpl = new XTemplate("list.tpl", PATH);
    $index = ($filter['page'] - 1) * $filter['limit'] + 1;
    $category = priceCategoryList();

    $sql = 'select count(*) as count from `'. PREFIX .'price_item` where (name like "%'. $filter['keyword'] .'%" or code like "%'. $filter['keyword'] .'%") '. ($filter['category'] ? 'and category = ' . $filter['category'] : '');
    $query = $db->query($sql);
    $number = $query->fetch()['count'];

    $sql = 'select * from `'. PREFIX .'price_item` where (name like "%'. $filter['keyword'] .'%" or code like "%'. $filter['keyword'] .'%") '. ($filter['category'] ? 'and category = ' . $filter['category'] : '') .' limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
    $query = $db->query($sql);

    if (!empty($allow)) $xtpl->parse('main.m1');
    while ($item = $query->fetch()) {
        $detailList = priceItemDetail($item['id']);
        $count = count($detailList);
        $xtpl->assign('row', $count + 1);
        $xtpl->assign('index', $index ++);
        $xtpl->assign('id', $item['id']);
        $xtpl->assign('code', $item['code']);
        $xtpl->assign('name', $item['name']);
        $xtpl->assign('category', $category[$item['category']]['name']);

        foreach ($detailList as $key => $detail) {
            $xtpl->assign('price', number_format($detail['price'], 0, '', ','));
            if (!empty($detail['number'])) {
                $xtpl->assign('number', $detail['number']);
                $xtpl->parse('main.row.section.p2');
            }
            else $xtpl->parse('main.row.section.p1');
            $xtpl->parse('main.row.section');
        }

        if (!empty($allow)) {
            $xtpl->parse('main.row.m2');
        }
        $xtpl->parse('main.row');
    }
    $xtpl->assign('nav', nav_generater('/admin/index.php?nv='. $module_name .'&op='. $op, $number, $filter['page'], $filter['limit']));
    $xtpl->parse('main');
    return $xtpl->text();
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
