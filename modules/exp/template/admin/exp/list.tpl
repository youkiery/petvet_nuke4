<!-- BEGIN: main -->
<div class="row-x">
  <div class="col-2">
    Số thứ tự
  </div>
  <div class="col-5">
    Tên hàng
  </div>
  <div class="col-3">
    Hạn sử dụng
  </div>
  <div class="col-2">

  </div>
</div>
<!-- BEGIN: row -->
<div class="row-x">
  <div class="col-2">
    {index}
  </div>
  <div class="col-5">
    <div class="relative">
      <input type="text" class="form-control" id="item-{id}" value="{name}">
      <input type="hidden" id="item-id-{id}" value="{rid}">
      <div class="suggest" id="item-{id}-suggest"></div>
    </div>
  </div>
  <div class="col-3">
    <input type="text" class="form-control date" id="item-{id}" value="{time}">
  </div>
  <div class="col-2">
    <button class="btn btn-info" onclick="update({id})">
      <span class="glyphicon glyphicon-refresh"></span>
    </button>
    <button class="btn btn-danger" onclick="remove({id})">
      <span class="glyphicon glyphicon-remove"></span>
    </button>
  </div>
</div>
<!-- END: row -->
{nav}
<!-- END: main -->
