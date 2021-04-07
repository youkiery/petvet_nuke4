<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th style="width: 40%;"> Tài khoản </th>
      <th style="width: 40%;"> Họ tên </th>
      <th style="width: 20%;"> Phân quyền </th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr>
      <td> {username} </td>
      <td> {name} </td>
      <td> 
        <button class="btn {btn_manager} btn-xs" onclick="setPermission({userid}, {rev_role})">
          quản lý
        </button>  
        <div style="margin-top: 1px;"></div>
        <button class="btn btn-danger btn-xs" onclick="removeEmploy({userid})">
          loại bỏ
        </button>  
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
{nav}
<!-- END: main -->