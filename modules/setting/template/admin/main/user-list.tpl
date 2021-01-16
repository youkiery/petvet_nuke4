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
        <button class="btn btn-xs {btn_manager}" onclick="change({id}, 'manager', '{manager_value}')">
          quản lý
        </button>  
        <button class="btn btn-xs {btn_except}" onclick="change({id}, 'except', '{except_value}')">
          kế toán
        </button>  
        <button class="btn btn-xs {btn_daily}" onclick="change({id}, 'daily', '{daily_value}')">
          đăng ký lịch
        </button>  
        <button class="btn btn-xs {btn_kaizen}" onclick="change({id}, 'kaizen', '{kaizen_value}')">
          kaizen
        </button>  
        <button class="btn btn-danger btn-xs" onclick="removeUser({id})">
          xóa
        </button>
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
{nav}
<!-- END: main -->