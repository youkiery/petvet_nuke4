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

$page_title = "autoload";

$action = $nv_Request->get_string('action', 'post', '');
if (!empty($action)) {
	$result = array('status' => 0);
	switch ($action) {
		case 'search':
			$keyword = $nv_Request->get_string('keyword', 'post', '');
			
			$result['status'] = 1;
			if (count($list)) {
				$result['html'] = dogRowByList($keyword);
			}

		break;
	}
	echo json_encode($result);
	die();
}

$id = $nv_Request->get_int('id', 'get', 0);

$xtpl = new XTemplate("detail.tpl", "modules/biograph/template");

$sql = 'select * from `'. PREFIX .'_pet` where id = ' . $id;
$query = $db->query($sql);

if (!empty($row = $query->fetch())) {
	$xtpl->assign('name', $row['name']);
	$xtpl->assign('dob', $row['dateofbirth']);
	$xtpl->assign('breed', $row['breed']);
	$xtpl->assign('species', $row['species']);
	$xtpl->assign('sex', $row['sex']);
	$xtpl->assign('color', $row['color']);
	$xtpl->assign('microchip', $row['microchip']);
	$xtpl->assign('image', $row['image']);

  $relation = getPetRelation($id);
  // $bay = array('grand' => array(), 'parent' => array(), 'sibling' => array(), 'child' => array());

  if ($row = $relation['grand']['e']['f']) {
    $xtpl->assign('egrandma', '<a href="/index.php?nv=biograph&op=detail&id=' . $row['name'] . '">' . $row['name'] . '</a>');
  }
  if ($row = $relation['grand']['e']['m']) {
    $xtpl->assign('egrandpa', '<a href="/index.php?nv=biograph&op=detail&id=' . $row['name'] . '">' . $row['name'] . '</a>');
  }
  if ($row = $relation['grand']['i']['f']) {
    $xtpl->assign('igrandma', '<a href="/index.php?nv=biograph&op=detail&id=' . $row['name'] . '">' . $row['name'] . '</a>');
  }
  if ($row = $relation['grand']['i']['m']) {
    $xtpl->assign('igrandpa', '<a href="/index.php?nv=biograph&op=detail&id=' . $row['name'] . '">' . $row['name'] . '</a>');
  }

  if ($row = $relation['parent']['m']) {
    $xtpl->assign('mama', '<a href="/index.php?nv=biograph&op=detail&id=' . $row['name'] . '">' . $row['name'] . '</a>');
  }
  if ($row = $relation['parent']['f']) {
    $xtpl->assign('papa', '<a href="/index.php?nv=biograph&op=detail&id=' . $row['name'] . '">' . $row['name'] . '</a>');
  }

  if (count($child = $relation['child'])) {
    $html = '';    
    foreach ($child as $row) {
      $html = '<a href="/index.php?nv=biograph&op=detail&id=' . $row['name'] . '">' . $row['name'] . '</a>';
    }
    $xtpl->assign('child', $html);
  }


  // if ($relation['grand']) {    
  //   foreach ($relation['grand'] as $row) {
  //     foreach ($row as $row2) {
  //       if ($row2) {
  //         $bay['grand'][] = '<a href="/index.php?nv=biograph&op=detail&id=' . $row['name'] . '">' . $row['name'] . '</a>';
  //       }
  //     }
  //   }
  // }
  // if ($relation['parent']) {    
  //   foreach ($relation['parent'] as $row) {
  //     if ($row) {
  //       $bay['parent'][] = '<a href="/index.php?nv=biograph&op=detail&id=' . $row['name'] . '">' . $row['name'] . '</a>';
  //     }
  //   }
  // }
  // if ($relation['sibling']) {    
  //   foreach ($relation['sibling'] as $row) {
  //     if ($row['id']) {
  //       $bay['parent'][] = '<a href="/index.php?nv=biograph&op=detail&id=' . $row['name'] . '">' . $row['name'] . '</a>';
  //     }
  //   }
  // }
  // if ($relation['child']) {    
  //   foreach ($relation['child'] as $row) {
  //     if ($row['id']) {
  //       $bay['child'][] = '<a href="/index.php?nv=biograph&op=detail&id=' . $row['name'] . '">' . $row['name'] . '</a>';
  //     }
  //   }
  // }

  $xtpl->assign('grand', implode('<br>', $bay['grand']));
  $xtpl->assign('parent', implode('<br>', $bay['parent']));
  $xtpl->assign('sibling', implode('<br>', $bay['sibling']));
  $xtpl->assign('child', implode('<br>', $bay['child']));

	$xtpl->parse("main.detail");
}
else {
	$xtpl->parse("main.error");
}

$xtpl->parse("main");

$contents = $xtpl->text("main");
include ("modules/biograph/layout/header.php");
echo $contents;
include ("modules/biograph/layout/footer.php");

