<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
  <tr>
    <th> STT </th>
    <th> Họ tên </th>
    <th> Địa chỉ </th>
    <th> Số điện thoại </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td> {fullname} </td>
    <td> {address} </td>
    <td> {mobile} </td>
    <td>
      <!-- BEGIN: undone -->
      <button class="btn btn-info btn-xs" onclick="edit({id})">
        sửa
      </button>
      <button class="btn btn-info btn-xs" onclick="done({id})">
        xác nhận
      </button>
      <!-- END: undone -->
      <button class="btn btn-info btn-xs" onclick="preview({id})">
        chi tiết
      </button>
    </td>
  </tr>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->