<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> Thiết bị </th>
      <th> Vị trí </th>
      <th> Nhân viên </th>
      <th> Trạng thái </th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr>
      <td> {name} </td>
      <td> {depart} </td>
      <td> {employ} </td>
      <td> 
        <!-- BEGIN: yes   -->
        đã báo cáo ngày: {date}
        <!-- END: yes   -->
        <!-- BEGIN: no   -->
        chưa báo cáo
        <!-- END: no   -->
      </td>
      <td>
        <button class="btn btn-info btn-xs" onclick="reportDetail({id})">
          chi tiết
        </button>
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
<!-- END: main -->
