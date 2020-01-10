<?php

/**
 * @Project Mining 0.1
 * @Author Mimic-san
 * @Copyright (C) 2019
 * @Createdate 16-09-2019 13:15
 */

if (!defined('NV_IS_FILE_ADMIN')) die('Stop!!!');
define('PREFIX', NV_PREFIXLANG . "_" . $module_data);

$action = $nv_Request->get_string('action', 'post', '');

function parseTime($time) {
  if (count($time_part = explode('/', $time)) == 3 || count($time_part = explode('-', $time)) == 3) {
    if (($timer = strtotime("$time_part[0]/$time_part[1]/$time_part[2]")) || ($timer = strtotime("$time_part[1]/$time_part[0]/$time_part[2]"))) {
      return $timer;
    }
    return false;
  }
  return false;
}

function alias($str) {
  $str = str_replace(' ', '-', trim(mb_strtolower($str)));
  $str = preg_replace("/(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)/", 'a', $str);
  $str = preg_replace("/(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)/", 'e', $str);
  $str = preg_replace("/(ì|í|ị|ỉ|ĩ)/", 'i', $str);
  $str = preg_replace("/(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)/", 'o', $str);
  $str = preg_replace("/(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)/", 'u', $str);
  $str = preg_replace("/(ỳ|ý|ỵ|ỷ|ỹ)/", 'y', $str);
  $str = preg_replace("/(đ)/", 'd', $str);
  return $str;
}

