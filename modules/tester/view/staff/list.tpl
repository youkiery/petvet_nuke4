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
        <button class="btn btn-xs {manager_btn}" onclick="update({userid}, 'manager', {manager_value})">
          quản lý
        </button>
        <button class="btn btn-xs {accountant_btn}" onclick="update({userid}, 'accountant', {accountant_value})">
          kế toán
        </button>
        <button class="btn btn-xs {hopital_btn}" onclick="update({userid}, 'hopital', {hopital_value})">
          bệnh viện
        </button>
        <button class="btn btn-xs {shop_btn}" onclick="update({userid}, 'shop', {shop_value})">
          shop
        </button>
        <button class="btn btn-xs {stay_btn}" onclick="update({userid}, 'stay', {stay_value})">
          lưu bệnh
        </button>
        <button class="btn btn-xs btn-danger" onclick="remove({userid})">
          xóa
        </button>
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
<!-- END: main  -->
