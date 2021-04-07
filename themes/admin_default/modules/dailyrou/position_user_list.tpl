<!-- BEGIN: main -->
  <table class="table table-bordered">
    <tr>
      <th>
        Số thứ tự
      </th>
      <th>
        Họ và tên
      </th>
      <th>
        Tài khoản
      </th>
      <th></th>
    </tr>
    <!-- BEGIN: row -->
    <tr>
      <td>
        {index}
      </td>
      <td>
        {fullname}
      </td>
      <td>
        {username}
      </td>
      <td class="text-center">
        <!-- BEGIN: position -->
        <button class="btn btn-sm btn-{type}" onclick="setPosition('{type}', {userid}, {id})">
          {position}
        </button>
        <!-- END: position -->
      </td>
    </tr>
    <!-- END: row -->
  </table>
<!-- END: main -->