if (!empty($action)) {
  $result = array('status' => 0);
  switch ($action) {
    case 'check':
      $data = $nv_Request->get_array('data', 'post', '');

      $array = array();
      $error_list = '';
      $count = 0;
      $count2 = 0;
      foreach ($data as $row) {
        $count2 ++;
        $error = array();
        $array = array(
          'type' => $row['Loại công văn'],
          'date_iss' => $row['Ngày ban hành'],
          'date_first' => $row['Ngày có hiệu lực'],
          'from_time' => $row['Ngày gửi'],
          'from_signer' => $row['Người ký'],
          'code' => $row['Số công văn'], // text
          'excode' => $row['Số công văn đến/đi'], // text
          'catid' => $row['Thuộc chủ đề'],
          'content' => $row['Trích yếu công văn'], // text
          'status' => mb_strtolower($row['Trạng thái']),
          'title' => $row['Tên công văn'], // text
          'from_depid' => $row['Tên phòng gửi'],
          'to_org' => $row['Đơn vị nhận'], // text
          'from_org' => $row['Đơn vị soạn'], // text
          'date_die' => $row['Ngày hết hiệu lực'],
          'file' => $row['Công văn đính kèm'], // text
          'dedo' => $row['Phòng ban nhận'],
          'dedo1' => $row['Phòng ban nhận 1'],
          'dedo2' => $row['Phòng ban nhận 2'],
          'dedo3' => $row['Phòng ban nhận 3'],
          'dedo4' => $row['Phòng ban nhận 4'],
        );
        // var_dump($array);die();
        foreach ($array as $key => $value) {
          $array[$key] = preg_replace('/^\p{Z}+|\p{Z}+$/u', '', $value);
        }

        if (!($array['date_iss'] = parseTime($array['date_iss']))) {
          $error[] = 'Ngày ban hành sai';
        }
        if (!($array['date_first'] = parseTime($array['date_first']))) {
          $error[] = 'Ngày có hiệu lực sai';
        }
        if (!($array['from_time'] = parseTime($array['from_time']))) {
          $error[] = 'Ngày gửi sai';
        }
        $array['date_die'] = 0;
        if (!empty($array['date_die'])) {
          if (!($array['date_die'] = parseTime($array['date_die']))) {
            $error[] = 'Ngày hết hiệu lực sai';
          }
        }

        if (strpos('để', $array['status']) !== false) {
          $array['status'] = 2;
        }
        else if (strpos('đã', $array['status']) !== false) {
          $array['status'] = 1;
        }
        else {
          $array['status'] = 0;
        }

        $sql = 'select * from `'. PREFIX .'_type` where lower(title) like "%' . mb_strtolower($array['type']) . '%"';
        $query = $db->query($sql);
        if (empty($row = $query->fetch())) {
          $error[] = 'Loại công văn không tồn tại';
        }
        else {
          $array['type'] = $row['id'];
        }
        
        $sql = 'select * from `'. PREFIX .'_cat` where lower(title) like "%' . mb_strtolower($array['catid']) . '%"';
        $query = $db->query($sql);
        if (empty($row = $query->fetch())) {
          $error[] = 'Loại chủ đề không tồn tại';
        }
        else {
          $array['catid'] = $row['id'];
        }
        
        $sql = 'select * from `'. PREFIX .'_signer` where lower(name) like "%' . mb_strtolower($array['from_signer']) . '%"';
        $query = $db->query($sql);
        if (empty($row = $query->fetch())) {
          $sql = 'select * from `'. PREFIX .'_signer` order by weight limit 1';
          $query = $db->query($sql);
          $signer = $query->fetch();
          $sql = 'insert into `'. PREFIX .'_signer` values(null, "'. $array['from_signer'] .'", "", '. ($signer['weight'] + 1) .', 1)';
          $db->query($sql);
          $array['from_signer'] = $db->lastInsertId();
        }
        else {
          $array['from_signer'] = $row['id'];
        }

        $sql = 'select * from `'. PREFIX .'_departments` where lower(title) like "%' . mb_strtolower(str_replace('&', '&amp;', $array['from_depid'])) . '%"';
        $query = $db->query($sql);
        if (empty($row = $query->fetch())) {
          $error[] = 'Phòng ban gửi không tồn tại';
        }
        else {
          $array['from_depid'] = $row['id'];
        }

        if (count($error) > 0) {
          $result['status'] = 2;
          $error_list .= "<p style=\"margin: 10px 0px 0px 0px;\"> <b> Dòng số $count2: </b> </p>" . implode('<br>', $error);
        }
        else {
          $alias = alias($array['title']);
          $sql = "select count(*) as count from `" . NV_PREFIXLANG . "_" . $module_data . "_document` where alias like '%$alias%'";
          $query = $db->query($sql);
          if (!empty($row = $query->fetch())) {
            $alias .= '-' . $row['count'];
          }
          $sql = "INSERT INTO " . NV_PREFIXLANG . "_" . $module_data . "_document VALUES (
          	NULL,
          	" . $array['type'] . ",
          	" . $array['catid'] . ",'". $alias ."',
          	" . $db->quote($array['title']) . ",
          	" . $db->quote($array['code']) . ",
          	" . $db->quote($array['excode']) . ",
          	" . $db->quote($array['content']) . ",
          	" . $db->quote($array['file']) . ",
          	" . $db->quote($array['from_org']) . "," . $array['from_depid'] . ",
          	" . $array['from_signer'] . ",
          	" . $array['from_time'] . ",
          	" . $array['date_iss'] . ",
          	" . $array['date_first'] . ",
          	" . $array['date_die'] . ",
          	" . $db->quote($array['to_org']) . ", 4,
            " . $array['status'] . ", 0 )";
            
          if ($db->query($sql)) {
            $id = $db->lastInsertId();
            if (!empty($array['dedo'])) {
              $dedo = explode(', ', $array['dedo']);
            }
            else {
              $dedo = array();
              if (!empty($array['dedo1'])) $dedo[]= $array['dedo1'];
              if (!empty($array['dedo2'])) $dedo[]= $array['dedo2'];
              if (!empty($array['dedo3'])) $dedo[]= $array['dedo3'];
              if (!empty($array['dedo4'])) $dedo[]= $array['dedo4'];
            }
    
            foreach ($dedo as $dedo_name) {
              $sql = 'select * from ' . NV_PREFIXLANG . '_' . $module_data . '_departments where title like "%'. trim($dedo_name) .'%"';
              $dedo_query = $db->query($sql);
              if ($dedo_data = $dedo_query->fetch()) {
                $sql = 'insert into ' . NV_PREFIXLANG . '_' . $module_data . '_de_do values (null, '. $id .', '. $dedo_data['id'] .')';
                $db->query($sql);
              }
            }
            $count ++;
          }
        }
      }

      $result['status'] = 1;
      $result['html'] = "Đã thêm $count trong tổng số $count2 dòng";
      if (!empty($error_list)) {
        $result['error'] = $error_list;
      }

    break;
  }
  echo json_encode($result);
  die();
}

$path = NV_ROOTDIR . "/themes/" . $global_config['module_theme'] . "/modules/" . $module_file;
$xtpl = new XTemplate("excel.tpl", $path);

$xtpl->parse('main');
$contents = $xtpl->text();

$page_title = $lang_module['add_document'];

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';