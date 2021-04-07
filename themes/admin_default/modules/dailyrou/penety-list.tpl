<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <th> STT </th>
    <th> Nhân viên </th>
    <th> Ngày </th>
    <th> Buổi </th>
    <th>  </th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td> {user} </td>
    <td> {time} </td>
    <td> {type} </td>
    <td>
      <button class="btn btn-info" onclick="change({id})">
        <span class="glyphicon glyphicon-remove"></span>
      </button>
    </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: main -->