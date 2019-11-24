<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <th> STT </th>
    <th> Ngày xuất </th>
    <th> Số vật tư </th>
    <th> Tổng lượng </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td> {date} </td>
    <td> {count} </td>
    <td> {total} </td>
    <td>
      <button class="btn btn-info" onclick="checkExport({id})">
        <span class="glyphicon glyphicon-edit"></span>
      </button>  
      <button class="btn btn-danger" onclick="exportRemove({id})">
        <span class="glyphicon glyphicon-remove"></span>
      </button>  
    </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: main -->
