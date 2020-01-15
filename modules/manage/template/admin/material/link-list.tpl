<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> Vật tư </th>
      <th> Vật tư liên kết </th>
      <th></th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr>
      <td> {index} </td>
      <td> {name} {unit} </td>
      <td> {name2} {unit2} </td>
      <td> <button class="btn btn-danger btn-xs" onclick="linkRemove({id})"> <span class="glyphicon glyphicon-remove"></span> </button> </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->
