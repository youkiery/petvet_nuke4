<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> Tài khoản </th>
      <th> Họ và tên </th>
      <th>  </th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr>
      <td> {index} </td>
      <td> {username} </td>
      <td> {fullname} </td>
      <td>  
        <!-- <button class="btn btn-info btn-xs" onclick="userConfig({id})">
          cấu hình
        </button> -->
        <button class="btn btn-danger btn-xs" onclick="removeUserSubmit({id})">
          xóa
        </button>
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
{nav}
<!-- END: main -->