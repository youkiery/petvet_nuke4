<!-- BEGIN: main -->
<p> 
  <!-- BEGIN: msg -->
  Tìm kiếm {keyword} từ {from} đến {end} trong {count} kết quả
  <!-- END: msg -->
</p>
<table class="table">
  <tr>
    <th> STT </th>
    <th> Tên </th>
    <th> Số microchip </th>
    <th> Giới tính </th>
    <th> Ngày sinh </th>
    <th> Giống </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tbody>
    <tr class="clickable-row" data-href=''>
      <td> <a href="/index.php?nv=biograph&op=detail&id={id}"> {index} </a> </td>
      <td> <a href="/index.php?nv=biograph&op=detail&id={id}"> {name} </a> </td>
      <td> <a href="/index.php?nv=biograph&op=detail&id={id}"> {microchip} </a> </td>
      <td> <a href="/index.php?nv=biograph&op=detail&id={id}"> {sex} </a> </td>
      <td> <a href="/index.php?nv=biograph&op=detail&id={id}"> {dob} </a> </td>
      <td> <a href="/index.php?nv=biograph&op=detail&id={id}"> {breed} </a> </td>
      <td>
        <!-- BEGIN: mod -->
        <button class="btn btn-info" onclick="editPet({id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>
        <button class="btn btn-danger" onclick="deletePet({id})">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
        <!-- END: mod -->
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
{nav}

<!-- END: main -->
