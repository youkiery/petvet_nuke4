<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <th> Số thứ tự </th>
    <th> Tên hàng </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td>
      {index}
    </td>
    <td>
      <input type="text" class="form-control" id="item-{id}" value="{name}">
    </td>
    <td>
      <button class="btn btn-info" onclick="update({id})">
        <span class="glyphicon glyphicon-refresh"></span>
      </button>
      <!-- <button class="btn btn-danger" onclick="remove({id})">
        <span class="glyphicon glyphicon-remove"></span>
      </button> -->
    </td>
  </tr>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->
