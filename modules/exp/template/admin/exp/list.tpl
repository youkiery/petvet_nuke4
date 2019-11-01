<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <th> Số thứ tự </th>
    <th> Tên hàng </th>
    <th> Số lượng </th>
    <th> Hạn sử dụng </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td>
      {index}
    </td>
    <td>
      <div class="relative">
        <input type="text" class="form-control" id="item-{id}" value="{name}">
        <input type="hidden" id="item-id-{id}" value="{rid}">
        <div class="suggest" id="item-{id}-suggest"></div>
      </div>
    </td>
    <td>
      <input type="text" class="form-control" id="item-number-{id}" value="{number}">
    </td>
    <td>
      <input type="text" class="form-control date" id="item-date-{id}" value="{time}">
    </td>
    <td>
      <button class="btn btn-info" onclick="update({id})">
        <span class="glyphicon glyphicon-refresh"></span>
      </button>
      <button class="btn btn-danger" onclick="remove({id})">
        <span class="glyphicon glyphicon-remove"></span>
      </button>
    </td>
  </tr>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->
