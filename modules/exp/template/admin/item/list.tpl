<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <th> Số thứ tự </th>
    <th> <input type="checkbox" id="item-check-all"> </th>
    <th> Mã hàng </th>
    <th> Tên hàng </th>
    <th> Số lượng </th>
    <th> Loại hàng </th>
    <th> Hạn sử dụng </th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td>
      {index}
    </td>
    <td>
      <label class="checkbox-inline">
        <input type="checkbox" class="event-checkbox" id="item-check-{id}">
      </label>
    </td>
    <td>
      <input type="text" class="form-control" id="item-code-{id}" value="{code}">
    </td>
    <td>
      <input type="text" class="form-control" id="item-{id}" value="{name}">
    </td>
    <td>
      <input type="text" class="form-control" id="item-number-{id}" value="{number}">
    </td>
    <td> {category} </td>
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
