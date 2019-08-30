<!-- BEGIN: main -->
<!-- BEGIN: row -->
<div class="thumb-gallery">
  <div class="xleft">
    <img src="{image}" class="transfer thumbnail">
  </div>
  <div class="xright">
    <p> Tên thú cưng: {name} </p>
    <p> Microchip: {microchip} </p>
    <p> Giới tính: {sex} </p>
    <p> Loài: {species} </p>
    <p> Giống: {breed} </p>
    <a href="/{module_file}/info/?id={id}">
      <button class="btn btn-info">
        Chi tiết
      </button>
    </a>
    <div></div>
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
  </div>
</div>
<!-- END: row -->

{nav}
<!-- END: main -->