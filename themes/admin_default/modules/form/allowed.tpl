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
        {permission} <br>
        <span class="font-size: .75em"> {risk} </span>
      </td>
      <td>
        <button class="btn btn-info" onclick="getPermission({userid})">
          Thay đổi
        </button>

        <!-- BEGIN: admin -->
        <button class="btn btn-warning" onclick="admin({userid}, 0)">
          <span class="glyphicon glyphicon-user"></span>
        </button>
        <!-- END: admin -->
        <!-- BEGIN: noadmin -->
        <button class="btn btn-success" onclick="admin({userid}, 1)">
          <span class="glyphicon glyphicon-user"></span>
        </button>
        <!-- END: noadmin -->

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