<?php

/**
 * @Project Thanhxuanpet 0.1
 * @Author Võ Anh Dư <vodaityr@gmail.com>
 * @Copyright (C) 2021 Thanhxuanpet
 * @License Nope
 * @Createdate 22/01/2021 14:15
 */

if (!defined('NV_SYSTEM')) {
  die('Stop!!!');
}

define('NV_IS_TX', true);
define('NV_IS_MOD_USER', true);
define('PATH', NV_ROOTDIR . "/modules/$module_file/funcs/template/");

include_once(NV_ROOTDIR . '/modal/customer.php');
include_once(NV_ROOTDIR . '/modal/pet.php');
include_once(NV_ROOTDIR . '/modal/user.php');
include_once(NV_ROOTDIR . '/modal/vaccine.php');
include_once(NV_ROOTDIR . '/modal/spa.php');
$customer = new Customer();
$pet = new Pet();
$user = new User($user_info['userid']);
$vaccine = new Vaccine();
$spa = new Spa();
$user->check();
if (!$user->isManager()) $user->prevent();