<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> <input type="checkbox" id="device-check-all"> </th>
      <th> Tên thiết bị </th>
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
      <td> {company} </td>
      <td> {status} </td>
      <td> {number} </td>
      <td> 
        <button class="btn btn-info btn-xs" onclick="deviceEdit({id})">
          sửa
        </button>  
        <a class="btn btn-info btn-xs" href="{url}"> HDSD </a>
        <button class="btn btn-info btn-xs" onclick="itemDetail({id})">
          phân quyền
        </button>  
        <button class="btn btn-danger btn-xs" onclick="deviceRemove({id})">
          xóa
        </button>  
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
{nav}
<!-- END: main -->