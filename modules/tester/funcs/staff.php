<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) die('Stop!!!');

$result = array('status' => 0);
$action = $nv_Request->get_string('action', 'post', '');
$staff = new Staff();

switch ($action) {
  case 'update':
    $data = $nv_Request->get_array('data', 'post');
    $staff->update($data['userid'], $data['type'], $data['value']);
    $result['status'] = 1;
    $result['html'] = $staff->viewStaffList();
    break;
  case 'remove':
    $userid = $nv_Request->get_int('userid', 'post');
    $staff->remove($userid);
    $result['status'] = 1;
    $result['html'] = $staff->viewStaffList();
    break;
  case 'filter':
    $keyword = $nv_Request->get_string('keyword', 'post');
    $result['status'] = 1;
    $result['html'] = $staff->viewFilter($keyword);
    break;
  case 'insert':
    $userid = $nv_Request->get_int('userid', 'post');
    $keyword = $nv_Request->get_string('keyword', 'post');
    $staff->insert($userid);
    $result['status'] = 1;
    $result['html'] = $staff->viewStaffList();
    $result['html2'] = $staff->viewFilter($keyword);
    break;
}

echo json_encode($result);die();