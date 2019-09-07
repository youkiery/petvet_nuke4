<!-- BEGIN: main -->
<table class="table table-bordered">
  <!-- <tr>
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
  </tr> -->
  <!-- BEGIN: row -->
  <tr class="{color}">
    <td rowspan="4" class="cell-center">
      {index}
    </td>
    <td>
      Tên chủ: {owner}
    </td>
    <td>
      Loài: {breed}
    </td>
  </tr>
  <tr>
    <td>
      Địa chỉ: {address}
    </td>
    <td>
      Giống: {species}
    </td>
  </tr>
  <tr>
    <td>
      SĐT: {mobile}
    </td>
    <td>
      {type}
    </td>
  </tr>
  <tr>
    <td colspan="3" style="text-align: right;">
      <!-- BEGIN: yes -->
      <button class="btn btn-success" onclick="uncheck({id})">
        <span class="glyphicon glyphicon-check"></span>
      </button>
      <!-- END: yes -->
      <!-- BEGIN: no -->
      <button class="btn btn-warning" onclick="check({id})">
        <span class="glyphicon glyphicon-unchecked"></span>
      </button>
      <!-- END: no -->
      <button class="btn btn-info" onclick="edit({id})">
        <span class="glyphicon glyphicon-edit"></span>
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
