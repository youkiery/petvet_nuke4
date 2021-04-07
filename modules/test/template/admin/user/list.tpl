<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <th> STT </th>
    <th> Tài khoản </th>
    <th> Người dùng </th>
    <th>  </th>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
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
      <button class="btn btn-xs btn-danger" onclick="removeUser({id})">
        xóa
      </button>  
    </td>
  </tbody>
  <!-- END: row -->
</table>
<!-- END: main -->