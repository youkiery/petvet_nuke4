<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> Mã phiếu </th>
      <th> <input type="checkbox"> </th>
      <th> Ngày nhập </th>
      <th> Số loại thiết bị </th>
      <th> Tổng lượng </th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr>
      <td> {id} </td>
      <th> <input type="checkbox"> </th>
      <td> {date} </td>
      <td> {count} </td>
      <td> {total} </td>
      <td> 
        <button class="btn btn-info" onclick="checkImport({import_id})">
          edit
        </button>  
        <button class="btn btn-danger">
          remove
        </button>  
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
<!-- END: main -->
