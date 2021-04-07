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
        case 'predit':
            $id = $nv_Request->get_int("id", "get/post", 0);
            if (!empty($id)) {
                $sql = "select * from `" . WORK_PREFIX . "_depart` where id = $id";
                $depart_query = $db->query($sql);
                if ($depart = $depart_query->fetch()) {
                    $result["status"] = 1;
                    $result["name"] = $depart["name"];
                }
            }
        break;
        case 'update':
            $name = $nv_Request->get_string("name", "get/post", "");
            $id = $nv_Request->get_string("id", "get/post", "");
            if (!empty($name) && !empty($id)) {
                $sql = "update `" . WORK_PREFIX . "_depart` set name = '$name' where id = $id";
                $depart_query = $db->query($sql);
                if ($depart_query) {
                    $result["status"] = 1;
                    $result["notify"] = $lang_module["g_saved"] . ": " . $name;
                    $result["list"] = depart_list();
                }
            }
        break;
        case 'save':
            $name = $nv_Request->get_string("name", "get/post", "");
            if (!empty($name)) {
                $sql = "insert into `" . WORK_PREFIX . "_depart` (name) values('" . $name . "')";
                $depart_query = $db->query($sql);
                if ($depart_query) {
                    $result["status"] = 1;
                    $result["notify"] = $lang_module["depart_insert_success"] . ": " . $name;
                    $result["list"] = depart_list();
                }
            }
        break;
        case 'remove':
            $id = $nv_Request->get_int("id", "get/post", 0);
            if (!empty($id)) {
                $sql = "delete from `" . WORK_PREFIX . "_depart` where id = $id";
                $depart_query = $db->query($sql);
                if ($depart_query) {
                    $result["status"] = 1;
                    $result["notify"] = $lang_module["g_saved"];
                    $result["list"] = depart_list();
                }
            }
        break;
    }
    echo json_encode($result);
    die();
}

$xtpl = new XTemplate('depart.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file);

$xtpl->assign('content', depart_list());
$xtpl->assign('lang', $lang_module);
$xtpl->parse('main');
$contents = $xtpl->text();

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
