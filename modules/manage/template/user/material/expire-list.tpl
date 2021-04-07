<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <th> STT </th>
    <th> Mặt hàng </th>
    <th> Số lượng </th>
    <th> Ngày hết hạn </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td> {item} </td>
    <td> {number} </td>
    <td> {date} </td>
    <td>
      <button class="btn btn-info" onclick="expireSubmit({id})">
        <span class="glyphicon glyphicon-ok"></span>
      </button>  
    </td>
  </tr>
  <!-- END: row -->
</table>
<!-- END: main -->
