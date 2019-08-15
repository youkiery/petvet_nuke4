<!-- BEGIN: main -->
<button class="btn btn-success" onclick="addVaccine()">
  <span class="glyphicon glyphicon-plus"> </span>
</button>
<table class="table table-bordered">
  <tr>
    <th> STT </th>
    <th> Thú cưng </th>
    <th> Ngày tiêm </th>
    <th> Ngày tái chủng </th>
    <th> Loại tiêm phòng </th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td> {pet} </td>
    <td> {time} </td>
    <td> {recall} </td>
    <td> {type} </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: main -->
