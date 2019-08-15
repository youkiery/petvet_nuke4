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


function vaccineList($petid) {
  global $db, $vaccine_array;
  $xtpl = new XTemplate('vaccine.tpl', PATH);

  $sql = 'select * from `'. PREFIX .'_vaccine` where petid = ' . $petid;
  $query = $db->query($sql);
  $index = 1;
  while ($row = $query->fetch()) {
    $pet = getPetById($petid);
    // var_dump($pet);die();
    $xtpl->assign('index', $index ++);
    $xtpl->assign('pet', $pet['name']);
    $xtpl->assign('time', date('d/m/Y', $row['time']));
    $xtpl->assign('recall', date('d/m/Y', $row['recall']));
    $xtpl->assign('type', $vaccine_array[$row['type']]['title']);
    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function DiseaseList($petid) {
  global $db, $request_array;
  $xtpl = new XTemplate('disease.tpl', PATH);

  $sql = 'select * from `'. PREFIX .'_disease` where petid = ' . $petid;
  $query = $db->query($sql);
  $index = 1;
  while ($row = $query->fetch()) {
    $pet = getPetById($petid);
    // var_dump($pet);die();
    $xtpl->assign('index', $index ++);
    $xtpl->assign('pet', $pet['name']);
    $xtpl->assign('treat', date('d/m/Y', $row['treat']));
    $xtpl->assign('treated', date('d/m/Y', $row['treated']));
    $xtpl->assign('disease', $row['disease']);
    $xtpl->assign('note', $row['note']);
    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function requestDetail($petid) {
  global $request_array;
  $xtpl = new XTemplate('request-detail.tpl', PATH);

  foreach ($request_array as $row) {
    $xtpl->assign('title', $row['title']);
    $xtpl->assign('type', $row['type']);
    $xtpl->assign('id', $petid);
    if (!empty($request = getPetRequest($petid, $row['type']))) {
      $request['status'] = intval($request['status']);
      switch ($request['status']) {
        case 0:
          $xtpl->parse('main.row.rerequest');
        break;
        case 1:
          $xtpl->parse('main.row.cancel');
        break;
        default:
          $xtpl->parse('main.row.request');
        break;
      }
    }
    else {
      $xtpl->parse('main.row.request');
    }
    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function userDogRowByList($userid, $tabber = array(0, 1, 2), $filter = array('page' => 1, 'limit' => 10, 'keyword' => '')) {
  global $db, $user_info, $sex_array;
  $index = 1;
  $xtpl = new XTemplate('dog-owner-list.tpl', PATH);

  $data = getUserPetList($userid, $tabber, $filter);

  foreach ($data['list'] as $row) {
    $xtpl->assign('index', $index++);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('microchip', $row['microchip']);
    $xtpl->assign('breed', $row['breed']);
    $xtpl->assign('sex', $sex_array[$row['sex']]);
    $xtpl->assign('dob', cdate($row['dateofbirth']));
    if (!empty($user_info) && !empty($user_info['userid']) && (in_array('1', $user_info['in_groups']) || in_array('2', $user_info['in_groups']))) {
      $request = getPetRequest($row['id']);
      if ($count = count($request) > 0) {
        $counter = 0;
        $scounter = 0;
        foreach ($request as $requester) {
          // request status: 0-fail, 1-requesting, 2-success
          if ($requester['status'] > 0) {
            if ($requester['status'] == 2) {
              ++$scounter;
            } 
            ++$counter;
          }
        }
        if ($counter == 0) {
          $xtpl->assign('request', 'danger');
        }
        else if ($counter == $count) {
          if ($scounter == $count) {
            $xtpl->assign('request', 'success');
          }
          else {
            $xtpl->assign('request', 'info');
          }
        }
        else {
          $xtpl->assign('request', 'warning');
        }
      }
      if ($row['active']) {
        $xtpl->parse('main.row.mod.uncheck');
      }
      else {
        $xtpl->parse('main.row.mod.check');
      }
    }
    $xtpl->parse('main.row.mod');
    $xtpl->parse('main.row');
  }
  // echo json_encode($data);die();

  $xtpl->assign('nav', navList($data['count'], $filter['page'], $filter['limit']));
  $xtpl->parse('main');
  return $xtpl->text();
}

function mainPetList($keyword = '', $page = 1, $filter = 10) {
  global $db, $sex_array;
  $index = 1;
  $xtpl = new XTemplate('dog-list.tpl', PATH);

  $data = getPetActiveList($keyword, $page, $filter);

  if (strlen(trim($keyword)) > 0) {
    $xtpl->assign('keyword', ' "' . $keyword . '",');
  }
  $count = $data['count'];

  $xtpl->assign('from', ($page - 1) * $filter + 1);
  $xtpl->assign('end', ($count + $filter >= ($page * $filter) ? $count : $page * $filter));
  $xtpl->assign('count', $count);
  $xtpl->parse('main.msg');

  foreach ($data['list'] as $row) {
    // var_dump($row);die();
    $owner = getOwnerById($row['userid']);
    $xtpl->assign('index', $index++);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('owner', $owner['fullname']);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('microchip', $row['microchip']);
    $xtpl->assign('breed', $row['breed']);
    $xtpl->assign('sex', $sex_array[$row['sex']]);
    $xtpl->assign('dob', cdate($row['dateofbirth']));
    $xtpl->parse('main.row');
  }
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
