<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_FORM')) {
	die('Stop!!!');
}

define('BUILDER_INSERT_NAME', 0);
define('BUILDER_INSERT_VALUE', 1);
define('BUILDER_EDIT', 2);

$action = $nv_Request->get_string('action', 'post', '');
$result = array('status' => 0);
if (!empty($action)) {
	switch ($action) {
		case 'send-review':
      $result['status'] = 1;
		break;
	}
}
echo json_encode($result);
die();
