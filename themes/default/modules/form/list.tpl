<!-- BEGIN: main -->
  <table class="table table-bordered">
    <tr>
      <th> STT </th>
      <th>Số phiếu</th>
      <th>Đơn in</th>
      <th>Số mẫu</th>
      <th>Loại mẫu</th>
    </tr>
    <tr>
      <td> {index} </td>
      <td> {code} </td>
      <td> {printer} </td>
      <td> {number} </td>
      <td> {sample} </td>
      <td>
        <button class="btn btn-info" onclick="edit({id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>  
        <button class="btn btn-remove" onclick="remove({id})">
          <span class="glyphicon glyphicon-danger"></span>
        </button>  
      </td>
    </tr>
  </table>
<!-- END: main -->