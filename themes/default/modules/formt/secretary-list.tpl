<!-- BEGIN: main -->
  <p> Hiển thị {from} - {end} trên {total} kết quả </p>
  <table class="table table-bordered">
    <tr>
      <th> Số phiếu </th>
      <th> Số ĐKXN </th>
      <th> Tên đơn vị </th>
      <th> Số lượng mẫu </th>
      <th> Trạng thái </th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
      <td> {code} </td>
      <td> {xcode} </td>
      <td> {unit} </td>
      <td> {number} </td>
      <td> {state} </td>
      <td>
        <button class="btn btn-info" onclick="editSecret({id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>  
      </td>
    </tr>
    <!-- END: row -->
  </table>
  {nav}
<!-- END: main -->