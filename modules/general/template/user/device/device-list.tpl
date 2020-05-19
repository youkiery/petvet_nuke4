<!-- BEGIN: main -->
<!-- BEGIN: yes -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> Tên thiết bị </th>
      <th> Tình trạng </th>
      <th> Số lượng </th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr>
      <td> {index} </td>
      <td> {name} </td>
      <td> {status} </td>
      <td> {number} </td>
      <td> 
        <button class="btn btn-info btn-xs" onclick="deviceDetail({id}, `{status}`, `{note}`)">
          cập nhật
        </button>  
        <button class="btn btn-info btn-xs" onclick="deviceEdit({id})">
          chi tiết
        </button>  
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
<!-- END: yes -->
<!-- BEGIN: no -->
<p class="text-center">
  <b>
    Tài khoản không quản lý thiết bị nào
  </b>
</p>
<!-- END: no -->
<!-- END: main -->