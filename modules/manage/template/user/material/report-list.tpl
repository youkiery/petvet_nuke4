<!-- BEGIN: main -->
<div class="form-group">
  Phiếu xuất nhập từ ngày {from} đến ngày {end}
</div>
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> Tên mục hàng </th>
      <th> Loại </th>
      <th> Số lượng nhập </th>
      <th> Số lượng xuất </th>
      <th>  </th>
    </tr>
  </thead>
  <!-- BEGIN: row -->
  <tbody>
    <tr>
      <td> {index} </td>
      <td> {name} </td>
      <td> {type} </td>
      <td> {import} </td>
      <td> {export} </td>
      <td>  
        <button class="btn btn-info btn-xs" onclick="report({id})">
          Xem báo cáo
        </button>
        <button class="btn btn-info btn-xs" onclick="reportExcel({id})">
          Xuất excel
        </button>
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->
