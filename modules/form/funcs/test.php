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

$sql = "select * from pet_form_row";
$query = $db->query($sql);

while ($row = $query->fetch()) {
	$sql = 'update pet_form_row set sender = "'. getRemindId($row['sender']) .'", receiver = "'. getRemindId($row['receiver']) .'", isenderemploy = "'. getRemindId($row['isenderemploy']) .'", ireceiverunit = "'. getRemindId($row['ireceiverunit']) .'", isenderunit = "'. getRemindId($row['isenderunit']) .'", ireceiveremploy = "'. getRemindId($row['ireceiveremploy']) .'" where id = ' . $row['id'];
	echo($sql . ";<br>");
}
die();


// $page_title = "Nhập hồ sơ một chiều";

// $xtpl = new XTemplate("test.tpl", PATH);



// // $xtpl->parse("main.sample.standard.result");
// // $xtpl->parse("main.sample.standard");
// // $xtpl->parse("main.sample.standard.result");
// // $xtpl->parse("main.sample.standard");
// // $xtpl->parse("main.sample.standard.result");
// // $xtpl->parse("main.sample.standard.result");
// $xtpl->parse("main.sample.standard.result");
// $xtpl->parse("main.sample.standard");
// $xtpl->parse("main.sample");
// $xtpl->parse("main");
// $contents = $xtpl->text("main");

include ( NV_ROOTDIR . "/includes/header.php" );
echo nv_site_theme($contents);
include ( NV_ROOTDIR . "/includes/footer.php" );

