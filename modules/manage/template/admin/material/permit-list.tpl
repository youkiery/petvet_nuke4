<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
  <tr>
    <th> STT </th>
    <th> Tài khoản </th>
    <th> Họ tên </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td> {username} </td>
    <td> {fullname} </td>
    <td>
      <button class="btn {type_btn} btn-xs" onclick="changePermit({id}, {type})">
        {type_name}
      </button>
      <button class="btn btn-danger btn-xs" onclick="removeEmploy({id})">
        xóa
      </button>
    </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: main -->