<?php

/**
 * @Project Mining 0.1
 * @Author Frogsis
 * @Createdate Mon, 28 Oct 2019 15:00:00 GMT
 */

if (!defined('NV_IS_MOD_CONGVAN')) die('Stop!!!');

$xco = array(1 => 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'AA', 'AB', 'AC', 'AD', 'AE', 'AF', 'AG', 'AH', 'AI', 'AJ', 'AK', 'AM', 'AN', 'AO', 'AP', 'AQ', 'AR', 'AS', 'AT', 'AU', 'AV', 'AW', 'AX', 'AY', 'AZ');
$title = array(1 => 'STT', 'name', 'n1', 'n2', 'low', 'pos', 'tag');

include 'PHPExcel/IOFactory.php';
$fileType = 'Excel2007';
$objPHPExcel = PHPExcel_IOFactory::load('excel.xlsx');

// settitle
$j = 1;
foreach ($title as $key => $value) {
  $objPHPExcel
  ->setActiveSheetIndex(0)
  ->setCellValue($xco[$key] . $j, $value);
}
$j++;
$sql = 'select * from `'. PREFIX .'product`';
$query = $db->query($sql);

while ($row = $query->fetch()) {
  $i = 1;
  $tag = getProductTagId($row['id']);
  $product = getProductId($row['itemid']);
  $objPHPExcel
  ->setActiveSheetIndex(0)
  ->setCellValue($xco[$i++] . $j, $index++)
  ->setCellValue($xco[$i++] . $j, $product['name'])
  ->setCellValue($xco[$i++] . $j, $row['n1'])
  ->setCellValue($xco[$i++] . $j, $row['n2'])
  ->setCellValue($xco[$i++] . $j, $row['low'])
  ->setCellValue($xco[$i++] . $j, $row['pos'])
  ->setCellValue($xco[$i++] . $j, implode(', ', $tag));
  $j++;
}

$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, $fileType);
$objWriter->save('excel-product.xlsx');
$objPHPExcel->disconnectWorksheets();
unset($objWriter, $objPHPExcel);
header('location: /excel-product.xlsx?t=' . time());
