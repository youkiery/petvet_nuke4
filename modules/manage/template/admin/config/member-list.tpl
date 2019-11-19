<!-- BEGIN: main -->
<table class="table table-bordered">
  <tr>
    <th> STT </th>
    <th> Người dùng </th>
    <th> Quyền sử dụng </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tr>
    <td> {index} </td>
    <td> {name} </td>
    <td> {author} </td>
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
<!-- END: main -->
