<?php

/**
 * @Project NUKEVIET 4.x
 * @Author VINADES.,JSC <contact@vinades.vn>
 * @Copyright (C) 2014 VINADES.,JSC. All rights reserved
 * @License GNU/GPL version 2 or any later version
 * @Createdate Tue, 19 Jul 2011 09:07:26 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) die('Stop!!!');

define('PREFIX', NV_PREFIXLANG . "_" . $module_data);

$page_title = $module_info['site_title'];
$key_words = $module_info['keywords'];
$se = $from = $to = $from_signer = 0;
$type = '';
$code = $content = '';

$xco = array('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AK', 'AM', 'AN', 'AO', 'AP', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY', 'AZ');
$yco = array('index' => 'STT', 'title' => 'Tên công văn', 'catid' => 'Chủ đề', 'type' => 'Loại công văn', 'from_time' => 'Ngày gửi', 'code' => 'Số công văn', 'from_org' => 'Đơn vị soạn', 'to_org' => 'Đơn vị nhận', 'from_depid' => 'Tên phòng gửi', 'from_signer' => 'Người ký', 'date_iss' => 'Ngày ban hành', 'date_first' => 'Ngày có hiệu lực', 'date_die' => 'Ngày hết hiệu lực', 'content' => 'Trích yếu công văn', 'statusid' => 'Trạng thái', 'deid' => 'Phòng ban nhận');
$status = array(0 => 'Chưa xử lý', 'Đã xử lý', 'Để lưu');

$array = array();
$error = '';
$sql = "FROM " . NV_PREFIXLANG . "_" . $module_data . "_document a inner join " . NV_PREFIXLANG . "_" . $module_data . "_departments b on a.from_depid = b.id WHERE a.id!=0";
$base_url = NV_BASE_SITEURL . "index.php?" . NV_NAME_VARIABLE . "=" . $module_name;

$listcats = nv_listcats(0);
$listdes = nv_listdes(0);
$listtypes = nv_listtypes($type);
$page_title = $lang_module['table'];

$sql2 = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_departments";
$query = $db->query($sql2);
$listdeparts = array();
while ($depart_row = $query->fetch()) {
  $listdeparts[$depart_row["id"]] = $depart_row;
}

if ($nv_Request->isset_request("excel", "get")) {
  include 'PHPExcel/IOFactory.php';
  $fileType = 'Excel2007'; 
  $objPHPExcel = PHPExcel_IOFactory::load('excel.xlsx');

  $data = $nv_Request->get_string('data', 'get', '');
  $fromTime = totime($nv_Request->get_string('fromTime', 'get/post', ''));
  $endTime = totime($nv_Request->get_string('endTime', 'get/post', ''));
  $j = 0;

  if (trim($data)) {
    $data = explode(',', $data);

    foreach ($data as $tag) {
      if (!empty($yco[$tag])) {
        $objPHPExcel
        ->setActiveSheetIndex(0)
        ->setCellValue($xco[$j ++] . '1', $yco[$tag]);
      }
    }
    $query = "SELECT * FROM " . PREFIX . "_document where from_time between $fromTime and $endTime";
    $re = $db->query($query);
    $index = 1;
    $i = 2;
    while ($row = $re->fetch()) {
      $j = 0;
      foreach ($data as $tag) {
        switch ($tag) {
          case 'index':
            $objPHPExcel
              ->setActiveSheetIndex(0)
              ->setCellValue($xco[$j ++] . $i, (($index < 10 ? '0' : '') . $index));
            $index ++;
            break;
          case 'catid':
            $sql = 'select * from `'. PREFIX .'_cat` where id = ' . $row[$tag];
            $query = $db->query($sql);
            if ($row2 = $query->fetch()) {
              $objPHPExcel
              ->setActiveSheetIndex(0)
              ->setCellValue($xco[$j ++] . $i, $row2['title']);
            }
          break;
          case 'from_depid':
            $sql = 'select * from `'. PREFIX .'_departments` where id = ' . $row[$tag];
            $query = $db->query($sql);
            if ($row2 = $query->fetch()) {
              $objPHPExcel
              ->setActiveSheetIndex(0)
              ->setCellValue($xco[$j ++] . $i, $row2['title']);
            }
          break;
          case 'from_signer':
            $sql = 'select * from `'. PREFIX .'_signer` where id = ' . $row[$tag];
            $query = $db->query($sql);
            if ($row2 = $query->fetch()) {
              $objPHPExcel
              ->setActiveSheetIndex(0)
              ->setCellValue($xco[$j ++] . $i, $row2['name']);
            }
          break;
          case 'type':
            $sql = 'select * from `'. PREFIX .'_type` where id = ' . $row[$tag];
            $query = $db->query($sql);
            if ($row2 = $query->fetch()) {
              $objPHPExcel
              ->setActiveSheetIndex(0)
              ->setCellValue($xco[$j ++] . $i, $row2['title']);
            }
          break;
          case 'statusid':
            $objPHPExcel
            ->setActiveSheetIndex(0)
            ->setCellValue($xco[$j ++] . $i, $status[$row[$tag]]);
          break;
          case 'deid':
            $sql = 'select * from `'. PREFIX .'_de_do` where doid = ' . $row['id'];
            $query = $db->query($sql);
            $list = array();
            while ($row2 = $query->fetch()) {
              $sql = 'select * from `'. PREFIX .'_departments` where id = ' . $row2['deid'];
              $query2 = $db->query($sql);
              $row3 = $query2->fetch();
              $list[] = $row3['title'];
            }
            $objPHPExcel
            ->setActiveSheetIndex(0)
            ->setCellValue($xco[$j ++] . $i, implode(', ', $list));
          break;
          case 'from_time':
          case 'date_iss':
          case 'date_first':
          case 'date_die':
            $value = '';
            if (!empty($row[$tag])) {
              $value = date('d/m/Y', $row[$tag]);
            }
            $objPHPExcel
            ->setActiveSheetIndex(0)
            ->setCellValue($xco[$j ++] . $i, $value);
          break;
          default: 
            $objPHPExcel
            ->setActiveSheetIndex(0)
            ->setCellValue($xco[$j ++] . $i, $row[$tag]);
          break;
        }
      }
      $i ++;
    }
  }
  else {
    $objPHPExcel
      ->setActiveSheetIndex(0)
      ->setCellValue('A1', "Ngày đến")
      ->setCellValue('B1', "Số đến")
      ->setCellValue('C1', "Tác giả")
      ->setCellValue('D1', "Số, ký hiệu văn bản")
      ->setCellValue('E1', "Ngày tháng ban hành VB")
      ->setCellValue('F1', "Tên loại và trích yếu nội dung")
      ->setCellValue('G1', "Đơn vị hoặc người nhận VB")
      ->setCellValue('H1', "")
      ->setCellValue('I1', "")
      ->setCellValue('J1', "");
    $i = 2;
    $query = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_document where from_time between $fromTime and $endTime";
  
    $re = $db->query($query);
    while ($row = $re->fetch()) {
      $query = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_departments where id = $row[from_depid]";
      $ru = $db->query($query);
      $depart = $ru->fetch();
  
      $query = "SELECT * FROM " . NV_PREFIXLANG . "_" . $module_data . "_signer where id = $row[from_signer]";
      $ru = $db->query($query);
      $signer = $ru->fetch();
  
      $objPHPExcel
      ->setActiveSheetIndex(0)
      ->setCellValue('A' . $i, date('d/m/Y', $row['from_time']))
      ->setCellValue('B' . $i, $row['id'])
      ->setCellValue('C' . $i, $row['from_org'])
      ->setCellValue('D' . $i, $row['code'])
      ->setCellValue('E' . $i, date('d/m/Y', $row['date_iss']))
      ->setCellValue('F' . $i, $row['content'])
      ->setCellValue('G' . $i, $row['to_org'])
      ->setCellValue('H' . $i, '')
      ->setCellValue('I' . $i, '')
      ->setCellValue('J' . $i, '');
      $i++;
    }
  }
  $objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, $fileType);
  $objWriter->save('excel-output.xlsx');
	$objPHPExcel->disconnectWorksheets();
	unset($objWriter, $objPHPExcel);
  header('location: /excel-output.xlsx?t=' . time());
}
if ($nv_Request->isset_request("se", "get")) {
  $page_title = $lang_module['list_se'];
  $se = $nv_Request->get_int('se', 'get', 0);
}
if ($nv_Request->isset_request("type", "get")) {
  $type = $nv_Request->get_int('type', 'get', 0);
  if ($type != 0) {
    $page_title = sprintf($lang_module['cv_list_by_type'], $listtypes[$type]['title']);
    $a_t = array();
    $query = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_type WHERE id=" . $type . " OR parentid= " . $type;
    $re = $db->query($query);
    while ($row = $re->fetch()) {
      $a_t[] = $row['id'];
    }
    $query = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_type WHERE id IN (" . implode(',', $a_t) . ")";
    $re = $db->query($query);
    if ($row = $re->fetch()) {
      $a_t[] = $row['id'];
    }

    $sql .= " AND a.type IN (" . implode(',', $a_t) . ")";

    $base_url .= "&amp;type=" . $type;
  }
}

if ($nv_Request->isset_request("depart", "get")) {
  $depart = $nv_Request->get_int('depart', 'get', 0);
  if ($depart != 0) {
    $page_title = sprintf($lang_module['print_depart'], $listdeparts[$depart]['title']);
    $a_t = array();
    $query = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_departments WHERE id=" . $depart . " OR parentid= " . $depart;
    $re = $db->query($query);
    while ($row = $re->fetch()) {
      $a_t[] = $row['id'];
    }
    $query = "SELECT id FROM " . NV_PREFIXLANG . "_" . $module_data . "_departments WHERE id IN (" . implode(',', $a_t) . ")";
    $re = $db->query($query);
    if ($row = $re->fetch()) {
      $a_t[] = $row['id'];
    }

    $sql .= " AND b.id IN (" . implode(',', $a_t) . ")";

    $base_url .= "&amp;depart=" . $depart;
  }
}

if ($nv_Request->isset_request("from", "get")) {

  $from = $nv_Request->get_title('from', 'get,post', '');

  unset($m);
  if (preg_match("/^([0-9]{1,2})\.([0-9]{1,2})\.([0-9]{4})$/", $from, $m)) {
    $from = mktime(0, 0, 0, $m[2], $m[1], $m[3]);
  } else {
    $from = 0;
  }

  if ($from != 0) {
    $sql .= " AND a.from_time >= " . $from;
    $base_url .= "&amp;from =" . $from;
  }
}
if ($nv_Request->isset_request("to", "get")) {
  $to = $nv_Request->get_title('to', 'get,post', '');

  unset($m);
  if (preg_match("/^([0-9]{1,2})\.([0-9]{1,2})\.([0-9]{4})$/", $to, $m)) {
    $to = mktime(0, 0, 0, $m[2], $m[1], $m[3]);
  } else {
    $to = 0;
  }
  if ($to != 0) {

    $sql .= " AND a.from_time <= " . $to;
    $base_url .= "&amp;to=" . $to;
  }
}

if ($nv_Request->isset_request("from_signer", "get")) {
  $from_signer = $nv_Request->get_int('from_signer', 'get', 0);

  if ($from_signer != 0) {
    $sql .= " AND a.from_signer=" . $from_signer;
    $base_url .= "&amp;from_signer=" . $from_signer;
  }
}

if ($nv_Request->isset_request("title", "get")) {
  $title = $nv_Request->get_title('title', 'get', '');
  if ($title != '') {
    $page_title = sprintf($lang_module['print_title'], '...' . $title . '...');
  }
  $sql .= " AND a.title LIKE '%" . $db->dblikeescape($title) . "%' ";
  $base_url .= "&amp;title=" . urlencode($title);
}
if ($nv_Request->isset_request("code", "get")) {
  $code = $nv_Request->get_title('code', 'get', '');
  if ($code != '') {
    $page_title = sprintf($lang_module['print_code'], '...' . $code . '...');
  }
  $sql .= " AND a.code LIKE '%" . $db->dblikeescape($code) . "%' ";
  $base_url .= "&amp;code=" . urlencode($code);
}
if ($nv_Request->isset_request("excode", "get")) {
  $excode = $nv_Request->get_title('excode', 'get', '');
  if ($excode != '') {
    $page_title = sprintf($lang_module['print_excode'], '...' . $excode . '...');
  }
  $sql .= " AND a.excode LIKE '%" . $db->dblikeescape($excode) . "%' ";
  $base_url .= "&amp;excode=" . urlencode($excode);
}

$tab = $nv_Request->get_title('tab', 'get', '');
if (empty($tab)) {
  $tab = 1;
}
$sql .= " AND a.catid = $tab ";
$base_url .= "&amp;tab=" . urlencode($tab);

if ($nv_Request->isset_request("content", "get")) {
  $content = $nv_Request->get_title('content', 'get', '');
  $sql .= " AND a.content LIKE '%" . $db->dblikeescape($content) . "%' ";
  $base_url .= "&amp;content=" . urlencode($content);
}

$sql1 = "SELECT COUNT(*) " . $sql;

$result1 = $db->query($sql1);
$all_page = $result1->fetchColumn();

if (!$all_page) {
  $error = $lang_module['search_empty'];
}

$sql .= " ORDER BY from_time DESC";

$page = $nv_Request->get_int('page', 'get', 0);
$per_page = 30;
$sql2 = "SELECT a.*, b.id as departid, b.title as depart " . $sql . " LIMIT " . $page . ", " . $per_page;
// die($sql2);
$query2 = $db->query($sql2);

$array = array();
$i = 0;

while ($row = $query2->fetch()) {
  $i = $i + 1;

  if ($listtypes[$row['type']]['status'] == 1 && nv_user_in_groups($row['groups_view'])) {
    if (nv_date('d.m.Y', $row['from_time']) == nv_date('d.m.Y', NV_CURRENTTIME)) {
      $row['code'] = $row['code'] . "<img src=\"" . NV_BASE_SITEURL . "themes/" . $module_info['template'] . "/images/" . $module_file . "/new.gif\">";
    }
    if (strlen($row['content']) > 100) {
      $row['content'] = nv_clean60($row['content'], 100);
    }
    $row['to_org'] = '- ' . $row['to_org'];
    if (strpos($row['to_org'], ',')) {
      $row['to_org'] = str_replace(',', '<br />- ', $row['to_org']);

    }

    $array[$row['id']] = array(
      'id' => (int) $row['id'],
      'stt' => $i,
      'title' => $row['title'],
      'code' => $row['code'],
      'from_org' => $row['from_org'],
      'to_org' => $row['to_org'],
      'cat' => $listcats[$row['catid']]['title'],
      'type' => $listtypes[$row['type']]['title'],
      'file' => $row['file'],
      'content' => $row['content'],
      'link_type' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . "&amp;type=" . $row['type'],
      'link_cat' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . "&amp;type=" . $row['type'] . "&catid=" . $row['catid'],
      'from_times' => $row['from_time'],
      'from_time' => nv_date('d.m.Y', $row['from_time']),
      'status' => $arr_status[$row['status']]['name'],
      'link_code' => NV_BASE_SITEURL . 'index.php?' . NV_LANG_VARIABLE . '=' . NV_LANG_DATA . '&amp;' . NV_NAME_VARIABLE . '=' . $module_name . "&amp;op=detail/" . $row['alias']
    );
    if (!empty($depart)) {
      $array[$row['id']]["departid"] = $row["departid"];
      $array[$row['id']]["depart"] = $row["depart"];
    }
  }
}

if (empty($array)) {
  $error = $lang_module['error_rows'];
}

$contents = nv_theme_congvan_main($error, $array, $page_title, $base_url, $all_page, $per_page, $page, $type, $se, $to, $from, $from_signer, $content, $code, $excode, $tab, $title, $depart);

include NV_ROOTDIR . '/includes/header.php';
echo nv_site_theme($contents);
include NV_ROOTDIR . '/includes/footer.php';