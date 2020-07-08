<!-- BEGIN: main -->
<!-- BEGIN: yes -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> Thiết bị </th>
      <th> Tình trạng </th>
      <th> Số lượng </th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr>
      <td> {index} </td>
      <td> {name} {check} </td>
      <td> {status} </td>
      <td> {number} </td>
      <td> 
        <button class="btn btn-info btn-xs" onclick="deviceEdit({id})">
          báo cáo
        </button>  
        <!-- BEGIN: manual -->
        <button class="btn btn-info btn-xs" onclick="manual({id})">
          HDSD
        </button>  
        <!-- END: manual -->
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