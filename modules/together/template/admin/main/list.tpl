<!-- BEGIN: main -->
<table class="table table-bordered table-hover">
  <tr>
    <th> STT </th>
    <th> Tên </th>
    <th> Chức năng </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td> {title} </td>
    <td> {name} </td>
    <td>
      <a class="btn btn-info btn-xs" href="/admin/index.php?&nv=together&id={id}">
        chi tiết
      </a>
      <button class="btn btn-danger btn-xs" onclick="remove({id})">
        xóa
      </button>
    </td>
  </tr>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->