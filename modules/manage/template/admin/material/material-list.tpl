<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> Tên mục hàng </th>
      <th> Loại </th>
      <th> Số lượng </th>
      <th> Giới hạn </th>
      <th> Mô tả </th>
      <th>  </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr>
      <td> {index} </td>
      <td> {name} {unit} </td>
      <td> {type} </td>
      <td> {number} </td>
      <td> {bound} </td>
      <td> {description} </td>
      <td>
        <button class="btn btn-info btn-xs" onclick="editMaterial({id})">
          sửa
        </button>
        <button class="btn btn-danger btn-xs" onclick="removeMaterial({id})">
          xóa
        </button>
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->
