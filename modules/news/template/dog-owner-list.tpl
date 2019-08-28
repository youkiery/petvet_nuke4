<!-- BEGIN: main -->
<p> 
  <!-- BEGIN: msg -->
  Tìm kiếm {keyword} từ {from} đến {end} trong {count} kết quả
  <!-- END: msg -->
</p>
<table class="table table-bordered">
  <tr>
    <th> Tên </th>
    <th> Số microchip </th>
    <th> Giới tính </th>
    <th> Ngày sinh </th>
    <th> Giống </th>
  </tr>
  <!-- BEGIN: row -->
  <tbody class="{pc}" style="display: {display};">
    <tr>
      <td> <a href="/{module_file}/info/?id={id}"> {name} </a> </td>
      <td> <a href="/{module_file}/info/?id={id}"> {microchip} </a> </td>
      <td> <a href="/{module_file}/info/?id={id}"> {sex} </a> </td>
      <td> <a href="/{module_file}/info/?id={id}"> {dob} </a> </td>
      <td> <a href="/{module_file}/info/?id={id}"> {breed} </a> </td>
    </tr>
    <tr class="right">
      <td colspan="6">
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
        <button class="btn btn-info" onclick="parentToggle({id})">
          <img src="/modules/{module_file}/src/parent.png" style="width: 20px; height: 20px;">
        </button>
        <!-- <button class="btn btn-danger" onclick="deletePet({id})">
          <span class="glyphicon glyphicon-remove"></span>
        </button> -->
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->
