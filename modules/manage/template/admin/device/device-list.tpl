<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> <input type="checkbox" id="device-check-all"> </th>
      <th> Tên thiết bị </th>
      <th> Phòng ban </th>
      <th> Công ty </th>
      <th> Tình trạng </th>
      <th> Số lượng </th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr>
      <td> {index} </td>
      <th> <input type="checkbox" class="device-checkbox" id="device-checkbox-{id}"> </th>
      <td> {name} </td>
      <td> {depart} </td>
      <td> {company} </td>
      <td> {status} </td>
      <td> {number} </td>
      <td> 
        <button class="btn btn-info" onclick="deviceEdit({id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>  
        <button class="btn btn-danger" onclick="deviceRemove({id})">
          <span class="glyphicon glyphicon-remove"></span>
        </button>  
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
<!-- END: main -->