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
  <tr class="{color}">
    <td> {index} </td>
    <td> {pet} </td>
    <td> {time} </td>
    <td> {recall} </td>
    <td> {type} </td>
  </tr>
  <tr>
    <td colspan="5">
      <div class="col-sm-6">
        {note}
      </div>
      <div class="col-sm-6" style="text-align: right;">
        <button class="btn btn-info" onclick="editVaccine({id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>
      </div>
    </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: main -->
