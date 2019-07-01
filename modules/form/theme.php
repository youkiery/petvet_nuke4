<?php

/**
 * @Project Petcoffee-tech
 * @Chistua (hchieuthua@gmail.com)
 * @Copyright (C) 2019
 * @Createdate 21-03-2019 13:15
 */

if (!defined('PREFIX')) {
  die('Stop!!!');
}

$sampleType = array(0 => 'Nguyên con', 'Huyết thanh', 'Máu', 'Phủ tạng', 'Swab');
$permissionType = array('Bị cấm', 'Chỉ đọc', 'Chỉnh sửa');

function employerList($key = '') {
  global $db, $permissionType;

  $xtpl = new XTemplate("allowed.tpl", PATH);
  $list = getAllowUser($key);

  foreach ($list as $row) {
    $xtpl->assign('userid', $row['userid']);
    $xtpl->assign('username', $row['username']);
    $xtpl->assign('fullname', $row['first_name']);
    $xtpl->assign('permission', $permissionType[$row['type']]);
    $permist = explode(',', $row['former']);
    $risk = '';
    foreach ($permist as $value) {
      if (trim($value)) {
        $risk .= '<button class="btn btn-xs">' . ($value + 1) . '</button>';
      }
    }
    $xtpl->assign('risk', $risk);
    if ($row['type'] == 1) {
      $xtpl->parse('main.row.up');
    }
    else if ($row['type'] == 2) {
      $xtpl->parse('main.row.down');
    }
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function notAllowList($key) {
  global $db;
  $html = '';

  $list = getNotAllow($key);

  foreach ($list as $row) {
    $html .= '<div class="suggest_item" onclick="addEmploy('.$row['userid'].')">'.$row['first_name'].'</div>';
  }
  return $html;
}

function summaryContent($from, $end, $exam = '', $unit = '', $sample = '') {
  global $db, $sampleType;

  $xtpl = new XTemplate("summary.tpl", PATH);
  $sql = 'select * from `'. PREFIX .'_row` where (time between ' . $from . ' and ' . $end . ') and exam like "%'. $exam .'%" and sender like "%'. $unit .'%" and sample like "%'. $sample .'%"';
  // die($sql);
  $query = $db->query($sql);
  $data = array();

  while ($row = $query->fetch()) {
    $sample = mb_strtolower($row['sample']);
    if (empty($data[$sample])) {
      $data[$sample] = array();
    }
    
    if (empty($data[$sample][$row['typeindex']])) {
      $data[$sample][$row['typeindex']] = "0";
    }

    $data[$sample][$row['typeindex']] += $row['number'];
  }
  // echo json_encode($data);die();

  foreach ($data as $sample => $types) {
    $count = 0;
    $xtpl->assign('sample', $sample);
    foreach ($types as $type => $number) {
      $typeName = 'Khác';
      if (!empty($sampleType[$type])) {
        $typeName = $sampleType[$type];
      }
      if ($count) {
        $xtpl->assign('type_more', $typeName);
        $xtpl->assign('number_more', $number);
        $xtpl->parse('main.row.more');
      }
      else {
        $xtpl->assign('type', $typeName);
        $xtpl->assign('number', $number);
      }
      $count ++;
    }
    $xtpl->assign('row', $count);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

// function checkSample() {
//   global $db;
//   $sql = 'select sample from `'. PREFIX .'_row`';
//   $query = $db->query($sql);
//   while (!empty($row = $query->fetch())) {
//     $row = explode(', ', $row['sample']);
//     foreach ($row as $value) {
//       $sql = 'select * from `'. PREFIX .'_sample` where name like "%'. $value .'%"';
//       $query2 = $db->query($sql);
//       if (empty($query2->fetch())) {
//         $sql = 'insert into `'. PREFIX .'_sample` (name) values ("'. $value .'")';
//         $db->query($sql);
//       }
//     }
//   }
// }

function formList($keyword = '', $page = 1, $limit = 10, $printer = 1, $other = array('exam' => '', 'unit' => '', 'sample' => ''), $xcode = '') {
  global $db, $sampleType, $user_info;
  $xtpl = new XTemplate("list.tpl", PATH);
  $xcode = str_replace('/', ', ', $xcode);
  
  $part = array('printer >= ' . $printer);
  if ($printer >= 1) {
    $part[] = 'code like "%'. $keyword .'%"';
    $part[] = 'sample like "%'. $other['sample'] .'%"';
    $part[] = 'sender like "%'. $other['unit'] .'%"';
    $part[] = 'exam like "%'. $other['exam'] .'%"';
  }

  if ($printer >= 2) {
    $part[] = 'xcode like "%'. $xcode .'%"';
  }

  $sqlCount = 'select count(*) as count from `'. PREFIX .'_row` where ' . (implode($part, ' and '));
  $query = $db->query($sqlCount);
  $count = $query->fetch();

  $xtpl->assign('total', $count['count']);

  $sql = 'select * from `'. PREFIX .'_row` where '. (implode($part, ' and ')) .' order by id desc limit ' . $limit . ' offset ' . ($page - 1) * $limit;
  $query = $db->query($sql);

  $index = 1;
  $from = ($page - 1) * $limit + 1;
  $end = $from - 1;
  while ($row = $query->fetch()) {
      $end ++;
      $xtpl->assign('index', $index++);
      $xtpl->assign('id', $row['id']);
      $xtpl->assign('xcode', str_replace(', ', '/', $row['xcode']));
      $xtpl->assign('xcode', str_replace(',', '/', $row['xcode']));
      $xtpl->assign('code', $row['code']);
      $xtpl->assign('number', $row['number']);
      $xtpl->assign('sample', $row['sample']);
      $xtpl->assign('printer', $row['printer']);
      for ($i = 1; $i <= $row['printer']; $i++) { 
        $xtpl->assign('printercount', $i);
        $xtpl->parse('main.row.printer');
      }
      $xtpl->assign('unit', $row['sender']);
      if (checkIsMod($user_info['userid'])) {
        $xtpl->parse('main.row.mod');
      }
      $xtpl->parse('main.row');
  }
  $xtpl->assign('from', $from);
  $xtpl->assign('end', $end);
  $xtpl->assign('nav', navList($count['count'], $page, $limit));
  $xtpl->parse('main');
  return $xtpl->text();
}

function navList ($number, $page, $limit) {
  global $lang_global;
  $total_pages = ceil($number / $limit);

  $on_page = $page;
  $page_string = "";
  if ($total_pages > 10) {
    $init_page_max = ($total_pages > 3) ? 3 : $total_pages;
    for ($i = 1; $i <= $init_page_max; $i ++) {
      $page_string .= ($i == $on_page) ? '<div class="btn">' . $i . "</div>" : '<button class="btn btn-info" onclick="goPage('.$i.')">' . $i . '</button>';
      if ($i < $init_page_max) $page_string .= " ";
    }
    if ($total_pages > 3) {
      if ($on_page > 1 && $on_page < $total_pages) {
        $page_string .= ($on_page > 5) ? " ... " : ", ";
        $init_page_min = ($on_page > 4) ? $on_page : 5;
        $init_page_max = ($on_page < $total_pages - 4) ? $on_page : $total_pages - 4;
        for ($i = $init_page_min - 1; $i < $init_page_max + 2; $i ++) {
          $page_string .= ($i == $on_page) ? '<div class="btn">' . $i . "</div>" : '<button class="btn btn-info" onclick="goPage('.$i.')">' . $i . '</button>';
          if ($i < $init_page_max + 1)  $page_string .= " ";
        }
        $page_string .= ($on_page < $total_pages - 4) ? " ... " : ", ";
      }
      else {
        $page_string .= " ... ";
      }
      
      for ($i = $total_pages - 2; $i < $total_pages + 1; $i ++) {
        $page_string .= ($i == $on_page) ? '<div class="btn">' . $i . "</div>" : '<button class="btn btn-info" onclick="goPage('.$i.')">' . $i . '</button>';
        if ($i < $total_pages) $page_string .= " ";
      }
    }
  }
  else {
    if ($total_pages) {
      for ($i = 1; $i < $total_pages + 1; $i ++) {
        $page_string .= ($i == $on_page) ? '<div class="btn">' . $i . "</div>" : '<button class="btn btn-info" onclick="goPage('.$i.')">' . $i . '</button>';
        if ($i < $total_pages) $page_string .= " ";
      }
    }
    else {
      $page_string .= '<div class="btn">' . 1 . "</div>";
    }
  }
  return $page_string;
}
