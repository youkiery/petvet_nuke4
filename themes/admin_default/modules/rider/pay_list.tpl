<!-- BEGIN: main -->
Tổng cộng {count} bản ghi
<table class="table">
  <thead>
    <tr>
      <th> STT </th>
      <th> Ngày </th>
      <th> Người chi </th>
      <th> Tiền chi </th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr>
      <td> {index} </td>
      <td> {date} </td>
      <td> {driver} </td>
      <td> {money}  </td>
      <td> 
        <!-- <button class="btn btn-info" onclick="edit(1, {id})">
          Sửa
        </button>   -->
        <button class="btn btn-danger" onclick="remove(1, {id})">
          Xóa
        </button>
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
<div>
  Trang
  {nav}
</div>
<!-- END: main -->