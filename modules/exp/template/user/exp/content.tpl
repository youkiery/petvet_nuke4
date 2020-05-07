<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <th> Số thứ tự </th>
    <th> Tên hàng </th>
    <th> Hạn sử dụng </th>
    <th> Số lượng cũ </th>
    <th> Số lượng mới </th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td>
      {index}
    </td>
    <td>
      {name}
    </td>
    <td>
      {time}
    </td>
    <td>
      {number}
    </td>
    <td>
      <input type="text" class="form-control number" id="number-{id}" value="{number2}">
    </td>
  </tr>
  <!-- END: row -->
</table>
<div class="text-center">
  <button class="btn btn-info" onclick="updateNumberSubmit()">
    Cập nhật
  </button>
</div>
<!-- END: main -->
