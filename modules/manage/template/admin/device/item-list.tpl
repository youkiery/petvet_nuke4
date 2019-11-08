<!-- BEGIN: main -->
<table class="table table-bordered">
  <thead>
    <tr>
      <th> STT </th>
      <th> <input type="checkbox"> </th>
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
      <th> <input type="checkbox"> </th>
      <td> {name} </td>
      <td> {company} </td>
      <td> {status} </td>
      <td> {number} </td>
      <td> 
        <button class="btn btn-info">
          edit
        </button>  
        <button class="btn btn-danger">
          remove
        </button>  
      </td>
    </tr>
    <!-- END: row -->
  </tbody>
</table>
<!-- END: main -->