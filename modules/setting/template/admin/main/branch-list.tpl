<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> Chi nhánh </th>
      <th> Tiền tố </th>
      <th> </th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr class="branch" id="{id}">
      <td> {index} </td>
      <td> 
        <input type="text" class="form-control" id="name-{id}" value="{name}">  
      </td>
      <td> 
        <input type="text" class="form-control" id="prefix-{id}" value="{prefix}">  
      </td>
      <td>
        <a class="btn btn-info btn-xs" href="/admin/index.php?nv=setting&id={id}">
          xem
        </a>
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