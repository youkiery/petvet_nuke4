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

function transferqList($userid, $filter = array('page' => 1, 'limit' => 10)) {
  global $db, $module_file;

  $xtpl = new XTemplate('transferq-list.tpl', PATH);

  $sql = 'select count(*) as count from `'. PREFIX .'_transfer_request` where userid = ' . $userid;
  $query = $db->query($sql);
  $count = $query->fetch()['count'];
  $xtpl->assign('nav', navList($count, $filter['page'], $filter['limit']));

  $sql = 'select * from `'. PREFIX .'_transfer_request` where userid = ' . $userid . ' limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;

  while ($row = $query->fetch()) {
    $pet = getPetById($row['petid']);
    $owner = checkUserinfo($pet['userid'], $pet['type']);

    // $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('image', $pet['image']);
    $xtpl->assign('species', $pet['species']);
    $xtpl->assign('name', $pet['name']);
    $xtpl->assign('breeder', $pet['breeder']);
    $xtpl->assign('owner', $owner['fullname']);
    $xtpl->assign('time', date('d/m/Y', $row['time']));
    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function vaccineList($petid) {
  global $db, $vaccine_array, $module_file;
  $xtpl = new XTemplate('vaccine.tpl', PATH);
  $xtpl->assign('module_file', $module_file);

  $sql = 'select * from `'. PREFIX .'_vaccine` where petid = ' . $petid . ' order by id desc';
  $query = $db->query($sql);
  $index = 1;
  $today = time(); 
  while ($row = $query->fetch()) {
    $pet = getPetById($petid);
    // var_dump($pet);die();
    $xtpl->assign('index', $index ++);
    $xtpl->assign('pet', $pet['name']);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('time', date('d/m/Y', $row['time']));
    $xtpl->assign('recall', date('d/m/Y', $row['recall']));
    if ($time >= $row['recall'] && $row['status'] == 0) {
      $xtpl->assign('color', 'red');
    }
    else {
      $xtpl->assign('color', '');
    }
    if ($row['type'] == 1) {
      $xtpl->assign('type', $vaccine_array[$row['val']]['title']);
    }
    else {
      $xtpl->assign('type', pickVaccineId($row['val'])['disease']);
    }
    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function DiseaseList($petid) {
  global $db, $request_array, $module_file;
  $xtpl = new XTemplate('disease.tpl', PATH);
  $xtpl->assign('module_file', $module_file);

  $sql = 'select * from `'. PREFIX .'_disease` where petid = ' . $petid . ' order by id desc';
  $query = $db->query($sql);
  $index = 1;
  while ($row = $query->fetch()) {
    $pet = getPetById($petid);
    // var_dump($pet);die();
    $xtpl->assign('index', $index ++);
    $xtpl->assign('id', $row['id']);
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
  global $db, $request_array, $module_file;
  $xtpl = new XTemplate('request-detail.tpl', PATH);
  $xtpl->assign('module_file', $module_file);
  $list = array();

  $sql = 'select * from `'. PREFIX .'_remind` where type = "request" and visible = 1';
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $xtpl->assign('title', $row['name']);
    $xtpl->assign('type', $row['id']);
    $xtpl->assign('id', $petid);
    if (!empty($request = getPetRequest($petid, $row['id']))) {
      $request['status'] = intval($request['status']);
      switch ($request['status']) {
        case 0:
          // decline
          $xtpl->parse('main.row.rerequest');
        break;
        case 1:
          // picking
          $xtpl->parse('main.row.cancel');
        break;
        default:
          // finish
          $xtpl->parse('main.row.request');
        break;
      }
    }
    else {
      $xtpl->parse('main.row.request');
    }
    $xtpl->parse('main.row');
  }

  $sql = 'select * from `'. PREFIX .'_request` where type = 2 and petid = ' . $petid . ' and status <> 2';
  // die($sql);
  $query = $db->query($sql);

  while ($row = $query->fetch()) {
    $sql = 'select * from `'. PREFIX .'_remind` where type = "request" and id = ' . $row['value'];
    $query2 = $db->query($sql);
    $remind = $query2->fetch();

    $xtpl->assign('title', $remind['name']);
    $xtpl->assign('type', $row['value']);
    $xtpl->assign('id', $petid);
    $status = intval($row['status']);
    switch ($status) {
      case 1:
        $xtpl->parse('main.row2.cancel2');
      break;
      case 0:
        $xtpl->parse('main.row2.rerequest2');
      break;
    }
    $xtpl->parse('main.row2');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function userDogRowByList($userid, $tabber = array(0, 1, 2), $filter = array('page' => 1, 'limit' => 10, 'keyword' => '')) {
  global $db, $user_info, $sex_array, $module_file, $module_name;
  $index = 1;
  $xtpl = new XTemplate('dog-owner-list.tpl', PATH);
  $xtpl->assign('module_file', $module_file);
  $xtpl->assign('module_name', $module_name);

  $data = getUserPetList($userid, $tabber, $filter);

  foreach ($data['list'] as $row) {
    $xtpl->assign('index', $index++);
    $list = array();
    $list[] = $row;
    $parent = getParentTree($row);
    $list = array_merge($list, $parent);
    $ping = 1;
    $i = 1;
    // echo json_encode($list); die();
    foreach ($list as $check) {
      $xtpl->assign('pr', 'disabled');
      if ($ping) {
        $ping = 0;
        $xtpl->assign('display', 'table-row-group');
        $xtpl->assign('pc', '');
        if (count($parent)) {
          $xtpl->assign('pr', '');
        }
      }
      else {
        $xtpl->assign('display', 'none');
        $xtpl->assign('pc', 'i' . $row['id']);
      }

      $xtpl->assign('name', $check['name']);
      // $xtpl->assign('breeder', $check['breeder']);
      $xtpl->assign('id', $check['id']);
      $xtpl->assign('microchip', $check['microchip']);
      $xtpl->assign('breed', $check['breed']);
      $xtpl->assign('species', $check['species']);
      $xtpl->assign('sex', $sex_array[$check['sex']]);
      $xtpl->assign('dob', cdate($check['dateofbirth']));
      if ($row['sell']) {
        $xtpl->parse('main.row.unsell');
      }
      else {
        $xtpl->parse('main.row.sell');
      }
      $request = getPetRequest($check['id']);
        // if ($count = count($request) > 0) {
        //   $counter = 0;
        //   $scounter = 0;
        //   foreach ($request as $requester) {
        //     // request status: 0-fail, 1-requesting, 2-success
        //     if ($requester['status'] > 0) {
        //       if ($requester['status'] == 2) {
        //         ++$scounter;
        //       } 
        //       ++$counter;
        //     }
        //   }
        //   if ($counter == 0) {
        //     $xtpl->assign('request', 'danger');
        //   }
        //   else if ($counter == $count) {
        //     if ($scounter == $count) {
        //       $xtpl->assign('request', 'success');
        //     }
        //     else {
        //       $xtpl->assign('request', 'info');
        //     }
        //   }
        //   else {
        //     $xtpl->assign('request', 'warning');
        //   }
        // }
        // else {
        //   $xtpl->assign('request', 'info');
        // }

      $xtpl->parse('main.row');
    }
  }
  // echo json_encode($data);die();

  $xtpl->assign('nav', navList($data['count'], $filter['page'], $filter['limit']));
  $xtpl->parse('main');
  return $xtpl->text();
}

function mainPetList($keyword = '', $page = 1, $filter = 12) {
  global $db, $sex_array, $module_file;
  $index = ($page - 1) * $filter + 1;
  $xtpl = new XTemplate('dog-list.tpl', PATH);
  $xtpl->assign('module_file', $module_file);

  $data = getPetActiveList($keyword, $page, $filter);

  if (strlen(trim($keyword)) > 0) {
    $xtpl->assign('keyword', ' "' . $keyword . '",');
  }
  $count = $data['count'];

  $xtpl->assign('from', ($page - 1) * $filter + 1);
  $xtpl->assign('end', ($count + $filter >= ($page * $filter) ? $count : $page * $filter));
  $xtpl->assign('count', $count);
  $xtpl->assign('nav', navList($count, $page, $filter));
  $xtpl->parse('main.msg');
  $time = time();
  $year = 60 * 60 * 24 * 365.25;

  foreach ($data['list'] as $row) {
    // var_dump($row);die();
    $owner = getOwnerById($row['userid'], $row['type']);
    $xtpl->assign('index', $index++);
    $xtpl->assign('image', $row['image']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('owner', $owner['fullname']);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('image', $row['image']);
    $xtpl->assign('microchip', $row['microchip']);
    $xtpl->assign('breed', $row['breed']);
    $xtpl->assign('species', $row['species']);
    $xtpl->assign('sex', $sex_array[$row['sex']]);
    $xtpl->assign('age', parseAgeTime($row['dateofbirth']));
    // $xtpl->assign('dob', cdate($row['dateofbirth']));
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function introList($userid, $filter = array('page' => 1, 'limit' => 10)) {
  global $db, $module_file;

  $xtpl = new XTemplate('intro-list.tpl', PATH);
  $xtpl->assign('module_file', $module_file);

  $sql = 'select count(*) as count from ((select a.* from `'. PREFIX .'_info` a inner join `'. PREFIX .'_pet` b on a.rid = b.id where (a.type = 1 or a.type = 3) and b.userid = '. $userid . ' and status = 1) union (select a.* from `'. PREFIX .'_info` a inner join `'. PREFIX .'_buy` b on a.rid = b.id where a.type = 2 and b.userid = '. $userid . ' and status = 1)) as c';

  $query = $db->query($sql);
  $count = $query->fetch()['count'];
  $xtpl->assign('nav', navList($count, $filter['page'], $filter['limit']));

  $sql = 'select * from ((select a.* from `'. PREFIX .'_info` a inner join `'. PREFIX .'_pet` b on a.rid = b.id where (a.type = 1 or a.type = 3) and b.userid = '. $userid . ' and status = 1) union (select a.* from `'. PREFIX .'_info` a inner join `'. PREFIX .'_buy` b on a.rid = b.id where a.type = 2 and b.userid = '. $userid . ' and status = 1) order by id desc) as c limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;

  while ($row = $query->fetch()) {
    $owner = getOwnerById($row['userid']);
    $xtpl->assign('index', $index++);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('target', $row['fullname']);
    $xtpl->assign('address', $row['address']);
    $xtpl->assign('mobile', $row['mobile']);
    $xtpl->assign('note', $row['note']);
    switch ($row['type']) {
      case 1:
        $xtpl->assign('type', 'Cần bán');
      break;
      case 2:
        $xtpl->assign('type', 'Cần mua');
      break;
      default:
      $xtpl->assign('type', 'Cần phối');
    }
    $xtpl->parse('main.row');
  }

  $xtpl->parse('main');
  return $xtpl->text();
}

function transferList($userid, $filter = array('page' => 1, 'limit' => 10)) {
  global $db, $module_file;

  $xtpl = new XTemplate('transfer-list.tpl', PATH);
  $xtpl->assign('module_file', $module_file);

  $sql = 'select count(*) as count from `'. PREFIX .'_transfer` where fromid = ' . $userid;
  $query = $db->query($sql);
  $count = $query->fetch()['count'];
  $xtpl->assign('nav', navList($count, $filter['page'], $filter['limit']));

  $sql = 'select * from `'. PREFIX .'_transfer` where fromid = ' . $userid . ' limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);
  $index = ($filter['page'] - 1) * $filter['limit'] + 1;

  $list = array();
  while ($row = $query->fetch()) {
    $target = checkUserinfo($row['targetid'], $row['type']);
    // echo $target['fullname'] . ' ('. $row['type'] .')<br>';
    $pet = getPetById($row['petid']);
    $target['mobile'] = xdecrypt($target['mobile']);
    $target['address'] = xdecrypt($target['address']);

    $xtpl->assign('index', $index++);
    $xtpl->assign('target', $target['fullname']);
    $xtpl->assign('address', $target['address']);
    $xtpl->assign('mobile', $target['mobile']);
    $xtpl->assign('id', $pet['id']);
    $xtpl->assign('pet', $pet['name']);
    $xtpl->assign('time', date('d/m/Y', $row['time']));
    $xtpl->parse('main.row');
  }
  // die(implode(', ', $list));

  $xtpl->parse('main');
  return $xtpl->text();
}

function sellList($filter = array('species' => '', 'breed' => '', 'keyword' => '', 'page' => '1', 'limit' => '12')) {
  global $db, $module_name;

  $xtpl = new XTemplate('sell-list.tpl', PATH);
  $xtpl->assign('module_name', $module_name);

  // ??
  $sql = 'select count(*) as count from `'. PREFIX .'_trade` a inner join `'. PREFIX .'_pet` b on a.petid = b.id where a.status = 1 and a.type = 1 and b.name like "%'. $filter['keyword'] .'%" and b.breed like "%'. $filter['species'] .'%" and b.species like "%'. $filter['breed'] .'%"';
  $query = $db->query($sql);
  $count = $query->fetch()['count'];
  $xtpl->assign('nav', navList($count, $filter['page'], $filter['limit']));

  $sql = 'select * from `'. PREFIX .'_trade` a inner join `'. PREFIX .'_pet` b on a.petid = b.id where a.status = 1 and a.type = 1 and b.name like "%'. $filter['keyword'] .'%" and b.breed like "%'. $filter['species'] .'%" and b.species like "%'. $filter['breed'] .'%" order by a.id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);

  while($row = $query->fetch()) {
    $owner = getOwnerById($row['userid'], $row['type']);
    $xtpl->assign('index', $index++);
    $xtpl->assign('age', floor((time() - $row['dateofbirth']) / 60 / 60 / 24 / 365.25));
    $xtpl->assign('image', $row['image']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('owner', $owner['fullname']);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('image', $row['image']);
    $xtpl->assign('microchip', $row['microchip']);
    $xtpl->assign('breed', $row['breed']);
    $xtpl->assign('species', $row['species']);
    $xtpl->assign('sex', $sex_array[$row['sex']]);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function breedingList($filter = array('species' => '', 'breed' => '', 'keyword' => '', 'page' => '1', 'limit' => '12')) {
  global $db, $module_name;

  $xtpl = new XTemplate('breeding-list.tpl', PATH);
  $xtpl->assign('module_name', $module_name);

  $sql = 'select count(*) as count from `'. PREFIX .'_trade` a inner join `'. PREFIX .'_pet` b on a.petid = b.id where a.status = 1 and a.type = 2 and b.name like "%'. $filter['keyword'] .'%" and b.breed like "%'. $filter['species'] .'%" and b.species like "%'. $filter['breed'] .'%"';
  $query = $db->query($sql);
  $count = $query->fetch()['count'];
  $xtpl->assign('nav', navList($count, $filter['page'], $filter['limit']));

  $sql = 'select * from `'. PREFIX .'_trade` a inner join `'. PREFIX .'_pet` b on a.petid = b.id where a.status = 1 and a.type = 2 and b.name like "%'. $filter['keyword'] .'%" and b.breed like "%'. $filter['species'] .'%" and b.species like "%'. $filter['breed'] .'%" order by a.id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);

  while($row = $query->fetch()) {
    $owner = getOwnerById($row['userid'], $row['type']);
    $xtpl->assign('index', $index++);
    $xtpl->assign('age', floor((time() - $row['dateofbirth']) / 60 / 60 / 24 / 365.25));
    $xtpl->assign('image', $row['image']);
    $xtpl->assign('name', $row['name']);
    $xtpl->assign('owner', $owner['fullname']);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('image', $row['image']);
    $xtpl->assign('microchip', $row['microchip']);
    $xtpl->assign('breed', $row['breed']);
    $xtpl->assign('species', $row['species']);
    $xtpl->assign('sex', $sex_array[$row['sex']]);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function buyList($filter = array('species' => '', 'breed' => '', 'page' => '1', 'limit' => '12')) {
  global $db, $module_name, $sex_array;

  $xtpl = new XTemplate('buy-list.tpl', PATH);
  $xtpl->assign('module_name', $module_name);

  $sql = 'select count(*) as count from `'. PREFIX .'_buy` where status = 1 and breed like "%'. $filter['species'] .'%" and species like "%'. $filter['breed'] .'%" order by id desc';
  $query = $db->query($sql);
  $count = $query->fetch()['count'];
  $xtpl->assign('nav', navList($count, $filter['page'], $filter['limit']));

  $sql = 'select * from `'. PREFIX .'_buy` where status = 1 and breed like "%'. $filter['species'] .'%" and species like "%'. $filter['breed'] .'%" order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
  $query = $db->query($sql);

  while($row = $query->fetch()) {
    $owner = getOwnerById($row['userid'], $row['type']);
    $xtpl->assign('id', $row['id']);
    $xtpl->assign('species', $row['species']);
    $xtpl->assign('breed', $row['breed']);
    $xtpl->assign('age', $row['age']);
    $xtpl->assign('sex', $sex_array[$row['sex']]);
    // $xtpl->assign('index', $index++);
    // $xtpl->assign('name', $row['name']);
    // $xtpl->assign('owner', $owner['fullname']);
    // $xtpl->assign('id', $row['id']);
    // $xtpl->assign('image', $row['image']);
    // $xtpl->assign('microchip', $row['microchip']);
    // $xtpl->assign('breed', $row['breed']);
    // $xtpl->assign('species', $row['species']);
    // $xtpl->assign('sex', $sex_array[$row['sex']]);
    $xtpl->parse('main.row');
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function sendbackList($userid, $filter = array('page' => '1', 'limit' => '10')) {
  global $db;

  $xtpl = new XTemplate('sendback-list.tpl', PATH);
  $petid_list = selectPetidOfOwner($userid);

  if (!empty($petid_list)) {
    $sql = 'select count(*) as count from `'. PREFIX .'_trade` where status = 2 and petid in ('. $petid_list .')';
    $query = $db->query($sql);
    $count = $query->fetch()['count'];
    $xtpl->assign('nav', navList($count, $filter['page'], $filter['limit']));

    $sql = 'select * from `'. PREFIX .'_trade` where status = 2 and petid in ('. $petid_list .') order by id desc limit ' . $filter['limit'] . ' offset ' . ($filter['page'] - 1) * $filter['limit'];
    $query = $db->query($sql);

    while($row = $query->fetch()) {
      $pet = getPetById($row['petid']);
      $xtpl->assign('id', $row['id']);
      $xtpl->assign('name', $pet['name']);
      $xtpl->assign('species', $pet['species']);
      $xtpl->assign('breed', $pet['breed']);
      $xtpl->assign('image', $pet['image']);
      $xtpl->assign('note', $row['note']);
      $xtpl->parse('main.row');
    }
  }
  $xtpl->parse('main');
  return $xtpl->text();
}

function getMarketContent($id) {
  $html = '';
  $pet = getTradeById($id);
  $data = array(
    '1' => array(
      'act' => 'sellSubmit()',
      'text' => 'Cần bán',
      'class' => 'info'
    ),
    '2' => array(
      'act' => 'breedingSubmit()',
      'text' => 'Cần phối',
      'class' => 'info'
    )
  );

  if ($pet['1'] == 1) {
    $data['1'] = array(
      'act' => 'unsellSubmit()',
      'text' => 'Hủy',
      'class' => 'warning'
    );
  }
  if ($pet['2'] == 1) {
    $data['2'] = array(
      'act' => 'unbreedingSubmit()',
      'text' => 'Hủy',
      'class' => 'warning'
    );
  }

  $html .= '
    <hr>
    <label class="row">
      <div class="col-sm-6">
        Đăng bán
      </div>
      <div class="col-sm-6" style="text-align: right;">
        <button class="btn btn-'. $data['1']['class'] .'" onclick="'. $data['1']['act'] .'">
          '. $data['1']['text'] .'
        </button>
      </div>
    </label>
    <hr>
    <label class="row">
      <div class="col-sm-6">
        Đăng cho phối
      </div>
      <div class="col-sm-6" style="text-align: right;">
        <button class="btn btn-'. $data['2']['class'] .'" onclick="'. $data['2']['act'] .'">
          '. $data['2']['text'] .'
        </button>
      </div>
    </label>';
  return $html;
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
