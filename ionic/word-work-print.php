<?php
require_once 'bootstrap.php';
require_once(NV_ROOTDIR . '/ionic/work.php');
$work = new Work();

$startdate = strtotime('last monday');
$enddate = $startdate + 60 * 60 * 24 * 7 - 1;

$filter = array(
  'startdate' => date('d/m/Y', $startdate),
  'enddate' => date('d/m/Y', $enddate),
  'keyword' => '',
  'userid' => '',
);
use PhpOffice\PhpWord\Shared\Converter;
use PhpOffice\PhpWord\Style\TablePosition;
// Creating the new document...

$phpWord = new \PhpOffice\PhpWord\PhpWord();

$section= $phpWord->addSection(array('orientation' => 'landscape', 'marginLeft' => 600, 'marginRight' => 600,
'marginTop' => 600, 'marginBottom' => 600));
$header = array('size' => 16, 'bold' => true);

$fancyTableStyleName = 'Fancy Table';
$fancyTableStyle = array('borderSize' => 1, 'borderColor' => '000000', 'cellMargin' => 80, 'alignment' => \PhpOffice\PhpWord\SimpleType\JcTable::CENTER, 'cellMargin' => 80);
$fancyTableFirstRowStyle = array();
$fancyTableCellStyle = array('valign' => 'center');
$fancyTableCellBtlrStyle = array('valign' => 'center', 'textDirection' => \PhpOffice\PhpWord\Style\Cell::TEXT_DIR_BTLR);
$fancyTableFontStyle = array('bold' => true);

$cellRowSpan = array('vMerge' => 'restart');
$cellRowContinue = array('vMerge' => 'continue');
$cellColSpan = array('gridSpan' => 2);

$phpWord->addTableStyle($fancyTableStyleName, $fancyTableStyle, $fancyTableFirstRowStyle);
$table = $section->addTable($fancyTableStyleName, array('tableWidth', array(100, 'pct')));
$header_style = array('bold' => true);
$header_option = array('align' => 'center');

$table->addRow();
$table->addCell(2000, $fancyTableCellStyle)->addText("Nhân viên", $header_style, $header_option);
$table->addCell(2000, $fancyTableCellStyle)->addText("Thứ 2", $header_style, $header_option);
$table->addCell(2000, $fancyTableCellStyle)->addText("Thứ 3", $header_style, $header_option);
$table->addCell(2000, $fancyTableCellStyle)->addText("Thứ 4", $header_style, $header_option);
$table->addCell(2000, $fancyTableCellStyle)->addText("Thứ 5", $header_style, $header_option);
$table->addCell(2000, $fancyTableCellStyle)->addText("Thứ 6", $header_style, $header_option);
$table->addCell(2000, $fancyTableCellStyle)->addText("Thứ 7", $header_style, $header_option);
$table->addCell(2000, $fancyTableCellStyle)->addText("Chủ nhật", $header_style, $header_option);

$list = $work->getWork($filter, 1); // only completed
$data = array();
foreach ($list as $row) {
  if (empty($data[$row['userid']])) $data[$row['userid']] = array('name' => $row['name'], 'data' => array(1 => array(), array(), array(), array(), array(), array(), array()));
  $data[$row['userid']]['data'][$row['day']] []= $row;
}

foreach ($data as $user) {
  $table->addRow();
  $table->addCell(2000, $fancyTableCellStyle)->addText($user['name']);
  // echo json_encode($user);die();
  foreach ($user['data'] as $day) {
    $index = 1;
    $firstLine = true;
    $cell = $table->addCell(2000, $fancyTableCellStyle);
    // if (count($day)) {var_dump($day);die();}
    foreach ($day as $row) {
      if ($firstLine) $firstLine = false;
      else $cell->addTextBreak();
      $cell->addText(($index ++) . '. ' .$row['content']);
    }
  }
}

// $table->addRow();
// $table->addCell(null, $cellRowContinue);
// $table->addCell(null, $cellRowContinue);
// $table->addCell(2000)->addText("4");
// $table->addCell(2000)->addText("5");
// $table->addCell(null, $cellRowContinue);

// $table->addRow();
// $table->addCell(2000);
// $table->addCell(2000);
// $table->addCell(2000);
// $table->addCell(2000);
// $table->addCell(2000);

$name = 'work-'. time();
$doc = '/ionic/files/'. $name .'.docx';
$preview = '/ionic/files/'. $name .'.html';

$objWriter = \PhpOffice\PhpWord\IOFactory::createWriter($phpWord, 'HTML');
$objWriter->save(NV_ROOTDIR . $preview);

$objWriter = \PhpOffice\PhpWord\IOFactory::createWriter($phpWord, 'Word2007');
$objWriter->save(NV_ROOTDIR . $doc);

// $objWriter->save(NV_ROOTDIR . $preview);
// $fp = fopen(NV_ROOTDIR . $preview,"wb");
// fwrite($fp,'');
// $phpWord->save(NV_ROOTDIR . $preview, 'HTML');

// die('d');

$result['status'] = 1;
$result['name'] = $name;
$result['doc'] = 'http://' . $_SERVER['SERVER_NAME'] . $doc;
$result['preview'] = 'http://' . $_SERVER['SERVER_NAME'] . $preview;
