<!-- BEGIN: main -->
  Tổng cộng {count} bản ghi
  <table class="table">
    <thead>
      <tr>
        <th> Ngày </th>
        <th> Người chi </th>
        <th> Tiền chi </th>
        <th></th>
      </tr>
    </thead>
    <tbody>
      <!-- BEGIN: row -->
      <tr>
        <td> {index} </td>
        <td> {date} </td>
        <td> {driver} </td>
        <td> {money}  </td>
        <td> <button class="btn btn-danger" onclick="removeRecord({id}, 2)"> <span class="glyphicon glyphicon-remove"></span> </button> </td>
      </tr>
      <!-- END: row -->
    </tbody>
  </table>
  <div>
    Trang
    {nav}
  </div>
<!-- END: main -->