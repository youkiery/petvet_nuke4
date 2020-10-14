<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> Chi nhánh </th>
      <th> </th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr>
      <td> {index} </td>
      <td> <a href="/admin/index.php?nv=setting&id={id}">{name}</a> </td>
      <td>
        <button class="btn btn-danger btn-xs" onclick="removeBranchSubmit({id})">
          xóa
        </button>
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
{nav}
<!-- END: main -->