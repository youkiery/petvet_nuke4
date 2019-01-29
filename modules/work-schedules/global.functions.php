<?php

/**
 * @Project WORK SCHEDULES 4.X
 * @Author PHAN TAN DUNG (phantandung92@gmail.com)
 * @Copyright (C) 2016 PHAN TAN DUNG. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Sat, 11 Jun 2016 23:45:51 GMT
 */

if (!defined('NV_MAINFILE')) {
    die('Stop!!!');
}

// $sort_option = array(
//     1 => "time asc"
// );
$m_name = str_replace("-", "_", $module_name);
define('WORK_PREFIX', $db_config['prefix'] . "_" . $m_name);

function depart_list() {
    global $db, $global_config, $module_file, $module_name, $lang_module;
    // initial
    $xtpl = new XTemplate('depart-list.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
    $base_url = NV_BASE_ADMINURL . "index.php?language=vi&nv=" . $module_name . "&op=depart-employ";
    $xtpl->assign('lang', $lang_module);
    $index = 1;

    $sql = "select * from `" . WORK_PREFIX . "_depart` order by id";
    $depart_query = $db->query($sql);
    $list = fetchall($depart_query);

    foreach ($list as $depart) {
        $xtpl->assign("index", $index);
        $xtpl->assign("id", $depart["id"]);
        $xtpl->assign("name", $depart["name"]);
        $xtpl->assign("link", $base_url . "&id=" . $depart["id"]);
        $xtpl->parse('main');
        $index ++;
    }

    return $xtpl->text();
}

function depart_employ_list() {
    global $db, $nv_Request, $global_config, $module_file, $module_name, $lang_module;
    // initial
    $xtpl = new XTemplate('depart-employ-list.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
    $base_url = NV_BASE_ADMINURL . "index.php?language=vi&nv=" . $module_name . "&op=depart-employ";
    $index = 1;
    $id = $nv_Request->get_int("id", "get/post", 1);
    $depart = get_depart_list();
    $xtpl->assign('lang', $lang_module);
    $role = array("Chờ kích hoạt", "Thành viên", "Trưởng nhóm");

    $sql = "select * from `" . WORK_PREFIX . "_employ` where depart = $id";
    $employ_query = $db->query($sql);
    $list = fetchall($employ_query);

    foreach ($list as $employ) {
        // name, role
        $xtpl->assign("index", $index);
        $xtpl->assign("id", $employ["userid"]);
        $xtpl->assign("name", $employ["name"]);
        $xtpl->assign("role", $role[$employ["role"]]);
        $xtpl->parse('main');
        $index ++;
    }

    return $xtpl->text();
}

function search_depart($list) {
    global $db, $global_config, $module_file, $module_name, $lang_module;
    // initial
    $xtpl = new XTemplate('depart-employ-search.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
    $base_url = NV_BASE_ADMINURL . "index.php?language=vi&nv=" . $module_name . "&op=depart-employ";
    $index = 1;
    $xtpl->assign("lang", $lang_module);

    foreach ($list as $depart) {
        $xtpl->assign("index", $index);
        $xtpl->assign("id", $depart["userid"]);
        $xtpl->assign("name", $depart["last_name"] . " " . $depart["first_name"]);
        $xtpl->parse("main");
        $index ++;
    }
    return $xtpl->text();
}

function get_depart_list() {
    global $db;
    $sql = "select * from `" . WORK_PREFIX . "_depart`";
    $depart_query = $db->query($sql);
    $list = array();
    while ($depart = $depart_query->fetch()) {
        $list[$depart["id"]] = $depart;
    }
    return $list;
}

function employ_list() {
    global $db, $lang_module, $global_config, $module_file, $db_config;
    $xtpl = new XTemplate('employ-list.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
    $index = 1;
    $xtpl->assign("lang", $lang_module);
        
    $sql = "select * from `" .  WORK_PREFIX . "_depart`";
    $query = $db->query($sql);
    $depart_list = array();
    while ($row = $query->fetch()) {
        $depart_list[$row["id"]] = $row["name"];
    }

    $sql = "select * from `" .  WORK_PREFIX . "_employ` group by userid order by userid";
    $query = $db->query($sql);
    while ($employ = $query->fetch()) {
        $sql = "select * from `" . $db_config["prefix"] . "_users` where userid = $employ[userid]";
        $user_query = $db->query($sql);
        $user = $user_query->fetch();

        $sql = "select * from `" . WORK_PREFIX . "_employ` where userid = $employ[userid]";
        $employ_query = $db->query($sql);
        $depart = array();
        while ($depart_employ = $employ_query->fetch()) {
            $depart[] = $depart_list[$depart_employ["depart"]];
        }
        $xtpl->assign("index", $index);
        $xtpl->assign("id", $employ["userid"]);
        $xtpl->assign("name", $user["username"]);
        $xtpl->assign("roles", implode(", ", $depart));
        $xtpl->parse("main");
        $index ++;
    }
    return $xtpl->text();
}

// function work_list() {
//     global $db, $global_config, $module_file, $lang_module, $nv_Request;
//     $xtpl = new XTemplate('work-list.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
//     $index = 1;
//     $xtpl->assign('lang', $lang_module);
//     $sort = $nv_Request->get_string("sort", "get/post", "");
//     $work_from = $nv_Request->get_string("work-from", "get/post", "");
//     $work_end = $nv_Request->get_string("work-end", "get/post", "");
//     $where = "";

//     // if (empty($sort)) {
//     //     $sort_type = ""
//     // }

//     $time = 0;
//     if (!empty($work_from)) {
//         $time += 1;
//     }
//     if (!empty($work_end)) {
//         $time += 2;
//     }
//     switch ($time) {
//         case '1':
//             $where = ""
//         break;
//         default:
//         break;
//     }

//     $sql = "select * from `" . WORK_PREFIX . "_work`";
//     $query = $db->query($sql);
//     while ($custom = $query->fetch()) {
//         $xtpl->assign("index", $index);
//         $xtpl->assign("id", $custom["id"]);
//         $xtpl->assign("name", $custom["name"]);
//         $xtpl->assign("index", $custom["address"]);
//         $xtpl->parse('main');
//         $index ++;
//     }

//     return $xtpl->text();
// }

function customer_list() {
    global $db, $global_config, $module_file, $lang_module;
    $xtpl = new XTemplate('customer-list.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
    $index = 1;
    $xtpl->assign('lang', $lang_module);

    $sql = "select * from `" . WORK_PREFIX . "_customer`";
    $query = $db->query($sql);
    while ($custom = $query->fetch()) {
        $xtpl->assign("index", $index);
        $xtpl->assign("id", $custom["id"]);
        $xtpl->assign("name", $custom["name"]);
        $xtpl->assign("index", $custom["address"]);
        $xtpl->parse('main');
        $index ++;
    }

    return $xtpl->text();
}

$global_array_show_type = array('week', 'all');

if ($module_config[$module_name]['auto_delete'] and (empty($module_config[$module_name]['cron_next_check']) or $module_config[$module_name]['cron_next_check'] <= NV_CURRENTTIME)) {
    // Xóa lịch
    $db->query('DELETE FROM ' . NV_PREFIXLANG . '_' . $module_data . '_rows WHERE e_time<' . (NV_CURRENTTIME - $module_config[$module_name]['auto_delete_time']));
    
    // Cập nhật CRON
    $config_name = 'cron_next_check';
    $config_value = NV_CURRENTTIME + $module_config[$module_name]['cron_interval'];
    
    try {
        $sql = 'UPDATE ' . NV_CONFIG_GLOBALTABLE . ' SET config_value=:config_value 
        WHERE lang=' . $db->quote(NV_LANG_DATA) . ' AND module=' . $db->quote($module_name) . ' AND config_name=:config_name';
        $sth = $db->prepare($sql);
        $sth->bindParam(':config_value', $config_value, PDO::PARAM_STR);
        $sth->bindParam(':config_name', $config_name, PDO::PARAM_STR);
        $sth->execute();
    } catch (PDOException $e) {
        trigger_error("Error set work-schedules config CRONS!!!", 256);
    }
    
    $nv_Cache->delMod('settings');
    $nv_Cache->delMod($module_name);
    unset($config_name, $config_value);
}

/**
 * nv_get_week_from_time()
 * 
 * @param mixed $time
 * @return
 */
function nv_get_week_from_time($time)
{
    $week = 1;
    $year = date('Y', $time);
    $real_week = array($week, $year);
    
    $time_per_week = 86400 * 7;
    $time_start_year = mktime(0, 0, 0, 1, 1, $year);
    $time_first_week = $time_start_year - (86400 * (date('N', $time_start_year) - 1));
    
    $addYear = true;
    $num_week_loop = nv_get_max_week_of_year($year) - 1;
    
    for ($i = 0; $i <= $num_week_loop; $i++) {
        $week_begin = $time_first_week + $i * $time_per_week;
        $week_next = $week_begin + $time_per_week;
    
        if ($week_begin <= $time and $week_next > $time) {
            $real_week[0] = $i + 1;
            $addYear = false;
            break;
        }
    }
    if ($addYear) {
        $real_week[1] = $real_week[1] + 1;
    }
    
    return $real_week;
}

/**
 * nv_get_max_week_of_year()
 * 
 * @param mixed $year
 * @return
 */
function nv_get_max_week_of_year($year)
{
    $time_per_week = 86400 * 7;
    $time_start_year = mktime(0, 0, 0, 1, 1, $year);
    $time_first_week = $time_start_year - (86400 * (date('N', $time_start_year) - 1));
    
    if (date('Y', $time_first_week + ($time_per_week * 53) - 1) == $year) {
        return 53;
    } else {
        return 52;
    }
}

/**
 * nv_get_display_field_value()
 * 
 * @param mixed $field
 * @param mixed $value
 * @return
 */
function nv_get_display_field_value($field, $value)
{
    if (empty($field) or empty($value)) {
        return '';
    }
    
    if ($field['field_type'] == 'date') {
        $value = nv_date('d/m/Y', intval($value));
    }
    
    return $value;
}

function fetchall($query) {
    global $db;
    $list = array();
    while ($row = $query->fetch()) {
        $list[] = $row;
    }
    return $list;
}
