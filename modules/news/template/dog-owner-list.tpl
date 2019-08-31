<!-- BEGIN: main -->

<table class="table table-bordered">
  <!-- BEGIN: row -->
  <tbody class="{pc}" style="display: {display}; border: 2px solid black;">
    <tr>
      <td rowspan="3" style="vertical-align: inherit; text-align: center;"> {name} </td>
      <td> Giới tính: {sex} </td>
    </tr>
    <tr>
      <td> Loài: {species} </td>
    </tr>
    <tr>
      <td> Giống: {breed} </td>
    </tr>
    <tr class="right">
      <td colspan="2">
        <button class="btn btn-warning" onclick="transfer({id})">
          <img src="/modules/{module_file}/src/transfer.png" style="width: 20px; height: 20px;">
        </button>
        <button class="btn btn-info" onclick="request({id})">
          <img src="/modules/{module_file}/src/request.png" style="width: 20px; height: 20px;">
        </button>
        <button class="btn btn-info" onclick="addVaccine({id})">
          <img src="/modules/{module_file}/src/syringe.png" style="width: 20px; height: 20px;">
        </button>
        <button class="btn btn-info" onclick="editPet({id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>
        <button class="btn btn-info" onclick="parentToggle({id})" {pr}>
          <img src="/modules/{module_file}/src/parent.png" style="width: 20px; height: 20px;">
        </button>
        <a href="/{module_name}/info?id={id}"> 
          <button class="btn btn-info">
            Chi tiết
          </button>
        </a>
        {breeder}
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->