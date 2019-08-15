<!-- BEGIN: main -->
<button class="btn btn-success" onclick="addDisease()">
  <span class="glyphicon glyphicon-plus"> </span>
</button>
<table class="table table-bordered">
  <tr>
    <th> STT </th>
    <th> Thú cưng </th>
    <th> Ngày điều trị </th>
    <th> Loại bệnh </th>
    <th> Thời gian khỏi </th>
    <th> Ghi chú </th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td> {pet} </td>
    <td> {treat} </td>
    <td> {disease} </td>
    <td> {treated} </td>
    <td> {note} </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: main -->
