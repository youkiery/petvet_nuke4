<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <th> Thời gian </th>
    <th> Mẫu </th>
    <th> Mục đích </th>
    <th> Người thực hiện </th>
    <th class="{show}"> </th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {time} </td>
    <td> {number} </td>
    <td> {target} </td>
    <td> {doctor} </td>
    <td class="{show}">
      <!-- BEGIN: test -->
      <!-- <button class="btn btn-info btn-xs" onclick="edit({typeid}, {id})">
        <span class="glyphicon glyphicon-edit"></span>
      </button> -->
      <button class="btn btn-danger btn-xs" onclick="remove({typeid}, {id})">
        <span class="glyphicon glyphicon-remove"></span>
      </button>
      <!-- END: test -->
    </td>
  </tr>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->