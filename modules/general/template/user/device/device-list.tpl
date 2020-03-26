<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> <input type="checkbox" id="device-check-all"> </th>
      <th> Tên thiết bị </th>
      <th> Phòng ban </th>
      <th> Tình trạng </th>
      <th> Số lượng </th>
      <!-- BEGIN: m1 -->
      <th></th>
      <!-- END: m1 -->
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr>
      <td> {index} </td>
      <th> <input type="checkbox" class="device-checkbox" id="device-checkbox-{id}"> </th>
      <td> {name} </td>
      <td> {depart} </td>
      <td> {status} </td>
      <td> {number} </td>
      <!-- BEGIN: m2 -->
      <td> 
        <button class="btn btn-info btn-sm" onclick="deviceEdit({id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>  
        <button class="btn btn-danger btn-sm" onclick="deviceRemove({id})">
          <span class="glyphicon glyphicon-remove"></span>
        </button>  
      </td>
      <!-- END: m2 -->
    </tr>
    <!-- END: row -->
  </tbody>
</table>
{nav}
<!-- END: main -->