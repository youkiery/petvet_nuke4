<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <td> STT </td>
    <td> Tên tài khoản </td>
    <td> Tên người dùng </td>
    <td> Cấp bậc </td>
    <td>  </td>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td> {username} </td>
    <td> {name} </td>
    <td> {level} </td>
    <td> 
      <button class="btn btn-info" onclick="editMember({id})">
        <span class="glyphicon glyphicon-edit"></span>
      </button>  
      <button class="btn btn-danger" onclick="removeMember({id})">
        <span class="glyphicon glyphicon-remove"></span>
      </button>  
    </td>
  </tr>
  <!-- END: row -->
</table>
<div class="form-group">
  {nav}
</div>
<!-- END: main -->
