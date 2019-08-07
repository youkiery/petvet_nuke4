<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <th>
      STT
    </th>
    <th>
      Chủ trại
    </th>
    <th>
      Địa chỉ
    </th>
    <th>
      Số điện thoại
    </th>
    <th>
      Thú cưng
    </th>
    <th>
      Loại yêu cầu
    </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td>
      {index}
    </td>
    <td>
      {owner}
    </td>
    <td>
      {mobile}
    </td>
    <td>
      {address}
    </td>
    <td>
      {pet}
    </td>
    <td>
      {type}
    </td>
    <td>
      <button class="btn btn-info" onclick="check({id})">
        <span class="glyphicon glyphicon-check"></span>
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
