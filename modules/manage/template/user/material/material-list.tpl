<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> Tên mục hàng </th>
      <th> Số lượng </th>
      <th> HSD </th>
      <th> Mô tả </th>
      <th>  </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr class="{color}">
      <td> {index} </td>
      <td> {name} {unit} </td>
      <td> {number} </td>
      <td> {expire} </td>
      <td> {description} </td>
      <td>
        <button class="btn btn-info btn-xs" onclick="updateItem({id})">
          sửa
        </button>  
        <!-- xóa -->
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->
