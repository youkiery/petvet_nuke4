<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
  <tr>
    <th> STT </th>
    <th> Mặt hàng </th>
    <th> </th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td> <input type="text" class="form-control" id="item-{id}" value="{name}"> </td>
    <td>
      <button class="btn btn-xs btn-info" onclick="editItem({id})">
        sửa
      </button>
      <button class="btn btn-xs btn-danger" onclick="removeItem({id})">
        xóa
      </button>
    </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: main -->