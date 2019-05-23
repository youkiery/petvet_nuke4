<!-- BEGIN: main -->
  <p> Hiển thị {from} - {end} trên {total} kết quả </p>
  <table class="table table-bordered">
    <tr>
      <th>Số phiếu</th>
      <th>Tên đơn vị</th>
      <th>Số mẫu</th>
      <th>Loại mẫu</th>
      <th>Loại động vật</th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
      <td> {code} </td>
      <td> {unit} </td>
      <td> {number} </td>
      <td> {type} </td>
      <td> {sample} </td>
      <td>
        <button class="btn btn-info" onclick="preview({id})">
          <span class="glyphicon glyphicon-eye-open"></span>
        </button>  
        <!-- BEGIN: mod -->
        <button class="btn btn-info" onclick="edit({id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>  
        <button class="btn btn-danger" onclick="remove({id})">
          <span class="glyphicon glyphicon-remove"></span>
        </button>  
        <!-- END: mod -->
      </td>
    </tr>
    <!-- END: row -->
  </table>
  {nav}
<!-- END: main -->