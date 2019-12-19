<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> Tên mục hàng </th>
      <th> Loại </th>
      <th> Số lượng </th>
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
      <td> {description} </td>
      <td>
        <button class="btn btn-info" onclick="editMaterial({id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>
        <button class="btn btn-danger" onclick="removeMaterial({id})">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
<!-- END: main -->