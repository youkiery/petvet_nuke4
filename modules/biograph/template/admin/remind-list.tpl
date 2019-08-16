<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <th> STT </th>
    <th> Tên </th>
    <th> Loại </th>
    <th> Số lần sử dụng </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td> {name} </td>
    <td> {type} </td>
    <td> {rate} </td>
    <td> 
      <!-- BEGIN: yes -->
      <button class="btn btn-info" onclick="check({id})">
        <span class="glyphicon glyphicon-check"></span>
      </button>  
      <!-- END: yes -->
      <!-- BEGIN: no -->
      <button class="btn btn-warning" onclick="nocheck({id})">
        <span class="glyphicon glyphicon-unchecked"></span>
      </button>  
      <!-- END: no -->
    </td>
  </tr>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->
