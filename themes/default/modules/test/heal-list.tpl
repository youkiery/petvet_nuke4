<!-- BEGIN: main -->
<p> Có tổng cộng {total} ca </p>
<table class="table">
  <thead>
    <tr>
      <th>
        Ngày tháng
      </th>
      <th>
        Khách hàng
      </th>
      <th>
        Số điện thoại
      </th>
      <th>
        Tên thú
      </th>
      <th> Cân nặng</th>
      <th></th>
    </th>
  </thead>
  <tbody>
  <!-- BEGIN: row -->
    <tr id="{id}">
      <td> {time} </td>
      <td> {customer} </td>
      <td> {phone} </td>
      <td> {petname} </td>
      <td> {weight}</td>
      <td> <button class="btn btn-info" onclick="edit({id})"> <span class="glyphicon glyphicon-edit"></span> </button> <button class="btn btn-danger" onclick="remove({id})"> <span class="glyphicon glyphicon-remove"></span> </button> </td>
    </tr>
  <!-- END: row -->
  </tbody>
</table>
<!-- END: main -->
