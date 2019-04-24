<!-- BEGIN: main -->
<p> Có tổng cộng {total} ca </p>
<table class="table table-bordered">
  <!-- BEGIN: row -->
  <tbody class="item-border">
    <tr id="{id}">
      <td> {customer} </td>
      <td> <b>Hướng điều trị:</b> {oriental} </td>
      <td rowspan="3" class="cell-center {class}"> <button class="btn btn-info" onclick="edit({id})"> <span class="glyphicon glyphicon-edit"></span> </button> <button class="btn btn-danger" onclick="remove({id})"> <span class="glyphicon glyphicon-remove"></span> </button> </td>
    </tr>
    <tr>
      <td> {petname} </td>
      <td rowspan="2"> <b>Thuốc:</b> {drug} </td>
    </tr>
    <tr>
      <td> {time} </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->
