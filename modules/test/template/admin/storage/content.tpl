<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
  <tr>
    <th> STT </th>
    <th> Vị trí </th>
    <th> </th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td> <input type="text" class="form-control" id="position-{id}" value="{name}"> </td>
    <td>
      <a href="/admin/index.php?nv=test&op=storage&id={id}" class="btn btn-xs btn-info">
        chi tiết
      </a>
      <button class="btn btn-xs btn-info" onclick="edit({id})">
        sửa
      </button>
      <button class="btn btn-xs btn-danger" onclick="remove({id})">
        xóa
      </button>
    </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: main -->