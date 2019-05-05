<!-- BEGIN: main -->
<p> Có tổng cộng {total} ca </p>
<table class="table table-bordered">
  <!-- BEGIN: row -->
  <tbody class="item-border">
    <tr id="{id}">
      <td> {customer} </td>
      <td> <b>Hướng điều trị:</b> {oriental} </td>
      <td rowspan="4" class="cell-center {class}">
        <button class="btn btn-info" onclick="edit({id})"> <span class="glyphicon glyphicon-edit"></span> </button>
        <button class="btn btn-warning" onclick="copy({id})"> <span class="glyphicon glyphicon-file"></span> </button>
        <!-- BEGIN: manager -->
        <button class="btn btn-danger" onclick="remove({id})"> <span class="glyphicon glyphicon-remove"></span> </button>
        <!-- END: manager -->
      </td>
    </tr>
    <tr>
      <td> {petname} </td>
      <td> <b> Hệ tác động: </b> {system} </td>
    </tr>
    <tr>
      <td> {time} </td>
      <td rowspan="2"> <b>Thuốc:</b> {drug} </td>
    </tr>
    <tr>
      <td>
        {doctor}
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->
