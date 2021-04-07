<!-- BEGIN: main  -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> Mặt hàng </th>
      <th> Tồn kho </th>
      <th> Giới hạn nhập kho </th>
      <th> Giới hạn chuyển kho </th>
      <th>   </th>
    </tr>
  </thead>
  <tbody>
    <!-- BEGIN: row -->
    <tr>
      <td> 
        <img src="{image}" class="image">  
        <p class="name"> {name} </p>
        <p class="code"> {code} </p>
      </td>
      <td> {limitup} </td>
      <td> {limitdown} </td>
      <td>
        <button class="btn btn-info btn-xs" onclick="update({id})"> cập nhật </button>
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
<!-- END: main  -->
