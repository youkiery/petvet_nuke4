<!-- BEGIN: main -->
<p> 
  <!-- BEGIN: msg -->
  Tìm kiếm {keyword} từ {from} đến {end} trong {count} kết quả
  <!-- END: msg -->
</p>
<table class="table">
  <tr>
    <th> STT </th>
    <th> Tên thú cưng </th>
    <th> Tên chủ </th>
    <th> Số microchip/Xăm tai </th>
    <th> Giới tính </th>
    <th> Giống </th>
    <th> Ngày sinh </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tbody>
    <tr class="clickable-row" data-href=''>
      <td> <a href="/detail/?id={id}"> {index} </a> </td>
      <td> <a href="/detail/?id={id}"> {name} </a> </td>
      <td> <a href="/detail/?id={id}"> {owner} </a> </td>
      <td> <a href="/detail/?id={id}"> {microchip} </a> </td>
      <td> <a href="/detail/?id={id}"> {sex} </a> </td>
      <td> <a href="/detail/?id={id}"> {breed} </a> </td>
      <td> <a href="/detail/?id={id}"> {dob} </a> </td>
      <td>
        <!-- BEGIN: mod -->
        <button class="btn btn-{request}" onclick="request({id})">
          <img src="/modules/news/src/request.png" style="width: 20px; height: 20px;">
        </button>
        <button class="btn btn-info" onclick="addVaccine({id})">
          <img src="/modules/news/src/syringe.png" style="width: 20px; height: 20px;">
        </button>
        <button class="btn btn-info" onclick="editPet({id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>
        <button class="btn btn-danger" onclick="deletePet({id})">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
        <!-- END: mod -->
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->
