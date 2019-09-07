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
      Giống
    </th>
    <th>
      Loại yêu cầu
    </th>
  </tr>
  <!-- BEGIN: row -->
  <tr class="{color}">
    <td rowspan="2" class="cell-center">
      {index}
    </td>
    <td>
      {owner}
    </td>
    <td>
      {address}
    </td>
    <td>
      {species}
    </td>
    <td>
      {type}
    </td>
  </tr>
  <tr>
    <td colspan="5" style="text-align: right;">
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
      <button class="btn btn-info" onclick="edit({petid})">
        <span class="glyphicon glyphicon-edit"></span>
      </button>
      <button class="btn btn-warning" onclick="sendback({id})">
        <span class="glyphicon glyphicon-share-alt"></span>
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
