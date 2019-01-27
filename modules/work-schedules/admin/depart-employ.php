<?php

/**
 * @Project WORK SCHEDULES 4.X
 * @Author PHAN TAN DUNG (phantandung92@gmail.com)
 * @Copyright (C) 2016 PHAN TAN DUNG. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Sat, 11 Jun 2016 23:45:51 GMT
 */
if (!defined('NV_IS_FILE_ADMIN')) {
    die('Stop!!!');
}

$action = $nv_Request->get_string("action", "get/post", "");
if ($action) {
    $result = array("status" => 0, "notify" => $lang_module["g_error"]);
    switch ($action) {
        case 'chose':
            $id = $nv_Request->get_string("id", "get/post", "");
            $userid = $nv_Request->get_string("userid", "get/post", "");
            $name = $nv_Request->get_string("name", "get/post", "");
            if (!empty($userid) && !empty($id) && !empty($name)) {
                $sql = "select * from `" . WORK_PREFIX . "_employ` where userid = " . $userid . " and depart = " . $id;
                $query = $db->query($sql);
                $employ = $query->fetch();

                if (empty($employ)) {
                    $sql = "insert into `" . WORK_PREFIX . "_employ` (userid, name, role, depart) values ($userid, '$name', 1, $id)";
                    $query = $db->query($sql);
                    if ($query) {
                        $result["status"] = 1;
                        $result["list"] = depart_employ_list();
                        $result["notify"] = "saved";
                    }
                }
            }
        break;
        case 'remove':
            $id = $nv_Request->get_string("id", "get/post", "");
            $userid = $nv_Request->get_string("userid", "get/post", "");
            if (!empty($userid) && !empty($id)) {
                $sql = "select * from `" . WORK_PREFIX . "_employ` where userid = " . $userid . " and depart = " . $id;
                $query = $db->query($sql);
                $employ = $query->fetch();

                if (!empty($employ)) {
                    $sql = "delete from `" . WORK_PREFIX . "_employ` where depart = $id and userid = $userid";
                    $query = $db->query($sql);
                    if ($query) {
                        $result["status"] = 1;
                        $result["list"] = depart_employ_list();
                        $result["notify"] = "saved";
                    }
                }
            }
        break;
        case 'search':
            $keyword = $nv_Request->get_string("keyword", "get/post", "");
            $id = $nv_Request->get_string("id", "get/post", "");
            if (!empty($id)) {
                $sql = "select * from `" . $db_config["prefix"] . "_users` where (first_name like '%" . $keyword . "%' or last_name like '%" . $keyword . "%' or username like '%" . $keyword . "%') and userid not in (select userid from `" . WORK_PREFIX . "_employ` where depart = $id)";
                // đang làm 13/01/2019 15:50
                $keyword_query = $db->query($sql);
                
                $list = fetchall($keyword_query);
                $result["status"] = 1;
                $result["list"] = search_depart($list);
            }
            else {
                $result["notify"] = $lang_module["keyword_blank"];
            }
        break;
    }
    echo json_encode($result);
    die();
}


$xtpl = new XTemplate('depart-employ.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);
$id = $nv_Request->get_int("id", "get/post", 1);
$sql = "select * from `" . WORK_PREFIX . "_depart` where id = " . $id;
$depart_query = $db->query($sql);
$depart = $depart_query->fetch();
if (!empty($depart["name"])) {
    $xtpl->assign('title', $depart["name"]);
}
else {
    $xtpl->assign('title', $lang_module["missing"]);
}

$xtpl->assign('content', depart_employ_list());
$xtpl->assign('lang', $lang_module);
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
