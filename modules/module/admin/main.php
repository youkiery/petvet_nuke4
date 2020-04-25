<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('NV_IS_ADMIN_MODULE')) {
	die('Stop!!!');
}

$xtpl = new XTemplate("main.tpl", PATH);

$sql = 'select * from `'. PREFIX .'_menu` where parent = ""';
$query = $db->query($sql);
$list = array();

/*
list structure
list = [
	{
		title: string,
		child: [
			{
				name: string
			}
		]
	}
]
*/

while ($row = $query->fetch()) {
	$list[$row['name']] = array(
		'title' => $row['title'],
		'child' => array()
	);

	$sql = 'select * from `'. PREFIX .'_menu` where parent = "'. $row['name'] .'"';
	$parent_query = $db->query($sql);

	while ($parent = $parent_query->fetch()) {
		$list[$row['name']]['child'] []= $parent;
	}
}

$xtpl->assign('modal', modal());
$xtpl->assign('list', json_encode($list));
$xtpl->assign('data', json_encode($admin_menu_mods));
$xtpl->parse("main");
$contents = $xtpl->text("main");
include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';
