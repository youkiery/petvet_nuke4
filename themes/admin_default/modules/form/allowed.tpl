<!-- BEGIN: main -->
  <table class="table">
    <tr>
      <th>
        Tài khoản
      </th>
      <th>
        Tên người dùng
      </th>
      <th>
        Quyền sử dụng
      </th>
      <th>

      </th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
      <td>
        {username}
      </td>
      <td>
        {fullname}
      </td>
      <td>
        {permission}
      </td>
      <td>
        <!-- BEGIN: up -->
        <button class="btn btn-info" onclick="upUser({userid})">
          <span class="glyphicon glyphicon-arrow-up"></span>
        </button>
        <!-- END: up -->
        <!-- BEGIN: down -->
        <button class="btn btn-warning" onclick="downUser({userid})">
          <span class="glyphicon glyphicon-arrow-down"></span>
        </button>
        <!-- END: down -->
        <button class="btn btn-danger" onclick="removeUser({userid})">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </td>
    </tr>
    <!-- END: row -->
  </table>
<!-- END: main -->