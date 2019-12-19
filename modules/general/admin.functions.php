<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_ADMIN') or !defined('NV_MAINFILE') or !defined('NV_IS_MODADMIN')) die('Stop!!!');
define('NV_IS_FILE_ADMIN', true);
define('PATH', NV_ROOTDIR . '/modules/' . $module_file . '/template/admin/' . $op);
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/global.functions.php');
include_once(NV_ROOTDIR . '/modules/' . $module_file . '/theme.php');


function bloodStatistic() {
    global $db, $db_config, $module_name, $nv_Request;
    $filter = $nv_Request->get_array('filter', 'post');

    $check = 0;
    if (empty($filter['from'])) {
      $check += 1;
    }
    if (empty($filter['end'])) {
      $check += 2;
    }
  
    switch ($check) {
      case 1:
        $filter['end'] = totime($filter['end']);
        $filter['from'] = $filter['from'] - 60 * 60 * 24 * 30;
      break;
      case 2:
        $filter['from'] = totime($filter['from']);
        $filter['end'] = $filter['end'] + 60 * 60 * 24 * 30;
      break;
      case 3:
        $time = strtotime(date('Y/m/d'));
        $filter['from'] = $time - 60 * 60 * 24 * 15;
        $filter['end'] = $time + 60 * 60 * 24 * 15;
      break;
      default:
        $filter['from'] = totime($filter['from']);
        $filter['end'] = totime($filter['end']);
    }
    
    $xtpl = new XTemplate("statistic-list.tpl", PATH);
    $xtpl->assign('from', date('d/m/Y', $filter['from']));
    $xtpl->assign('end', date('d/m/Y', $filter['end']));
    $doctor = getDoctorList();

    $sql = 'select * from `'. PREFIX .'blood_row` where (time between '. $filter['from'] .' and '. $filter['end'] .')';
    $query = $db->query($sql);
    $data = array();
    while ($row = $query->fetch()) {
      if (empty($data[$row['doctor']])) {
        $data[$row['doctor']]= array(
          'number' => 0,
          'real' => 0,
          'count' => 0
        );
      }
      $data[$row['doctor']]['count'] ++;
      $data[$row['doctor']]['number'] += $row['number'];
      $data[$row['doctor']]['real'] += ($row['start'] - $row['end']);
    }

    if (count($data)) {
      foreach ($data as $doctorid => $counter) {
        $xtpl->assign('doctor', $doctor[$doctorid]);
        $xtpl->assign('number', $counter['number']);
        $xtpl->assign('real', $counter['real']);
        $xtpl->assign('count', $counter['count']);
        $xtpl->parse('main.row');
      }
    }
    else {
      $xtpl->parse('main.non');
    }

    $sql = 'select * from `'. PREFIX .'blood_import` where (time between '. $filter['from'] .' and '. $filter['end'] .')';
    $query = $db->query($sql);
    $total = 0;
    while ($row = $query->fetch()) {
      $total += $row['number'];
    }
    $xtpl->assign('total', number_format($total * 1000, 0, '', ',') . ' VNĐ');

    $xtpl->parse('main');
    return $xtpl->text();
  }

?>
