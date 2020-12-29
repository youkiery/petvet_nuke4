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

require_once(MODAL_PATH . '/promo.php');
require_once(MODAL_PATH . '/salary.php');
$promo = new Promo();
$salary = new Salary();

$page_title = "Lương và bổ nhiệm lại";

$action = $nv_Request->get_string('action', 'post/get', "");
$type = $nv_Request->get_string('type', 'post/get', "");
if (!empty($action)) {
	switch ($action) {
    case 'employ-insert':
      $name = $nv_Request->get_string('name', 'post/get', "");
      
      if ($employid = $salary->employ->insert($name)) {
        $salary->insert(array(
          'employid' => $employid,
          'formal' => '',
          'note' => '',
          'time' => date('Y/m/d')
        ));
        $promo->insert(array(
          'employid' => $employid,
          'note' => '',
          'time' => date('Y/m/d')
        ));
        $result->status = 1;
        $result->html = $salary->salary_content();
        $result->html2 = $salary->employ_content();
      }
    break;
    case 'employ-remove':
      $id = $nv_Request->get_int('id', 'post/get', "0");
      
      if ($salary->employ->remove($id)) {
        $salary->remove($id);
        $promo->remove($id);
        $result->status = 1;
        $result->html = $salary->salary_content();
        $result->html2 = $salary->employ_content();
      }
      break;
    case 'salary-up':
      $data = $nv_Request->get_array('data', 'post/get');

      if ($salary->insert($data)) {
        $result->status = 1;
        $result->html = $salary->salary_content();
      }
    break;
	}

	echo json_encode($result);
	die();
}

$xtpl = new XTemplate("main.tpl", PATH2);

if ($type = 'promo') {
  $xtpl->assign('active_promo', 'class="active"')  
  $xtpl->assign('active_promo', 'class="active"')  
}

$xtpl->assign('modal', $salary->modal());
$xtpl->assign('content', $salary->salary_content());
$xtpl->parse('main');
$contents = $xtpl->text();

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

