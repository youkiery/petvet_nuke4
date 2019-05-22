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

$sampleType = array('Nguyên con', 'Huyết thanh', 'Máu', 'Phủ tạng', 'Swab');
$permissionType = array('Bị cấm', 'Chỉ đọc', 'Chỉnh sửa');

function employerList($key) {
  global $db, $permissionType;

  $xtpl = new XTemplate("allowed.tpl", PATH);
  $list = getAllowUser($key);

  foreach ($list as $row) {
    $xtpl->assign('userid', $row['userid']);
    $xtpl->assign('username', $row['username']);
    $xtpl->assign('fullname', $row['first_name']);
    $xtpl->assign('permission', $permissionType[$row['type']]);
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

function formList($keyword = '', $page = 1, $limit = 10, $printer = 5) {
  global $db, $sampleType;

  $xtpl = new XTemplate("list.tpl", PATH);

  $sqlCount = 'select count(*) as count from `'. PREFIX .'_row` where code like "%'. $keyword .'%" '. $extraSql;
  $query = $db->query($sqlCount);
  $count = $query->fetch();

  $xtpl->assign('total', $count['count']);

  $sql = 'select * from `'. PREFIX .'_row` where code like "%'. $keyword .'%" '. $extraSql . ' limit ' . $limit . ' offset ' . ($page - 1) * $limit;
  $query = $db->query($sql);

  $index = 1;
  $from = ($page - 1) * $limit;
  $end = $from;
  while ($row = $query->fetch()) {
    // if (in_array(strval(checkPrinter($row)), $printer)) {
    if (checkPrinter($row) <= $printer) {
      $end ++;
      if (!empty($sampleType[$row['typeindex']])) {
        $xtpl->assign('sample', $sampleType[$row['typeindex']]);
      }
      else {
        $xtpl->assign('sample', $row['typevalue']);
      }
      $xtpl->assign('index', $index++);
      $xtpl->assign('id', $row['id']);
      $xtpl->assign('code', $row['code']);
      $xtpl->assign('number', $row['number']);
      $xtpl->assign('sample', $row['sample']);
      $xtpl->assign('unit', getRemindId($row['sender']));
      $xtpl->parse('main.row');
    }
  }
  $xtpl->assign('from', $from);
  $xtpl->assign('end', $end);
  $xtpl->assign('nav', navList($number, $page, $limit));
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
