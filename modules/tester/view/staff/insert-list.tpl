<!-- BEGIN: main  -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> Họ tên </th>
      <th> Người dùng </th>
      <th>  </th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr>
      <td> {index} </td>
      <td> {fullname} </td>
      <td> {username} </td>
      <td> 
        <button class="btn btn-success btn-xs" onclick="insert({userid})">
          thêm
        </button>
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
<!-- END: main  -->
