<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <th>
      STT
    </th>
    <th>
      Tên khách
    </th>
    <th>
      Địa chỉ
    </th>
    <th>
      Số điện thoại
    </th>
    <th>
      Chuyên mục
    </th>
  </tr>
  <!-- BEGIN: row -->
  <tbody style="border: 2px dotted black;">
    <tr>
      <td> {index} </td>
      <td> {target} </td>
      <td> {address} </td>
      <td> {mobile} </td>
      <td> {type} </td>
    </tr>
    <tr>
      <td colspan="5">
        <div style="width: 50%; float: left;">
          Ghi chú: {note}
        </div>
        <div style="width: 50%; float: left; text-align: right;">
          <!-- BEGIN: yes -->
          <button class="btn btn-success" onclick="check({id})">
            <span class="glyphicon glyphicon-unchecked"></span>
          </button>
          <!-- END: yes -->
          <!-- BEGIN: no -->
          <button class="btn btn-warning" onclick="uncheck({id})">
            <span class="glyphicon glyphicon-check"></span>
          </button>
          <!-- END: no -->
          <button class="btn btn-danger" onclick="remove({id})">
            <span class="glyphicon glyphicon-remove"></span>
          </button>
        </div>
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->
