<!-- BEGIN: main -->
<p> {keyword} {from} - {end} trong {total} kết quả</p>
<table class="table">
  <tr>
    <th> STT </th>
    <th> Tên </th>
    <th> Số microchip </th>
    <th> Giới tính </th>
    <th> Ngày sinh </th>
    <th> Giống </th>
  </tr>
  <!-- BEGIN: row -->
  <tr class="clickable-row" data-href='/index.php?nv=biograph&op=detail&id={id}'>
    <td> {index} </td>
    <td> {name} </td>
    <td> {microchip} </td>
    <td> {sex} </td>
    <td> {dob} </td>
    <td> {breed} </td>
  </tr>
  <!-- END: row -->
</table>
{nav}

<!-- END: main -->
