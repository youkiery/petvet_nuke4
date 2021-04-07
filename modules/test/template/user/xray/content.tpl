<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> Khách hàng </th>
      <th> SĐT </th>
      <th> Ngày lưu </th>
      <th> Tình trạng </th>
      <th>  </th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->  
    <tr class="{color}">
      <td> {customer} </td>
      <td> {phone} </td>
      <td> {cometime} </td>
      <td> {condition} </td>
      <td>  
        <button class="btn btn-info btn-xs" onclick="edit({id})">
          sửa
        </button>
      </td>
    </tr>
    <!-- END: row -->  
  </tbody>
</table>
{nav}
<!-- END: main -->
