<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <th> Số thứ tự </th>
    <th> <input type="checkbox" id="item-check-all"> </th>
    <th> Tên hàng </th>
    <th> Số lượng </th>
    <th> Hạn sử dụng </th>
    <th>  </th>
  </tr>
  <!-- BEGIN: row -->
  <tr class="{color}">
    <td>
      {index}
    </td>
    <td>
      <label class="checkbox-inline">
        <input type="checkbox" class="item-checkbox" id="item-check-{id}">
      </label>
    </td>
    <td>
      {name}
    </td>
    <td>
      {number}
    </td>
    <td>
      {time}
    </td>
    <td>
      <button class="btn btn-info" onclick="done({id})"> <span class="glyphicon glyphicon-check"></span> </button>
    </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: main -->

