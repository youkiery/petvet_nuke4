<!-- BEGIN: main -->
  <p> Hiển thị {from} - {end} trên {total} kết quả </p>
  <table class="table table-bordered">
    <tr>
      <th> STT </th>
      <th>Số phiếu</th>
      <th>Đơn in</th>
      <th>Số mẫu</th>
      <th>Loại mẫu</th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
      <td> {index} </td>
      <td> {code} </td>
      <td> {printer} </td>
      <td> {number} </td>
      <td> {type} </td>
      <td>
        <button class="btn btn-info" onclick="edit({id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>  
        <button class="btn btn-danger" onclick="remove({id})">
          <span class="glyphicon glyphicon-remove"></span>
        </button>  
      </td>
    </tr>
    <!-- END: row -->
  </table>
<!-- END: main -->