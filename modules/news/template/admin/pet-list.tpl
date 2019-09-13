<!-- BEGIN: main -->
<p> 
  <!-- BEGIN: msg -->
  Tìm kiếm {keyword} từ {from} đến {end} trong {count} kết quả
  <!-- END: msg -->
</p>
<table class="table table-bordered">
  <tr>
    <th> STT </th>
    <th> Tên </th>
    <th> Chủ nuôi </th>
    <th> Số microchip </th>
    <th> Giới tính </th>
    <th> Ngày sinh </th>
    <th> Giống </th>
    <th></th>
  </tr>
  <!-- BEGIN: row -->
  <tbody>
    <tr class="clickable-row" data-href=''>
      <td> <a href="/news/detail/?id={id}"> {index} </a> </td>
      <td> <a href="/news/detail/?id={id}"> {name} </a> </td>
      <td> <a href="/news/detail/?id={id}"> {owner} </a> </td>
      <td> <a href="/news/detail/?id={id}"> {microchip} </a> </td>
      <td> <a href="/news/detail/?id={id}"> {sex} </a> </td>
      <td> <a href="/news/detail/?id={id}"> {dob} </a> </td>
      <td> <a href="/news/detail/?id={id}"> {breed} </a> </td>
      <td>
        <button class="btn btn-info" onclick="editPet({id})">
          <span class="glyphicon glyphicon-edit"></span>
        </button>
        <!-- BEGIN: uncheck -->
        <button class="btn btn-warning" onclick="checkPet({id}, 0)">
          <span class="glyphicon glyphicon-check"></span>
        </button>
        <!-- BEGIN: yes -->
        <button class="btn btn-warning" onclick="ceti({id}, {price})">
          <img src="/themes/default/images/cetificate.png">
        </button>
        <!-- END: yes -->
        <!-- BEGIN: no -->
        <button class="btn btn-success" onclick="ceti({id}, {price})">
          <img src="/themes/default/images/cetificate.png">
        </button>
        <!-- END: no -->
        
        <!-- END: uncheck -->
        <!-- BEGIN: check -->
        <button class="btn btn-success" onclick="checkPet({id}, 1)">
          <span class="glyphicon glyphicon-unchecked"></span>
        </button>
        <!-- END: check -->
        <button class="btn btn-success" onclick="pickOwner({id}, {userid}, '{mobile}')">
          <span class="glyphicon glyphicon-user"></span>
        </button>
        <button class="btn btn-danger" onclick="deletePet({id})">
          <span class="glyphicon glyphicon-remove"></span>
        </button>
      </td>
    </tr>
  </tbody>
  <!-- END: row -->
</table>
{nav}
<!-- END: main -->
